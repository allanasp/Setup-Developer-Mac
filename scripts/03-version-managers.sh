#!/bin/bash

# Version Managers Setup
# Installs: Volta (Node.js), pyenv (Python)

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Version Managers Setup"

check_macos
check_homebrew

# Python via pyenv (version manager)
print_status "Installing Python via pyenv..."
# Install pyenv dependencies first
brew install xz cairo gobject-introspection
brew install pyenv

# Add pyenv to PATH and initialize for current session
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

# Check if pyenv is already initialized in shell
if ! grep -q 'pyenv init' ~/.zshrc 2>/dev/null; then
    echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.zshrc
    echo '[[ -d ${PYENV_ROOT}/bin ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
    print_success "Pyenv added to .zshrc"
fi

# Initialize pyenv for current session
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    print_success "Pyenv initialized for current session"
else
    print_warning "Pyenv not available in current session - restart terminal after script completes"
fi

# Install Python versions if pyenv is available
if command -v pyenv >/dev/null 2>&1; then
    print_status "Installing Python versions via pyenv..."
    pyenv install --skip-existing 3.9.6 2>/dev/null || print_warning "Python 3.9.6 installation failed"
    pyenv install --skip-existing 3.10.13 2>/dev/null || print_warning "Python 3.10.13 installation failed"
    pyenv install --skip-existing 3.12.1 2>/dev/null || print_warning "Python 3.12.1 installation failed"
    
    # Set global Python version
    pyenv global 3.12.1 2>/dev/null || print_warning "Failed to set global Python version"
    print_success "Python versions installation attempted"
else
    print_warning "Pyenv not available - Python versions will be installed after restart"
fi

# Node.js Version Manager - Volta
print_status "Installing Volta (Node.js version manager)..."
if ! command -v volta &> /dev/null; then
    curl https://get.volta.sh | bash
    export VOLTA_HOME="${HOME}/.volta"
    export PATH="${VOLTA_HOME}/bin:${PATH}"
    print_success "Volta installed"
else
    print_success "Volta already installed"
fi

# Install Node.js via Volta
print_status "Installing Node.js via Volta..."
if command -v volta &> /dev/null; then
    volta install node@lts
    print_success "Node.js LTS installed via Volta"
else
    print_warning "Volta not available - restart terminal and run: volta install node@lts"
fi

# Install Yarn Berry
print_status "Installing Yarn Berry..."
if command -v volta &> /dev/null; then
    volta install yarn
    yarn set version berry 2>/dev/null || print_warning "Yarn Berry setup may need manual configuration"
    print_success "Yarn installed via Volta"
else
    print_warning "Volta not available - Yarn installation skipped"
fi

print_success "Version managers setup completed!"
echo ""
echo "📋 Verification commands (run after restarting terminal):"
echo "• Verify Volta: volta --version"
echo "• Verify pyenv: pyenv --version"
echo "• Verify Node.js: node --version"
echo "• Verify Python: python --version"
echo ""
echo "Python management commands:"
echo "• List versions: pyenv versions"
echo "• Install version: pyenv install 3.11.7"
echo "• Set global: pyenv global 3.12.1"
echo ""
echo "Node.js management commands:"
echo "• Install Node: volta install node@lts" 
echo "• Install package: volta install typescript"
echo ""
echo "Next steps:"
echo "• Restart terminal or run 'source ~/.zshrc'"
echo "• Run programming languages setup: ./scripts/04-languages.sh"
