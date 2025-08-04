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

# Function to check VS Code extension
vscode_extension_exists() {
    code --list-extensions 2>/dev/null | grep -q "$1"
}

print_section "System Requirements"

# Xcode Command Line Tools
if xcode-select -p &> /dev/null; then
    xcode_version=$(xcodebuild -version 2>/dev/null | head -n1 || echo "Command Line Tools")
    print_installed "Xcode Command Line Tools ($xcode_version)"
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
    pyenv versions --bare | while read version; do
        if [[ -n "$version" ]]; then
            print_installed "  Python $version"
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
    print_installed "Ruby ($ruby_version)"
else
    print_missing "Ruby"
fi

# Java (JDK)
if command_exists java; then
    java_version=$(java --version 2>/dev/null | head -n1 | cut -d' ' -f2 || java -version 2>&1 | head -n1 | cut -d'"' -f2 || echo "installed")
    print_installed "Java JDK ($java_version)"
    
    # Check JAVA_HOME
    if [[ -n "$JAVA_HOME" ]]; then
        print_installed "  JAVA_HOME set ($JAVA_HOME)"
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
    print_installed "npm ($npm_version)"
else
    print_missing "npm"
fi

# Yarn
if command_exists yarn; then
    yarn_version=$(yarn --version 2>/dev/null || echo "installed")
    print_installed "Yarn ($yarn_version)"
else
    print_missing "Yarn"
fi

# pnpm
if command_exists pnpm; then
    pnpm_version=$(pnpm --version 2>/dev/null || echo "installed")
    print_installed "pnpm ($pnpm_version)"
else
    print_missing "pnpm"
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

# React Native CLI
if command_exists react-native; then
    print_installed "React Native CLI ($(react-native --version | head -n1))"
else
    print_missing "React Native CLI"
fi

# Expo CLI
if command_exists expo; then
    expo_version=$(expo --version 2>/dev/null || echo "installed")
    print_installed "Expo CLI ($expo_version)"
else
    print_missing "Expo CLI"
fi

# Vite
if command_exists create-vite; then
    vite_version=$(npm list -g create-vite --depth=0 2>/dev/null | grep create-vite | cut -d'@' -f2 || echo "installed")
    print_installed "Vite (create-vite@$vite_version)"
else
    print_missing "Vite (create-vite)"
fi

# Serve
if command_exists serve; then
    print_installed "Serve ($(serve --version))"
else
    print_missing "Serve"
fi

print_section "Development Applications"

# VS Code
if app_exists "/Applications/Visual Studio Code.app"; then
    if command_exists code; then
        vscode_version=$(code --version 2>/dev/null | head -n1 || echo "installed")
        print_installed "Visual Studio Code ($vscode_version)"
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

# Zed
if app_exists "/Applications/Zed.app"; then
    print_installed "Zed"
else
    print_missing "Zed"
fi

# TextMate
if app_exists "/Applications/TextMate.app"; then
    print_installed "TextMate"
else
    print_missing "TextMate"
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
        print_installed "Oh My Zsh ($omz_version)"
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

# Git Flow
if command_exists git-flow; then
    print_installed "Git Flow"
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
if command_exists psql; then
    print_installed "PostgreSQL ($(psql --version | cut -d' ' -f3))"
    # Check if service is running
    if brew services list | grep postgresql | grep -q started; then
        print_installed "  PostgreSQL service (running)"
    else
        print_warning "  PostgreSQL service (not running)"
    fi
else
    print_missing "PostgreSQL"
fi

# Sequel Ace
if app_exists "/Applications/Sequel Ace.app"; then
    print_installed "Sequel Ace"
else
    print_missing "Sequel Ace"
fi

print_section "Kubernetes & DevOps Tools"

# kOps
if command_exists kops; then
    print_installed "kOps ($(kops version --short))"
else
    print_missing "kOps"
fi

# Helm
if command_exists helm; then
    print_installed "Helm ($(helm version --short))"
else
    print_missing "Helm"
fi

# kubectl
if command_exists kubectl; then
    print_installed "kubectl ($(kubectl version --client --short 2>/dev/null || echo 'installed'))"
else
    print_missing "kubectl"
fi

# kubectx
if command_exists kubectx; then
    kubectx_version=$(kubectx --version 2>/dev/null || echo "installed")
    print_installed "kubectx ($kubectx_version)"
else
    print_missing "kubectx"
fi

# kubens
if command_exists kubens; then
    kubens_version=$(kubens --version 2>/dev/null || echo "installed")
    print_installed "kubens ($kubens_version)"
else
    print_missing "kubens"
fi

print_section "Mobile Development"

# Android Studio
if app_exists "/Applications/Android Studio.app"; then
    print_installed "Android Studio"
else
    print_missing "Android Studio"
fi

# iOS Development Tools
if command_exists xcodes; then
    xcodes_version=$(xcodes version 2>/dev/null || echo "installed")
    print_installed "xcodes ($xcodes_version)"
else
    print_missing "xcodes"
fi

if command_exists swiftlint; then
    print_installed "SwiftLint ($(swiftlint version))"
else
    print_missing "SwiftLint"
fi

if command_exists ios-deploy; then
    ios_deploy_version=$(ios-deploy --version 2>/dev/null || echo "installed")
    print_installed "ios-deploy ($ios_deploy_version)"
else
    print_missing "ios-deploy"
