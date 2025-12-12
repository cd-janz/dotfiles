#!/usr/bin/env python3
import json
import subprocess
from sys import exit

def get_label(index: int) -> str:
    if 0 < index > 9:
        exit()
    _LABELS: list[str] = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X']
    return _LABELS[index]

def get_workspaces(focus: int):
    ws_query = subprocess.run("wmctrl -d | wc -l", shell=True, capture_output=True, check=True, text=True)
    num_ws = ws_query.stdout.strip()
    ws_active_query = subprocess.run("wmctrl -l | awk '{print $2}' | sort -u", shell=True, capture_output=True, check=True, text=True)
    ws_active = ws_active_query.stdout.split("\n")
    result = []
    for i in range(1, int(num_ws)+1):
        active = str(i-1) in ws_active
        focused = i-1 == focus
        if not active and not focused:
            continue
        index = i-1
        result.append({"id": index, "workspaces": i, "label": get_label(index) , "active": active, "focused": focused})
    return result

def listen_changes():
    process = subprocess.Popen(
        ["xprop", "-spy", "-root", "_NET_CURRENT_DESKTOP"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
        bufsize=1
    )

    if not process.stdout:
        exit(1)

    for line in process.stdout:
        line = line.strip()
        if not line:
            continue
        focus = int(line.split('=')[1])
        json_temp = get_workspaces(focus);
        json_output = json.dumps(json_temp, ensure_ascii=False)
        print(json_output, flush=True)

if __name__ == "__main__":
    try:
        listen_changes()
    except KeyboardInterrupt:
        pass
