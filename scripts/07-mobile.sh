#!/bin/bash

# Mobile Development Setup
# Installs: Android Studio, iOS tools, React Native environment

set -e  # Exit on any error

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
if [[ -d "/Applications/Android Studio.app" ]] || [[ -d "$HOME/Library/Android" ]]; then
    # Add Android environment variables to shell
    if ! grep -q 'ANDROID_HOME' ~/.zshrc 2>/dev/null; then
        echo '' >> ~/.zshrc
        echo '# Android Development (React Native)' >> ~/.zshrc
        echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
        echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.zshrc
        echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
        echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.zshrc
        print_success "Android environment variables added to .zshrc"
    else
        print_success "Android environment variables already configured"
    fi
    
    # Set for current session
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
else
    print_warning "Android Studio not found - environment variables will be set for future use"
    # Still add the environment variables for when Android Studio is installed
    if ! grep -q 'ANDROID_HOME' ~/.zshrc 2>/dev/null; then
        echo '' >> ~/.zshrc
        echo '# Android Development (React Native)' >> ~/.zshrc
        echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
        echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.zshrc
        echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
        echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.zshrc
        print_success "Android environment variables added to .zshrc (for future use)"
    fi
fi

print_success "Android development environment configured"

# iOS Development Tools (Optional - Requires Manual Xcode Installation)
print_status "iOS Development Setup..."
echo ""
echo "⚠️  ${YELLOW}IMPORTANT: iOS Development Requires Manual Steps${NC}"
echo "   • Xcode CANNOT be installed via Homebrew (Apple restriction)"
echo "   • Xcode must be downloaded from Mac App Store (~15GB)"
echo "   • Some iOS tools require full Xcode installation"
echo ""

read -p "Install iOS development tools? (requires manual Xcode install later) [y/N]: " install_ios
install_ios=${install_ios:-n}

if [[ "$install_ios" =~ ^[Yy]$ ]]; then
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
    brew install ios-deploy  # Deploy to iOS devices
    brew install cocoapods  # iOS dependency manager
    
    # Xcode management tool
    print_status "Installing xcodes (Xcode version manager)..."
    brew install xcodes  # Manage multiple Xcode versions
    
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
echo "• Manual steps: Configure Android SDK in Android Studio"
echo ""
if [[ "$install_ios" =~ ^[Yy]$ ]]; then
    echo "📱 iOS Development:"
    echo "• iOS tools installed (xcodes, ios-deploy, cocoapods)"
    if [[ -d "/Applications/Xcode.app" ]]; then
        echo "• Xcode found and configured"
    else
        echo "• Manual step: Install Xcode from App Store"
    fi
else
    echo "📱 iOS Development: Skipped"
fi
echo ""
echo "Next steps:"
echo "• Configure Android Studio (SDK, AVD)"
echo "• Test React Native: npx react-native doctor"
echo "• Run productivity tools setup: ./scripts/08-productivity.sh"