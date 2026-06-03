#!/bin/bash

# Mac Development Setup Checker Script v2.0
# Run with: bash check-setup.sh
# Verifies all tools from the main setup script are installed
# Now includes version information where available

echo "🔍 Checking Mac Development Setup (with versions)..."

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Architecture-aware Homebrew prefix (Apple Silicon vs Intel)
if [[ "$(uname -m)" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi

# Counters
INSTALLED=0
MISSING=0
TOTAL=0

print_installed() {
    echo -e "${GREEN}[✓]${NC} $1"
    ((INSTALLED++))
    ((TOTAL++))
}

print_missing() {
    echo -e "${RED}[✗]${NC} $1"
    ((MISSING++))
    ((TOTAL++))
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
    ((TOTAL++))
}

print_section() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if app exists
app_exists() {
    [[ -d "$1" ]]
}

# Function to check VS Code extension (anchored, case-insensitive)
vscode_extension_exists() {
    code --list-extensions 2>/dev/null | grep -qi "^$1$"
}

print_section "System Requirements"

# Xcode Command Line Tools
if xcode-select -p &>/dev/null; then
    xcode_version=$(xcodebuild -version 2>/dev/null | head -n1 || echo "Command Line Tools")
    print_installed "Xcode Command Line Tools (${xcode_version})"

    # Check if full Xcode is installed
    if [[ -d "/Applications/Xcode.app" ]]; then
        print_installed "  Full Xcode installation found"

        # Check Xcode license status
        if xcodebuild -license check &>/dev/null; then
            print_installed "  Xcode license accepted"
        else
            print_warning "  Xcode license NOT accepted (run: sudo xcodebuild -license accept)"
        fi
    else
        print_warning "  Full Xcode not installed (iOS development limited)"
    fi
else
    print_missing "Xcode Command Line Tools"
fi

# Homebrew
if command_exists brew; then
    print_installed "Homebrew ($(brew --version | head -n1))"
else
    print_missing "Homebrew"
fi

print_section "Version Managers"

# Volta
if command_exists volta; then
    print_installed "Volta ($(volta --version))"
else
    print_missing "Volta"
fi

# pyenv
if command_exists pyenv; then
    print_installed "pyenv ($(pyenv --version))"
else
    print_missing "pyenv"
fi

print_section "Programming Languages"

# Node.js
if command_exists node; then
    print_installed "Node.js ($(node --version))"
else
    print_missing "Node.js"
fi

# Python versions via pyenv
if command_exists pyenv; then
    echo -e "${BLUE}Python versions via pyenv:${NC}"
    pyenv versions --bare | while read -r version; do
        if [[ -n "${version}" ]]; then
            print_installed "  Python ${version}"
        fi
    done
else
    print_missing "Python (pyenv not found)"
fi

# TypeScript
if command_exists tsc; then
    print_installed "TypeScript ($(tsc --version))"
else
    print_missing "TypeScript"
fi

# Go
if command_exists go; then
    print_installed "Go ($(go version | cut -d' ' -f3))"
else
    print_missing "Go"
fi

# Ruby
if command_exists ruby; then
    ruby_version=$(ruby --version | cut -d' ' -f2 || echo "installed")
    print_installed "Ruby (${ruby_version})"
else
    print_missing "Ruby"
fi

# Java (JDK)
if command_exists java; then
    java_version=$(java --version 2>/dev/null | head -n1 | cut -d' ' -f2 || java -version 2>&1 | head -n1 | cut -d'"' -f2 || echo "installed")
    print_installed "Java JDK (${java_version})"

    # Check JAVA_HOME
    if [[ -n "${JAVA_HOME}" ]] || [[ -d "${BREW_PREFIX}/opt/openjdk@17" ]]; then
        java_home_path="${JAVA_HOME:-${BREW_PREFIX}/opt/openjdk@17}"
        print_installed "  JAVA_HOME available (${java_home_path})"
    else
        print_warning "  JAVA_HOME not set"
    fi
else
    print_missing "Java JDK"
fi

print_section "Package Managers"

# npm (comes with Node.js)
if command_exists npm; then
    npm_version=$(npm --version 2>/dev/null || echo "installed")
    print_installed "npm (${npm_version})"
else
    print_missing "npm"
fi

# pnpm
if command_exists pnpm; then
    pnpm_version=$(pnpm --version 2>/dev/null || echo "installed")
    print_installed "pnpm (${pnpm_version})"
else
    print_missing "pnpm"
fi

# bun
if command_exists bun; then
    bun_version=$(bun --version 2>/dev/null || echo "installed")
    print_installed "bun (${bun_version})"
else
    print_missing "bun"
fi

print_section "Frontend CLI Tools"

# Vue CLI
if command_exists vue; then
    print_installed "Vue CLI ($(vue --version))"
else
    print_missing "Vue CLI"
fi

# Nuxt CLI
if command_exists nuxt; then
    print_installed "Nuxt CLI"
else
    print_missing "Nuxt CLI"
fi

# React Native CLI (via @react-native-community/cli)
if command -v npx >/dev/null 2>&1; then
    # Test the correct React Native CLI command
    rn_test=$(npx @react-native-community/cli --version 2>/dev/null)
    if [[ -n "${rn_test}" ]]; then
        rn_version=$(echo "${rn_test}" | head -n1 | awk '{print $1}')
        print_installed "React Native CLI (${rn_version})"
    else
        print_missing "React Native CLI"
    fi
else
    print_missing "React Native CLI (npx not available)"
fi

# Expo CLI (via npx)
if command -v npx >/dev/null 2>&1 && npx expo --version >/dev/null 2>&1; then
    expo_version=$(npx expo --version 2>/dev/null | head -n1 || echo "installed")
    print_installed "Expo CLI (${expo_version} via npx)"
elif command -v expo >/dev/null 2>&1; then
    expo_version=$(expo --version 2>/dev/null | head -n1 || echo "installed")
    print_installed "Expo CLI (${expo_version} global)"
else
    print_missing "Expo CLI"
fi

# EAS CLI
if command_exists eas; then
    eas_version=$(eas --version 2>/dev/null || echo "installed")
    print_installed "EAS CLI (${eas_version})"
else
    print_missing "EAS CLI"
fi

# Watchman (React Native)
if command_exists watchman; then
    watchman_version=$(watchman version 2>/dev/null | jq -r '.version' 2>/dev/null || watchman --version 2>/dev/null || echo "installed")
    print_installed "Watchman (${watchman_version})"
else
    print_missing "Watchman (React Native file watching)"
fi

# Vite
if command_exists create-vite; then
    vite_version=$(npm list -g create-vite --depth=0 2>/dev/null | grep create-vite | cut -d'@' -f2 || echo "installed")
    print_installed "Vite (create-vite@${vite_version})"
else
    print_missing "Vite (create-vite)"
fi

# Serve
if command_exists serve; then
    print_installed "Serve ($(serve --version))"
else
    print_missing "Serve"
fi

# Turbo (Turborepo)
if command_exists turbo; then
    print_installed "Turbo ($(turbo --version 2>/dev/null || echo installed))"
else
    print_missing "Turbo (Turborepo)"
fi

# Vercel CLI
if command_exists vercel; then
    print_installed "Vercel CLI ($(vercel --version 2>/dev/null | head -n1 || echo installed))"
else
    print_missing "Vercel CLI"
fi

# create-expo-app
if command_exists create-expo-app; then
    print_installed "create-expo-app"
else
    print_missing "create-expo-app"
fi

# Storyblok CLI
if command_exists storyblok; then
    print_installed "Storyblok CLI ($(storyblok --version 2>/dev/null | head -n1 || echo installed))"
else
    print_missing "Storyblok CLI"
fi

# Sanity CLI
if command_exists sanity; then
    print_installed "Sanity CLI ($(sanity --version 2>/dev/null | head -n1 || echo installed))"
else
    print_missing "Sanity CLI"
fi

print_section "Development Applications"

# VS Code
if app_exists "/Applications/Visual Studio Code.app"; then
    if command_exists code; then
        vscode_version=$(code --version 2>/dev/null | head -n1 || echo "installed")
        print_installed "Visual Studio Code (${vscode_version})"
    else
        print_installed "Visual Studio Code (CLI not in PATH)"
    fi
else
    print_missing "Visual Studio Code"
fi

# Cursor
if app_exists "/Applications/Cursor.app"; then
    print_installed "Cursor"
else
    print_missing "Cursor"
fi

# TextMate
if app_exists "/Applications/TextMate.app"; then
    print_installed "TextMate"
else
    print_missing "TextMate"
fi

# Kiro (AWS agentic IDE)
if app_exists "/Applications/Kiro.app"; then
    print_installed "Kiro"
else
    print_missing "Kiro"
fi

print_section "Terminals"

# iTerm2
if app_exists "/Applications/iTerm.app"; then
    print_installed "iTerm2"
else
    print_missing "iTerm2"
fi

# Warp
if app_exists "/Applications/Warp.app"; then
    print_installed "Warp"
else
    print_missing "Warp"
fi

# Oh My Zsh
if [[ -d ~/.oh-my-zsh ]]; then
    if [[ -f ~/.oh-my-zsh/tools/upgrade.sh ]]; then
        # Try to get version from git if available
        omz_version=$(cd ~/.oh-my-zsh && git describe --tags 2>/dev/null || echo "installed")
        print_installed "Oh My Zsh (${omz_version})"
    else
        print_installed "Oh My Zsh (installed)"
    fi
else
    print_missing "Oh My Zsh"
fi

# PowerLevel10k
if [[ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
    print_installed "PowerLevel10k theme"
else
    print_missing "PowerLevel10k theme"
fi

print_section "Git Tools"

# Git
if command_exists git; then
    print_installed "Git ($(git --version | cut -d' ' -f3))"
else
    print_missing "Git"
fi

# Git Flow (AVH edition provides the `git flow` subcommand)
if command_exists git-flow || git flow version &>/dev/null || brew list git-flow-avh &>/dev/null; then
    print_installed "Git Flow (AVH)"
else
    print_missing "Git Flow"
fi

# GitHub CLI
if command_exists gh; then
    print_installed "GitHub CLI ($(gh --version | head -n1 | cut -d' ' -f3))"
else
    print_missing "GitHub CLI"
fi

# GitHub Desktop
if app_exists "/Applications/GitHub Desktop.app"; then
    print_installed "GitHub Desktop"
else
    print_missing "GitHub Desktop"
fi

print_section "Database Tools"

# PostgreSQL
if command_exists psql || [[ -f "${BREW_PREFIX}/opt/postgresql@15/bin/psql" ]]; then
    if command_exists psql; then
        psql_version=$(psql --version 2>/dev/null | cut -d' ' -f3)
    else
        psql_version=$("${BREW_PREFIX}/opt/postgresql@15/bin/psql" --version 2>/dev/null | cut -d' ' -f3 || echo "15.x")
    fi
    print_installed "PostgreSQL (${psql_version})"
    # Check if service is running
    if brew services list 2>/dev/null | grep '^postgresql@15 ' | grep -q started; then
        print_installed "  PostgreSQL service (running)"
    else
        print_warning "  PostgreSQL service (not running - run: brew services start postgresql@15)"
    fi
else
    print_missing "PostgreSQL"
fi

# DBeaver Community Edition
if app_exists "/Applications/DBeaver.app"; then
    print_installed "DBeaver Community Edition"
else
    print_missing "DBeaver Community Edition"
fi

# pgAdmin 4
if app_exists "/Applications/pgAdmin 4.app"; then
    print_installed "pgAdmin 4"
else
    print_missing "pgAdmin 4"
fi

# Supabase CLI
if command_exists supabase; then
    print_installed "Supabase CLI ($(supabase --version 2>/dev/null | head -n1 || echo installed))"
else
    print_missing "Supabase CLI"
fi

print_section "DevOps Tools"

# UpCloud CLI (upctl)
if command_exists upctl; then
    print_installed "UpCloud CLI (upctl $(upctl version 2>/dev/null | head -n1 || echo installed))"
else
    print_missing "UpCloud CLI (upctl)"
fi

# kubectl (Kubernetes CLI)
if command_exists kubectl; then
    print_installed "kubectl ($(kubectl version --client -o yaml 2>/dev/null | grep gitVersion | head -n1 | awk '{print $2}' || echo installed))"
else
    print_missing "kubectl (Kubernetes CLI)"
fi

# Tilt
if command_exists tilt; then
    print_installed "Tilt ($(tilt version 2>/dev/null | head -n1 || echo installed))"
else
    print_missing "Tilt"
fi

# Terraform
if command_exists terraform; then
    print_installed "Terraform ($(terraform version 2>/dev/null | head -n1 | awk '{print $2}' || echo installed))"
else
    print_missing "Terraform"
fi

# Note: ngrok is verified in the "Command Line Utilities" section below.

print_section "Mobile Development"

# Android Studio
if app_exists "/Applications/Android Studio.app"; then
    print_installed "Android Studio"

    # Check Android environment variables
    if [[ -n "${ANDROID_HOME}" ]] || [[ -d "${HOME}/Library/Android/sdk" ]]; then
        android_home_path="${ANDROID_HOME:-${HOME}/Library/Android/sdk}"
        print_installed "  ANDROID_HOME available (${android_home_path})"
    else
        print_warning "  ANDROID_HOME not set (restart terminal or source ~/.zshrc)"
    fi

    # Check if Android SDK exists
    if [[ -d "${HOME}/Library/Android/sdk" ]]; then
        print_installed "  Android SDK found"
    else
        print_warning "  Android SDK not found (configure in Android Studio)"
    fi
else
    print_missing "Android Studio"
fi

# iOS Development Tools
if command_exists xcodes; then
    xcodes_version=$(xcodes version 2>/dev/null || echo "installed")
    print_installed "xcodes (${xcodes_version})"
else
    print_missing "xcodes"
fi

if command_exists swiftlint; then
    print_installed "SwiftLint ($(swiftlint version))"
else
    if [[ -d "/Applications/Xcode.app" ]]; then
        print_missing "SwiftLint (Xcode available - run: brew install swiftlint)"
    else
        print_warning "SwiftLint (requires full Xcode from App Store)"
    fi
fi

if command_exists ios-deploy; then
    ios_deploy_version=$(ios-deploy --version 2>/dev/null || echo "installed")
    print_installed "ios-deploy (${ios_deploy_version})"
else
    print_missing "ios-deploy"
fi

if command_exists pod; then
    print_installed "CocoaPods ($(pod --version))"
else
    print_missing "CocoaPods"
fi

# Maestro (mobile UI testing)
if command_exists maestro || [[ -x "${HOME}/.maestro/bin/maestro" ]]; then
    maestro_bin="$(command -v maestro || echo "${HOME}/.maestro/bin/maestro")"
    maestro_version=$("${maestro_bin}" --version 2>/dev/null | head -n1 || echo "installed")
    print_installed "Maestro (${maestro_version})"
else
    print_missing "Maestro (mobile UI testing)"
fi

print_section "Productivity Tools"

# Rectangle
if app_exists "/Applications/Rectangle.app"; then
    print_installed "Rectangle"
else
    print_missing "Rectangle"
fi

# 1Password
if app_exists "/Applications/1Password.app" || app_exists "/Applications/1Password 7 - Password Manager.app"; then
    print_installed "1Password"
else
    print_missing "1Password"
fi

# 1Password CLI
if command_exists op; then
    op_version=$(op --version 2>/dev/null || echo "installed")
    print_installed "1Password CLI (${op_version})"

    # Check if signed in
    if op whoami &>/dev/null; then
        print_installed "  1Password CLI (authenticated)"
    else
        print_warning "  1Password CLI (not signed in - run: op signin)"
    fi
else
    print_missing "1Password CLI"
fi

# Maccy
if app_exists "/Applications/Maccy.app"; then
    print_installed "Maccy"
else
    print_missing "Maccy"
fi

# Obsidian
if app_exists "/Applications/Obsidian.app"; then
    print_installed "Obsidian"
else
    print_missing "Obsidian"
fi

print_section "Browsers"

# Chrome
if app_exists "/Applications/Google Chrome.app"; then
    print_installed "Google Chrome"
else
    print_missing "Google Chrome"
fi

# Firefox
if app_exists "/Applications/Firefox.app"; then
    print_installed "Firefox"
else
    print_missing "Firefox"
fi

# Brave
if app_exists "/Applications/Brave Browser.app"; then
    print_installed "Brave Browser"
else
    print_missing "Brave Browser"
fi

# Comet Browser (Perplexity AI)
if app_exists "/Applications/Comet.app"; then
    print_installed "Comet Browser (Perplexity AI)"

    # Check if it's set as default browser (only if duti is available)
    if command_exists duti; then
        default_browser=$(duti -x http 2>/dev/null | grep -o 'com\.perplexity\.Comet' || echo "")
        if [[ -n "${default_browser}" ]]; then
            print_installed "  Comet (set as default browser)"
        else
            print_warning "  Comet (not default browser - set manually in System Settings)"
        fi
    else
        print_warning "  Comet (install 'duti' to verify default-browser status)"
    fi
else
    print_missing "Comet Browser (requires manual installation)"
fi

print_section "Developer Utilities"

# OrbStack
if app_exists "/Applications/OrbStack.app"; then
    print_installed "OrbStack"
else
    print_missing "OrbStack"
fi

# Postman
if app_exists "/Applications/Postman.app"; then
    print_installed "Postman"
else
    print_missing "Postman"
fi

# Mockoon
if app_exists "/Applications/Mockoon.app"; then
    print_installed "Mockoon"
else
    print_missing "Mockoon"
fi

# Expo Orbit
if app_exists "/Applications/Expo Orbit.app"; then
    print_installed "Expo Orbit"
else
    print_missing "Expo Orbit"
fi

# Figma
if app_exists "/Applications/Figma.app"; then
    print_installed "Figma"
else
    print_missing "Figma"
fi

# System Color Picker - removed (package doesn't exist)
# Use built-in Digital Color Meter app instead

# AppCleaner
if app_exists "/Applications/AppCleaner.app"; then
    print_installed "AppCleaner"
else
    print_missing "AppCleaner"
fi

# Ice
if app_exists "/Applications/Ice.app"; then
    print_installed "Ice"
else
    print_missing "Ice"
fi

# Syncthing
if app_exists "/Applications/Syncthing.app"; then
    print_installed "Syncthing"
else
    print_missing "Syncthing"
fi

# Wireshark
if app_exists "/Applications/Wireshark.app"; then
    print_installed "Wireshark"
else
    print_missing "Wireshark"
fi

# WireGuard
if app_exists "/Applications/WireGuard.app"; then
    print_installed "WireGuard"
else
    print_missing "WireGuard"
fi

# DevToys
if app_exists "/Applications/DevToys.app"; then
    print_installed "DevToys"
else
    print_missing "DevToys"
fi

# Signal
if app_exists "/Applications/Signal.app"; then
    print_installed "Signal"
else
    print_missing "Signal"
fi

# WiFiman
if app_exists "/Applications/WiFiman Desktop.app"; then
    print_installed "WiFiman"
else
    print_missing "WiFiman"
fi

# ImageOptim
if app_exists "/Applications/ImageOptim.app"; then
    print_installed "ImageOptim"
else
    print_missing "ImageOptim"
fi

print_section "Command Line Utilities"

# ngrok
if command_exists ngrok; then
    ngrok_version=$(ngrok version 2>/dev/null | head -n1 | cut -d' ' -f2 || echo "installed")
    print_installed "ngrok (${ngrok_version})"
else
    print_missing "ngrok"
fi

# eza (modern ls replacement, replaces exa)
if command_exists eza; then
    eza_version=$(eza --version 2>/dev/null | head -n1 | cut -d' ' -f2 || echo "installed")
    print_installed "eza (${eza_version})"
else
    print_missing "eza"
fi

# wget
if command_exists wget; then
    wget_version=$(wget --version 2>/dev/null | head -n1 | cut -d' ' -f3 || echo "installed")
    print_installed "wget (${wget_version})"
else
    print_missing "wget"
fi

# jq
if command_exists jq; then
    print_installed "jq ($(jq --version))"
else
    print_missing "jq"
fi

# tree
if command_exists tree; then
    tree_version=$(tree --version 2>/dev/null | head -n1 | cut -d' ' -f2 || echo "installed")
    print_installed "tree (${tree_version})"
else
    print_missing "tree"
fi

# fzf
if command_exists fzf; then
    fzf_version=$(fzf --version 2>/dev/null | cut -d' ' -f1 || echo "installed")
    print_installed "fzf (${fzf_version})"
else
    print_missing "fzf"
fi

# ripgrep
if command_exists rg; then
    print_installed "ripgrep ($(rg --version 2>/dev/null | head -n1 | awk '{print $2}' || echo installed))"
else
    print_missing "ripgrep (rg)"
fi

# fd
if command_exists fd; then
    print_installed "fd ($(fd --version 2>/dev/null | awk '{print $2}' || echo installed))"
else
    print_missing "fd"
fi

# bat
if command_exists bat; then
    print_installed "bat ($(bat --version 2>/dev/null | awk '{print $2}' || echo installed))"
else
    print_missing "bat"
fi

# git-delta
if command_exists delta; then
    print_installed "git-delta ($(delta --version 2>/dev/null | awk '{print $2}' || echo installed))"
else
    print_missing "git-delta"
fi

# Shell power-ups
for tool in zoxide lazygit direnv atuin btop dust duf; do
    if command_exists "${tool}"; then
        print_installed "${tool}"
    else
        print_missing "${tool}"
    fi
done

# tldr (provided by tealdeer)
if command_exists tldr; then
    print_installed "tldr (tealdeer)"
else
    print_missing "tldr (tealdeer)"
fi

# Note: watchman is verified in the "Frontend CLI Tools" section above.

print_section "AI Coding Assistants"

# Claude Code
if command_exists claude; then
    claude_version=$(claude --version 2>/dev/null | head -n1 || echo "installed")
    print_installed "Claude Code (${claude_version})"
else
    print_missing "Claude Code"
fi

# OpenCode
if command_exists opencode; then
    opencode_version=$(opencode --version 2>/dev/null | head -n1 || echo "installed")
    print_installed "OpenCode AI (${opencode_version})"

    # Check if authenticated
    if [[ -f ~/.opencode/config.json ]] && grep -q "apiKey" ~/.opencode/config.json 2>/dev/null; then
        print_installed "  OpenCode (authenticated)"
    else
        print_warning "  OpenCode (not configured - run: opencode auth login)"
    fi
else
    print_missing "OpenCode AI"
fi

print_section "VS Code Extensions"

if command_exists code; then
    extensions=(
        "vue.volar"
        "ms-vscode.vscode-typescript-next"
        "esbenp.prettier-vscode"
        "ms-python.python"
        "golang.go"
        "github.vscode-pull-request-github"
        "github.copilot"
        "eamodio.gitlens"
        "editorconfig.editorconfig"
        "ms-vscode-remote.remote-containers"
        "redhat.vscode-yaml"
        "pkief.material-icon-theme"
        "yzhang.markdown-all-in-one"
        "shd101wyy.markdown-preview-enhanced"
    )

    for extension in "${extensions[@]}"; do
        if vscode_extension_exists "${extension}"; then
            print_installed "  ${extension}"
        else
            print_missing "  ${extension}"
        fi
    done
else
    print_missing "VS Code (cannot check extensions)"
fi

print_section "Fonts"

# Check for Nerd Fonts (common locations)
font_locations=(
    "/System/Library/Fonts"
    "/Library/Fonts"
    "${HOME}/Library/Fonts"
)

fonts_found=false
for location in "${font_locations[@]}"; do
    if find "${location}" -name "*Nerd*" -o -name "*Fira*Code*" -o -name "*JetBrains*Mono*" 2>/dev/null | grep -q .; then
        fonts_found=true
        break
    fi
done

if ${fonts_found}; then
    print_installed "Developer Fonts (Nerd Fonts/Fira Code/JetBrains Mono found)"
else
    print_missing "Developer Fonts"
fi

# Summary
print_section "Summary"
echo -e "${GREEN}✓ Installed: ${INSTALLED}${NC}"
echo -e "${RED}✗ Missing: ${MISSING}${NC}"
echo -e "${BLUE}📊 Total checked: ${TOTAL}${NC}"

# Calculate percentage
if [[ ${TOTAL} -gt 0 ]]; then
    percentage=$((INSTALLED * 100 / TOTAL))
    echo -e "${BLUE}📈 Completion: ${percentage}%${NC}"
fi

if [[ ${MISSING} -eq 0 ]]; then
    echo -e "\n🎉 ${GREEN}Perfect! All development tools are installed with versions tracked!${NC}"
elif [[ ${MISSING} -le 5 ]]; then
    echo -e "\n👍 ${YELLOW}Great! Only ${MISSING} tools missing. Your setup is ${percentage}% complete!${NC}"
else
    echo -e "\n🔧 ${YELLOW}${MISSING} tools are missing (${percentage}% complete). Consider running the setup script.${NC}"
fi

echo -e "\n💡 ${BLUE}Tip: Run the main setup script to install missing tools automatically.${NC}"
echo -e "🔄 ${BLUE}Version tracking helps monitor updates and compatibility.${NC}"
