#!/bin/bash

# Roll back tooling installed by this setup.
#
# Best-effort, category-by-category, with confirmation. It removes apps (casks),
# CLI formulae and Volta packages installed by the scripts. It deliberately does
# NOT remove Homebrew itself, the Xcode Command Line Tools, git, Node, or your
# shell config — those are left intact.
#
# Usage:
#   ./uninstall.sh            # Interactive, asks before each category
#   ./uninstall.sh --dry-run  # Show what would be removed, change nothing
#   ./uninstall.sh -y         # Don't ask, remove everything listed

set -e

source "$(dirname "$0")/scripts/common.sh"

ASSUME_YES=false
for arg in "$@"; do
    case "${arg}" in
        --dry-run | -n) export DRY_RUN=true ;;
        --yes | -y) ASSUME_YES=true ;;
    esac
done

LOG_FILE="${HOME}/mac-uninstall-$(date +%Y-%m-%d).log"
exec > >(tee -a "${LOG_FILE}") 2>&1

print_section "Uninstall — roll back installed tooling"
check_macos
check_homebrew

print_warning "This removes apps, CLI tools and Volta packages installed by this setup."
print_warning "Homebrew, Xcode CLT, git, Node and your shell config are kept."

# Apps installed as Homebrew casks
CASKS=(
    iterm2 warp visual-studio-code cursor textmate kiro github
    rectangle maccy obsidian google-chrome firefox brave-browser
    orbstack postman mockoon expo-orbit figma imageoptim wireguard
    devtoys signal wifiman appcleaner jordanbaird-ice syncthing wireshark
    dbeaver-community pgadmin4 android-studio
    font-fira-code font-jetbrains-mono font-source-code-pro font-hack-nerd-font
)

# CLI tools installed as Homebrew formulae (core git/node intentionally excluded)
FORMULAE=(
    git-flow-avh gh openjdk@17 go ruby pyenv watchman postgresql@15
    ngrok eza wget jq tree fzf ripgrep fd bat git-delta
    zoxide lazygit direnv atuin tealdeer btop dust duf
    kubernetes-cli tilt 1password-cli ios-deploy cocoapods xcodes swiftlint
    hashicorp/tap/terraform UpCloudLtd/tap/upcloud-cli oven-sh/bun/bun
    supabase/tap/supabase
)

# Global packages installed via Volta
VOLTA_PKGS=(
    typescript @vue/cli nuxt create-vite serve turbo vercel
    storyblok @sanity/cli @react-native-community/cli @expo/cli eas-cli
    create-expo-app pnpm
)

confirm_category() {
    # confirm_category "label"  -> returns 0 to proceed, 1 to skip
    local label="$1"
    if is_dry_run || [[ "${ASSUME_YES}" == "true" ]]; then
        return 0
    fi
    read -r -p "Remove ${label}? [y/N]: " ans
    [[ "${ans}" =~ ^[Yy]$ ]]
}

remove_cask() {
    local cask="$1"
    if ! brew list --cask "${cask}" &>/dev/null; then
        return 0
    fi
    if is_dry_run; then
        print_status "[dry-run] would remove cask: ${cask}"
        return 0
    fi
    if brew uninstall --cask "${cask}" 2>/dev/null; then
        print_success "Removed cask: ${cask}"
    else
        print_warning "Could not remove cask: ${cask}"
    fi
}

remove_formula() {
    local formula="$1"
    if ! brew list "${formula}" &>/dev/null; then
        return 0
    fi
    if is_dry_run; then
        print_status "[dry-run] would remove formula: ${formula}"
        return 0
    fi
    # No --ignore-dependencies: if something still depends on this formula,
    # brew refuses, which is the safe behaviour for a rollback.
    if brew uninstall "${formula}" 2>/dev/null; then
        print_success "Removed formula: ${formula}"
    else
        print_warning "Could not remove ${formula} (in use by another formula?)"
    fi
}

remove_volta_pkg() {
    local pkg="$1"
    command_exists volta || return 0
    # Skip packages that aren't actually installed (mirrors the brew guards).
    volta list 2>/dev/null | grep -q "${pkg}" || return 0
    if is_dry_run; then
        print_status "[dry-run] would remove Volta package: ${pkg}"
        return 0
    fi
    volta uninstall "${pkg}" &>/dev/null && print_success "Removed Volta package: ${pkg}" || print_warning "Could not remove Volta package: ${pkg}"
}

if confirm_category "applications (casks)"; then
    for c in "${CASKS[@]}"; do remove_cask "${c}"; done
fi

if confirm_category "CLI tools (formulae)"; then
    for f in "${FORMULAE[@]}"; do remove_formula "${f}"; done
fi

if confirm_category "Volta global packages"; then
    for p in "${VOLTA_PKGS[@]}"; do remove_volta_pkg "${p}"; done
fi

print_success "Uninstall complete!"
echo ""
echo "📄 Full log saved to: ${LOG_FILE}"
echo "Note: shell config (~/.zshrc, ~/.zshenv) and ~/.oh-my-zsh were left intact."
