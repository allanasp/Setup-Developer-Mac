#!/bin/bash

# Common functions and variables for all setup scripts
# This file should be sourced by all other setup scripts

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_section() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE} $1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# Function to safely install cask applications
install_cask_app() {
    local app_name="$1"
    local cask_name="$2"
    local app_path="$3"
    
    print_status "Installing/Updating $app_name..."
    if [[ -d "$app_path" ]]; then
        print_success "$app_name already installed (will be updated by brew upgrade)"
        return 0
    else
        if brew install --cask "$cask_name"; then
            print_success "$app_name installed successfully"
            return 0
        else
            print_error "$app_name installation failed"
            return 1
        fi
    fi
}

# Function to safely install volta packages
install_volta_package() {
    local package_name="$1"
    
    print_status "Installing $package_name via Volta..."
    if volta install "$package_name"; then
        print_success "$package_name installed successfully"
    else
        print_error "$package_name installation failed"
        return 1
    fi
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only"
        exit 1
    fi
}

# Check if Homebrew is installed
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        print_error "Homebrew is required but not installed. Please run the system setup first."
        exit 1
    fi
}

# Check if Volta is installed
check_volta() {
    if ! command -v volta &> /dev/null; then
        print_error "Volta is required but not installed. Please run the version managers setup first."
        exit 1
    fi
}