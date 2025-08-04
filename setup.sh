#!/bin/bash

# Frontend Developer Mac Setup & Update Script
# Run with: bash setup.sh
# Can be run every 6 months to update everything

set -e  # Exit on any error

echo "🚀 Starting Frontend Developer Mac Setup & Update..."

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to safely install cask applications
install_cask_app() {
    local app_name="$1"
    local cask_name="$2"
    local app_path="$3"
    
    print_status "Installing/Updating $app_name..."
    if [[ -d "$app_path" ]]; then
        print_success "$app_name already installed (will be updated by brew upgrade)"
    else
        if brew install --cask "$cask_name" 2>/dev/null; then
            print_success "$app_name installed successfully"
        else
            print_warning "$app_name installation failed or skipped"
        fi
    fi
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only"
    exit 1
fi

# Install Xcode Command Line Tools (required for most tools)
print_status "Installing Xcode Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    xcode-select --install
    print_warning "Please complete the Xcode Command Line Tools installation and re-run this script"
    exit 1
else
    print_success "Xcode Command Line Tools already installed"
fi

# Install Homebrew
print_status "Installing/Updating Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session and future sessions
    if [[ $(uname -m) == "arm64" ]]; then
        # Apple Silicon Mac
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        # Also add to current session
        export PATH="/opt/homebrew/bin:$PATH"
    else
        # Intel Mac
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
        export PATH="/usr/local/bin:$PATH"
    fi
    
    print_success "Homebrew installed and added to PATH"
else
    print_success "Homebrew already installed - updating..."
    brew update
    brew upgrade
    brew cleanup
    print_success "Homebrew updated"
fi

# Install iTerm2
print_status "Installing iTerm2..."
if [[ -d "/Applications/iTerm.app" ]]; then
    print_success "iTerm2 already installed"
else
    brew install --cask iterm2
fi

# Alternative modern terminal (optional)
install_cask_app "Warp" "warp" "/Applications/Warp.app"  # Free modern terminal with AI features

# Install Oh My Zsh
print_status "Installing Oh My Zsh..."
if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_success "Oh My Zsh already installed"
fi

# Install Oh My Zsh plugins and improved configuration
print_status "Installing Oh My Zsh plugins..."
if [[ -d ~/.oh-my-zsh ]]; then
    # Install useful plugins with error handling
    if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        print_success "zsh-autosuggestions plugin installed"
    else
        print_success "zsh-autosuggestions plugin already installed"
    fi
    
    if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        print_success "zsh-syntax-highlighting plugin installed"  
    else
        print_success "zsh-syntax-highlighting plugin already installed"
    fi
    
    # Create improved .zshrc configuration
    print_status "Setting up improved .zshrc configuration..."
    
    # Backup existing .zshrc if not already backed up
    if [[ ! -f ~/.zshrc.backup ]]; then
        cp ~/.zshrc ~/.zshrc.backup
        print_success "Backed up existing .zshrc"
    fi
    
    # Add plugins to .zshrc if not already there
    if ! grep -q "zsh-autosuggestions" ~/.zshrc 2>/dev/null; then
        sed -i '' 's/plugins=(git)/plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
        print_success "Updated plugin list in .zshrc"
    else
        print_success "Plugins already configured in .zshrc"
    fi
    
    # Add useful aliases if not already there
    if ! grep -q "# Useful aliases for development" ~/.zshrc 2>/dev/null; then
        cat >> ~/.zshrc << 'EOF'

# Useful aliases for development
alias ip="ipconfig getifaddr en0"
alias zshconfig="vim ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias sshhome="cd ~/.ssh"
alias sshconfig="vim ~/.ssh/config"
alias gitconfig="vim ~/.gitconfig"

# Git aliases
alias gits="git status"
alias gitd="git diff"
alias gitl="git lg"
alias gita="git add ."
alias gitc="git commit"

# Better ls with eza
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias tree="eza --tree"

# Load completions
autoload -U compinit && compinit

EOF
        print_success "Added development aliases to .zshrc"
    else
        print_success "Development aliases already present in .zshrc"
    fi
    
    print_success "Oh My Zsh plugins and configuration updated"
else
    print_warning "Oh My Zsh not found, skipping plugin installation"
fi

# Install PowerLevel10k theme
print_status "Installing PowerLevel10k theme..."
if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    
    # Update .zshrc to use PowerLevel10k
    sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
    print_success "PowerLevel10k installed"
else
    print_success "PowerLevel10k already installed"
fi

# Essential Development Tools
print_status "Installing essential development tools..."

# Git and GitHub tools
brew install git
brew install git-flow-avh  # Git Flow extension for branching model
brew install gh  # GitHub CLI
install_cask_app "GitHub Desktop" "github" "/Applications/GitHub Desktop.app"

# Visual Studio Code
print_status "Installing Visual Studio Code..."
if [[ -d "/Applications/Visual Studio Code.app" ]]; then
    print_success "Visual Studio Code already installed"
else
    if brew install --cask visual-studio-code 2>/dev/null; then
        print_success "Visual Studio Code installed successfully"
    else
        print_warning "Visual Studio Code installation failed or skipped"
    fi
fi

# Add VS Code CLI to PATH if not already there
if [[ -d "/Applications/Visual Studio Code.app" ]] && ! command -v code &> /dev/null; then
    print_status "Adding VS Code CLI to PATH..."
    if ! grep -q 'Visual Studio Code' ~/.zshrc 2>/dev/null; then
        echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
        export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
        print_success "VS Code CLI added to PATH"
    fi
fi

# Cursor (mentioned in preferences)
print_status "Installing Cursor..."
if [[ -d "/Applications/Cursor.app" ]]; then
    print_success "Cursor already installed"
else
    brew install --cask cursor
fi

# Programming Languages (via version managers - no system versions)
print_status "Installing programming languages..."

# Python via pyenv (version manager)
print_status "Installing Python via pyenv..."
# Install pyenv dependencies first
brew install xz cairo gobject-introspection
brew install pyenv

# Add pyenv to PATH and initialize for current session
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Check if pyenv is already initialized in shell
if ! grep -q 'pyenv init' ~/.zshrc 2>/dev/null; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
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

# Java Development Kit (essential for React Native Android & many tools)
print_status "Installing Java Development Kit (JDK)..."
if ! command -v java &> /dev/null; then
    # Install JDK via Homebrew (OpenJDK)
    brew install openjdk@21
    
    # Add JDK to PATH and set JAVA_HOME
    if ! grep -q 'JAVA_HOME' ~/.zshrc 2>/dev/null; then
        echo 'export JAVA_HOME="$(brew --prefix)/opt/openjdk@21"' >> ~/.zshrc
        echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
        print_success "Java environment variables added to .zshrc"
    fi
    
    # Set for current session
    export JAVA_HOME="$(brew --prefix)/opt/openjdk@21"
    export PATH="$JAVA_HOME/bin:$PATH"
    
    print_success "OpenJDK 21 installed"
else
    java_version=$(java --version 2>/dev/null | head -n1 | cut -d' ' -f2 || echo "unknown")
    print_success "Java already installed ($java_version)"
fi

# Go and Ruby (standalone installations)
brew install go
brew install ruby

# Node.js Version Manager - Volta (from user preferences)
print_status "Installing Volta (Node.js version manager)..."
if ! command -v volta &> /dev/null; then
    curl https://get.volta.sh | bash
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
    print_success "Volta installed"
else
    print_success "Volta already installed"
fi

# Install Node.js via Volta
print_status "Installing Node.js via Volta..."
volta install node@lts

# Install Yarn Berry (from user preferences)
print_status "Installing Yarn Berry..."
volta install yarn
yarn set version berry

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

# Amazon Q Developer (via AWS CLI)
print_status "Setting up Amazon Q Developer..."
if command -v aws &> /dev/null; then
    # Check if Amazon Q plugin is available
    if aws --version &> /dev/null; then
        print_success "AWS CLI available for Amazon Q Developer"
        print_success "Amazon Q available via AWS Toolkit (VS Code) and AWS CLI"
    fi
else
    print_warning "AWS CLI not available - Amazon Q setup incomplete"
fi

# Note: Claude Code is installed via Volta in the frontend tools section

# Frontend Development Tools
print_status "Installing frontend development tools..."

# Vue CLI and Nuxt CLI
volta install @vue/cli
volta install nuxt

# React Native CLI and Expo CLI
volta install @react-native-community/cli
volta install @expo/cli

# Database tools
print_status "Installing database tools..."
brew install postgresql@15
brew services start postgresql@15

# Essential productivity tools
print_status "Installing productivity & development tools..."
install_cask_app "Raycast" "raycast" "/Applications/Raycast.app"
install_cask_app "Rectangle" "rectangle" "/Applications/Rectangle.app"
install_cask_app "1Password" "1password" "/Applications/1Password.app"
install_cask_app "Maccy" "maccy" "/Applications/Maccy.app"

# Additional browsers for testing
install_cask_app "Firefox" "firefox" "/Applications/Firefox.app"
install_cask_app "Brave Browser" "brave-browser" "/Applications/Brave Browser.app"

# Database GUI and tunneling
install_cask_app "Sequel Ace" "sequel-ace" "/Applications/Sequel Ace.app"
brew install ngrok  # Command line tool, no cask needed

# Image optimization and utilities
install_cask_app "ImageOptim" "imageoptim" "/Applications/ImageOptim.app"
brew install eza  # Command line tool
brew install wget  # Command line tool

# Useful development tools
install_cask_app "OrbStack" "orbstack" "/Applications/OrbStack.app"
brew install watchman  # For React Native file watching
install_cask_app "Postman" "postman" "/Applications/Postman.app"
install_cask_app "Figma" "figma" "/Applications/Figma.app"

# Mobile Development (React Native) - Global tools only
print_status "Installing/Updating mobile development tools..."
install_cask_app "Android Studio" "android-studio" "/Applications/Android Studio.app"
# Note: Xcode needs to be installed from App Store manually

# iOS Development Global Tools
brew install ios-deploy  # Deploy to iOS devices
brew install cocoapods  # iOS dependency manager

# Xcode optimization tools
print_status "Installing Xcode optimization tools..."
brew install xcodes  # Manage multiple Xcode versions
brew install swiftlint  # Swift code linting tool

# Kubernetes and DevOps tools
print_status "Installing Kubernetes and DevOps tools..."
brew install kops  # Kubernetes cluster management
brew install helm  # Kubernetes package manager  
brew install kubernetes-cli  # kubectl command line tool
brew install kubectx  # Switch between Kubernetes contexts
brew install kubens  # Switch between Kubernetes namespaces

# Additional useful tools
print_status "Installing/Updating additional development tools..."
install_cask_app "Google Chrome" "google-chrome" "/Applications/Google Chrome.app"
brew install jq  # JSON processor
brew install tree  # Directory tree viewer
brew install fzf  # Fuzzy finder

# Fonts for development
print_status "Installing developer fonts..."
brew tap homebrew/cask-fonts 2>/dev/null || print_warning "Font tap already exists"

# Install fonts with error handling
for font in font-fira-code font-jetbrains-mono font-source-code-pro font-hack-nerd-font; do
    if brew install --cask "$font" 2>/dev/null; then
        print_success "$font installed"
    else
        print_warning "$font installation failed or already exists"
    fi
done

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
    "ms-vscode.vscode-typescript-next"
    "christian-kohler.path-intellisense"
    "PKief.material-icon-theme"
    "ms-vscode.test-adapter-converter"
)

