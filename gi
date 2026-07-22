#!/bin/bash

if ! command -v fzf &> /dev/null; then
    echo "ERROR: 'fzf' not found."
    echo "macOS: brew install fzf  |  Ubuntu: sudo pacman -S fzf"
    exit 1
fi

LIST=$(curl -sL "https://gitignore.io/api/list" | tr ',' '\n' | sort)

if [ -z "$LIST" ]; then
    echo "ERROR: Failed to get list of gitignore templates."
    exit 1
fi

SELECTED=$(echo "$LIST" | fzf -m --preview "echo 'Selecting: {}'")

if [ -z "$SELECTED" ]; then
    echo "Cancelled"
    exit 0
fi

QUERY=$(echo "$SELECTED" | paste -sd "," -)

echo "Selected Environments: $QUERY"
echo "Generating .gitignore ..."

curl -sL "https://gitignore.io/api/$QUERY" > .gitignore

cat .gitignore
