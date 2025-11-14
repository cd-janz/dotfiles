#!/bin/bash
CURRENT_TWM="$DESKTOP_SESSION"
CURRENT_ST="$XDG_SESSION_TYPE"
if [[ "$CURRENT_ST" == "x11" ]]; then
  CURRENT_RES_RAW="$(xrandr | grep -m 1 'Screen 0' | awk '{print $8"x"$10}')"
  CURRENT_RES=$(echo "$CURRENT_RES_RAW" | tr -d ',')
  if [[ "$CURRENT_RES" != "1920x1080" ]]; then
    echo "Current res ($CURRENT_RES) it's not 1920x1080. Fixing..."
    xrandr --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-1 --off &
  fi
  if ! pgrep -x picom > /dev/null; then
    echo "Picom it's not running. Starting..."
    picom -b &
  fi
  if ! pacman -Q xwallpaper &> /dev/null; then
    echo "XWallpaper ain't installed, installing..."
    sudo pacman -S xwallpaper
  fi
  if pacman -Q eww &> /dev/null; then
    eww open bar &
  fi
  xwallpaper --stretch ~/dotfiles/assets/pictures/wallpapers/mona.jpg &
fi
