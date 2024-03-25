#!/bin/bash

# Define the source directory where your dotfiles are stored
SOURCE_DIR="$HOME/.dotfiles"

# Define the target directory where your dotfiles should be copied to
TARGET_DIR="$HOME"

# List of dotfiles to be copied
DOTFILES=(
    ".gitconfig"
    ".zshrc",

)

# Function to copy a single dotfile
copy_dotfile() {
    local dotfile="$1"
    local source_path="$SOURCE_DIR/$dotfile"
    local target_path="$TARGET_DIR/$dotfile"

    if [ -f "$source_path" ]; then
        echo "Copying $dotfile to $TARGET_DIR"
        cp "$source_path" "$target_path"
    else
        echo "Error: $dotfile not found in $SOURCE_DIR"
    fi
}

# Loop through each dotfile and copy it
for dotfile in "${DOTFILES[@]}"; do
    copy_dotfile "$dotfile"
done

echo "Dotfiles setup complete."