#!/bin/bash

# Modular Mac Development Setup Script
# Main orchestrator that runs all category scripts

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/scripts/common.sh"

print_section "Mac Development Environment Setup"
echo "🚀 Starting modular setup process..."
echo ""

# Check if running on macOS
check_macos

# Define all setup scripts in order
scripts=(
    "01-system.sh"
    "02-terminal.sh" 
    "03-version-managers.sh"
    "04-languages.sh"
    "05-frontend.sh"
    "06-dev-apps.sh"
    "07-mobile.sh"
    "08-productivity.sh"
    "09-database.sh"
    "10-devops.sh"
    "11-fonts.sh"
)

# Script descriptions (using parallel arrays for compatibility)
descriptions=(
    "System Requirements (Xcode, Homebrew)"
    "Terminal & Shell (iTerm2, Oh My Zsh, PowerLevel10k)"
    "Version Managers (Volta, pyenv)"
    "Programming Languages (Java, Go, Ruby)"
    "Frontend Tools (TypeScript, Vue, React Native, Vite)"
    "Development Apps (VS Code, Cursor, Zed, Extensions)"
    "Mobile Development (Android Studio, iOS tools)"
    "Productivity Tools (Raycast, Rectangle, Browsers)"
    "Database Tools (PostgreSQL, Sequel Ace)"
    "DevOps Tools (Kubernetes, AWS CLI, Utilities)"
    "Developer Fonts (Fira Code, JetBrains Mono)"
)

# Interactive mode - let user choose which categories to install
echo "Available setup categories:"
echo ""
for i in "${!scripts[@]}"; do
    script="${scripts[$i]}"
    description="${descriptions[$i]}"
    printf "%2d. %s\n" $((i+1)) "$description"
done
echo ""

read -p "Install all categories? [Y/n]: " install_all
install_all=${install_all:-y}

if [[ "$install_all" =~ ^[Yy]$ ]]; then
    # Run all scripts
    for script in "${scripts[@]}"; do
        script_path="$(dirname "$0")/scripts/$script"
        if [[ -f "$script_path" ]]; then
            print_status "Running $script..."
            chmod +x "$script_path"
            if bash "$script_path"; then
                print_success "$script completed successfully"
            else
                print_error "$script failed"
                exit 1
            fi
            echo ""
        else
            print_error "Script not found: $script_path"
            exit 1
        fi
    done
else
    # Interactive selection
    echo "Enter the numbers of categories to install (e.g., 1 2 5-8):"
    read -p "Categories: " selected
    
    # Parse selection (this is a simplified version)
    echo "Selected categories: $selected"
    echo "Note: For custom selection, run individual scripts manually:"
    echo "Example: ./scripts/01-system.sh"
fi

# Final summary
print_section "Setup Complete!"
echo "🎉 Modular setup process completed!"
echo ""
echo "📋 What was installed:"
for i in "${!scripts[@]}"; do
    description="${descriptions[$i]}"
    echo "• $description"
done
echo ""
echo "🔄 Next steps:"
echo "1. Restart terminal or run 'source ~/.zshrc'"
echo "2. Run 'p10k configure' to setup PowerLevel10k theme"
echo "3. Configure applications as needed"
echo "4. Run './check-setup.sh' to verify installation"
echo ""
echo "📁 Individual scripts available in ./scripts/ directory"
echo "🔧 Re-run any category: ./scripts/XX-category.sh"
echo ""
print_warning "Some tools may require system restart to work properly"