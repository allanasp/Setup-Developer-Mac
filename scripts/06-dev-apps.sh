#!/bin/bash

# Development Applications Setup
# Installs: VS Code, Cursor, Zed, TextMate, VS Code extensions

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Development Applications Setup"

check_macos
check_homebrew

# Git and GitHub tools
print_status "Installing Git and GitHub tools..."
brew install git
brew install git-flow-avh  # Git Flow extension for branching model
brew install gh  # GitHub CLI
install_cask_app "GitHub Desktop" "github" "/Applications/GitHub Desktop.app"

# Visual Studio Code
print_status "Installing Visual Studio Code..."
if [[ -d "/Applications/Visual Studio Code.app" ]]; then
    print_success "Visual Studio Code already installed"
else
    if brew install --cask visual-studio-code; then
        print_success "Visual Studio Code installed successfully"
    else
        print_error "Visual Studio Code installation failed"
    fi
fi

# Additional code editors
install_cask_app "Cursor" "cursor" "/Applications/Cursor.app"
install_cask_app "Zed" "zed" "/Applications/Zed.app"
install_cask_app "TextMate" "textmate" "/Applications/TextMate.app"

# Add VS Code CLI to PATH if not already there
if [[ -d "/Applications/Visual Studio Code.app" ]] && ! command -v code &> /dev/null; then
    print_status "Adding VS Code CLI to PATH..."
    if ! grep -q 'Visual Studio Code' ~/.zshrc 2>/dev/null; then
        echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
        export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
        print_success "VS Code CLI added to PATH"
    fi
fi

# Add CLI commands for all editors
print_status "Setting up editor CLI commands..."
if ! grep -q "# Editor CLI commands" ~/.zshrc 2>/dev/null; then
    cat >> ~/.zshrc << 'EOF'

# Editor CLI commands
# VS Code - already has built-in 'code' command

# Cursor
cursor() {
    if [[ -d "/Applications/Cursor.app" ]]; then
        open -a "Cursor" "${1:-.}"
    else
        echo "Cursor not installed"
    fi
}

# Zed
zed() {
    if [[ -d "/Applications/Zed.app" ]]; then
        open -a "Zed" "${1:-.}"
    else
        echo "Zed not installed"
    fi
}

# TextMate
mate() {
    if [[ -d "/Applications/TextMate.app" ]]; then
        open -a "TextMate" "${1:-.}"
    else
        echo "TextMate not installed"
    fi
}

EOF
    print_success "Editor CLI commands added to .zshrc"
else
    print_success "Editor CLI commands already configured"
fi

# VS Code Extensions
print_status "Installing useful VS Code extensions..."

# List of extensions to install
extensions=(
    "Vue.volar"
    "ms-vscode.vscode-typescript-next"
    "esbenp.prettier-vscode"
    "ms-python.python"
    "golang.Go"
    "ms-vscode-remote.remote-containers"
    "GitHub.vscode-pull-request-github"
    "GitHub.copilot"
    "Amazon.aws-toolkit-vscode"
    "eamodio.gitlens"
    "formulahendry.auto-close-tag"
    "formulahendry.auto-rename-tag"
    "aaron-bond.better-comments"
    "streetsidesoftware.code-spell-checker"
    "naumovs.color-highlight"
    "EditorConfig.EditorConfig"
    "dbaeumer.vscode-eslint"
    "ms-playwright.playwright"
    "humao.rest-client"
    "bradlc.vscode-tailwindcss"
    "ms-vscode.vscode-json"
    "redhat.vscode-yaml"
    "ms-vscode-remote.remote-ssh"
    "christian-kohler.path-intellisense"
    "PKief.material-icon-theme"
    "yzhang.markdown-all-in-one"
    "shd101wyy.markdown-preview-enhanced"
)

# Install each extension with error handling
if command -v code &> /dev/null; then
    for extension in "${extensions[@]}"; do
        if code --install-extension "$extension"; then
            print_success "Installed VS Code extension: $extension"
        else
            print_warning "Failed to install VS Code extension: $extension (might already be installed)"
        fi
    done
else
    print_warning "VS Code CLI not available - extensions will need to be installed manually"
fi

print_success "Development applications setup completed!"
echo ""
echo "Installed applications:"
echo "• Visual Studio Code (with extensions)"
echo "• Cursor (AI-powered editor)"
echo "• Zed (fast Rust-based editor)"
echo "• TextMate (lightweight editor)"
echo "• GitHub Desktop"
echo "• Git & Git Flow & GitHub CLI"
echo ""
echo "Editor CLI commands available:"
echo "• code .     - Open VS Code in current directory"
echo "• cursor .   - Open Cursor in current directory"
echo "• zed .      - Open Zed in current directory"
echo "• mate .     - Open TextMate in current directory"
echo ""
echo "Next steps:"
echo "• Restart terminal or run 'source ~/.zshrc' to activate commands"
echo "• Configure Git: git config --global user.name 'Your Name'"
echo "• Authenticate GitHub: gh auth login"
echo "• Run mobile development setup: ./scripts/07-mobile.sh"