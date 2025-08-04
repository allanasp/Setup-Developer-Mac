#!/bin/bash

# DevOps Tools Setup
# Installs: Kubernetes tools, AWS CLI, command line utilities

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "DevOps Tools Setup"

check_macos
check_homebrew

# Kubernetes and DevOps tools
print_status "Installing Kubernetes and DevOps tools..."
brew install kops  # Kubernetes cluster management
brew install helm  # Kubernetes package manager  
brew install kubernetes-cli  # kubectl command line tool
brew install kubectx  # Switch between Kubernetes contexts (includes kubens)
print_success "Kubernetes tools installed"

# AI Coding Assistants
print_status "Installing AI coding assistants..."

# AWS CLI (required for Amazon Q)
print_status "Installing AWS CLI..."
if ! command -v aws &> /dev/null; then
    brew install awscli
    print_success "AWS CLI installed"
else
    print_success "AWS CLI already installed"
fi

# Command line utilities
print_status "Installing command line utilities..."
brew install ngrok  # Local tunneling
brew install eza    # Modern ls replacement
brew install wget   # File download utility
brew install jq     # JSON processor
brew install tree   # Directory tree viewer
brew install fzf    # Fuzzy finder
print_success "Command line utilities installed"

print_success "DevOps tools setup completed!"
echo ""
echo "Installed Kubernetes tools:"
echo "• kOps (cluster management)"
echo "• Helm (package manager)"
echo "• kubectl (CLI)"
echo "• kubectx & kubens (context switching)"
echo ""
echo "Installed CLI utilities:"
echo "• AWS CLI (for Amazon Q)"
echo "• ngrok (local tunneling)"
echo "• eza (better ls with colors)"
echo "• wget (file downloads)"
echo "• jq (JSON processing)"
echo "• tree (directory visualization)"
echo "• fzf (fuzzy finder)"
echo ""
echo "Kubernetes usage:"
echo "• Switch context: kubectx production"
echo "• Switch namespace: kubens default"
echo "• Install chart: helm install myapp ./chart"
echo ""
echo "Next steps:"
echo "• Configure AWS: aws configure"
echo "• Configure kubectl with cluster credentials"
echo "• Run fonts setup: ./scripts/11-fonts.sh"