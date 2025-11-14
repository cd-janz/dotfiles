#!/usr/bin/env bash

# ===============================
# Función: convertir número a romano
# ===============================
to_roman() {
  case $1 in
    0) echo "X" ;;
    1) echo "I" ;;
    2) echo "II" ;;
    3) echo "III" ;;
    4) echo "IV" ;;
    5) echo "V" ;;
    6) echo "VI" ;;
    7) echo "VII" ;;
    8) echo "VIII" ;;
    9) echo "IX" ;;
    *) echo "$1" ;;
  esac
}

# ===============================
# Función: generar JSON de workspaces
# ===============================
generate_json() {
  NUM_WORKSPACES=$(wmctrl -d | wc -l)
  MANDATORY=$1

  ACTIVE_WORKSPACES=$(wmctrl -l | awk '{print $2}' | sort -u)
  current=$(wmctrl -d | awk '/\*/ {print $1}')
  aux_current=$((current + 1))  # Ajustar a escala 1–10

  JSON="["
  first=true

  for ((i=1; i<=NUM_WORKSPACES; i++)); do
    workspace=$(( i % NUM_WORKSPACES ))

    active=$(echo "$ACTIVE_WORKSPACES" | grep -q "^$workspace$" && echo "true" || echo "false")
    mandatory=$([ "$workspace" -lt "$MANDATORY" ] && echo "true" || echo "false")

    if [ "$active" = "false" ] && [ "$mandatory" = "false" ] && [ "$workspace" -ne "$aux_current" ]; then
      continue
    fi

    label=$(to_roman "$workspace")

    if [ "$first" = true ]; then
      first=false
    else
      JSON+=","
    fi

    JSON+="{\"id\":$workspace,\"workspace\":$workspace,\"label\":\"$label\",\"active\":$active,\"mandatory\":$mandatory"

    if [ "$workspace" -eq "$aux_current" ]; then
      JSON+=",\"focused\":true"
    else
      JSON+=",\"focused\":false"
    fi

    JSON+="}"
  done

  JSON+="]"
  echo "$JSON"
}

# ===============================
# Inicio
# ===============================
MANDATORY=${2:-0}

# Imprimir el estado inicial
generate_json "$MANDATORY"

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  xprop -spy -root _NET_CURRENT_DESKTOP _NET_CLIENT_LIST _NET_CLIENT_LIST_STACKING |
  while read -r _; do
    generate_json "$MANDATORY"
  done

elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  # 🔹 Wayland: soporta Hyprland y Sway
  if command -v hyprctl &>/dev/null; then
    hyprctl -j activeworkspace -m | while read -r _; do
      generate_json "$MANDATORY"
    done
  elif command -v swaymsg &>/dev/null; then
    swaymsg -t subscribe '["workspace"]' | while read -r _; do
      generate_json "$MANDATORY"
    done
  else
    echo "Error: no se detectó compositor Wayland compatible" >&2
    exit 1
  fi
else
  echo "Error: entorno no detectado (XDG_SESSION_TYPE=$XDG_SESSION_TYPE)" >&2
  exit 1
fi
