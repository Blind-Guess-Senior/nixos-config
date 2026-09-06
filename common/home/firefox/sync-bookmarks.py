#!/usr/bin/env python3
"""Export Firefox bookmarks to the JSON consumed by Home Manager.

Normal usage (close Firefox first):

    firefox-bookmarks-sync --dry-run
    firefox-bookmarks-sync

The command finds Firefox's default profile through ``profiles.ini`` and writes
``common/home/firefox/bookmarks.json`` in the nixos-config checkout. Use
``--profile-dir``, ``--repo``, or ``--output`` to override those locations.

Firefox stores bookmarks in ``places.sqlite``. This script reads that database
without modifying it and preserves folders, ordering, separators, URLs, tags,
and GET keywords. Firefox must be closed because it locks the database while
running. Home Manager has no dedicated roots for Other or Mobile Bookmarks, so
non-empty roots are exported as regular folders with a warning. History,
favicons, timestamps, and POST keyword data are intentionally omitted.

Maintenance notes: bookmark nodes come from ``moz_bookmarks``, URLs from
``moz_places``, keywords from ``moz_keywords``, and tags from folders below the
``tags________`` root. The produced JSON must continue to match
``programs.firefox.profiles.<name>.bookmarks.settings``.
"""

from __future__ import annotations

import argparse
import configparser
import difflib
import json
import os
from collections import defaultdict
from pathlib import Path
import sqlite3
import sys
import tempfile
from typing import Any


BOOKMARK = 1
FOLDER = 2
SEPARATOR = 3

ROOT_GUIDS = {
    "menu": "menu________",
    "toolbar": "toolbar_____",
    "tags": "tags________",
    "unfiled": "unfiled_____",
    "mobile": "mobile______",
}

REQUIRED_COLUMNS = {
    "moz_bookmarks": {"id", "type", "fk", "parent", "position", "title", "guid"},
    "moz_places": {"id", "url"},
    "moz_keywords": {"keyword", "place_id", "post_data"},
}


class SyncError(Exception):
    """An expected error that should be shown without a traceback."""


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        prog="firefox-bookmarks-sync",
        description="Export the current Firefox bookmarks to bookmarks.json."
    )
    parser.add_argument(
        "--profile-dir",
        type=Path,
        help="Firefox profile directory (defaults to the default profile in profiles.ini)",
    )
    parser.add_argument(
        "--repo",
        type=Path,
        help="nixos-config checkout containing common/home/firefox/default.nix",
    )
    parser.add_argument(
        "--output",
        type=Path,
        help="write to this JSON file instead of common/home/firefox/bookmarks.json",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="print the prospective diff without changing bookmarks.json",
    )
    return parser.parse_args()


def firefox_bases() -> list[Path]:
    home = Path.home()
    xdg_config_home = Path(os.environ.get("XDG_CONFIG_HOME", home / ".config"))
    return [
        xdg_config_home / "mozilla/firefox",
        home / ".mozilla/firefox",
    ]


def find_profile(explicit: Path | None) -> Path:
    if explicit is not None:
        profile = explicit.expanduser().resolve()
        if not (profile / "places.sqlite").is_file():
            raise SyncError(f"places.sqlite not found in profile: {profile}")
        return profile

    for base in firefox_bases():
        profiles_ini = base / "profiles.ini"
        if not profiles_ini.is_file():
            continue

        parser = configparser.ConfigParser(interpolation=None)
        try:
            with profiles_ini.open(encoding="utf-8") as handle:
                parser.read_file(handle)
        except (OSError, configparser.Error) as error:
            raise SyncError(f"cannot read {profiles_ini}: {error}") from error

        profiles: list[tuple[bool, Path]] = []
        for section in parser.sections():
            if not section.startswith("Profile") or not parser.has_option(section, "Path"):
                continue
            raw_path = parser.get(section, "Path")
            is_relative = parser.getboolean(section, "IsRelative", fallback=True)
            path = base / raw_path if is_relative else Path(raw_path).expanduser()
            profiles.append((parser.getboolean(section, "Default", fallback=False), path))

        for _, path in sorted(profiles, key=lambda item: not item[0]):
            if (path / "places.sqlite").is_file():
                return path.resolve()

    raise SyncError(
        "could not find a default Firefox profile; pass its directory with --profile-dir"
    )


def is_config_repo(path: Path) -> bool:
    return (path / "common/home/firefox/default.nix").is_file()


def path_and_parents(path: Path) -> list[Path]:
    resolved = path.expanduser().resolve()
    if resolved.is_file():
        resolved = resolved.parent
    return [resolved, *resolved.parents]


