#!/usr/bin/env python3
import json
import shutil
import subprocess
import time
import unicodedata

MAX_UNITS = 20.0
TICK = 0.30
QUERY_EVERY = 2

def char_w(ch: str) -> float:
    if unicodedata.east_asian_width(ch) in ("W", "F"):
        return 1.75
    if ch in "ilIjftr.,:;!|' ":
        return 0.55
    if ch in "WMmwGOQD@#%&":
        return 1.30
    return 1.0

def str_w(s: str) -> float:
    return sum(char_w(c) for c in s)

def slice_units(s: str, start: int, max_units: float) -> str:
    n = len(s)
    res = []
    units = 0.0
    i = start
    while True:
        ch = s[i % n]
        w = char_w(ch)
        if units + w > max_units:
            break
        res.append(ch)
        units += w
        i += 1
    return "".join(res)

def query_player():
    if not shutil.which("playerctl"):
        return None
    fmt = "{{status}}\x1f{{title}}\x1f{{artist}}\x1f{{album}}\x1f{{playerName}}"
    try:
        out = subprocess.check_output(
            ["playerctl", "metadata", "--format", fmt],
            stderr=subprocess.DEVNULL,
            text=True,
            timeout=1,
        ).rstrip("\n")
        parts = out.split("\x1f")
        if len(parts) == 5:
            return parts
    except Exception:
        pass
    return None

last_label = ""
offset = 0
tick_cnt = 0
cached = None

while True:
    if tick_cnt % QUERY_EVERY == 0 or cached is None:
        cached = query_player()
    tick_cnt += 1

    if not cached or cached[0] == "Stopped" or not cached[1]:
        last_label = ""
        offset = 0
        print(json.dumps({"text": "", "tooltip": "", "class": "stopped"}), flush=True)
        time.sleep(TICK)
        continue

    status, title, artist, album, player = cached
    label = f"{title} - {artist}" if artist else title

    if label != last_label:
        last_label = label
        offset = 0

    icon = "▶" if status == "Playing" else "⏸"
    if str_w(label) <= MAX_UNITS:
        shown = label
        cls = status.lower()
    else:
        loop_str = label + "   ·   "
        shown = slice_units(loop_str, offset, MAX_UNITS)
        if status == "Playing":
            offset = (offset + 1) % len(loop_str)
        cls = f"{status.lower()} scrolling"

    tip_lines = [f"{player} ({status})", label]
    if album:
        tip_lines.append(f"[{album}]")

    print(
        json.dumps({
            "text": f"{icon} {shown}",
            "tooltip": "\n".join(tip_lines),
            "class": cls,
        }),
        flush=True,
    )
    time.sleep(TICK)