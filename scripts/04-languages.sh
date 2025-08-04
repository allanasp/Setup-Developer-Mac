#!/bin/bash

# Programming Languages Setup
# Installs: Java JDK, Go, Ruby

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Programming Languages Setup"

check_macos
check_homebrew

# Java Development Kit (React Native requires JDK 17 minimum)
print_status "Installing Java Development Kit (JDK 17 for React Native)..."
if ! command -v java &> /dev/null; then
    # Install JDK 17 (React Native requirement)
    brew install openjdk@17
    
    # Add JDK to PATH and set JAVA_HOME
    if ! grep -q 'JAVA_HOME' ~/.zshrc 2>/dev/null; then
        echo 'export JAVA_HOME="$(brew --prefix)/opt/openjdk@17"' >> ~/.zshrc
        echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
        print_success "Java environment variables added to .zshrc"
    fi
    
    # Set for current session
    export JAVA_HOME="$(brew --prefix)/opt/openjdk@17"
    export PATH="$JAVA_HOME/bin:$PATH"
    
    print_success "OpenJDK 17 installed (React Native compatible)"
else
    java_version=$(java --version 2>/dev/null | head -n1 | cut -d' ' -f2 || echo "unknown")
    print_success "Java already installed ($java_version)"
    
    # Verify Java version is 17+
    java_major=$(java --version 2>/dev/null | head -n1 | cut -d' ' -f2 | cut -d'.' -f1 || echo "0")
    if [[ "$java_major" -lt 17 ]]; then
        print_warning "Java version may be too old for React Native (requires JDK 17+)"
        print_warning "Consider upgrading: brew install openjdk@17"
    fi
fi

# Go and Ruby (standalone installations)
print_status "Installing Go..."
brew install go
print_success "Go installed"

print_status "Installing Ruby..."
brew install ruby
print_success "Ruby installed"

print_success "Programming languages setup completed!"
echo ""
echo "Installed languages:"
echo "• Java JDK 17 (for React Native)"
echo "• Go (latest)"
echo "• Ruby (latest)"
echo "• Python (via pyenv - from version managers script)"
echo "• Node.js (via Volta - from version managers script)"
echo ""
echo "Next steps:"
echo "• Run frontend tools setup: ./scripts/05-frontend.sh"
echo "• Check Java: java --version && echo \$JAVA_HOME"