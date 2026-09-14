#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/AmaseCocoa/cocoa-useful-scripts.git"
INSTALL_DIR="${HOME}/.local/share/cocoa-useful-scripts"

echo "Bootstrapping tools repository..."

if [[ -d "${INSTALL_DIR}/.git" ]]; then
    echo "Repository already exists at ${INSTALL_DIR}. Updating..."
    git -C "${INSTALL_DIR}" pull origin "$(git -C "${INSTALL_DIR}" rev-parse --abbrev-ref HEAD)"
else
    echo "Cloning repository to ${INSTALL_DIR}..."
    mkdir -p "$(dirname "${INSTALL_DIR}")"
    git clone "${REPO_URL}" "${INSTALL_DIR}"
fi

chmod +x "${INSTALL_DIR}/bin/csmanage"

echo ""
echo "Installation complete."

if [[ ":$PATH:" != *":${INSTALL_DIR}/bin:"* ]]; then
    echo "Notice: ${INSTALL_DIR}/bin is not in your PATH."
    echo "Add the following line to your ~/.bashrc or ~/.zshrc:"
    echo "  export PATH=\"${INSTALL_DIR}/bin:\$PATH\""
    echo ""
fi

echo "Run 'csmanage' to select and toggle tools."