fi

if command_exists pod; then
    print_installed "CocoaPods ($(pod --version))"
else
    print_missing "CocoaPods"
fi

print_section "Productivity Tools"

# Raycast
if app_exists "/Applications/Raycast.app"; then
    print_installed "Raycast"
else
    print_missing "Raycast"
fi

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

# Figma
if app_exists "/Applications/Figma.app"; then
    print_installed "Figma"
else
    print_missing "Figma"
fi

# System Color Picker
if app_exists "/Applications/System Color Picker.app"; then
    print_installed "System Color Picker"
else
    print_missing "System Color Picker"
fi

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
    print_installed "ngrok ($ngrok_version)"
else
    print_missing "ngrok"
fi

# exa
if command_exists exa; then
    exa_version=$(exa --version 2>/dev/null | head -n1 | cut -d' ' -f2 || echo "installed")
    print_installed "exa ($exa_version)"
else
    print_missing "exa"
fi

# wget
if command_exists wget; then
    wget_version=$(wget --version 2>/dev/null | head -n1 | cut -d' ' -f3 || echo "installed")
    print_installed "wget ($wget_version)"
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
    print_installed "tree ($tree_version)"
else
    print_missing "tree"
fi

# fzf
if command_exists fzf; then
    fzf_version=$(fzf --version 2>/dev/null | cut -d' ' -f1 || echo "installed")
    print_installed "fzf ($fzf_version)"
else
    print_missing "fzf"
fi

# watchman
if command_exists watchman; then
    watchman_version=$(watchman version 2>/dev/null | jq -r '.version' 2>/dev/null || watchman --version 2>/dev/null || echo "installed")
    print_installed "watchman ($watchman_version)"
else
    print_missing "watchman"
fi

print_section "AI Coding Assistants"

# AWS CLI (required for Amazon Q)
if command_exists aws; then
    aws_version=$(aws --version 2>/dev/null | cut -d' ' -f1 | cut -d'/' -f2 || echo "installed")
    print_installed "AWS CLI ($aws_version)"
else
    print_missing "AWS CLI (required for Amazon Q)"
fi

# Amazon Q (check via AWS CLI and VS Code extension)
if command_exists aws; then
    # Check if user has configured AWS CLI (basic check)
    if aws sts get-caller-identity &>/dev/null 2>&1; then
        print_installed "Amazon Q Developer (AWS configured)"
    else
        print_warning "Amazon Q Developer (AWS CLI not configured - run 'aws configure')"
    fi
else
    print_missing "Amazon Q Developer (AWS CLI missing)"
fi

# Claude Code
if command_exists claude; then
    claude_version=$(claude --version 2>/dev/null | head -n1 || echo "installed")
    print_installed "Claude Code ($claude_version)"
else
    print_missing "Claude Code"
fi

print_section "VS Code Extensions"

if command_exists code; then
    extensions=(
        "Vue.volar"
        "ms-vscode.vscode-typescript-next"
        "esbenp.prettier-vscode"
        "ms-python.python"
        "golang.Go"
        "GitHub.vscode-pull-request-github"
        "GitHub.copilot"
        "Amazon.aws-toolkit-vscode"
        "eamodio.gitlens"
        "EditorConfig.EditorConfig"
        "ms-vscode-remote.remote-containers"
        "ms-vscode.vscode-json"
        "redhat.vscode-yaml"
        "PKief.material-icon-theme"
        "yzhang.markdown-all-in-one"
        "shd101wyy.markdown-preview-enhanced"
    )
    
    for extension in "${extensions[@]}"; do
        if vscode_extension_exists "$extension"; then
            print_installed "  $extension"
        else
            print_missing "  $extension"
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
    "$HOME/Library/Fonts"
)

fonts_found=false
for location in "${font_locations[@]}"; do
    if find "$location" -name "*Nerd*" -o -name "*Fira*Code*" -o -name "*JetBrains*Mono*" 2>/dev/null | grep -q .; then
        fonts_found=true
        break
    fi
done

if $fonts_found; then
    print_installed "Developer Fonts (Nerd Fonts/Fira Code/JetBrains Mono found)"
else
    print_missing "Developer Fonts"
fi

# Summary
print_section "Summary"
echo -e "${GREEN}✓ Installed: $INSTALLED${NC}"
echo -e "${RED}✗ Missing: $MISSING${NC}"
echo -e "${BLUE}📊 Total checked: $TOTAL${NC}"

# Calculate percentage
if [[ $TOTAL -gt 0 ]]; then
    percentage=$((INSTALLED * 100 / TOTAL))
    echo -e "${BLUE}📈 Completion: ${percentage}%${NC}"
fi

if [[ $MISSING -eq 0 ]]; then
    echo -e "\n🎉 ${GREEN}Perfect! All development tools are installed with versions tracked!${NC}"
elif [[ $MISSING -le 5 ]]; then
    echo -e "\n👍 ${YELLOW}Great! Only $MISSING tools missing. Your setup is ${percentage}% complete!${NC}"
else
    echo -e "\n🔧 ${YELLOW}$MISSING tools are missing (${percentage}% complete). Consider running the setup script.${NC}"
fi

echo -e "\n💡 ${BLUE}Tip: Run the main setup script to install missing tools automatically.${NC}"
echo -e "🔄 ${BLUE}Version tracking helps monitor updates and compatibility.${NC}"