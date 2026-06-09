#!/bin/bash

# Terminal and Shell Setup
# Installs: iTerm2, Warp, Oh My Zsh, PowerLevel10k, plugins, aliases

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Terminal and Shell Setup"

check_macos
check_homebrew

# Install iTerm2
install_cask_app "iTerm2" "iterm2" "/Applications/iTerm.app"

# Configure iTerm2 with Dracula theme
print_status "Configuring iTerm2 with Dracula theme..."
if is_dry_run; then
    print_status "[dry-run] would stage the Dracula iTerm theme in ~/Downloads"
elif [[ -d "/Applications/iTerm.app" ]]; then
    # Create the directories we write into if they don't exist yet
    mkdir -p ~/Library/Preferences ~/Downloads

    # Copy Dracula theme from repo
    script_dir="$(dirname "$(dirname "$0")")" # Go up to repo root
    if [[ -f "${script_dir}/Dracula.itermcolors" ]]; then
        if [[ ! -f ~/Downloads/Dracula.itermcolors ]]; then
            print_status "Copying Dracula theme from repo..."
            cp "${script_dir}/Dracula.itermcolors" ~/Downloads/
            print_success "Dracula theme copied to Downloads"
        fi
    else
        print_warning "Dracula.itermcolors not found in repo, downloading..."
        curl -fsSL -o ~/Downloads/Dracula.itermcolors https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors || print_warning "Dracula theme download failed - import manually later"
    fi

    print_success "Dracula theme ready for import"
    print_success "To apply: Open iTerm2 → Preferences → Profiles → Colors → Import ~/Downloads/Dracula.itermcolors"
else
    print_warning "iTerm2 not found - skipping configuration"
fi

# Alternative modern terminal
install_cask_app "Warp" "warp" "/Applications/Warp.app"

# Install Oh My Zsh
print_status "Installing Oh My Zsh..."
if [[ -d ~/.oh-my-zsh ]]; then
    print_success "Oh My Zsh already installed"
elif is_dry_run; then
    print_status "[dry-run] would install Oh My Zsh"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || print_warning "Oh My Zsh install failed"
    print_success "Oh My Zsh installed"
fi

# Clone a custom Oh My Zsh plugin/theme (idempotent, dry-run aware, set -e safe)
clone_omz_repo() {
    # clone_omz_repo "label" "url" "dest"
    local label="$1" url="$2" dest="$3"
    if [[ -d "${dest}" ]]; then
        print_success "${label} already installed"
    elif is_dry_run; then
        print_status "[dry-run] would clone ${label}"
    else
        git clone --depth=1 "${url}" "${dest}" && print_success "${label} installed" || print_warning "${label} clone failed"
    fi
}

# Install Oh My Zsh plugins and improved configuration
print_status "Installing Oh My Zsh plugins..."
if [[ -d ~/.oh-my-zsh ]] || is_dry_run; then
    clone_omz_repo "zsh-autosuggestions plugin" \
        "https://github.com/zsh-users/zsh-autosuggestions" \
        ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    clone_omz_repo "zsh-syntax-highlighting plugin" \
        "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    # zsh-completions is enabled in plugins=() below, so it must exist as a
    # custom plugin (it is not bundled with Oh My Zsh).
    clone_omz_repo "zsh-completions plugin" \
        "https://github.com/zsh-users/zsh-completions.git" \
        ~/.oh-my-zsh/custom/plugins/zsh-completions

    # Create improved .zshrc configuration
    print_status "Setting up improved .zshrc configuration..."
    if is_dry_run; then
        print_status "[dry-run] would back up ~/.zshrc and set the plugin list"
    else
        # Ensure a .zshrc exists (Oh My Zsh normally creates one, but guard anyway)
        [[ -f ~/.zshrc ]] || touch ~/.zshrc

        # Backup existing .zshrc if not already backed up
        if [[ ! -f ~/.zshrc.backup ]]; then
            cp ~/.zshrc ~/.zshrc.backup
            print_success "Backed up existing .zshrc"
        fi

        # Add plugins to .zshrc if not already there
        if ! grep -q "zsh-autosuggestions" ~/.zshrc 2>/dev/null; then
            if grep -q '^plugins=(git)' ~/.zshrc 2>/dev/null; then
                sed -i '' 's/plugins=(git)/plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
            else
                # No default plugins line to replace — append an explicit one
                echo 'plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)' >>~/.zshrc
            fi
            print_success "Updated plugin list in .zshrc"
        else
            print_success "Plugins already configured in .zshrc"
        fi
    fi

    # Add useful aliases (interactive config → ~/.zshrc; add_to_zshrc is dry-run aware)
    add_to_zshrc "Useful aliases for development" <<'EOF'
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

# Better ls with eza — guarded so the alias quietly disappears if eza
# is ever uninstalled (otherwise plain `ls` errors with "command not found").
if command -v eza >/dev/null 2>&1; then
    alias ls="eza"
    alias ll="eza -l"
    alias la="eza -la"
    alias tree="eza --tree"
fi

# Load completions
autoload -U compinit && compinit
EOF
    print_success "Development aliases ensured in .zshrc"

    print_success "Oh My Zsh plugins and configuration updated"
else
    print_warning "Oh My Zsh not found, skipping plugin installation"
fi

# Install PowerLevel10k theme
print_status "Installing PowerLevel10k theme..."
clone_omz_repo "PowerLevel10k theme" \
    "https://github.com/romkatv/powerlevel10k.git" \
    ~/.oh-my-zsh/custom/themes/powerlevel10k
if is_dry_run; then
    print_status "[dry-run] would set ZSH_THEME to powerlevel10k"
else
    # Update .zshrc to use PowerLevel10k
    if grep -q '^ZSH_THEME="robbyrussell"' ~/.zshrc 2>/dev/null; then
        sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
    elif ! grep -q 'powerlevel10k/powerlevel10k' ~/.zshrc 2>/dev/null; then
        echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc
    fi
fi

# Install Dracula theme for PowerLevel10k (for matching prompt colors)
print_status "Installing Dracula theme for PowerLevel10k..."
clone_omz_repo "Dracula PowerLevel10k theme" \
    "https://github.com/dracula/powerlevel10k.git" \
    ~/.dracula-powerlevel10k
if is_dry_run; then
    print_status "[dry-run] would copy the Dracula .p10k.zsh to ~/.p10k.zsh"
elif [[ -f ~/.dracula-powerlevel10k/files/.p10k.zsh ]]; then
    cp ~/.dracula-powerlevel10k/files/.p10k.zsh ~/.p10k.zsh
    print_success "Dracula PowerLevel10k configuration installed"
fi

print_success "Terminal setup completed!"
echo ""
echo "🎨 Dracula Theme Setup Complete:"
echo "• iTerm2: Import ~/Downloads/Dracula.itermcolors in iTerm2 → Preferences → Colors"
echo "• PowerLevel10k: Dracula colors pre-configured (skip 'p10k configure' or run to customize)"
echo "• Restart terminal or run 'source ~/.zshrc' to see changes"
echo ""
echo "Next steps:"
echo "• Run version managers setup: ./scripts/03-version-managers.sh"
