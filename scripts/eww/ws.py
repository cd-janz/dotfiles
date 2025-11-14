#!/usr/bin/env python3
import json
import subprocess
from sys import argv, exit
from os import path

if len(argv) > 3:
    print("[]")
    exit(1)

if argv[1] != "-w" and not isinstance(argv[2], (int)):
    print("[]")
    exit(1)


def get_image_path(active: bool, focused: bool = False):
    if focused:
        return "󰮯"
    elif active:
        return "󰊠"
    else:
        return ""


def get_workspaces(focus: int):
    ws_query = subprocess.run("wmctrl -d | wc -l", shell=True, capture_output=True, check=True, text=True)
    num_ws = ws_query.stdout.strip()
    ws_active_query = subprocess.run("wmctrl -l | awk '{print $2}' | sort -u", shell=True, capture_output=True, check=True, text=True)
    ws_active = ws_active_query.stdout.split("\n")
    mandatory: int = int(argv[2])
    result = []
    for i in range(1, int(num_ws)+1):
        if len(ws_active) -1 >= mandatory and not str(i-1) in ws_active and i-1 != focus:
            continue
        elif not str(i-1) in ws_active and i-1 != focus and i > mandatory:
            continue
        active = str(i-1) in ws_active
        focused = i-1 == focus
        print(f"workspace: {i};isActive: {active}; isFocused: {focused}")
        result.append({
            "id": i - 1, "workspaces": i, "label": get_image_path(active, focused), "active": active,
            "mandatory": i <= mandatory, "focused": focused
            })
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
