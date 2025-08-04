# Modular Mac Development Setup

A modular approach to setting up a complete Mac development environment. The original `setup.sh` has been split into focused, category-based scripts for easier maintenance and selective installation.

## 🗂️ Script Structure

```
scripts/
├── common.sh              # Shared functions and utilities
├── 01-system.sh          # System Requirements (Xcode, Homebrew)
├── 02-terminal.sh         # Terminal & Shell (iTerm2, Oh My Zsh)
├── 03-version-managers.sh # Version Managers (Volta, pyenv)
├── 04-languages.sh        # Programming Languages (Java, Go, Ruby)
├── 05-frontend.sh         # Frontend Tools (TypeScript, Vue, React Native)
├── 06-dev-apps.sh         # Development Apps (VS Code, Cursor, extensions)
├── 07-mobile.sh           # Mobile Development (Android Studio, iOS)
├── 08-productivity.sh     # Productivity Tools (Raycast, Rectangle)
├── 09-database.sh         # Database Tools (PostgreSQL, Sequel Ace)
├── 10-devops.sh           # DevOps Tools (Kubernetes, AWS CLI)
└── 11-fonts.sh            # Developer Fonts (Fira Code, JetBrains Mono)
```

## 🚀 Usage Options

### Option 1: Run All Categories
```bash
./setup-modular.sh
```

### Option 2: Run Individual Categories
```bash
# System requirements first (required for others)
./scripts/01-system.sh

# Then any category you need
./scripts/05-frontend.sh      # Frontend tools
./scripts/06-dev-apps.sh      # VS Code and editors
./scripts/08-productivity.sh  # Productivity apps
```

### Option 3: Selective Installation
Run the main script and choose categories interactively:
```bash
./setup-modular.sh
# Choose 'n' when asked to install all
# Then select specific categories
```

## 📋 What Each Script Installs

### 01-system.sh
- Xcode Command Line Tools
- Homebrew package manager
- Basic system configuration (hidden files in Finder)

### 02-terminal.sh
- iTerm2 and Warp terminals
- Oh My Zsh with plugins
- PowerLevel10k theme
- Useful aliases and shell improvements

### 03-version-managers.sh
- Volta (Node.js version manager)
- pyenv (Python version manager)
- Python 3.9.6, 3.10.13, 3.12.1
- Node.js LTS via Volta

### 04-languages.sh
- OpenJDK 17 (React Native compatible)
- Go programming language
- Ruby programming language

### 05-frontend.sh
- TypeScript (global)
- Vue CLI & Nuxt CLI
- React Native CLI & Expo CLI & EAS CLI
- Vite (create-vite) & Serve
- Watchman (file watching)

### 06-dev-apps.sh
- Visual Studio Code + extensions
- Cursor (AI-powered editor)
- Zed (fast Rust-based editor)
- TextMate (lightweight editor)
- Git, Git Flow, GitHub CLI, GitHub Desktop

### 07-mobile.sh
- Android Studio
- Android environment variables
- iOS development tools (optional)
- xcodes, ios-deploy, CocoaPods, SwiftLint

### 08-productivity.sh
- Raycast (better Spotlight)
- Rectangle (window management)
- 1Password, Maccy, Obsidian
- Browsers: Chrome, Firefox, Brave
- Utilities: OrbStack, Postman, Figma

### 09-database.sh
- PostgreSQL 15
- Sequel Ace (database GUI)

### 10-devops.sh
- Kubernetes: kubectl, kubectx, kops, helm
- AWS CLI (for Amazon Q)
- Command line utilities: ngrok, eza, wget, jq, tree, fzf

### 11-fonts.sh
- Fira Code (with ligatures)
- JetBrains Mono (with ligatures)
- Source Code Pro, Hack Nerd Font

## 🔧 Dependencies

Scripts have dependencies on each other:
- `01-system.sh` - Required first (installs Homebrew)
- `03-version-managers.sh` - Required before `05-frontend.sh`
- Most scripts depend on Homebrew being installed

## ✅ Benefits of Modular Approach

1. **Selective Installation** - Install only what you need
2. **Easier Maintenance** - Update individual categories
3. **Better Error Handling** - Isolate issues to specific areas
4. **Faster Re-runs** - Update just one category
5. **Clear Organization** - Find tools by category
6. **Reduced Complexity** - Smaller, focused scripts

## 🔄 Updating

To update a specific category:
```bash
./scripts/08-productivity.sh  # Update productivity tools
./scripts/05-frontend.sh      # Update frontend tools
```

## 🧪 Testing

Check your installation:
```bash
./check-setup.sh
```

## 🆚 Migration from Original

The original `setup.sh` is preserved. The modular scripts provide the same functionality but with better organization:

- **Before**: One 800+ line script
- **After**: 11 focused scripts + shared utilities
- **Same tools installed** - just better organized
- **Better error handling** - no more hidden failures
- **Selective installation** - choose what you need