def find_repo(explicit: Path | None) -> Path:
    if explicit is not None:
        resolved = explicit.expanduser().resolve()
        if is_config_repo(resolved):
            return resolved
        raise SyncError(f"not a nixos-config checkout: {explicit.expanduser()}")

    candidates: list[Path] = []
    configured = os.environ.get("NIXOS_CONFIG_REPO")
    if configured:
        resolved = Path(configured).expanduser().resolve()
        if is_config_repo(resolved):
            return resolved
        raise SyncError(f"NIXOS_CONFIG_REPO is not a nixos-config checkout: {resolved}")

    candidates.extend(path_and_parents(Path.cwd()))
    candidates.extend(path_and_parents(Path(__file__)))
    candidates.append(Path.home() / "nixos-config")

    seen: set[Path] = set()
    for candidate in candidates:
        resolved = candidate.expanduser().resolve()
        if resolved in seen:
            continue
        seen.add(resolved)
        if is_config_repo(resolved):
            return resolved

    raise SyncError(
        "could not find the nixos-config checkout; run inside it or pass --repo"
    )


def resolve_output(args: argparse.Namespace) -> Path:
    if args.output is not None:
        return args.output.expanduser().resolve()
    return find_repo(args.repo) / "common/home/firefox/bookmarks.json"


def validate_schema(connection: sqlite3.Connection) -> None:
    for table, required in REQUIRED_COLUMNS.items():
        columns = {
            row["name"]
            for row in connection.execute(f"PRAGMA table_info({table})").fetchall()
        }
        missing = required - columns
        if missing:
            raise SyncError(
                f"unsupported Firefox database: {table} is missing {', '.join(sorted(missing))}"
            )


def load_bookmarks(
    database: Path,
) -> tuple[list[Any], list[str], dict[str, int]]:
    uri = f"{database.resolve().as_uri()}?mode=ro"
    connection: sqlite3.Connection | None = None
    try:
        connection = sqlite3.connect(uri, uri=True, timeout=1)
        connection.row_factory = sqlite3.Row
        connection.execute("PRAGMA query_only = ON")
        connection.execute("BEGIN")
    except sqlite3.OperationalError as error:
        if connection is not None:
            connection.close()
        if "locked" in str(error).lower():
            raise SyncError(
                "Firefox is using places.sqlite; close Firefox and run the command again"
            ) from error
        raise SyncError(f"cannot open {database}: {error}") from error

    try:
        validate_schema(connection)

        rows = {
            row["id"]: dict(row)
            for row in connection.execute(
                """
                SELECT id, type, fk, parent, position, COALESCE(title, '') AS title, guid
                FROM moz_bookmarks
                ORDER BY parent, position, id
                """
            )
        }
        children: dict[int, list[dict[str, Any]]] = defaultdict(list)
        for row in rows.values():
            children[row["parent"]].append(row)
        for siblings in children.values():
            siblings.sort(key=lambda row: (row["position"], row["id"]))

        roots = {
            name: next(
                (row["id"] for row in rows.values() if row["guid"] == guid),
                None,
            )
            for name, guid in ROOT_GUIDS.items()
        }
        missing_roots = [name for name, root_id in roots.items() if root_id is None]
        if missing_roots:
            raise SyncError(
                "unsupported Firefox database: missing bookmark roots "
                + ", ".join(missing_roots)
            )

        places = {
            row["id"]: row["url"]
            for row in connection.execute("SELECT id, url FROM moz_places")
        }

        warnings: list[str] = []
        keywords: dict[int, str] = {}
        for row in connection.execute(
            "SELECT place_id, keyword, post_data FROM moz_keywords ORDER BY id"
        ):
            if row["post_data"]:
                warnings.append(
                    f"keyword {row['keyword']!r} uses POST data, which Home Manager cannot preserve"
                )
                continue
            if row["place_id"] is not None and row["keyword"]:
                existing = keywords.setdefault(row["place_id"], row["keyword"])
                if existing != row["keyword"]:
                    warnings.append(
                        f"multiple keywords target place {row['place_id']}; preserved {existing!r}"
                    )

        tags: dict[int, set[str]] = defaultdict(set)
        tags_root = roots["tags"]
        assert tags_root is not None
        for tag_folder in children[tags_root]:
            if tag_folder["type"] != FOLDER:
                warnings.append("ignored an unexpected non-folder entry in the Firefox tags root")
                continue
            tag = tag_folder["title"]
            for tagged in children[tag_folder["id"]]:
                if tagged["type"] == BOOKMARK and tagged["fk"] is not None:
                    tags[tagged["fk"]].add(tag)

        def convert(row: dict[str, Any], ancestors: frozenset[int]) -> Any:
            row_id = row["id"]
            if row_id in ancestors:
                raise SyncError(f"bookmark folder cycle detected at database row {row_id}")

            if row["type"] == SEPARATOR:
                return "separator"

            if row["type"] == BOOKMARK:
                place_id = row["fk"]
                if place_id is None or place_id not in places:
                    raise SyncError(f"bookmark row {row_id} has no URL")
                bookmark: dict[str, Any] = {"name": row["title"]}
                bookmark_tags = sorted(tags.get(place_id, ()), key=str.casefold)
                if bookmark_tags:
                    bookmark["tags"] = bookmark_tags
                if place_id in keywords:
                    bookmark["keyword"] = keywords[place_id]
                bookmark["url"] = places[place_id]
                return bookmark

            if row["type"] == FOLDER:
                next_ancestors = ancestors | {row_id}
                return {
                    "name": row["title"],
                    "bookmarks": [
                        convert(child, next_ancestors) for child in children[row_id]
                    ],
                }

            raise SyncError(
                f"bookmark row {row_id} uses unsupported type {row['type']}"
            )

        toolbar_root = roots["toolbar"]
        menu_root = roots["menu"]
        assert toolbar_root is not None and menu_root is not None
        settings: list[Any] = [
            {
                "name": "Bookmarks Toolbar",
                "toolbar": True,
                "bookmarks": [
                    convert(child, frozenset({toolbar_root}))
                    for child in children[toolbar_root]
                ],
            }
        ]
        settings.extend(
            convert(child, frozenset({menu_root})) for child in children[menu_root]
        )

        for root_name, display_name in (
            ("unfiled", "Other Bookmarks"),
            ("mobile", "Mobile Bookmarks"),
        ):
            root_id = roots[root_name]
            assert root_id is not None
            if children[root_id]:
                warnings.append(
                    f"{display_name} is represented as a regular folder because Home Manager has no matching root"
                )
                settings.append(
                    {
                        "name": display_name,
                        "bookmarks": [
                            convert(child, frozenset({root_id}))
                            for child in children[root_id]
                        ],
                    }
                )

        counts = {"bookmarks": 0, "folders": 0, "separators": 0}

        def count(nodes: list[Any]) -> None:
            for node in nodes:
                if node == "separator":
                    counts["separators"] += 1
                elif "url" in node:
                    counts["bookmarks"] += 1
                else:
                    counts["folders"] += 1
                    count(node["bookmarks"])

        count(settings)
        return settings, warnings, counts
    except sqlite3.DatabaseError as error:
        if "locked" in str(error).lower():
            raise SyncError(
                "Firefox is using places.sqlite; close Firefox and run the command again"
            ) from error
        raise SyncError(f"cannot read {database}: {error}") from error
    finally:
        connection.close()


