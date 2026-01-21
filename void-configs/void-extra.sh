#!/bin/bash
# =============================================================================== #
# List Packages:                                                                  #
# =============================================================================== #
packages=(
    # PACKAGE MANAGER:                                                                #
    # =============================================================================== #
    "bun"
    "yarn"
    "pnpm"
    # TREE-SITER:                                                                     #
    # =============================================================================== #
    "tree-sitter-cli"
    # LANGUAGE SERVER PROTOCOL:                                                       #
    # =============================================================================== #
    "@typescript/native-preview"
    "@olrtg/emmet-language-server"
    "@tailwindcss/language-server"
    "vscode-langservers-extracted"
    "prettier"
    # HOT-RELOAD:                                                                     #
    # =============================================================================== #
    "browser-sync"
)
# =============================================================================== #
# NPM Packages:                                                                   #
# =============================================================================== #
for package in "${packages[@]}"; do
    echo "Installing $package..."
    npm install -g "$package"
done
echo "Installation Of NPM Packages Is Complete!"