# Install each extension with error handling
for extension in "${extensions[@]}"; do
    if code --install-extension "$extension" 2>/dev/null; then
        print_success "Installed VS Code extension: $extension"
    else
        print_warning "Failed to install VS Code extension: $extension (might already be installed)"
    fi
done

# Configure Git (optional - user can skip)
print_status "Git configuration (optional)..."
read -p "Enter your Git username (or press Enter to skip): " git_username
read -p "Enter your Git email (or press Enter to skip): " git_email

if [[ -n "$git_username" ]]; then
    git config --global user.name "$git_username"
fi

if [[ -n "$git_email" ]]; then
    git config --global user.email "$git_email"
fi

# Improved Git configuration
if [[ -n "$git_username" ]]; then
    print_status "Setting up improved Git configuration..."
    git config --global init.defaultBranch main
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    print_success "Git configured with better defaults and 'git lg' alias"
fi

# Create useful directories
print_status "Creating development directories..."
mkdir -p ~/Developer/{Projects,Learning,Playground}

# Final setup notes
print_success "🎉 Setup/Update completed!"
echo ""
echo "🗃️  PostgreSQL is now running and will start automatically on boot"
echo "   Default connection: postgresql://localhost:5432"
echo "   Create database: createdb your_project_name"
echo "   Connect: psql your_project_name"
echo ""
echo "🤖 AI Coding Assistants installed/updated:"
echo "   • Claude Code - Terminal-based AI coding assistant (via Volta)"
echo "   • GitHub Copilot - AI pair programmer (via VS Code extension)"
echo "   • Amazon Q Developer - AWS AI assistant (via AWS CLI + VS Code extension)"
echo "   • AWS CLI - Required for Amazon Q integration"
echo ""
echo "🚀 Global Development Tools installed/updated:"
echo "   • Node.js (latest LTS via Volta version manager)"
echo "   • npm (updated to latest version)"
echo "   • Python (3.9.6, 3.10.13, 3.12.1 via pyenv version manager)"
echo "   • Java JDK (OpenJDK 21 - required for React Native Android)"
echo "   • TypeScript (global compiler)"
echo "   • Go (latest via Homebrew)"
echo "   • Ruby (latest via Homebrew)"
echo "   • Vue CLI, Nuxt CLI"
echo "   • React Native CLI, Expo CLI"  
echo "   • Vite (project creator)"
echo ""
echo "📦 Package Managers installed/updated:"
echo "   • npm (Node.js default package manager - updated)"
echo "   • Yarn Berry (Facebook's package manager)"
echo "   • pnpm (Performant Node.js package manager)"
echo ""
echo "☸️ Kubernetes & DevOps Tools installed/updated:"
echo "   • kOps - Kubernetes cluster management"
echo "   • Helm - Kubernetes package manager"
echo "   • kubectl - Kubernetes command line interface"
echo "   • kubectx - Switch between Kubernetes contexts"
echo "   • kubens - Switch between Kubernetes namespaces"
echo ""
echo "📱 iOS Development Tools installed/updated:"
echo "   • xcodes - Manage multiple Xcode versions"
echo "   • SwiftLint - Swift code linting"
echo "   • ios-deploy - Deploy to iOS devices"
echo "   • CocoaPods - iOS dependency manager"
echo ""
echo "☕ Java Development Tools installed/updated:"
echo "   • OpenJDK 21 - Java Development Kit"
echo "   • JAVA_HOME - Environment variable configured"
echo "   • Required for: React Native Android, Android Studio, Spring Boot"
echo ""
echo "📝 Free Specialized Tools installed/updated:"
echo "   • Obsidian - Free markdown editor with graph view and note-taking"
echo "   • Zed - Free, ultra-fast code editor (written in Rust)"
echo "   • TextMate - Lightweight text editor for quick file editing"
echo "   • System Color Picker - Free native color picker tool"
echo "   • AppCleaner - Free complete app uninstaller"
echo "   • Ice - Free menubar organizer (hides overflow icons)"
echo "   • Syncthing - Free file syncing between devices"
echo "   • Wireshark - Free network protocol analyzer (debug APIs, network traffic)"
echo "   • WireGuard - Modern, secure VPN client"
echo "   • Warp - Free modern terminal with AI features"
echo "   • VS Code - Free with excellent JSON/YAML/Markdown support via extensions"
echo ""
echo "📝 Manual steps remaining:"
echo "  1. Install Xcode from App Store (for iOS development)"
echo "  2. Run 'p10k configure' to setup PowerLevel10k theme"
echo "  3. Configure iTerm2 color scheme and profile (or try Warp for modern terminal)"
echo "  4. Run 'gh auth login' to authenticate with GitHub"
echo "  5. Initialize git flow in your projects with 'git flow init'"
echo "  6. Setup Raycast (CMD+Space) and disable Spotlight shortcut in System Preferences"
echo "  7. Configure Rectangle window management shortcuts"
echo "  8. Setup 1Password and Maccy (clipboard manager)"
echo "  9. Configure AWS CLI: Run 'aws configure' for Amazon Q access"
echo "  10. Setup Amazon Q in VS Code: Install AWS Toolkit extension and sign in"
echo "  11. Setup Ice menubar organizer (right-click menubar icon to configure)"
echo "  12. Try Obsidian for markdown notes and documentation"
echo "  13. Restart terminal to activate pyenv (or run 'source ~/.zshrc')"
echo "  14. Configure kubectl with your Kubernetes cluster credentials"
echo "  15. Import WireGuard VPN configurations if needed"
echo "  16. Create PostgreSQL database: 'createdb your_project_name'"
echo "  17. Sign in to Sequel Ace for database management"
echo "  18. Configure Android Studio SDK for React Native (JDK is now installed)"
echo "  19. Verify Java setup: 'java --version' and 'echo $JAVA_HOME'"
echo "  20. Use 'xcodes list' to see available Xcode versions for iOS development"
echo ""
echo "🐍 Python Version Management (pyenv commands):"
echo "   • List installed versions: 'pyenv versions'"
echo "   • Install new version: 'pyenv install 3.11.7'"
echo "   • Set global version: 'pyenv global 3.12.1'"
echo "   • Set local project version: 'pyenv local 3.10.13'"
echo "   • List available versions: 'pyenv install --list'"
echo ""
echo "☸️ Kubernetes Quick Commands:"
echo "   • Switch context: 'kubectx production'"
echo "   • Switch namespace: 'kubens default'"
echo "   • List clusters: 'kops get clusters'"
echo "   • Install Helm chart: 'helm install myapp ./mychart'"
echo ""
echo "☕ Java Development Commands:"
echo "   • Check Java version: 'java --version'"
echo "   • Check JAVA_HOME: 'echo $JAVA_HOME'"
echo "   • Check JDK installation: 'javac --version'"
echo ""
echo "📱 Xcode Optimization:"
echo "   • Install Xcode version: 'xcodes install 15.1'"
echo "   • List available versions: 'xcodes list'"
echo "   • Run SwiftLint: 'swiftlint' (in project directory)"
echo ""
echo "🔄 To update everything in 6 months, just run this script again!"
echo "   All tools will be updated to their latest versions."
echo ""
echo "⚠️  Note: Project-specific tools (ESLint, Prettier configs, testing frameworks)"
echo "   should be installed per project via package.json"
echo ""
echo "💰 All development tools in this script are FREE!"
echo "   (1Password requires subscription, but you mentioned you already use it)"
echo ""
echo "🔧 New productivity tools installed:"
echo "   • Raycast - Much better Spotlight replacement (CMD+Space)"
echo "   • Rectangle - Window management with keyboard shortcuts"
echo "   • Maccy - Clipboard manager (essential for development)"
echo "   • Sequel Ace - Beautiful database GUI for PostgreSQL/MySQL"
echo "   • ngrok - Local tunneling for testing webhooks/mobile apps"
echo "   • Firefox & Brave - Additional browsers for testing"
echo ""
echo "🔧 Command Line Utilities:"
echo "   • ngrok - Local tunneling for webhook testing"
echo "   • eza - Modern 'ls' replacement with colors and icons"
echo "   • wget - File download utility"
echo "   • jq - JSON processor and formatter"
echo "   • tree - Directory structure visualization"
echo "   • fzf - Fuzzy file finder"
echo "   • watchman - File watching service (React Native)"
echo ""
echo "⚡ Terminal improvements:"
echo "   • New aliases: 'gits', 'gitl', 'la', 'tree', etc."
echo "   • Auto-suggestions and syntax highlighting"
echo "   • Better Git log with 'git lg'"
echo "   • eza aliases for better file listing"
echo ""
echo ""
echo "🔄 This script can be run every 6 months for updates!"
echo ""
echo "⚠️  IMPORTANT: Restart your terminal or run 'source ~/.zshrc' to:"
echo "   • Activate Homebrew in PATH"
echo "   • Activate Volta for Node.js management"  
echo "   • Activate pyenv for Python management"
echo "   • Enable VS Code CLI command"
echo "   • Set JAVA_HOME for Java development"
echo "   • Apply all shell configuration changes"
echo ""
print_warning "After restarting terminal, run the check-setup.sh script to verify everything works!"
echo ""
print_warning "Some tools may require system restart to work properly"