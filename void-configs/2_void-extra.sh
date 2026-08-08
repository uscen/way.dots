#!/usr/bin/env bash
# =============================================================================== #
# Extra:                                                                          #
# =============================================================================== #
# Define the local NPM path: =====================================================================
NPM_PACKAGES="${HOME}/.local/share/npm-packages"

# Set up the environment for the current session: ================================================
export PATH="$HOME/.config/bin:$HOME/.cargo/bin:$HOME/.local/bin:$NPM_PACKAGES/bin:$PATH"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# Configure NPM to actually use this local directory for global installs: ========================
if command -v npm &> /dev/null; then
    npm config set prefix "$NPM_PACKAGES"
else
    echo "Error: npm is not installed. Please install it with xbps-install -S nodejs first."
    exit 1
fi

# =============================================================================== #
# Packages:                                                                       #
# =============================================================================== #
packages=(
    "@typescript/native-preview"
    "@olrtg/emmet-language-server"
    "@tailwindcss/language-server"
    "vscode-langservers-extracted"
    "prettier"
    "tree-sitter-cli"
    "browser-sync"
)
for package in "${packages[@]}"; do
    echo "Installing $package..."
    npm install -g "$package"
done
echo "Installation Packages Is Complete!"
