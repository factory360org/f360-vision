#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/factory360org/f360-vision"
BRANCH="main"

# Download repo as zip
curl -fsSL "$REPO_URL/archive/$BRANCH.zip" -o "f360-vision.zip"


# Unzip to current directory
unzip -q "f360-vision.zip" -d .

# delete the zip
rm -f "f360-vision.zip"

cp -r unix/* .

rm -rf unix winos docs

# Run setup script
bash setup.sh
