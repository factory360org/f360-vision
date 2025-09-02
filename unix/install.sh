#!/usr/bin/env bash
set -e

# Usage: ./install.sh [target_directory]
TARGET_DIR="${1:-$(pwd)}"

REPO_URL="https://github.com/factory360org/f360-vision"
BRANCH="main"
ZIP_NAME="f360-vision.zip"

# print target_dir
echo "Target directory: $TARGET_DIR"

# Download repo as zip
curl -fsSL "$REPO_URL/archive/$BRANCH.zip" -o "$ZIP_NAME"

# Unzip to target directory
unzip "$ZIP_NAME" -d "$TARGET_DIR"

# Delete the zip
rm -f "$ZIP_NAME"

mv "f360-vision-$BRANCH"/* "$TARGET_DIR"

# Enter the extracted repo directory
cd "$TARGET_DIR"

# Copy contents to target directory
cp -r unix/* .

# Remove extracted folders
rm -rf f360-vision-$BRANCH unix winos docs .gitignore

# Run setup script
bash setup.sh
