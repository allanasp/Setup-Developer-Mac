#!/bin/bash

# Development Applications Setup
# Installs: VS Code, Cursor, Kiro, TextMate, VS Code extensions

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Development Applications Setup"

check_macos
check_homebrew

# Git and GitHub tools
print_status "Installing Git and GitHub tools..."
install_brew_formula "git"
install_brew_formula "git-flow-avh" "Git Flow (AVH)" # Git Flow extension for branching model
install_brew_formula "gh" "GitHub CLI"
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
install_cask_app "TextMate" "textmate" "/Applications/TextMate.app"
install_cask_app "Kiro" "kiro" "/Applications/Kiro.app" # AWS agentic IDE

# OpenCode AI coding agent
print_status "Checking OpenCode AI coding agent..."
if command_exists opencode; then
    opencode_version=$(opencode --version 2>/dev/null || echo "unknown")
    print_success "OpenCode already installed (${opencode_version})"
elif is_dry_run; then
    print_status "[dry-run] would install OpenCode (brew sst/tap/opencode or install script)"
else
    print_status "Installing OpenCode AI coding agent..."
    # Try Homebrew tap first
    if brew install sst/tap/opencode 2>/dev/null; then
        if command_exists opencode; then
            print_success "OpenCode installed successfully via Homebrew"
        else
            print_warning "OpenCode installation completed but command not found"
        fi
    else
        # Fallback to install script
        print_status "Trying OpenCode install script..."
        if curl -fsSL https://opencode.ai/install | bash; then
            if command_exists opencode; then
                print_success "OpenCode installed successfully via install script"
            else
                print_error "OpenCode installation failed"
                print_status "Try manually: curl -fsSL https://opencode.ai/install | bash"
            fi
        else
            print_error "Failed to install OpenCode"
            print_warning "Continuing without OpenCode..."
        fi
    fi
fi

# Add VS Code CLI to PATH (env → ~/.zshenv) if not already there
if [[ -d "/Applications/Visual Studio Code.app" ]] && ! command -v code &>/dev/null; then
    print_status "Adding VS Code CLI to PATH..."
    add_to_zshenv "Visual Studio Code CLI" \
        'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${PATH}"'
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${PATH}"
    print_success "VS Code CLI added to PATH"
fi

# Add CLI commands for all editors (interactive convenience → ~/.zshrc)
print_status "Setting up editor CLI commands..."
add_to_zshrc "Editor CLI commands" <<'EOF'
# VS Code - already has built-in 'code' command

# Cursor
cursor() {
    if [[ -d "/Applications/Cursor.app" ]]; then
        open -a "Cursor" "${1:-.}"
    else
        echo "Cursor not installed"
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
print_success "Editor CLI commands ensured in .zshrc"

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
if is_dry_run; then
    print_status "[dry-run] would install ${#extensions[@]} VS Code extensions"
elif command -v code &>/dev/null; then
    installed_exts="$(code --list-extensions 2>/dev/null)"
    for extension in "${extensions[@]}"; do
        # Check if extension is already installed
        if grep -qx "${extension}" <<<"${installed_exts}"; then
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
echo "• TextMate (lightweight editor)"
echo "• Kiro (AWS agentic IDE)"
echo "• OpenCode (AI coding agent for terminal)"
echo "• GitHub Desktop"
echo "• Git & Git Flow & GitHub CLI"
echo ""
echo "Editor CLI commands available:"
echo "• code .     - Open VS Code in current directory"
echo "• cursor .   - Open Cursor in current directory"
echo "• mate .     - Open TextMate in current directory"
echo "• opencode   - Start OpenCode AI agent in terminal"
echo ""

# Git Configuration
print_section "Git Configuration"
echo "Git and GitHub CLI are installed. Let's configure them for your development work."
echo ""

# Check if Git is already configured
git_name=$(git config --global user.name 2>/dev/null || echo "")
git_email=$(git config --global user.email 2>/dev/null || echo "")

if is_dry_run; then
    print_status "[dry-run] would configure git identity (name/email) if unset"
elif [[ -z "${git_name}" || -z "${git_email}" ]]; then
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

# Git aliases + sensible global defaults
if is_dry_run; then
    print_status "[dry-run] would set git aliases and sensible global defaults"
else
    # Pretty graph log alias (used by the `gitl` shell alias in 02-terminal.sh)
    git config --global alias.lg \
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"

    # Sensible defaults
    git config --global init.defaultBranch main
    git config --global push.autoSetupRemote true
    git config --global pull.ff only
    git config --global merge.conflictStyle zdiff3

    # Use git-delta as the pager/diff tool when available
    if command_exists delta; then
        git config --global core.pager delta
        git config --global interactive.diffFilter "delta --color-only"
        git config --global delta.navigate true
        git config --global delta.line-numbers true
        print_success "Configured git aliases, defaults and delta pager"
    else
        print_success "Configured git aliases and sensible defaults"
    fi
fi

echo ""

# GitHub CLI Authentication
print_status "GitHub CLI Authentication"
if is_dry_run; then
    print_status "[dry-run] would prompt for GitHub CLI authentication (gh auth login)"
elif gh auth status &>/dev/null; then
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
echo "□ OpenCode AI Agent Setup"
echo "  → Run: opencode auth login"
echo "  → Select your LLM provider (OpenAI, Anthropic, etc.)"
echo "  → Add your API key"
echo "  → Test with: opencode"
echo "  → Configuration stored in ~/.opencode/config.json"
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
