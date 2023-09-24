#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
SCRIPT_NAME="$(basename "$0")"


for script in "$SCRIPT_DIR"/*; do
    # Check if the file is executable, not a directory, not the autorun.sh script,
    # and does not start with an underscore
    if [ -x "$script" ] && [ ! -d "$script" ] && [ "$script" != "$SCRIPT_DIR/$SCRIPT_NAME" ] && [[ "$(basename "$script")" != _* ]]; then
        # Run the script
        echo "Running $script..."
        "$script"
    fi
done