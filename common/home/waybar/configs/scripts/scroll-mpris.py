#!/usr/bin/env python3
import json
import os
import re
import shutil
import subprocess
import time
import unicodedata

MAX_UNITS = 50.0
TICK = 0.28
LOOKAHEAD = 0.15
LRC_REFRESH_TICKS = 4
TS_RE = re.compile(r"\[(\d{1,3}):(\d{2})(?:[.:](\d{1,3}))?\]")
COPY_FILE = os.path.join(os.environ.get("XDG_RUNTIME_DIR", "/tmp"), "waybar-current-lyric")

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

def parse_lrc(raw: str):
    by_ts = {}
    for line in raw.splitlines():
        matches = list(TS_RE.finditer(line))
        if not matches:
            continue
        lyric = TS_RE.sub("", line).strip()
        if not lyric:
            continue
        for m in matches:
            mins = int(m.group(1))
            secs = int(m.group(2))
            frac = float(f"0.{m.group(3)}") if m.group(3) else 0.0
            ts = mins * 60.0 + secs + frac
            if ts not in by_ts:
                by_ts[ts] = [lyric, ""]
            elif not by_ts[ts][1] and lyric != by_ts[ts][0]:
                by_ts[ts][1] = lyric
    return sorted((ts, v[0], v[1]) for ts, v in by_ts.items())

def query_state():
    if not shutil.which("playerctl"):
        return None
    fmt = "{{status}}\x1f{{position}}\x1f{{title}}\x1f{{artist}}\x1f{{album}}\x1f{{playerName}}"
    try:
        out = subprocess.check_output(
            ["playerctl", "metadata", "--format", fmt],
            stderr=subprocess.DEVNULL,
            text=True,
            timeout=1,
        ).rstrip("\n")
        parts = out.split("\x1f")
        if len(parts) == 6:
            status, pos_us, title, artist, album, player = parts
            pos_sec = int(pos_us) / 1_000_000.0 if pos_us.isdigit() else 0.0
            return status, pos_sec, title, artist, album, player
    except Exception:
        pass
    return None

def query_raw_lrc(player: str) -> str:
    try:
        cmd = ["playerctl"]
        if player:
            cmd += ["-p", player]
        cmd += ["metadata", "xesam:asText"]
        return subprocess.check_output(cmd, stderr=subprocess.DEVNULL, text=True, timeout=1)
    except Exception:
        return ""

def write_copy_cache(text: str):
    try:
        with open(COPY_FILE, "w", encoding="utf-8") as f:
            f.write(text)
    except Exception:
        pass

last_track = None
last_raw_lrc = ""
stale_raw_lrc = None
lrc_lines = []
last_display_src = ""
last_copied_cache = None
offset = 0
tick_cnt = 0

while True:
    state = query_state()
    if not state or state[0] == "Stopped" or not state[2]:
        last_track = None
        last_raw_lrc = ""
        stale_raw_lrc = None
        lrc_lines = []
        last_display_src = ""
        offset = 0
        tick_cnt = 0
        if last_copied_cache != "":
            write_copy_cache("")
            last_copied_cache = ""
        print(json.dumps({"text": "", "tooltip": "", "class": ["stopped"]}), flush=True)
        time.sleep(0.5)
        continue

    status, pos_sec, title, artist, album, player = state
    track = (player, title, artist)

    if track != last_track:
        last_track = track
        stale_raw_lrc = last_raw_lrc if last_raw_lrc else None
        lrc_lines = []
        last_display_src = ""
        offset = 0
        tick_cnt = 0

    if tick_cnt % LRC_REFRESH_TICKS == 0:
        raw = query_raw_lrc(player)
        if raw != stale_raw_lrc and raw != last_raw_lrc:
            stale_raw_lrc = None
            last_raw_lrc = raw
            lrc_lines = parse_lrc(raw) if raw.strip() else []
            offset = 0
    tick_cnt += 1

    song_label = f"{title} - {artist}" if artist else title

    # 查找当前歌词；前奏/无歌词时回退显示歌名-歌手
    cur_idx = -1
    if lrc_lines:
        t = pos_sec + LOOKAHEAD
        for idx, (ts, _, _) in enumerate(lrc_lines):
            if ts <= t:
                cur_idx = idx
            else:
                break

    if cur_idx >= 0:
        _, lyric, trans = lrc_lines[cur_idx]
        display_src = lyric
    else:
        lyric, trans = "", ""
        display_src = song_label

    if display_src != last_display_src:
        last_display_src = display_src
        offset = 0

    # 把完整歌词（无歌词时为歌名）写入缓存文件，供左键一键复制
    if display_src != last_copied_cache:
        write_copy_cache(display_src)
        last_copied_cache = display_src

    if str_w(display_src) <= MAX_UNITS:
        shown = display_src
        cls = [status.lower()]
    else:
        loop_str = display_src + "   ·   "
        shown = slice_units(loop_str, offset, MAX_UNITS)
        if status == "Playing":
            offset = (offset + 1) % len(loop_str)
        cls = [status.lower(), "scrolling"]

    # tooltip 首行永远放歌名-歌手
    tip_lines = [song_label]
    if album:
        tip_lines.append(f"[{album}]")
    if lyric:
        tip_lines.append("")
        tip_lines.append(lyric)
        if trans:
            tip_lines.append(trans)
    tip_lines.append(f"\n({player} · {status})")

    print(
        json.dumps({
            "text": shown,
            "tooltip": "\n".join(tip_lines),
            "class": cls,
        }),
        flush=True,
    )
    time.sleep(TICK)