#!/usr/bin/env bash
set -e

# Usage: ./install.sh [target_directory]
TARGET_DIR="${1:-$(pwd)}"

REPO_URL="https://github.com/factory360org/f360-vision"
BRANCH="main"
ZIP_NAME="f360-vision.zip"

# Download repo as zip
curl -fsSL "$REPO_URL/archive/$BRANCH.zip" -o "$ZIP_NAME"

# Unzip to target directory
unzip -q "$ZIP_NAME" -d "$TARGET_DIR"

# Delete the zip
rm -f "$ZIP_NAME"

cd "$TARGET_DIR"

# Copy contents to target directory (if not already in place)
cp -r "unix"/* .

# Remove extracted folders
rm -rf "unix" "winos" "docs"
bash setup.sh
