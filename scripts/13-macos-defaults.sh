#!/bin/bash

# macOS System Defaults
# Applies sensible developer-friendly `defaults write` tweaks.
# Everything here is standard, reversible, and idempotent. Honors DRY_RUN.

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "macOS System Defaults"

check_macos

if is_dry_run; then
    print_status "[dry-run] would apply macOS defaults (keyboard, Finder, Dock, screenshots, dialogs)"
    print_success "macOS defaults preview complete"
    exit 0
fi

print_warning "Applying system tweaks. Some changes need a logout/restart to fully apply."

# ----------------------------------------------------------
# Keyboard — fast key repeat, no press-and-hold accents (better for coding)
# ----------------------------------------------------------
print_status "Keyboard: fast key repeat, disable press-and-hold..."
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
print_success "Keyboard tuned"

# ----------------------------------------------------------
# Text — disable auto-correct / smart quotes & dashes (annoying in code)
# ----------------------------------------------------------
print_status "Text: disable smart quotes/dashes and auto-correct..."
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
print_success "Text substitution tuned"

# ----------------------------------------------------------
# Finder — show everything, sane defaults
# ----------------------------------------------------------
print_status "Finder: show hidden files, extensions, path/status bar..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Use list view by default ("Nlsv")
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Don't write .DS_Store on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
print_success "Finder configured"

# ----------------------------------------------------------
# Screenshots — to ~/Screenshots, PNG, no window shadow
# ----------------------------------------------------------
print_status "Screenshots: save to ~/Screenshots (PNG, no shadow)..."
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
print_success "Screenshots configured"

# ----------------------------------------------------------
# Dock — autohide, faster, no recents
# ----------------------------------------------------------
print_status "Dock: autohide, faster animation, hide recents..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock show-recents -bool false
print_success "Dock configured"

# ----------------------------------------------------------
# Dialogs — expand save/print panels, save to disk by default
# ----------------------------------------------------------
print_status "Dialogs: expand save/print panels by default..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
print_success "Dialogs configured"

# ----------------------------------------------------------
# Apply: restart affected UI services
# ----------------------------------------------------------
print_status "Restarting Finder, Dock and SystemUIServer to apply changes..."
for app in Finder Dock SystemUIServer; do
    killall "${app}" 2>/dev/null || true
done

print_success "macOS defaults applied!"
echo ""
echo "📋 Notes:"
echo "• A few settings (key repeat) take effect after logout/restart."
echo "• Screenshots now land in ~/Screenshots."
echo "• Revert any tweak with: defaults delete <domain> <key>"
echo ""
echo "Next steps:"
echo "• Log out and back in (or restart) for all changes to take effect"
