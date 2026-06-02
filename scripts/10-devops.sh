#!/bin/bash

# DevOps Tools Setup
# Installs: AWS CLI, ngrok, command line utilities

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "DevOps Tools Setup"

check_macos
check_homebrew

# AWS CLI (for S3, CloudFront, Lambda deployment)
if command -v aws &> /dev/null; then
    print_success "AWS CLI already installed"
else
    install_brew_formula "awscli" "AWS CLI"
fi

# Configure AWS CLI for Amazon Q Developer (uses dummy config)
print_status "Configuring AWS CLI for Amazon Q Developer..."
if ! aws configure list &>/dev/null; then
    print_status "Setting up dummy AWS config for Amazon Q Developer..."
    echo ""
    echo "ℹ️  Amazon Q only needs AWS CLI installed - using dummy credentials"
    echo "   You'll authenticate through VS Code with AWS Builder ID (free)"
    echo ""
    
    # Set dummy AWS credentials for Amazon Q
    aws configure set aws_access_key_id "dummy-for-amazon-q"
    aws configure set aws_secret_access_key "dummy-for-amazon-q"
    aws configure set default.region "us-east-1"
    aws configure set default.output "json"
    
    print_success "AWS CLI configured with dummy credentials for Amazon Q"
    print_status "To use Amazon Q: Open VS Code → Amazon Q icon → Sign in with Builder ID"
else
    print_success "AWS CLI already configured"
fi

# Command line utilities
print_status "Installing command line utilities..."
for util in ngrok eza wget jq tree fzf; do
    install_brew_formula "${util}"
done

# UpCloud CLI (upctl) - manage UpCloud infrastructure
if command -v upctl &> /dev/null; then
    print_success "UpCloud CLI (upctl) already installed"
else
    install_brew_formula "UpCloudLtd/tap/upcloud-cli" "UpCloud CLI (upctl)"
fi

print_success "DevOps tools setup completed!"
echo ""
echo "Installed tools:"
echo "• AWS CLI (for S3, CloudFront, Lambda deployment)"
echo "• ngrok (local tunneling for sharing dev servers)"
echo "• eza (modern ls replacement with colors)"
echo "• wget (file downloads)"
echo "• jq (JSON processing for APIs)"
echo "• tree (directory visualization)"
echo "• fzf (fuzzy finder for terminal)"
echo "• UpCloud CLI (upctl - manage UpCloud infrastructure)"
echo ""
echo "📋 TODO: Account Creation & Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ Amazon Q Developer (AI Coding Assistant)"
echo "  → Open VS Code"
echo "  → Click Amazon Q icon in sidebar"
echo "  → Sign in with AWS Builder ID (free, no credit card)"
echo "  → NOT an AWS account - just for Amazon Q"
echo ""
echo "□ ngrok Account (for sharing local dev)"
echo "  → Sign up: https://ngrok.com"
echo "  → Get auth token: ngrok config add-authtoken <token>"
echo "  → Usage: ngrok http 3000 (share your dev server)"
echo ""
echo "□ AWS Account (OPTIONAL - only if deploying to AWS)"
echo "  → Only needed for S3, CloudFront, Lambda"
echo "  → Skip if using Vercel/Netlify instead"
echo ""
echo "Next steps:"
echo "• Run fonts setup: ./scripts/11-fonts.sh"
