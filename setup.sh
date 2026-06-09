#!/bin/bash

# Modular Mac Development Setup Script
# Main orchestrator that runs all category scripts
#
# Usage:
#   ./setup.sh                 # Interactive mode with configuration prompts
#   ./setup.sh --skip-prompts  # Non-interactive mode (CI/automated)
#   ./setup.sh -y              # Same as --skip-prompts
#   ./setup.sh --dry-run       # Preview installs/config without making changes
#   ./setup.sh -n              # Same as --dry-run

set -e # Exit on any error

# Source common functions
source "$(dirname "$0")/scripts/common.sh"

# Parse flags (any order)
SKIP_PROMPTS=${SKIP_PROMPTS:-false}
for arg in "$@"; do
    case "${arg}" in
        --skip-prompts | -y)
            SKIP_PROMPTS=true
            print_status "Running in non-interactive mode (skipping configuration prompts)"
            ;;
        --dry-run | -n)
            # Exported so the category scripts (run as child processes) inherit it.
            export DRY_RUN=true
            print_warning "DRY-RUN: no changes will be made (helper-managed installs and shell config only)"
            ;;
    esac
done

# Log everything to a dated file and collect install results for the summary
LOG_FILE="${HOME}/mac-setup-$(date +%Y-%m-%d).log"
exec > >(tee -a "${LOG_FILE}") 2>&1
SETUP_RESULTS_FILE="$(mktemp)"
export SETUP_RESULTS_FILE
print_status "Logging this run to ${LOG_FILE}"

print_section "Mac Frontend Developer Environment Setup"
echo "🎨 Optimized for JavaScript/TypeScript developers"
echo "🚀 Starting modular setup process..."
echo ""

# Check if running on macOS
check_macos

# Snapshot whether Homebrew is already on PATH BEFORE running the essentials.
# If brew is missing here, 01-system will install it — and the parent shell
# (this setup.sh) will not pick up the new PATH until the user opens a fresh
# shell. We use this snapshot to force a "restart your terminal + re-curl"
# pause after 01+02 so the rest of the setup runs in a properly initialised shell.
BREW_WAS_PREINSTALLED=false
if command -v brew &>/dev/null; then
    BREW_WAS_PREINSTALLED=true
fi

# Function to prompt user for configuration completion
prompt_configuration() {
    local script_name="$1"
    local config_steps="$2"

    # Skip prompts if flag is set
    if [[ "${SKIP_PROMPTS}" == "true" ]]; then
        if [[ -n "${config_steps}" ]]; then
            echo ""
            print_status "⚙️  Configuration needed for ${script_name} (skipped in non-interactive mode):"
            echo "${config_steps}"
            echo ""
        fi
        return
    fi

    if [[ -n "${config_steps}" ]]; then
        echo ""
        print_status "⚙️  Configuration needed for ${script_name}:"
        echo "${config_steps}"
        echo ""

        while true; do
            read -r -p "Have you completed these configuration steps? (y/n): " response
            case ${response} in
                [Yy] | [Yy][Ee][Ss])
                    print_success "Configuration completed! Continuing..."
                    break
                    ;;
                [Nn] | [Nn][Oo])
                    echo ""
                    echo "Please complete the configuration steps above before continuing."
                    echo "The script will wait here until you're ready."
                    echo ""
                    ;;
                *)
                    echo "Please answer y (yes) or n (no)"
                    ;;
            esac
        done
        echo ""
    fi
}

# Function to run a script
run_script() {
    local script="$1"
    local script_path
    script_path="$(dirname "$0")/scripts/${script}"

    if [[ -f "${script_path}" ]]; then
        print_status "Running ${script}..."
        chmod +x "${script_path}"
        if bash "${script_path}"; then
            print_success "${script} completed successfully"

            # Prompt for configuration based on script
            case ${script} in
                "01-system.sh")
                    prompt_configuration "System Requirements" "• Open Xcode to accept license (if prompted)
• Verify Homebrew: run 'brew --version'"
                    ;;
                "02-terminal.sh")
                    prompt_configuration "Terminal & Shell" "• Import Dracula theme: iTerm2 → Preferences → Colors → Import ~/Downloads/Dracula.itermcolors (copied from repo)
• Restart terminal or run 'source ~/.zshrc'
• PowerLevel10k is pre-configured with Dracula colors (no need to run 'p10k configure' unless you want to customize)"
                    ;;
                "03-version-managers.sh")
                    prompt_configuration "Version Managers" "• Restart terminal or run 'source ~/.zshrc'
• Verify Volta: run 'volta --version'
• Verify pyenv: run 'pyenv --version'
• Verify Node.js: run 'node --version'
• Verify Python: run 'python --version'"
                    ;;
                "04-languages.sh")
                    prompt_configuration "Programming Languages" "• Verify Java: run 'java -version' (should show JDK 17+)
