#!/bin/bash

# Productivity Tools Setup
# Installs: Raycast, Rectangle, Maccy, Obsidian, browsers, utilities

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

# 1Password CLI
print_status "Checking 1Password CLI..."
if command_exists op; then
    local op_version
    op_version=$(op --version 2>/dev/null || echo "unknown")
    print_success "1Password CLI already installed (${op_version})"
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

# Comet Browser (Perplexity AI)
print_status "Checking Comet Browser..."
if app_exists "/Applications/Comet.app"; then
    print_success "Comet Browser already installed"
else
    print_warning "Comet Browser not installed - requires manual installation"
    echo ""
    echo "${YELLOW}To install Comet Browser:${NC}"
    echo "1. Visit: https://comet.perplexity.ai"
    echo "2. Download the macOS installer"
    echo "3. Follow installation instructions"
    echo "4. Note: Requires Perplexity Max subscription or invite"
    echo ""
fi

# Set Comet as default browser if installed
if app_exists "/Applications/Comet.app"; then
    print_status "Setting Comet as default browser..."
    
    # Use duti if available, otherwise fallback to open
    if command_exists duti; then
        # Install duti if not present
        brew install duti 2>/dev/null || true
        
        # Set Comet as default for HTTP and HTTPS
        if command_exists duti; then
            echo "com.perplexity.Comet http" > ~/.duti
            echo "com.perplexity.Comet https" >> ~/.duti
            duti ~/.duti 2>/dev/null && print_success "Comet set as default browser" || print_warning "Could not set default browser automatically"
        fi
    else
        # Alternative method using defaultbrowser
        if ! command_exists defaultbrowser; then
            print_status "Installing defaultbrowser utility..."
            brew install defaultbrowser 2>/dev/null || true
        fi
        
        if command_exists defaultbrowser; then
            defaultbrowser comet 2>/dev/null && print_success "Comet set as default browser" || print_warning "Could not set default browser automatically"
        else
            print_warning "Default browser must be set manually in System Settings → Desktop & Dock → Default web browser"
        fi
    fi
else
    print_status "Comet Browser not installed - skipping default browser setup"
fi

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
echo "• 1Password CLI (op command)"
echo ""
echo "Installed browsers:"
echo "• Google Chrome"
echo "• Firefox"
echo "• Brave Browser"
echo "• Comet Browser (if manually installed)"
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
echo "□ 1Password CLI Setup"
echo "  → Sign in to 1Password app first (required)"
echo "  → Run: op signin"
echo "  → Follow prompts to connect to your 1Password account"
echo "  → Test access: op vault list"
echo "  → Enable biometric unlock: op whoami --account <account-id>"
echo ""
echo "□ Comet Browser Setup (AI-Powered Browser)"
echo "  → Download from: https://comet.perplexity.ai"
echo "  → Requires Perplexity Max subscription or invite"
echo "  → Sign in with your Perplexity account"
echo "  → Configure AI assistance preferences"
echo "  → Import bookmarks from other browsers"
echo ""
echo "□ Browser Setup"
echo "  → Sign in to Chrome/Firefox/Brave with your accounts"
echo "  → Import bookmarks and settings"
echo "  → Install password manager extensions"
echo ""
echo "Next steps:"
echo "• Complete the TODO items above for each application"
echo "• Run database tools setup: ./scripts/09-database.sh"
