#!/bin/bash

# System Requirements Setup
# Installs: Xcode Command Line Tools, Homebrew, basic system configuration

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "System Requirements Setup"

check_macos

# Enable hidden files in Finder
print_status "Enabling hidden files in Finder..."
if is_dry_run; then
    print_status "[dry-run] would enable hidden files in Finder"
else
    defaults write com.apple.finder AppleShowAllFiles -bool true
    killall Finder 2>/dev/null || print_warning "Finder restart failed - may need manual restart"
    print_success "Hidden files enabled in Finder"
fi

# Install Xcode Command Line Tools (required for most tools)
print_status "Installing Xcode Command Line Tools..."
if xcode-select -p &>/dev/null; then
    print_success "Xcode Command Line Tools already installed"
elif is_dry_run; then
    print_status "[dry-run] would install Xcode Command Line Tools"
else
    xcode-select --install
    print_warning "Please complete the Xcode Command Line Tools installation and re-run this script"
    exit 1
fi

# Install Homebrew
print_status "Installing/Updating Homebrew..."
if ! command -v brew &>/dev/null; then
    if is_dry_run; then
        print_status "[dry-run] would install Homebrew and add it to PATH"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for current session and future sessions.
        # brew shellenv belongs in ~/.zprofile (login shells); guard against
        # appending it twice on re-run.
        if [[ $(uname -m) == "arm64" ]]; then
            brew_bin="/opt/homebrew/bin"
        else
            brew_bin="/usr/local/bin"
        fi
        if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
            echo "eval \"\$(${brew_bin}/brew shellenv)\"" >>~/.zprofile
        fi
        eval "$(${brew_bin}/brew shellenv)"
        export PATH="${brew_bin}:${PATH}"

        print_success "Homebrew installed and added to PATH"
    fi
elif is_dry_run; then
    print_status "[dry-run] would update Homebrew (update/upgrade/cleanup)"
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
