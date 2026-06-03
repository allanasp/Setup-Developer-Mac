#!/bin/bash

# Productivity Tools Setup
# Installs: Rectangle, Maccy, Obsidian, browsers, utilities

set -e # Exit on any error (install helpers are graceful and never abort)

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Productivity Tools Setup"

check_macos
check_homebrew

# Essential productivity tools
print_status "Installing productivity & development tools..."
install_cask_app "Rectangle" "rectangle" "/Applications/Rectangle.app"
install_cask_app "Maccy" "maccy" "/Applications/Maccy.app"
install_cask_app "Obsidian" "obsidian" "/Applications/Obsidian.app"

# 1Password CLI
print_status "Checking 1Password CLI..."
if command_exists op; then
    op_version=$(op --version 2>/dev/null || echo "unknown")
    print_success "1Password CLI already installed (${op_version})"
elif is_dry_run; then
    print_status "[dry-run] would install 1Password CLI (brew 1password-cli)"
else
    print_status "Installing 1Password CLI..."
    if brew install 1password-cli 2>/dev/null; then
        # Verify installation
        if command_exists op; then
            print_success "1Password CLI installed successfully ($(op --version))"
        else
            print_error "1Password CLI installation completed but 'op' command not found"
            print_status "Try manually: brew install 1password-cli"
        fi
    else
        print_error "Failed to install 1Password CLI"
        print_warning "Continuing without 1Password CLI..."
    fi
fi

# Additional browsers for testing
install_cask_app "Google Chrome" "google-chrome" "/Applications/Google Chrome.app"
install_cask_app "Firefox" "firefox" "/Applications/Firefox.app"
install_cask_app "Brave Browser" "brave-browser" "/Applications/Brave Browser.app"

# Developer utilities
install_cask_app "OrbStack" "orbstack" "/Applications/OrbStack.app"
install_cask_app "Postman" "postman" "/Applications/Postman.app"
install_cask_app "Mockoon" "mockoon" "/Applications/Mockoon.app"
install_cask_app "Expo Orbit" "expo-orbit" "/Applications/Expo Orbit.app"
install_cask_app "Figma" "figma" "/Applications/Figma.app"
install_cask_app "ImageOptim" "imageoptim" "/Applications/ImageOptim.app"
install_cask_app "WireGuard" "wireguard" "/Applications/WireGuard.app"
install_cask_app "DevToys" "devtoys" "/Applications/DevToys.app"
install_cask_app "Signal" "signal" "/Applications/Signal.app"
install_cask_app "WiFiman" "wifiman" "/Applications/WiFiman Desktop.app"

# Additional utility apps (optional - the helper warns and continues on failure)
install_cask_app "AppCleaner" "appcleaner" "/Applications/AppCleaner.app"
install_cask_app "Ice" "jordanbaird-ice" "/Applications/Ice.app"
install_cask_app "Syncthing" "syncthing" "/Applications/Syncthing.app"

# Note: System Color Picker package doesn't exist - use built-in Digital Color Meter instead

# Optional tools that may require user interaction
print_status "Installing optional network tools (may require password)..."
install_cask_app "Wireshark" "wireshark" "/Applications/Wireshark.app"

print_success "Productivity tools setup completed!"
echo ""
echo "Installed productivity tools:"
echo "• Rectangle (window management)"
echo "• Maccy (clipboard manager)"
echo "• Obsidian (note-taking)"
echo "• 1Password CLI (op command)"
echo ""
echo "Installed browsers:"
echo "• Google Chrome"
echo "• Firefox"
echo "• Brave Browser"
echo ""
echo "Installed utilities:"
echo "• OrbStack (Docker replacement)"
echo "• Postman (API testing)"
echo "• Mockoon (API mocking)"
echo "• Expo Orbit (Expo build/simulator launcher)"
echo "• Figma (design)"
echo "• ImageOptim (image compression)"
echo "• AppCleaner (uninstaller)"
echo "• Ice (menubar organizer)"
echo "• Syncthing (file sync)"
echo "• WireGuard (VPN)"
echo "• Wireshark (network analysis - if installation succeeded)"
echo "• DevToys (developer Swiss-army knife)"
echo "• Signal (encrypted messaging)"
echo "• WiFiman (network/WiFi analyzer)"
echo ""
echo "📋 TODO: Application Setup & Account Creation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
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
echo "□ 1Password CLI Setup"
echo "  → Sign in to 1Password app first (required)"
echo "  → Run: op signin"
echo "  → Follow prompts to connect to your 1Password account"
echo "  → Test access: op vault list"
echo "  → Enable biometric unlock: op whoami --account <account-id>"
echo ""
echo "□ Browser Setup"
echo "  → Sign in to Chrome/Firefox/Brave with your accounts"
echo "  → Import bookmarks and settings"
echo "  → Install password manager extensions"
echo ""
echo "Next steps:"
echo "• Complete the TODO items above for each application"
echo "• Run database tools setup: ./scripts/09-database.sh"
