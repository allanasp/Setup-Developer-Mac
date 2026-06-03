#!/bin/bash

# Frontend Development Tools Setup - The Heart of This Setup! 🎨
# Installs: TypeScript, Vue CLI, React Native CLI, Expo CLI, Vite, Storyblok CLI, Sanity CLI, etc.
# This is the primary focus of our Mac setup - optimized for modern frontend development

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Frontend Development Tools Setup"

check_macos
check_homebrew
check_volta

# Frontend Development Tools
print_status "Installing frontend development tools..."

# Vue CLI and Nuxt CLI
install_volta_package "@vue/cli"
install_volta_package "nuxt"

# TypeScript (global)
install_volta_package "typescript"

# Vite and other build tools
install_volta_package "create-vite"
install_volta_package "serve"

# Monorepo + deployment tooling
install_volta_package "turbo"  # Turborepo
install_volta_package "vercel" # Vercel CLI

# Headless CMS tools
install_volta_package "storyblok"   # Storyblok CLI
install_volta_package "@sanity/cli" # Sanity CLI

# React Native Development Tools
print_status "Installing React Native development tools..."
install_volta_package "@react-native-community/cli" # React Native CLI
install_volta_package "@expo/cli"                   # Expo CLI
install_volta_package "eas-cli"                     # EAS CLI for Expo Application Services
install_volta_package "create-expo-app"             # Create Expo apps

# Watchman (recommended by React Native docs for better performance)
install_brew_formula "watchman" "Watchman"

print_success "Frontend development tools setup completed!"
echo ""
echo "Installed tools:"
echo "• TypeScript (global compiler)"
echo "• Vue CLI & Nuxt CLI"
echo "• React Native CLI & Expo CLI & EAS CLI"
echo "• Vite (create-vite) & Serve"
echo "• Turbo (Turborepo) & Vercel CLI"
echo "• Storyblok CLI & Sanity CLI (headless CMS)"
echo "• Watchman (file watching)"
echo ""
echo "📋 TODO: Account Creation & Authentication Required"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Before using these tools, create accounts and login:"
echo ""
echo "□ Expo Account (for React Native development)"
echo "  → Sign up: https://expo.dev"
echo "  → Login: npx expo login"
echo ""
echo "□ Storyblok Account (headless CMS)"
echo "  → Sign up: https://storyblok.com"
echo "  → Login: storyblok login"
echo ""
echo "□ Sanity Account (headless CMS)"
echo "  → Sign up: https://sanity.io"
echo "  → Login: sanity login"
echo ""
echo "Usage examples (after authentication):"
echo "• Create Vue app: vue create my-app"
echo "• Create Nuxt app: npx create-nuxt-app@latest my-app"
echo "• Create React Native app: npx @react-native-community/cli@latest init MyApp"
echo "• Create Expo app: npx create-expo-app@latest"
echo "• Create Vite app: npm create vite@latest"
echo "• Initialize Storyblok: storyblok init"
echo "• Create Sanity project: sanity init"
echo ""
echo "Next steps:"
echo "• Run development apps setup: ./scripts/06-dev-apps.sh"