• Verify Go: run 'go version'
• JAVA_HOME is automatically configured in your shell"
                    ;;
                "05-frontend.sh")
                    prompt_configuration "Frontend Tools" "• Review the TODO list above for account creation steps
• Verify installations work after completing authentication
• Test project creation: 'npm create vue@latest test-project'"
                    ;;
                "06-dev-apps.sh")
                    prompt_configuration "Development Apps" "• Review the TODO list above for editor account setup
• Sign in to VS Code and Cursor
• Authenticate Claude Code (run 'claude' → /login) and kiro-cli (run 'kiro auth login')
• Enable settings sync in VS Code
• Git and GitHub should already be configured from the prompts"
                    ;;
                "07-mobile.sh")
                    prompt_configuration "Mobile Development" "• Review the TODO list above for setup steps
• Complete Android Studio configuration
• For iOS + full Expo/React Native, run ./scripts/12-expo-rn.sh"
                    ;;
                "08-productivity.sh")
                    prompt_configuration "Productivity Tools" "• Review the TODO list above for all app setups
• Complete account creation and login for each app
• Configure launch on login settings where needed"
                    ;;
                "09-database.sh")
                    prompt_configuration "Database Tools" "• Review the TODO list above for DBeaver and Supabase setup
• Test PostgreSQL: run 'psql --version'
• Configure DBeaver to connect to local PostgreSQL"
                    ;;
                "10-devops.sh")
                    prompt_configuration "DevOps Tools" "• Review the TODO list above for account creation steps
• Test kubectl: run 'kubectl version --client'
• Test Terraform: run 'terraform version'
• Verify installations are working"
                    ;;
                "11-fonts.sh")
                    prompt_configuration "Developer Fonts" "• Restart applications to use new fonts
• Configure your editor to use Fira Code or JetBrains Mono
• Enable font ligatures in VS Code/editor"
                    ;;
                *)
                    # No specific configuration needed for this script
                    ;;
            esac
        else
            print_error "${script} failed"
            exit 1
        fi
        echo ""
    else
        print_error "Script not found: ${script_path}"
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
    "12-expo-rn.sh"
    "13-macos-defaults.sh"
)

optional_descriptions=(
    "Programming Languages (Java, Go, Ruby)"
    "Frontend Tools (TypeScript, Vue, React Native, Vite, Turbo, Vercel, Storyblok, Sanity CLI)"
    "Development Apps (VS Code, Cursor, Claude Code, kiro-cli, Extensions)"
    "Mobile Development (Android Studio + Android env; iOS/RN → script 12)"
    "Productivity Tools (Rectangle, Browsers, Mockoon, Expo Orbit)"
    "Database Tools (PostgreSQL, DBeaver, Supabase CLI)"
    "DevOps Tools (ngrok, UpCloud, Kubernetes, Tilt, Terraform, Utilities)"
    "Developer Fonts (Fira Code, JetBrains Mono)"
    "Expo + React Native Local Dev (Watchman, JDK 17, Maestro, full iOS/Android toolchain)"
    "macOS System Defaults (keyboard, Finder, Dock, screenshots, dialogs)"
)

# First, always install essential components
echo "🔧 Installing essential components first (required for everything else):"
echo ""
for i in "${!essential_scripts[@]}"; do
    printf "   %d. %s\n" $((i + 1)) "${essential_descriptions[i]}"
done
echo ""

print_status "Installing essential components..."
echo ""

# Stage A: System foundations (01-system + 02-terminal). These install Homebrew,
# Oh My Zsh and friends; the new PATH / shell config only takes effect after the
# user opens a fresh terminal. We run them here, then — if brew was just
# installed this run — pause and ask the user to restart + re-curl before we
# touch the version managers and the rest.
for script in "${essential_scripts[@]:0:2}"; do
    run_script "${script}"
done

if [[ "${BREW_WAS_PREINSTALLED}" != "true" && "${SKIP_PROMPTS}" != "true" && "${DRY_RUN}" != "true" ]]; then
    print_section "🔄 Restart terminal & re-run the installer"
    echo "Homebrew, the shell framework, and your PATH have just been set up."
    echo "Your current terminal session can't see them yet — you need a fresh shell"
    echo "before the rest of the setup (version managers, frontend tools, etc.) can run."
    echo ""
    echo "👉 Quit iTerm2 (⌘Q) and open a new window, then re-run the installer:"
    echo ""
    echo "   sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)\""
    echo ""
    echo "Scripts that have already run will be skipped on the next pass."
    echo ""
    echo "📄 Log so far: ${LOG_FILE}"
    print_setup_summary "${SETUP_RESULTS_FILE}"
    rm -f "${SETUP_RESULTS_FILE}"
    exit 0
fi

# Stage B: version managers + everything else (requires a working brew on PATH).
for script in "${essential_scripts[@]:2}"; do
    run_script "${script}"
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
    printf "%2d. %s\n" $((i + 4)) "${optional_descriptions[i]}"
