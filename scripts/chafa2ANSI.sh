#!/bin/bash

if ! command -v chafa &>/dev/null; then
  echo "❌ 'chafa' is not installed on your system."
  echo "💡 You can install it with:"
  echo "   sudo apt install chafa      # For Arch Linux/Manjaro"
  exit 1
fi

if [[ $# -lt 2 ]]; then
    echo "⚠️ Usage: $0 <image_path> <output_filename>"
    exit 1
fi

IMAGE_PATH="$1"
OUTPUT_DIR="$HOME/dotfiles/.assets/ansi"
OUTPUT_FILE="$OUTPUT_DIR/$2"

mkdir -p "$OUTPUT_DIR"

if [[ -f "$IMAGE_PATH" ]]; then
    echo "🎨 Generating ANSI art from: $IMAGE_PATH"
    chafa "$IMAGE_PATH" --size=55x20 --stretch --color-space=rgb --symbols=ascii > "$OUTPUT_FILE"
    echo "✅ Output saved to: $OUTPUT_FILE"
else
    echo "⚠️ No image found at: $IMAGE_PATH"
    exit 1
fi
