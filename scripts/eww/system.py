#!/usr/bin/env python3
import psutil
from sys import exit, argv

if len(argv) != 2:
    exit("Usage: %s -ram | -disk | -cpu | -gpu" % argv[0])

def get_ram_usage_percent():
    mem = psutil.virtual_memory()
    print(f"{mem.percent}%")
def get_disk_usage_percent():
    disk = psutil.disk_usage('/')
    print(f"{disk.percent}%")
def get_cpu_usage_percent():
    cpu = psutil.cpu_percent(percpu=False, interval=0.5)
    print(f"{cpu}%")

if __name__ == "__main__":
    if argv[1] == "-ram":
        get_ram_usage_percent()
    elif argv[1] == "-disk":
        get_disk_usage_percent()
    elif argv[1] == "-cpu":
        get_cpu_usage_percent()
    exit(0)