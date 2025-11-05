#!/usr/bin/env bash
#
# monita.sh - Hyprland Monitor Configuration Manager
# Manages monitor configurations by updating the source file dynamically

set -euo pipefail

# Configuration paths
HYPR_CONFIG_DIR="${HOME}/.config/hypr"
SOURCE_FILE="${HYPR_CONFIG_DIR}/monitor-source.conf"

# Monitor configuration options
declare -A MONITOR_CONFIGS=(
    ["dual"]="source = ~/.config/hypr/monitor-dual.conf"
    ["mirror"]="source = ~/.config/hypr/monitor-mirror.conf"
    ["single"]="source = ~/.config/hypr/monitor-single.conf"
)

# Check if gum is installed
if ! command -v gum &> /dev/null; then
    echo "Error: gum is not installed. Please install it first."
    echo "Visit: https://github.com/charmbracelet/gum"
    exit 1
fi

# Ensure the Hyprland config directory exists
if [[ ! -d "$HYPR_CONFIG_DIR" ]]; then
    echo "Error: Hyprland config directory not found: $HYPR_CONFIG_DIR"
    exit 1
fi

# Present monitor configuration options
echo "Select monitor configuration:"
CHOICE=$(gum choose "dual" "mirror" "single")

# Get the corresponding source line
SOURCE_LINE="${MONITOR_CONFIGS[$CHOICE]}"

# Write the source line to monitor-source.conf
echo "$SOURCE_LINE" > "$SOURCE_FILE"

# Success message
echo "✅ Monitor configuration updated to: $CHOICE"
echo "Configuration: $SOURCE_LINE"
