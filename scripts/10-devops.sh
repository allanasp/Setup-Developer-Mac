#!/bin/bash

# DevOps Tools Setup
# Installs: ngrok, UpCloud CLI, Kubernetes/Tilt/Terraform, command line utilities

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "DevOps Tools Setup"

check_macos
check_homebrew

# Command line utilities
print_status "Installing command line utilities..."
# ripgrep (rg), fd, bat and git-delta are modern replacements that pair with
# fzf/eza; git-delta also powers the git pager configured in 06-dev-apps.sh.
for util in ngrok eza wget jq tree fzf ripgrep fd bat git-delta; do
    install_brew_formula "${util}"
done

# Wire fzf zsh integration (Ctrl-T fuzzy files, Alt-C fuzzy cd, ** completion).
# Ctrl-R history search is left to atuin if it is installed later.
add_to_zshrc "fzf shell integration" \
    'command -v fzf >/dev/null && source <(fzf --zsh)'
print_success "fzf shell integration ensured in .zshrc"

# UpCloud CLI (upctl) - manage UpCloud infrastructure
if command -v upctl &>/dev/null; then
    print_success "UpCloud CLI (upctl) already installed"
else
    install_brew_formula "UpCloudLtd/tap/upcloud-cli" "UpCloud CLI (upctl)"
fi

# Infrastructure / orchestration tooling
print_status "Installing infrastructure tools..."
install_brew_formula "kubernetes-cli" "kubectl (Kubernetes CLI)"
install_brew_formula "tilt" "Tilt"
# Terraform lives in HashiCorp's tap (moved out of core under the BSL license);
# `brew install` auto-taps hashicorp/tap.
if command -v terraform &>/dev/null; then
    print_success "Terraform already installed"
else
    install_brew_formula "hashicorp/tap/terraform" "Terraform"
fi

# Shell power-ups
print_status "Installing shell power-ups..."
for tool in zoxide lazygit direnv atuin tealdeer btop dust duf; do
    install_brew_formula "${tool}"
done

# Shell integrations (interactive → ~/.zshrc). atuin is added after fzf so it
# owns Ctrl-R history search; fzf keeps Ctrl-T / Alt-C.
add_to_zshrc "zoxide init" 'command -v zoxide >/dev/null && eval "$(zoxide init zsh)"'
add_to_zshrc "direnv hook" 'command -v direnv >/dev/null && eval "$(direnv hook zsh)"'
add_to_zshrc "atuin init" 'command -v atuin >/dev/null && eval "$(atuin init zsh)"'
print_status "Tip: run 'tldr --update' once to fetch the tealdeer page cache"

print_success "DevOps tools setup completed!"
echo ""
echo "Installed tools:"
echo "• ngrok (local tunneling for sharing dev servers)"
echo "• eza (modern ls replacement with colors)"
echo "• wget (file downloads)"
echo "• jq (JSON processing for APIs)"
echo "• tree (directory visualization)"
echo "• fzf (fuzzy finder for terminal)"
echo "• ripgrep (rg), fd, bat (fast search/find/cat)"
echo "• git-delta (syntax-highlighted git diffs)"
echo "• zoxide (smart cd), lazygit (git TUI), direnv (per-dir env)"
echo "• atuin (searchable history), tldr, btop/dust/duf (top/du/df)"
echo "• UpCloud CLI (upctl - manage UpCloud infrastructure)"
echo "• kubectl (Kubernetes CLI)"
echo "• Tilt (Kubernetes dev environments)"
echo "• Terraform (infrastructure as code)"
echo ""
echo "📋 TODO: Account Creation & Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ ngrok Account (for sharing local dev)"
echo "  → Sign up: https://ngrok.com"
echo "  → Get auth token: ngrok config add-authtoken <token>"
echo "  → Usage: ngrok http 3000 (share your dev server)"
echo ""
echo "□ UpCloud (if managing UpCloud infrastructure)"
echo "  → Sign up: https://upcloud.com"
echo "  → Authenticate: upctl account login"
echo ""
echo "Next steps:"
echo "• Run fonts setup: ./scripts/11-fonts.sh"
