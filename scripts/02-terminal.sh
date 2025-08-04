#!/bin/bash

# Terminal and Shell Setup
# Installs: iTerm2, Warp, Oh My Zsh, PowerLevel10k, plugins, aliases

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Terminal and Shell Setup"

check_macos
check_homebrew

# Install iTerm2
print_status "Installing iTerm2..."
if [[ -d "/Applications/iTerm.app" ]]; then
    print_success "iTerm2 already installed"
else
    brew install --cask iterm2
fi

# Configure iTerm2 with black background
print_status "Configuring iTerm2 with black background..."
if [[ -d "/Applications/iTerm.app" ]]; then
    # Create iTerm2 preferences directory if it doesn't exist
    mkdir -p ~/Library/Preferences
    
    # Set black background color for iTerm2
    defaults write com.googlecode.iterm2 "New Bookmarks" -array-add '{
        "Name" = "Default";
        "Guid" = "Default";
        "Background Color" = {
            "Red Component" = 0;
            "Green Component" = 0;
            "Blue Component" = 0;
            "Alpha Component" = 1;
        };
        "Foreground Color" = {
            "Red Component" = 1;
            "Green Component" = 1;
            "Blue Component" = 1;
            "Alpha Component" = 1;
        };
    }' 2>/dev/null || print_warning "iTerm2 configuration may need manual setup"
    
    print_success "iTerm2 configured with black background"
else
    print_warning "iTerm2 not found - skipping configuration"
fi

# Alternative modern terminal
install_cask_app "Warp" "warp" "/Applications/Warp.app"

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

print_success "Terminal setup completed!"
echo ""
echo "Next steps:"
echo "• Run 'p10k configure' to setup PowerLevel10k theme"
echo "• Restart terminal or run 'source ~/.zshrc'"
echo "• Run version managers setup: ./scripts/03-version-managers.sh"