def render_json(settings: list[Any]) -> str:
    return json.dumps(settings, ensure_ascii=False, indent=2) + "\n"


def read_existing(output: Path) -> str:
    if not output.exists():
        return ""
    try:
        return output.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as error:
        raise SyncError(f"cannot read {output}: {error}") from error


def show_diff(output: Path, current: str, generated: str) -> None:
    diff = difflib.unified_diff(
        current.splitlines(keepends=True),
        generated.splitlines(keepends=True),
        fromfile=str(output),
        tofile=f"{output} (generated)",
    )
    sys.stdout.writelines(diff)


def atomic_write(output: Path, content: str) -> None:
    if not output.parent.is_dir():
        raise SyncError(f"output directory does not exist: {output.parent}")

    temporary: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            mode="w",
            encoding="utf-8",
            dir=output.parent,
            prefix=f".{output.name}.",
            delete=False,
        ) as handle:
            temporary = Path(handle.name)
            handle.write(content)
            handle.flush()
            os.fsync(handle.fileno())
        temporary.chmod(0o644)
        os.replace(temporary, output)
        temporary = None
    except OSError as error:
        raise SyncError(f"cannot write {output}: {error}") from error
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


def run() -> int:
    args = parse_args()
    try:
        profile = find_profile(args.profile_dir)
        output = resolve_output(args)
        settings, warnings, counts = load_bookmarks(profile / "places.sqlite")
        generated = render_json(settings)
        current = read_existing(output)

        for warning in warnings:
            print(f"warning: {warning}", file=sys.stderr)

        if current == generated:
            print(f"Bookmarks are already up to date: {output}")
            return 0

        if args.dry_run:
            show_diff(output, current, generated)
            print(
                f"Would export {counts['bookmarks']} bookmarks, "
                f"{counts['folders']} folders, and {counts['separators']} separators."
            )
            return 0

        atomic_write(output, generated)
        print(
            f"Exported {counts['bookmarks']} bookmarks, "
            f"{counts['folders']} folders, and {counts['separators']} separators to {output}"
        )
        return 0
    except SyncError as error:
        print(f"error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(run())
