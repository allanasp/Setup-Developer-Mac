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
    if brew install --cask "${font}"; then
        print_success "${font} installed"
    else
        print_warning "${font} installation failed or already exists"
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
echo "📋 TODO: Configure Developer Fonts"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ VS Code Font Setup"
echo "  → Open VS Code Settings (⌘,)"
echo "  → Search 'font family'"
echo "  → Set to: 'Fira Code', 'JetBrains Mono', monospace"
echo "  → Search 'font ligatures' and enable"
echo ""
echo "□ Terminal Font Setup"
echo "  → iTerm2: Preferences → Profiles → Text → Font"
echo "  → Choose 'Fira Code' or 'JetBrains Mono'"
echo "  → Size: 14pt recommended"
echo ""
echo "□ Other Editors"
echo "  → Cursor: Same font settings as VS Code"
echo "  → Zed: Settings → Font Family"
echo ""
echo "✨ Font Features You'll Love:"
echo "• Ligatures: !== becomes ≠, => becomes →"
echo "• Clear 0 vs O distinction"
echo "• Better code readability"
echo "• Professional appearance"
echo ""
echo "🎉 Setup completed! All category scripts have been run."
