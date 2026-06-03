#!/bin/bash
# 12-expo-rn.sh
# Sets up a complete LOCAL Expo + React Native development environment.
# Includes Xcode + Android Studio configuration.
# Installs: Watchman, OpenJDK 17, Android Studio, iOS toolchain (xcodes,
# ios-deploy, cocoapods, swiftlint), Expo/RN CLIs (via Volta), Maestro.
# Configures: JAVA_HOME, ANDROID_HOME, Maestro PATH in ~/.zshrc.

set -e

source "$(dirname "$0")/common.sh"

print_section "Expo + React Native Local Development Setup"

check_macos
check_homebrew

# Architecture-aware Homebrew prefix
if [[ $(uname -m) == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi

# ----------------------------------------------------------
# Pre-flight: Xcode Command Line Tools
# ----------------------------------------------------------
print_status "Checking Xcode Command Line Tools..."
if xcode-select -p &>/dev/null; then
    print_success "Xcode Command Line Tools already installed"
else
    print_warning "Xcode Command Line Tools missing — triggering install dialog"
    xcode-select --install 2>/dev/null || true
    print_warning "Complete the install dialog, then re-run this script"
    exit 1
fi

# ----------------------------------------------------------
# Watchman (required by React Native / Metro)
# ----------------------------------------------------------
print_status "Installing Watchman..."
if brew list watchman &>/dev/null; then
    print_success "Watchman already installed"
else
    if brew install watchman; then
        print_success "Watchman installed"
    else
        print_error "Watchman install failed"
    fi
fi

# ----------------------------------------------------------
# OpenJDK 17 (required for Android builds via Gradle)
# ----------------------------------------------------------
print_status "Installing OpenJDK 17 for Android builds..."
if brew list openjdk@17 &>/dev/null; then
    print_success "OpenJDK 17 already installed"
else
    if brew install openjdk@17; then
        print_success "OpenJDK 17 installed"
    else
        print_error "OpenJDK 17 install failed"
    fi
fi

# System-wide JDK symlink (so /usr/libexec/java_home discovers it)
JDK_SYMLINK="/Library/Java/JavaVirtualMachines/openjdk-17.jdk"
if [[ ! -e "$JDK_SYMLINK" ]]; then
    print_status "Creating system JDK symlink (requires sudo)..."
    if sudo ln -sfn "${BREW_PREFIX}/opt/openjdk@17/libexec/openjdk.jdk" "$JDK_SYMLINK" 2>/dev/null; then
        print_success "JDK symlink created"
    else
        print_warning "JDK symlink failed — set JAVA_HOME manually if needed"
    fi
else
    print_success "JDK symlink already present"
fi

# JAVA_HOME in ~/.zshrc
if ! grep -q 'JAVA_HOME' ~/.zshrc 2>/dev/null; then
    {
        echo ''
        echo '# Java (for Android / React Native)'
        echo 'export JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null)"'
        echo 'export PATH="$JAVA_HOME/bin:$PATH"'
    } >>~/.zshrc
    print_success "JAVA_HOME added to ~/.zshrc"
else
    print_success "JAVA_HOME already configured"
fi

# ----------------------------------------------------------
# Android Studio
# ----------------------------------------------------------
install_cask_app "Android Studio" "android-studio" "/Applications/Android Studio.app"

# Android SDK environment variables
if ! grep -q 'ANDROID_HOME' ~/.zshrc 2>/dev/null; then
    {
        echo ''
        echo '# Android SDK (populated after Android Studio SDK Manager runs)'
        echo 'export ANDROID_HOME="$HOME/Library/Android/sdk"'
        echo 'export PATH="$PATH:$ANDROID_HOME/emulator"'
        echo 'export PATH="$PATH:$ANDROID_HOME/platform-tools"'
        echo 'export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"'
    } >>~/.zshrc
    print_success "Android SDK environment added to ~/.zshrc"
else
    print_success "ANDROID_HOME already configured"
fi

# ----------------------------------------------------------
# iOS toolchain (CLI helpers)
# ----------------------------------------------------------
print_status "Installing iOS CLI tools..."
for tool in ios-deploy cocoapods xcodes; do
    if brew list "$tool" &>/dev/null; then
        print_success "$tool already installed"
    else
        if brew install "$tool"; then
            print_success "$tool installed"
        else
            print_warning "$tool install failed"
        fi
    fi
done

# ----------------------------------------------------------
# Xcode (manual install) + license + SwiftLint
# ----------------------------------------------------------
if [[ -d "/Applications/Xcode.app" ]]; then
    print_status "Xcode detected — verifying license & toolchain..."

    if ! xcodebuild -license check &>/dev/null; then
        print_warning "Xcode license not accepted — accepting (requires sudo)"
        if sudo xcodebuild -license accept 2>/dev/null; then
            print_success "Xcode license accepted"
        else
            print_warning "License accept failed — run manually: sudo xcodebuild -license accept"
        fi
    else
        print_success "Xcode license already accepted"
    fi

    # Point xcode-select at full Xcode (not just Command Line Tools)
    if [[ "$(xcode-select -p)" != "/Applications/Xcode.app/Contents/Developer" ]]; then
        print_status "Switching xcode-select to full Xcode..."
        if sudo xcode-select -s /Applications/Xcode.app/Contents/Developer 2>/dev/null; then
            print_success "xcode-select now points to Xcode"
        else
            print_warning "xcode-select switch failed"
        fi
    fi

    # SwiftLint (requires Xcode to compile from source)
    if brew list swiftlint &>/dev/null; then
        print_success "SwiftLint already installed"
    else
        if brew install swiftlint; then
            print_success "SwiftLint installed"
        else
            print_warning "SwiftLint install failed"
        fi
    fi
else
    print_warning "Xcode NOT installed — install from Mac App Store (~15 GB)"
    print_warning "SwiftLint skipped (requires full Xcode)"
    print_warning "Re-run this script after installing Xcode to finish iOS setup"
fi

# ----------------------------------------------------------
# Expo + React Native CLIs via Volta
# ----------------------------------------------------------
print_status "Installing Expo + React Native CLIs via Volta..."
if command_exists volta; then
    install_volta_package "@expo/cli"
    install_volta_package "eas-cli"
    install_volta_package "create-expo-app"
    install_volta_package "@react-native-community/cli"
else
    print_warning "Volta not installed — run 03-version-managers.sh first"
fi

# ----------------------------------------------------------
# Maestro (mobile UI testing — `maestro studio` is a subcommand)
# ----------------------------------------------------------
print_status "Installing Maestro (mobile UI testing)..."
if [[ -x "$HOME/.maestro/bin/maestro" ]]; then
    print_success "Maestro already installed"
else
    if curl -fsSL "https://get.maestro.mobile.dev" | bash; then
        print_success "Maestro installed to ~/.maestro"
    else
        print_warning "Maestro install failed — try: curl -fsSL https://get.maestro.mobile.dev | bash"
    fi
fi

# Maestro PATH
if ! grep -q '.maestro/bin' ~/.zshrc 2>/dev/null; then
    {
        echo ''
        echo '# Maestro'
        echo 'export PATH="$PATH:$HOME/.maestro/bin"'
    } >>~/.zshrc
    print_success "Maestro added to PATH in ~/.zshrc"
else
    print_success "Maestro PATH already configured"
fi

# ----------------------------------------------------------
# Summary + manual TODOs
# ----------------------------------------------------------
print_success "Expo + React Native setup completed!"
echo ""
echo "📋 TODO: Manual Configuration Steps"
echo ""
echo "□ Xcode (iOS development)"
echo "  → Install Xcode from Mac App Store (~15 GB)"
echo "  → Open Xcode once, accept license, install additional components"
echo "  → Re-run this script to auto-accept license + install SwiftLint"
echo "  → Verify: xcodebuild -version"
echo ""
echo "□ Android SDK (Android development)"
echo "  → Open Android Studio → More Actions → SDK Manager"
echo "  → SDK Platforms: install Android 14 (API 34), Android 13 (API 33)"
echo "  → SDK Tools: Platform-Tools, Build-Tools, Emulator, Cmdline-Tools (latest)"
echo "  → Virtual Device Manager: create a Pixel emulator (API 34)"
echo "  → Verify after restart: adb --version"
echo ""
echo "□ iOS simulator"
echo "  → Xcode → Settings → Platforms → install latest iOS Simulator runtime"
echo "  → Verify: xcrun simctl list devices"
echo ""
echo "□ Expo Go on simulators (optional)"
echo "  → iOS: open simulator, then: npx expo start → press 'i'"
echo "  → Android: install Expo Go via Play Store on emulator"
echo ""
echo "□ EAS authentication"
echo "  → eas login"
echo "  → eas whoami"
echo ""
echo "□ Verify environment"
echo "  → Restart terminal (or: source ~/.zshrc)"
echo "  → npx expo-doctor                # for Expo projects"
echo "  → npx react-native doctor        # for bare RN projects"
echo ""
echo "□ Smoke test (create + run a fresh app)"
echo "  → npx create-expo-app@latest my-test-app"
echo "  → cd my-test-app"
echo "  → npx expo start --ios           # or --android"
echo ""
