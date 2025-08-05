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
        echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${PATH}"' >> ~/.zshrc
        export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${PATH}"
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
    "amazonwebservices.aws-toolkit-vscode"
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
        # Check if extension is already installed
        if code --list-extensions | grep -q "^${extension}$"; then
            print_success "VS Code extension already installed: ${extension}"
        else
            print_status "Installing VS Code extension: ${extension}"
            if code --install-extension "${extension}" 2>/dev/null; then
                print_success "Installed VS Code extension: ${extension}"
            else
                print_warning "Failed to install VS Code extension: ${extension}"
            fi
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

# Git Configuration
print_section "Git Configuration"
echo "Git and GitHub CLI are installed. Let's configure them for your development work."
echo ""

# Check if Git is already configured
git_name=$(git config --global user.name 2>/dev/null || echo "")
git_email=$(git config --global user.email 2>/dev/null || echo "")

if [[ -z "${git_name}" || -z "${git_email}" ]]; then
    print_status "Git needs to be configured with your identity"
    echo ""
    
    if [[ -z "${git_name}" ]]; then
        read -p "Enter your full name for Git commits: " user_name
        if [[ -n "${user_name}" ]]; then
            git config --global user.name "${user_name}"
            print_success "Git user.name set to: ${user_name}"
        fi
    else
        print_success "Git user.name already set to: ${git_name}"
    fi
    
    if [[ -z "${git_email}" ]]; then
        read -p "Enter your email for Git commits: " user_email
        if [[ -n "${user_email}" ]]; then
            git config --global user.email "${user_email}"
            print_success "Git user.email set to: ${user_email}"
        fi
    else
        print_success "Git user.email already set to: ${git_email}"
    fi
else
    print_success "Git already configured:"
    echo "  Name: ${git_name}"
    echo "  Email: ${git_email}"
fi

echo ""

# GitHub CLI Authentication
print_status "GitHub CLI Authentication"
if gh auth status &>/dev/null; then
    print_success "GitHub CLI already authenticated"
    gh auth status
else
    echo "GitHub CLI needs authentication to work with repositories."
    echo ""
    read -p "Authenticate with GitHub now? [Y/n]: " gh_auth
    gh_auth=${gh_auth:-Y}
    
    if [[ "${gh_auth}" =~ ^[Yy]$ ]]; then
        print_status "Starting GitHub authentication..."
        echo ""
        echo "🌐 This will open your browser for GitHub authentication"
        echo "   Choose: Login with a web browser"
        echo "   Protocol: HTTPS (recommended)"
        echo "   Authenticate Git: Yes"
        echo ""
        read -p "Press Enter to continue..."
        
        if gh auth login; then
            print_success "GitHub CLI authenticated successfully!"
            echo ""
            print_status "Testing GitHub connection..."
            gh auth status
            echo ""
            print_status "📝 SSH Key Information:"
            echo "GitHub CLI generates SSH keys automatically during authentication."
            echo ""
            echo "🔑 SSH Key Management Options:"
            echo "• GitHub CLI: Automatic key generation (recommended)"
            echo "• 1Password: SSH agent integration for secure key storage"
            echo "• Manual: Generate keys with 'ssh-keygen -t ed25519 -C \"your@email.com\"'"
            echo ""
            echo "📍 SSH Key Locations:"
            echo "• Private key: ~/.ssh/id_ed25519"
            echo "• Public key: ~/.ssh/id_ed25519.pub"
            echo "• SSH config: ~/.ssh/config"
            echo ""
            echo "🔧 1Password SSH Agent Setup (if using 1Password):"
            echo "• 1Password → Settings → Developer → SSH Agent"
            echo "• Configure git: git config --global gpg.ssh.program \"/Applications/1Password.app/Contents/MacOS/op-ssh-sign\""
        else
            print_warning "GitHub authentication failed - you can try again later with 'gh auth login'"
        fi
    else
        print_status "GitHub authentication skipped - run 'gh auth login' later to authenticate"
    fi
fi

echo ""
echo "📋 TODO: Additional Development Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ VS Code Settings Sync"
echo "  → Open VS Code: code ."
echo "  → Sign in with GitHub/Microsoft account"
echo "  → Enable Settings Sync to backup extensions & preferences"
echo ""
echo "□ Cursor AI Editor Setup"
echo "  → Open Cursor: cursor ."
echo "  → Sign in to enable AI features"
echo "  → Configure API keys if needed"
echo ""
echo "□ Zed Editor Setup"
echo "  → Open Zed: zed ."
echo "  → Sign in with GitHub account"
echo "  → Enable collaboration features"
echo ""
echo "□ GitHub Desktop (if using Git GUI)"
echo "  → Open GitHub Desktop"
echo "  → Sign in with your GitHub account"
echo ""
echo "Next steps:"
echo "• Restart terminal or run 'source ~/.zshrc' to activate commands"
echo "• Run mobile development setup: ./scripts/07-mobile.sh"
