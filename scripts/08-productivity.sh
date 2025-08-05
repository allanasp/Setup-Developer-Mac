#!/bin/bash

# Productivity Tools Setup
# Installs: Raycast, Rectangle, 1Password, Maccy, Obsidian, browsers, utilities

# Don't exit on errors for optional apps - continue installing others
# set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Productivity Tools Setup"

check_macos
check_homebrew

# Essential productivity tools
print_status "Installing productivity & development tools..."
install_cask_app "Raycast" "raycast" "/Applications/Raycast.app"
install_cask_app "Rectangle" "rectangle" "/Applications/Rectangle.app"
install_cask_app "Maccy" "maccy" "/Applications/Maccy.app"
install_cask_app "Obsidian" "obsidian" "/Applications/Obsidian.app"

# Additional browsers for testing
install_cask_app "Google Chrome" "google-chrome" "/Applications/Google Chrome.app"
install_cask_app "Firefox" "firefox" "/Applications/Firefox.app"
install_cask_app "Brave Browser" "brave-browser" "/Applications/Brave Browser.app"

# Developer utilities
install_cask_app "OrbStack" "orbstack" "/Applications/OrbStack.app"
install_cask_app "Postman" "postman" "/Applications/Postman.app"
install_cask_app "Figma" "figma" "/Applications/Figma.app"
install_cask_app "ImageOptim" "imageoptim" "/Applications/ImageOptim.app"
install_cask_app "WireGuard" "wireguard" "/Applications/WireGuard.app"

# Additional utility apps (optional - don't fail if some don't install)
install_cask_app "AppCleaner" "appcleaner" "/Applications/AppCleaner.app" || print_warning "AppCleaner installation failed - continuing..."
install_cask_app "Ice" "jordanbaird-ice" "/Applications/Ice.app" || print_warning "Ice installation failed - continuing..."
install_cask_app "Syncthing" "syncthing" "/Applications/Syncthing.app" || print_warning "Syncthing installation failed - continuing..."

# Note: System Color Picker package doesn't exist - use built-in Digital Color Meter instead

# Optional tools that may require user interaction
print_status "Installing optional network tools (may require password)..."
install_cask_app "Wireshark" "wireshark" "/Applications/Wireshark.app" || print_warning "Wireshark installation failed - may need manual installation"

print_success "Productivity tools setup completed!"
echo ""
echo "Installed productivity tools:"
echo "• Raycast (better Spotlight)"
echo "• Rectangle (window management)"
echo "• Maccy (clipboard manager)"
echo "• Obsidian (note-taking)"
echo ""
echo "Installed browsers:"
echo "• Google Chrome"
echo "• Firefox"
echo "• Brave Browser"
echo ""
echo "Installed utilities:"
echo "• OrbStack (Docker replacement)"
echo "• Postman (API testing)"
echo "• Figma (design)"
echo "• ImageOptim (image compression)"
echo "• AppCleaner (uninstaller)"
echo "• Ice (menubar organizer)"
echo "• Syncthing (file sync)"
echo "• WireGuard (VPN)"
echo "• Wireshark (network analysis - if installation succeeded)"
echo ""
echo "📋 TODO: Application Setup & Account Creation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ Raycast Setup (Spotlight Replacement)"
echo "  → Open Raycast"
echo "  → Create account at raycast.com or sign in"
echo "  → Set hotkey to ⌘Space (recommended)"
echo "  → Disable Spotlight: System Settings → Keyboard → Shortcuts → Spotlight"
echo ""
echo "□ Rectangle Configuration (Window Management)"
echo "  → Open Rectangle"
echo "  → Follow the setup wizard"
echo "  → Enable 'Launch on login'"
echo "  → Configure your preferred window shortcuts"
echo ""
echo "□ Maccy Setup (Clipboard Manager)"
echo "  → Open Maccy"
echo "  → Open Preferences (⌘,)"
echo "  → Check 'Launch at login'"
echo "  → Check 'Automatically check for updates'"
echo "  → Set your preferred hotkey (default: ⌘⇧C)"
echo ""
echo "□ Obsidian Configuration (Note-Taking)"
echo "  → Open Obsidian"
echo "  → Create new vault or open existing"
echo "  → Sign in for sync (optional)"
echo ""
echo "□ OrbStack Setup (Docker Desktop Alternative)"
echo "  → Open OrbStack"
echo "  → Complete initial setup"
echo "  → Sign in for additional features (optional)"
echo ""
echo "□ Postman Configuration (API Testing)"
echo "  → Open Postman"
echo "  → Create account at postman.com or sign in"
echo "  → Join your team workspace (if applicable)"
echo ""
echo "□ Figma Setup (Design Tool)"
echo "  → Open Figma"
echo "  → Sign in with Google/email at figma.com"
echo "  → Install Figma font helper (if prompted)"
echo ""
echo "□ Browser Setup"
echo "  → Sign in to Chrome/Firefox/Brave with your accounts"
echo "  → Import bookmarks and settings"
echo "  → Install password manager extensions"
echo ""
echo "Next steps:"
echo "• Complete the TODO items above for each application"
echo "• Run database tools setup: ./scripts/09-database.sh"
