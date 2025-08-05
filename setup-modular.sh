#!/bin/bash

# Modular Mac Development Setup Script
# Main orchestrator that runs all category scripts

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/scripts/common.sh"

print_section "Mac Frontend Developer Environment Setup"
echo "🎨 Optimized for JavaScript/TypeScript developers"
echo "🚀 Starting modular setup process..."
echo ""

# Check if running on macOS
check_macos

# Function to run a script
run_script() {
    local script="$1"
    local script_path="$(dirname "$0")/scripts/$script"
    
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
}

# Essential scripts (always installed first)
essential_scripts=(
    "01-system.sh"
    "02-terminal.sh" 
    "03-version-managers.sh"
)

essential_descriptions=(
    "System Requirements (Xcode, Homebrew)"
    "Terminal & Shell (iTerm2, Oh My Zsh, PowerLevel10k)"
    "Version Managers (Volta, pyenv)"
)

# Optional scripts (user can choose)
optional_scripts=(
    "04-languages.sh"
    "05-frontend.sh"
    "06-dev-apps.sh"
    "07-mobile.sh"
    "08-productivity.sh"
    "09-database.sh"
    "10-devops.sh"
    "11-fonts.sh"
)

optional_descriptions=(
    "Programming Languages (Java, Go, Ruby)"
    "Frontend Tools (TypeScript, Vue, React Native, Vite, Storyblok, Sanity CLI)"
    "Development Apps (VS Code, Cursor, Zed, Extensions)"
    "Mobile Development (Android Studio, iOS tools)"
    "Productivity Tools (Raycast, Rectangle, Browsers)"
    "Database Tools (PostgreSQL, Sequel Ace, Supabase CLI)"
    "DevOps Tools (Kubernetes, AWS CLI, Utilities)"
    "Developer Fonts (Fira Code, JetBrains Mono)"
)

# First, always install essential components
echo "🔧 Installing essential components first (required for everything else):"
echo ""
for i in "${!essential_scripts[@]}"; do
    printf "   %d. %s\n" $((i+1)) "${essential_descriptions[i]}"
done
echo ""

print_status "Installing essential components..."
echo ""

for script in "${essential_scripts[@]}"; do
    run_script "$script"
done

print_success "Essential components installed successfully!"
echo ""
echo "🎉 Core frontend development environment is ready!"
echo "   ✅ Node.js, npm, and JavaScript tools installed"
echo ""

# Now show optional scripts for selection
echo "📦 Additional Frontend & Development Scripts (choose which ones to install):"
echo ""
for i in "${!optional_scripts[@]}"; do
    printf "%2d. %s\n" $((i+4)) "${optional_descriptions[i]}"
done
echo ""

# Simple CLI selection for optional scripts
echo "Choose additional scripts to install:"
echo "• Frontend Focus: Type '5 6 8 11' (Frontend + Dev Apps + Productivity + Fonts)"
echo "• React Native: Type '5 6 7 8 11' (includes Mobile development)"
echo "• Fullstack: Type '4 5 6 8 9' (includes Languages + Database)"
echo "• Custom: Type any numbers separated by spaces (e.g., '4 6 10')"
echo "• Type 'all' to install everything | Press Enter to skip | Type 'quit' to exit"
echo ""
read -p "Additional scripts to install: " selection

selected_scripts=()

# Parse user selection for optional scripts
case $selection in
    'all'|'ALL')
        selected_scripts=("${optional_scripts[@]}")
        echo ""
        echo "✅ Selected ALL additional scripts for installation"
        ;;
    'quit'|'QUIT'|'q'|'Q')
        echo "❌ Setup cancelled"
        exit 0
        ;;
    '')
        echo "⏭️ Skipping additional scripts"
        ;;
    *)
        # Parse numbers
        if [[ -n "$selection" ]]; then
            for num in $selection; do
                if [[ "$num" =~ ^[0-9]+$ ]] && [[ "$num" -ge 4 ]] && [[ "$num" -le 11 ]]; then
                    idx=$((num-4))  # Convert to optional_scripts index (4->0, 5->1, etc.)
                    selected_scripts+=("${optional_scripts[$idx]}")
                    echo "✓ Selected: ${optional_descriptions[$idx]}"
                else
                    echo "❌ Invalid script number: $num (valid range: 4-11)"
                fi
            done
        fi
        ;;
esac

# Install additional selected scripts
if [[ ${#selected_scripts[@]} -gt 0 ]]; then
    echo ""
    echo "📋 Additional scripts to be installed:"
    for script in "${selected_scripts[@]}"; do
        # Find description for this script
        for i in "${!optional_scripts[@]}"; do
            if [[ "${optional_scripts[$i]}" == "$script" ]]; then
                echo "  • ${optional_descriptions[$i]}"
                break
            fi
        done
    done
    echo ""
    read -p "Proceed with additional installations? [Y/n]: " confirm
    confirm=${confirm:-y}
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "❌ Additional installations cancelled"
        exit 0
    fi
    
    # Install selected additional scripts
    echo ""
    print_status "Installing additional components..."
    echo ""
    
    for script in "${selected_scripts[@]}"; do
        run_script "$script"
    done
else
    echo ""
    echo "✅ Setup complete with essential components only!"
fi

# Final summary
print_section "Setup Complete!"
echo "🎉 Modular setup process completed!"
echo ""
echo "📋 What was installed:"
echo ""
echo "🔧 Essential components:"
for i in "${!essential_scripts[@]}"; do
    description="${essential_descriptions[$i]}"
    echo "• ${description/- REQUIRED/}"
done

if [[ ${#selected_optional[@]} -gt 0 ]]; then
    echo ""
    echo "📦 Optional components:"
    for script in "${selected_optional[@]}"; do
        # Find description for this script
        for i in "${!optional_scripts[@]}"; do
            if [[ "${optional_scripts[$i]}" == "$script" ]]; then
                echo "• ${optional_descriptions[$i]}"
                break
            fi
        done
    done
fi
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