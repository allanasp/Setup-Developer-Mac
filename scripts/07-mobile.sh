#!/bin/bash

# Mobile Development Setup (Android only)
# Installs: Android Studio + Android environment.
# For the full iOS toolchain and Expo/React Native env, run 12-expo-rn.sh.

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

# Persist ANDROID_HOME + PATH to ~/.zshenv so GUI/non-interactive shells
# (e.g. Gradle from Android Studio) see it. Idempotent, and shared with
# 12-expo-rn.sh via the ANDROID_HOME marker so it's only written once.
add_to_zshenv "ANDROID_HOME" \
    'export ANDROID_HOME="${HOME}/Library/Android/sdk"' \
    'export PATH="${PATH}:${ANDROID_HOME}/emulator"' \
    'export PATH="${PATH}:${ANDROID_HOME}/platform-tools"' \
    'export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"'

if [[ -d "/Applications/Android Studio.app" ]] || [[ -d "${HOME}/Library/Android" ]]; then
    # Set for current session
    export ANDROID_HOME="${HOME}/Library/Android/sdk"
    export PATH="${PATH}:${ANDROID_HOME}/emulator"
    export PATH="${PATH}:${ANDROID_HOME}/platform-tools"
    export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
    print_success "Android environment variables configured"
else
    print_warning "Android Studio not found - ANDROID_HOME set in ~/.zshenv for future use"
fi

print_success "Android development environment configured"

# iOS toolchain + full Expo/React Native environment live in 12-expo-rn.sh.
# This script intentionally covers only Android Studio + the Android
# environment to avoid duplicating installs; 12 is a superset for iOS/RN.
echo ""
# shellcheck disable=SC2154  # BLUE is defined in common.sh
echo "📱 ${BLUE}iOS & complete Expo/React Native setup${NC}"
echo "   This script installs Android Studio + the Android environment only."
echo "   For the full iOS toolchain (xcodes, ios-deploy, cocoapods, SwiftLint,"
echo "   Xcode license) plus Watchman, JDK 17, the Expo/RN/EAS CLIs and Maestro:"
echo ""
echo "      ./scripts/12-expo-rn.sh"
echo ""

print_success "Mobile development setup completed!"
echo ""
echo "📱 Android Development:"
echo "• Android Studio installed"
echo "• Environment variables configured (~/.zshenv)"
echo ""
echo "📋 TODO: Mobile Development Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ Android Studio Configuration"
echo "  → Open Android Studio"
echo "  → Complete initial setup wizard"
echo "  → Install Android SDK (API 33+ for React Native)"
echo "  → Create an Android Virtual Device (AVD)"
echo ""
echo "□ Full Expo / React Native + iOS toolchain"
echo "  → Run: ./scripts/12-expo-rn.sh"
echo "  → Installs Watchman, JDK 17, Maestro, and the complete iOS toolchain"
echo ""
echo "Next steps:"
echo "• Run the Expo + React Native setup: ./scripts/12-expo-rn.sh"
echo "• Or continue with productivity tools: ./scripts/08-productivity.sh"
