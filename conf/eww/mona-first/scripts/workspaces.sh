#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Not arguments provided"
  exit 1
fi

if [[ "$1" == "-w" || "$1" == "--workspaces" ]]; then
  NUM_WORKSPACES=$(wmctrl -d | wc -l)
  MANDATORY=0

  if [[ -z "$2" ]]; then
    MANDATORY=$NUM_WORKSPACES
  else
    if ! [[ "$2" =~ ^[0-9]+$ ]]; then
      echo "Usage: $0 -w [NUM_MANDATORY_WORKSPACES]"
      exit 1
    fi
    if [ "$2" -gt 0 ] && [ "$2" -le "$NUM_WORKSPACES" ]; then
      MANDATORY="$2"
    else
      echo "Error: [NUM_MANDATORY_WORKSPACES] <= $NUM_WORKSPACES"
      exit 1
    fi
  fi

  ACTIVE_WORKSPACES=$(wmctrl -l | awk '{print $2}' | sort -u)
  
  JSON="["
  for ((i=0; i<NUM_WORKSPACES; i++)); do
    workspace=$(( (i + 1) % 10 ))
    [[ $workspace -eq 0 ]] && workspace=0  # por si llega a 10

    if echo "$ACTIVE_WORKSPACES" | grep -q "^$i$"; then
      active=true
    else
      active=false
    fi

    if [ "$i" -lt "$MANDATORY" ]; then
      mandatory=true
    else
      mandatory=false
    fi

    JSON+="{\"id\":$i,\"workspace\":$workspace,\"active\":$active,\"mandatory\":$mandatory}"

    if [ "$i" -lt $((NUM_WORKSPACES - 1)) ]; then
      JSON+=","
    fi
  done
  JSON+="]"

  echo "$JSON"
fi
