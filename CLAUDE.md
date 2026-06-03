# Mac Developer Setup - Project Context

## Project Overview
Modular Bash script system for automated macOS development environment setup, optimized for frontend developers.

## Tech Stack
- **Language**: Pure Bash shell scripts (no JavaScript/Node.js in project itself)
- **Target OS**: macOS (Intel + Apple Silicon)
- **Tools Installed**: Node.js, Python, Vue, React Native, TypeScript, databases, productivity apps

## Project Structure
├── setup.sh                 # Main orchestrator with interactive prompts
├── check-setup.sh          # Verification script with version info
├── scripts/
│   ├── common.sh           # Shared functions (print_, check_, install_*)
│   ├── 01-system.sh        # Xcode CLI Tools, Homebrew (essential)
│   ├── 02-terminal.sh      # iTerm2, Oh My Zsh, PowerLevel10k (essential)
│   ├── 03-version-managers.sh  # Volta, pyenv (essential)
│   ├── 04-languages.sh     # Java, Go, Ruby (optional)
│   ├── 05-frontend.sh      # Vue, React Native, TypeScript, Vite (optional)
│   ├── 06-dev-apps.sh      # VS Code, Cursor, Git tools (optional)
│   ├── 07-mobile.sh        # Android Studio, iOS tools (optional)
│   ├── 08-productivity.sh  # Rectangle, browsers, Mockoon, Expo Orbit (optional)
│   ├── 09-database.sh      # PostgreSQL, DBeaver, Supabase (optional)
│   ├── 10-devops.sh        # ngrok, UpCloud, Kubernetes, Tilt, Terraform (optional)
│   ├── 11-fonts.sh         # Developer fonts (optional)
│   └── 12-expo-rn.sh       # Expo + React Native local dev env (optional)
└── docs/                   # GitHub Pages documentation

## Code Conventions

### Script Pattern
```bash
#!/bin/bash
set -e  # Exit on any error

source "$(dirname "$0")/common.sh"

print_section "Category Name Setup"
check_macos
check_homebrew

# Installation logic with error handling
print_status "Installing tool..."
if brew install tool; then
    print_success "Tool installed"
else
    print_error "Installation failed"
    return 1
fi

# TODO section for manual steps
echo "📋 TODO: Manual Configuration"
echo "□ Step 1: Action needed"
Common Functions (from common.sh)

print_status "msg" - Blue info message
print_success "msg" - Green success message
print_warning "msg" - Yellow warning
print_error "msg" - Red error
print_section "title" - Section header
check_macos - Verify running on macOS
check_homebrew - Verify Homebrew installed
install_cask_app "Name" "cask" "/path" - Safe app installation
install_volta_package "pkg" - Safe Node.js package install

Idempotence Pattern
bash# Check before installing
if [[ -d "/Applications/App.app" ]]; then
    print_success "App already installed"
else
    brew install --cask app
fi

# Check before adding to config
if ! grep -q 'CONFIG' ~/.zshrc 2>/dev/null; then
    echo 'export CONFIG="value"' >> ~/.zshrc
    print_success "Config added"
else
    print_success "Config already present"
fi
Cross-Platform Support
bash# Handle Intel vs Apple Silicon
if [[ $(uname -m) == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
Key Features

Modular: Users choose which categories to install
Interactive: Prompts for configuration after each script
Idempotent: Safe to re-run scripts multiple gange
Validated: check-setup.sh verifies installations
Documented: TODO lists guide manual setup steps

Design Principles

User feedback first: Clear messages for every operation
Fail gracefully: Don't crash entire setup on single failure
Defensive programming: Check everything before using it
Guide don't assume: Provide TODO lists for manual steps
Cross-compatible: Work on both Mac architectures

Interactive Prompt System
The main setup.sh includes configuration prompts after each script:
bashprompt_configuration "Script Name" "
- Step 1: Do this
- Step 2: Do that
- Step 3: Verify it works
"
User must confirm completion before continuing to next script.
Documentation Files

README.md - Main project overview and quick start (root)
docs/start-here.md - Minimal quick start guide
docs/script-guide.md - Detailed documentation per script
docs/post-installation.md - Complete manual setup steps
docs/ - GitHub Pages website with full documentation (all guides live here)

Common Tasks
Adding a New Tool

Add to appropriate scripts/XX-category.sh
Use install_cask_app or install_volta_package
Add TODO section if manual setup needed
Update check-setup.sh with verification
Document in relevant .md files

Adding Configuration Prompt
In setup.sh, add case to prompt_configuration():
bash"05-frontend.sh")
    prompt_configuration "Frontend Tools" "
- Create accounts at service.com
- Run: service login
- Verify: service --version
"
    ;;
Testing Scripts
bash# Syntax check
bash -n scripts/XX-category.sh

# Test idempotence (run twice)
./scripts/XX-category.sh
./scripts/XX-category.sh  # Should not fail

# Verify installation
./check-setup.sh
Anti-Patterns to Avoid
❌ Hardcoded paths without architecture check
❌ Missing error handling on brew/volta commands
❌ Assuming dependencies exist without checking
❌ Scripts that crash on re-run
❌ Vague error messages without actionable steps
❌ Forgetting to update check-setup.sh
❌ Missing TODO sections for manual steps
Success Criteria
✅ All operations have error handling
✅ Clear status messages throughout
✅ Idempotent (safe to re-run)
✅ Works on Intel + Apple Silicon
✅ TODO lists for manual steps
✅ Verification in check-setup.sh
✅ Updated documentation

---

Perfect til at give Claude fuld kontekst om projektet! 🎯