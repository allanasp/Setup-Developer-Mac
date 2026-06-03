#!/bin/bash

# Update everything installed by this setup in one go.
#
# Usage:
#   ./update.sh            # Upgrade Homebrew, Volta/Node, Oh My Zsh, PowerLevel10k
#   ./update.sh --dry-run  # Show what would be upgraded without changing anything

set -e # Exit on any error

source "$(dirname "$0")/scripts/common.sh"

# --dry-run / -n
for arg in "$@"; do
    case "${arg}" in
        --dry-run | -n) export DRY_RUN=true ;;
    esac
done

# Log the run
LOG_FILE="${HOME}/mac-update-$(date +%Y-%m-%d).log"
exec > >(tee -a "${LOG_FILE}") 2>&1

print_section "Updating Development Environment"
check_macos

run_step() {
    # run_step "description" command...
    local desc="$1"
    shift
    if is_dry_run; then
        print_status "[dry-run] would ${desc}"
        return 0
    fi
    print_status "${desc}..."
    if "$@"; then
        print_success "${desc} - done"
    else
        print_warning "${desc} - failed (continuing)"
    fi
}

# --- Homebrew -----------------------------------------------------------------
if command_exists brew; then
    run_step "update Homebrew" brew update
    run_step "upgrade Homebrew formulae & casks" brew upgrade
    run_step "clean up Homebrew" brew cleanup
else
    print_warning "Homebrew not installed - skipping"
fi

# --- Volta / Node -------------------------------------------------------------
if command_exists volta; then
    run_step "install latest Node LTS via Volta" volta install node@lts
else
    print_warning "Volta not installed - skipping Node update"
fi

# --- Oh My Zsh ----------------------------------------------------------------
if [[ -f "${HOME}/.oh-my-zsh/tools/upgrade.sh" ]]; then
    run_step "upgrade Oh My Zsh" "${HOME}/.oh-my-zsh/tools/upgrade.sh"
else
    print_warning "Oh My Zsh not installed - skipping"
fi

# --- Custom zsh plugins & PowerLevel10k (git pull) ----------------------------
for repo in \
    "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" \
    "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
    "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
    "${HOME}/.oh-my-zsh/custom/plugins/zsh-completions"; do
    if [[ -d "${repo}/.git" ]]; then
        run_step "update $(basename "${repo}")" git -C "${repo}" pull --ff-only
    fi
done

print_success "Update complete!"
echo ""
echo "📄 Full log saved to: ${LOG_FILE}"
echo "🔄 Restart your terminal (or 'source ~/.zshrc') to pick up changes."
