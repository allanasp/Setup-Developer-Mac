#!/bin/sh

# Mac Developer Setup - Bootstrap Installer
#
# POSIX-sh bootstrap that can be run directly from the web:
#
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)"
#
# It will:
#   1. Verify it is running on macOS
#   2. Install Xcode Command Line Tools (needed for git) if missing
#   3. Clone (or update) the repo into ~/Setup-Developer-Mac
#   4. Hand off to ./setup.sh (which runs under bash)
#
# Pass arguments straight through to setup.sh, e.g.:
#   sh -c "$(curl -fsSL .../install.sh)" -- --skip-prompts

set -eu

REPO_URL="https://github.com/allanasp/Setup-Developer-Mac.git"
INSTALL_DIR="${SETUP_INSTALL_DIR:-$HOME/Setup-Developer-Mac}"

# --- Minimal coloured output (matches the project's style) -------------------
if [ -t 1 ]; then
    BLUE='\033[0;34m'
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m'
else
    BLUE=''
    GREEN=''
    RED=''
    NC=''
fi

# Keep the message out of the printf format string (a stray % would break it).
info() { printf '%bℹ️  %s%b\n' "$BLUE" "$1" "$NC"; }
success() { printf '%b✅ %s%b\n' "$GREEN" "$1" "$NC"; }
error() { printf '%b❌ %s%b\n' "$RED" "$1" "$NC" >&2; }

# --- 1. macOS check ----------------------------------------------------------
if [ "$(uname -s)" != "Darwin" ]; then
    error "This installer only supports macOS."
    exit 1
fi
success "Running on macOS"

# --- 2. Xcode Command Line Tools (provides git) ------------------------------
if ! xcode-select -p >/dev/null 2>&1; then
    info "Installing Xcode Command Line Tools (needed for git)..."
    xcode-select --install || true
    echo ""
    info "Finish the Xcode Command Line Tools install in the popup, then re-run this command."
    exit 1
fi
success "Xcode Command Line Tools present"

if ! command -v git >/dev/null 2>&1; then
    error "git is not available even though Xcode CLI Tools are installed."
    exit 1
fi

# --- 3. Clone or update the repo ---------------------------------------------
if [ -d "$INSTALL_DIR/.git" ]; then
    info "Repo already exists at $INSTALL_DIR — pulling latest..."
    git -C "$INSTALL_DIR" pull --ff-only
    success "Repo updated"
else
    info "Cloning into $INSTALL_DIR..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    success "Repo cloned"
fi

# --- 4. Hand off to setup.sh (runs under bash) -------------------------------
cd "$INSTALL_DIR"
chmod +x setup.sh
find scripts -name '*.sh' -exec chmod +x {} +

info "Launching setup.sh..."
echo ""
exec bash ./setup.sh "$@"
