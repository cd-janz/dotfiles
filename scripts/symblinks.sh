#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <target folder> <folder output>"
  exit 1
fi

target="$1"
output="$2"

if [ ! -d "$target" ]; then
  echo "Error: target folder '$target' don't exists."
  exit 1
fi

if [ ! -d "$output" ]; then
  echo "Warning: output folder '$output' don't exists, creating...."
  mkdir -p $output
fi

i=1
paths=()
check_icon="  "
cross_icon="  "

for dir in "$target"/*; do
  if [ -d "$dir" ]; then
    dirname=$(basename "$dir")
    link_path="$output/$dirname"
    if [ -L "$link_path" ]; then
      status="[$check_icon]"
    else
      status="[$cross_icon]"
    fi
    printf "[%d] %-30s %s\n" "$i" "$dirname" "$status"
    paths+=("$dir")
    ((i++))
  fi
done

echo "----------------------------------------"
read -p "👉 Enter the numbers of the directories you want to send to output (ex: 1 3 5): " -a selection

echo
if [ ${#selection[@]} -gt 0 ]; then
  echo "🚀 Sending the following directories to '$output':"
else
  echo "ℹ️ No directories were selected."
  exit 0
fi
echo

for idx in "${selection[@]}"; do
  if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx > 0 && idx <= ${#paths[@]} )); then
    dir="${paths[$((idx-1))]}"
    dirname=$(basename "$dir")
    link_path="$output/$dirname"
    
    if [ -L "$link_path" ]; then
      rm "$link_path"
      echo "🗑️ Deleted symlink: $dirname"
    else
      ln -s "$dir" "$link_path"
      echo "🔗 Created symlink: $dirname"
    fi
  else
    echo "⚠️  Invalid index: $idx"
  fi
done

echo
echo "✅ Process completed."
