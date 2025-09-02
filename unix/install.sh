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
unzip "$ZIP_NAME" "f360-vision-$BRANCH/*" "f360-vision-$BRANCH/**/*" -d "$TARGET_DIR"

# Delete the zip
rm -f "$ZIP_NAME"

# Enter the extracted repo directory
cd "$TARGET_DIR"

# Copy contents to target directory
cp -r unix/* .

# Remove extracted folders
rm -rf unix winos docs

# Run setup script
bash setup.sh
