#!/bin/bash

# Common functions and variables for all setup scripts
# This file should be sourced by all other setup scripts

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
    
    print_status "Installing/Updating ${app_name}..."
    if [[ -d "${app_path}" ]]; then
        print_success "${app_name} already installed"
        return 0
    else
        if brew install --cask "${cask_name}"; then
            print_success "${app_name} installed successfully"
            return 0
        else
            print_error "${app_name} installation failed"
            return 1
        fi
    fi
}

# Function to safely install a Homebrew formula (idempotent + graceful)
# `brew install` already returns 0 when a formula is present, and running it
# inside the `if` condition means a real failure never trips `set -e`.
install_brew_formula() {
    local formula="$1"
    local label="${2:-$1}"

    print_status "Installing ${label}..."
    if brew install "${formula}"; then
        print_success "${label} installed"
        return 0
    else
        print_error "${label} installation failed"
        print_warning "Continuing without ${label}..."
        return 0
    fi
}

# Function to safely install volta packages
install_volta_package() {
    local package_name="$1"

    print_status "Installing ${package_name} via Volta..."
    if volta install "${package_name}"; then
        print_success "${package_name} installed successfully"
    else
        print_error "${package_name} installation failed"
        print_warning "Continuing without ${package_name}..."
    fi
    return 0
}

# Check if a macOS application bundle exists
app_exists() {
    [[ -d "$1" ]]
}

# Check if running on macOS
check_macos() {
    if [[ "${OSTYPE}" != "darwin"* ]]; then
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

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
