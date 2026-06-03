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

# Dry-run mode: when DRY_RUN=true the install helpers and shell-config writers
# only report what they would do, without mutating the system. Enable with
# `./setup.sh --dry-run` or `DRY_RUN=true ./scripts/XX.sh`.
DRY_RUN="${DRY_RUN:-false}"
is_dry_run() {
    [[ "${DRY_RUN}" == "true" ]]
}

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

    if [[ -d "${app_path}" ]]; then
        print_success "${app_name} already installed"
        return 0
    fi
    if is_dry_run; then
        print_status "[dry-run] would install cask: ${cask_name} (${app_name})"
        return 0
    fi
    print_status "Installing/Updating ${app_name}..."
    if brew install --cask "${cask_name}"; then
        print_success "${app_name} installed successfully"
    else
        print_error "${app_name} installation failed"
        print_warning "Continuing without ${app_name}..."
    fi
    # Graceful: never abort the caller (which may run under `set -e`) just
    # because one optional app failed to install.
    return 0
}

# Function to safely install a Homebrew formula (idempotent + graceful)
# `brew install` already returns 0 when a formula is present, and running it
# inside the `if` condition means a real failure never trips `set -e`.
install_brew_formula() {
    local formula="$1"
    local label="${2:-$1}"

    if is_dry_run; then
        print_status "[dry-run] would install formula: ${formula} (${label})"
        return 0
    fi
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

    if is_dry_run; then
        print_status "[dry-run] would install via Volta: ${package_name}"
        return 0
    fi
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

# Append a block of shell config to ~/.zshenv exactly once, keyed by a marker.
# Environment/PATH exports belong in ~/.zshenv (not ~/.zshrc) so they are also
# available to non-interactive and GUI-launched shells — e.g. Gradle/Xcode
# builds spawned by Android Studio — and not just interactive terminals.
# The marker doubles as the dedup guard, so two scripts exporting the same
# variable (e.g. JAVA_HOME from 04 and 12) only write it once.
# Usage: add_to_zshenv "MARKER" 'export FOO=bar' 'export PATH=...'
add_to_zshenv() {
    local marker="$1"
    shift
    local zshenv="${HOME}/.zshenv"

    if [[ -f "${zshenv}" ]] && grep -qF "${marker}" "${zshenv}" 2>/dev/null; then
        return 0
    fi
    if is_dry_run; then
        print_status "[dry-run] would add '${marker}' to ~/.zshenv"
        return 0
    fi
    [[ -f "${zshenv}" ]] || touch "${zshenv}"
    {
        echo ""
        echo "# ${marker}"
        printf '%s\n' "$@"
    } >>"${zshenv}"
}

# Append a block of shell config to ~/.zshrc exactly once, keyed by a marker.
# Use this for *interactive* shell config — aliases, prompt setup, shell
# integrations (`pyenv init`), convenience functions. Pure env/PATH exports
# belong in ~/.zshenv via add_to_zshenv instead.
# Pass the content as arguments (one per line), or via stdin for larger
# blocks (heredoc). The marker is written as a comment header and used as the
# dedup guard.
# Usage: add_to_zshrc "MARKER" 'line1' 'line2'
#        add_to_zshrc "MARKER" <<'EOF' ... EOF
add_to_zshrc() {
    local marker="$1"
    shift
    local zshrc="${HOME}/.zshrc"

    if [[ -f "${zshrc}" ]] && grep -qF "${marker}" "${zshrc}" 2>/dev/null; then
        return 0
    fi
    if is_dry_run; then
        print_status "[dry-run] would add '${marker}' to ~/.zshrc"
        # Drain stdin so a heredoc caller doesn't leak into the next command.
        [[ $# -gt 0 ]] || cat >/dev/null
        return 0
    fi
    [[ -f "${zshrc}" ]] || touch "${zshrc}"
    {
        echo ""
        echo "# ${marker}"
        if [[ $# -gt 0 ]]; then
            printf '%s\n' "$@"
        else
            cat
        fi
    } >>"${zshrc}"
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
    if ! command -v brew &>/dev/null; then
        print_error "Homebrew is required but not installed. Please run the system setup first."
        exit 1
    fi
}

# Check if Volta is installed
check_volta() {
    if ! command -v volta &>/dev/null; then
        print_error "Volta is required but not installed. Please run the version managers setup first."
        exit 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
