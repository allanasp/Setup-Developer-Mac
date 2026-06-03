#!/bin/bash

# Mobile Development Setup
# Installs: Android Studio, iOS tools, React Native environment

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Mobile Development Setup"

check_macos
check_homebrew

# Mobile Development (React Native) - Android Setup
print_status "Installing/Updating mobile development tools..."
install_cask_app "Android Studio" "android-studio" "/Applications/Android Studio.app"

# Configure Android environment variables for React Native
print_status "Configuring Android environment for React Native..."
if [[ -d "/Applications/Android Studio.app" ]] || [[ -d "${HOME}/Library/Android" ]]; then
    # Add Android environment variables to shell
    if ! grep -q 'ANDROID_HOME' ~/.zshrc 2>/dev/null; then
        {
            echo ''
            echo '# Android Development (React Native)'
            # shellcheck disable=SC2016  # We want literal ${} in shell config
            echo 'export ANDROID_HOME=${HOME}/Library/Android/sdk'
            echo 'export PATH=${PATH}:${ANDROID_HOME}/emulator'
            echo 'export PATH=${PATH}:${ANDROID_HOME}/platform-tools'
            echo 'export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin'
        } >>~/.zshrc
        print_success "Android environment variables added to .zshrc"
    else
        print_success "Android environment variables already configured"
    fi

    # Set for current session
    export ANDROID_HOME=${HOME}/Library/Android/sdk
    export PATH=${PATH}:${ANDROID_HOME}/emulator
    export PATH=${PATH}:${ANDROID_HOME}/platform-tools
    export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin
else
    print_warning "Android Studio not found - environment variables will be set for future use"
    # Still add the environment variables for when Android Studio is installed
    if ! grep -q 'ANDROID_HOME' ~/.zshrc 2>/dev/null; then
        {
            echo ''
            echo '# Android Development (React Native)'
            # shellcheck disable=SC2016  # We want literal ${} in shell config
            echo 'export ANDROID_HOME=${HOME}/Library/Android/sdk'
            echo 'export PATH=${PATH}:${ANDROID_HOME}/emulator'
            echo 'export PATH=${PATH}:${ANDROID_HOME}/platform-tools'
            echo 'export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin'
        } >>~/.zshrc
        print_success "Android environment variables added to .zshrc (for future use)"
    fi
fi

print_success "Android development environment configured"

# iOS Development Tools (Optional - Requires Manual Xcode Installation)
print_status "iOS Development Setup..."
echo ""
# shellcheck disable=SC2154
echo "📱 ${BLUE}iOS Development Information${NC}"
echo "   • Xcode needs to be installed from the Mac App Store"
echo "   • Download size is approximately 15GB"
echo "   • We'll install supporting tools once Xcode is ready"
echo ""

read -r -p "Install iOS development tools? (requires manual Xcode install later) [y/N]: " install_ios
install_ios=${install_ios:-n}

if [[ "${install_ios}" =~ ^[Yy]$ ]]; then
    print_status "Installing iOS development tools..."

    # Check if Xcode is already installed and handle license
    if [[ -d "/Applications/Xcode.app" ]]; then
        print_status "Xcode found - checking license agreement..."

        # Check if license needs to be accepted
        if ! xcodebuild -license check &>/dev/null; then
            print_warning "Xcode license needs to be accepted"
            echo "This will prompt for your password to accept the Xcode license..."

            if sudo xcodebuild -license accept 2>/dev/null; then
                print_success "Xcode license accepted"
            else
                print_warning "Failed to accept Xcode license automatically"
                print_warning "Please run manually: sudo xcodebuild -license accept"
            fi
        else
            print_success "Xcode license already accepted"
        fi
    else
        print_warning "Xcode not found - install from App Store first"
    fi

    # Tools that work without Xcode
    install_brew_formula "ios-deploy" # Deploy to iOS devices
    install_brew_formula "cocoapods"  # iOS dependency manager

    # Xcode management tool
    install_brew_formula "xcodes" # Manage multiple Xcode versions

    # SwiftLint requires full Xcode installation
    print_status "Checking SwiftLint (requires full Xcode)..."
    if [[ -d "/Applications/Xcode.app" ]]; then
        if brew install swiftlint; then
            print_success "SwiftLint installed successfully"
        else
            print_warning "SwiftLint installation failed - may need Xcode license acceptance"
        fi
    else
        print_warning "SwiftLint skipped - install Xcode from App Store first"
    fi

    print_success "iOS development tools installed (Xcode setup required)"
else
    print_warning "iOS development tools skipped by user choice"
fi

print_success "Mobile development setup completed!"
echo ""
echo "📱 Android Development:"
echo "• Android Studio installed"
echo "• Environment variables configured"
echo ""
if [[ "${install_ios}" =~ ^[Yy]$ ]]; then
    echo "📱 iOS Development:"
    echo "• iOS tools installed (xcodes, ios-deploy, cocoapods)"
    if [[ -d "/Applications/Xcode.app" ]]; then
        echo "• Xcode found and configured"
    else
        echo "• Xcode installation needed (see TODO below)"
    fi
else
    echo "📱 iOS Development: Skipped (can install later)"
fi
echo ""
echo "📋 TODO: Mobile Development Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ Android Studio Configuration"
echo "  → Open Android Studio"
echo "  → Complete initial setup wizard"
echo "  → Install Android SDK (API 33+ for React Native)"
echo "  → Create an Android Virtual Device (AVD)"
echo ""
if [[ "${install_ios}" =~ ^[Yy]$ ]] && [[ ! -d "/Applications/Xcode.app" ]]; then
    echo "□ Xcode Installation (iOS Development)"
    echo "  → Open Mac App Store"
    echo "  → Search for 'Xcode' and install (~15GB)"
    echo "  → Open Xcode and accept license agreement"
    echo "  → Install additional components when prompted"
    echo ""
fi
echo "□ React Native Verification"
echo "  → Run: npx @react-native-community/cli doctor"
echo "  → Fix any issues reported by the doctor command"
echo "  → To verify CLI: npx @react-native-community/cli --version"
echo ""
echo "Next steps:"
echo "• Complete the TODO items above"
echo "• Run productivity tools setup: ./scripts/08-productivity.sh"
