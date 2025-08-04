#!/bin/bash

# Developer Fonts Setup
# Installs: Nerd Fonts and other programming fonts

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Developer Fonts Setup"

check_macos
check_homebrew

# Fonts for development
print_status "Installing developer fonts..."
brew tap homebrew/cask-fonts 2>/dev/null || print_warning "Font tap already exists"

# Install fonts with error handling
fonts=(
    "font-fira-code"
    "font-jetbrains-mono" 
    "font-source-code-pro"
    "font-hack-nerd-font"
)

for font in "${fonts[@]}"; do
    if brew install --cask "$font"; then
        print_success "$font installed"
    else
        print_warning "$font installation failed or already exists"
    fi
done

print_success "Developer fonts setup completed!"
echo ""
echo "Installed fonts:"
echo "• Fira Code (ligatures)"
echo "• JetBrains Mono (ligatures)"
echo "• Source Code Pro (Adobe)"
echo "• Hack Nerd Font (icons + ligatures)"
echo ""
echo "These fonts are now available in:"
echo "• Terminal applications (iTerm2, Warp)"
echo "• Code editors (VS Code, Cursor, Zed)"
echo "• System font picker"
echo ""
echo "Setup completed! All category scripts have been run."