done
echo ""

# Simple CLI selection for optional scripts
echo "Choose additional scripts to install:"
echo "• Frontend Focus: Type '5 6 8 11' (Frontend + Dev Apps + Productivity + Fonts)"
echo "• React Native: Type '5 6 7 8 11 12' (includes Mobile + Expo/RN local dev)"
echo "• Fullstack: Type '4 5 6 8 9' (includes Languages + Database)"
echo "• Custom: Type any numbers separated by spaces (e.g., '4 6 10')"
echo "• Type 'all' to install everything | Press Enter to skip | Type 'quit' to exit"
echo ""
if [[ "${SKIP_PROMPTS}" == "true" ]]; then
    # Non-interactive mode (CI / curl bootstrap): take selection from env,
    # defaulting to installing everything. Set SETUP_OPTIONAL="" to skip optional,
    # or e.g. SETUP_OPTIONAL="5 6 8 11" to pick specific scripts.
    selection="${SETUP_OPTIONAL-all}"
    print_status "Non-interactive mode: optional scripts = '${selection:-<none>}'"
else
    read -r -p "Additional scripts to install: " selection
fi

selected_scripts=()

# Parse user selection for optional scripts
case ${selection} in
    'all' | 'ALL')
        selected_scripts=("${optional_scripts[@]}")
        echo ""
        echo "✅ Selected ALL additional scripts for installation"
        ;;
    'quit' | 'QUIT' | 'q' | 'Q')
        echo "❌ Setup cancelled"
        exit 0
        ;;
    '')
        echo "⏭️ Skipping additional scripts"
        ;;
    *)
        # Parse numbers
        if [[ -n "${selection}" ]]; then
            for num in ${selection}; do
                if [[ "${num}" =~ ^[0-9]+$ ]] && [[ "${num}" -ge 4 ]] && [[ "${num}" -le 13 ]]; then
                    idx=$((num - 4)) # Convert to optional_scripts index (4->0, 5->1, etc.)
                    selected_scripts+=("${optional_scripts[${idx}]}")
                    echo "✓ Selected: ${optional_descriptions[${idx}]}"
                else
                    echo "❌ Invalid script number: ${num} (valid range: 4-13)"
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
            if [[ "${optional_scripts[${i}]}" == "${script}" ]]; then
                echo "  • ${optional_descriptions[${i}]}"
                break
            fi
        done
    done
    echo ""
    if [[ "${SKIP_PROMPTS}" == "true" ]]; then
        confirm="y"
    else
        read -r -p "Proceed with additional installations? [Y/n]: " confirm
    fi
    confirm=${confirm:-y}
    if [[ ! "${confirm}" =~ ^[Yy]$ ]]; then
        echo "❌ Additional installations cancelled"
        exit 0
    fi

    # Install selected additional scripts
    echo ""
    print_status "Installing additional components..."
    echo ""

    for script in "${selected_scripts[@]}"; do
        run_script "${script}"
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
    description="${essential_descriptions[${i}]}"
    echo "• ${description/- REQUIRED/}"
done

if [[ ${#selected_scripts[@]} -gt 0 ]]; then
    echo ""
    echo "📦 Optional components:"
    for script in "${selected_scripts[@]}"; do
        # Find description for this script
        for i in "${!optional_scripts[@]}"; do
            if [[ "${optional_scripts[${i}]}" == "${script}" ]]; then
                echo "• ${optional_descriptions[${i}]}"
                break
            fi
        done
    done
fi
echo ""
if [[ "${SKIP_PROMPTS}" == "true" ]]; then
    echo "🔄 Configuration needed (was skipped in non-interactive mode):"
    echo "• Review configuration steps shown above for each installed component"
    echo "• Import Dracula theme: iTerm2 → Preferences → Colors"
    echo "• PowerLevel10k: Dracula colors pre-configured (run 'p10k configure' to customize)"
    echo "• Restart terminal or run 'source ~/.zshrc'"
else
    echo "✅ All configurations completed during interactive setup!"
    echo ""
    echo "🔄 Final steps:"
    echo "• Restart terminal for all changes to take effect"
fi
echo ""
echo "🔍 Verify your setup:"
echo "• Run './check-setup.sh' to see what's working"
echo "• Check versions, identify any issues, see completion percentage"
echo ""
echo "📁 Individual scripts available in ./scripts/ directory"
echo "🔧 Re-run any category: ./scripts/XX-category.sh"
echo ""

# Aggregate install summary across all category scripts, then clean up
print_setup_summary "${SETUP_RESULTS_FILE}"
rm -f "${SETUP_RESULTS_FILE}"
echo ""
echo "📄 Full log saved to: ${LOG_FILE}"
echo ""
print_warning "Some tools may require system restart to work properly"
