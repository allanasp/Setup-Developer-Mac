#!/bin/bash

# System Requirements Setup
# Installs: Xcode Command Line Tools, Homebrew, basic system configuration

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "System Requirements Setup"

check_macos

# Enable hidden files in Finder
print_status "Enabling hidden files in Finder..."
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder 2>/dev/null || print_warning "Finder restart failed - may need manual restart"
print_success "Hidden files enabled in Finder"

# Install Xcode Command Line Tools (required for most tools)
print_status "Installing Xcode Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    xcode-select --install
    print_warning "Please complete the Xcode Command Line Tools installation and re-run this script"
    exit 1
else
    print_success "Xcode Command Line Tools already installed"
fi

# Install Homebrew
print_status "Installing/Updating Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session and future sessions
    if [[ $(uname -m) == "arm64" ]]; then
        # Apple Silicon Mac
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        # Also add to current session
        export PATH="/opt/homebrew/bin:${PATH}"
    else
        # Intel Mac
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
        export PATH="/usr/local/bin:${PATH}"
    fi
    
    print_success "Homebrew installed and added to PATH"
else
    print_success "Homebrew already installed - updating..."
    brew update
    brew upgrade
    brew cleanup
    print_success "Homebrew updated"
fi

print_success "System setup completed!"
echo ""
echo "Next steps:"
echo "• Run terminal setup: ./scripts/02-terminal.sh"
echo "• Or run all scripts: ./setup.sh"
