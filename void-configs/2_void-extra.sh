#!/usr/bin/env bash
# =============================================================================== #
# Packages:                                                                       #
# =============================================================================== #
packages=(
    # LANGUAGE SERVER PROTOCOL:                                                       #
    # =============================================================================== #
    "@typescript/native-preview"
    "@olrtg/emmet-language-server"
    "@tailwindcss/language-server"
    "vscode-langservers-extracted"
    "prettier"
    # Treesitter:                                                                     #
    # =============================================================================== #
    "tree-sitter-cli"
    # HOT-RELOAD:                                                                     #
    # =============================================================================== #
    "browser-sync"
)
for package in "${packages[@]}"; do
    echo "Installing $package..."
    npm install -g "$package"
done
echo "Installation Packages Is Complete!"
