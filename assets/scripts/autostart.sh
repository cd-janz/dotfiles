#!/bin/bash
CURRENT_TWM="$DESKTOP_SESSION"
CURRENT_ST="$XDG_SESSION_TYPE"
if [[ "$CURRENT_ST" == "x11" ]]; then
  CURRENT_RES_RAW="$(xrandr | grep -m 1 'Screen 0' | awk '{print $8"x"$10}')"
  CURRENT_RES=$(echo "$CURRENT_RES_RAW" | tr -d ',')
  if [[ "$CURRENT_RES" != "1920x1080" ]]; then
    echo "Current res ($CURRENT_RES) it's not 1920x1080. Fixing..."
    xrandr --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-2 --off &
  fi
  if ! pgrep -x picom > /dev/null; then
    echo "Picom it's not running. Starting..."
    picom -b &
  fi
  if ! pacman -Q xwallpaper &> /dev/null; then
    echo "XWallpaper ain't installed, installing..."
    sudo pacman -S xwallpaper
  fi
  xwallpaper --stretch ~/dotfiles/Pictures/Wallpapers/japanese_landscape.jpeg &
  if ! pacman -Q polybar &> /dev/null; then
    echo "Polybar ain't installed, installing now..."
    sudo pacman -S polybar
  fi
  if ! pgrep -x polybar > /dev/null; then
    polybar &
  else
    pkill polybar
    polybar &
  fi
fi
