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
for util in ngrok eza wget jq tree fzf; do
    install_brew_formula "${util}"
done

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

print_success "DevOps tools setup completed!"
echo ""
echo "Installed tools:"
echo "• ngrok (local tunneling for sharing dev servers)"
echo "• eza (modern ls replacement with colors)"
echo "• wget (file downloads)"
echo "• jq (JSON processing for APIs)"
echo "• tree (directory visualization)"
echo "• fzf (fuzzy finder for terminal)"
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
