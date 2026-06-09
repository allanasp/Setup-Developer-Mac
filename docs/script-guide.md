---
title: Complete Script Guide
description: Detailed documentation for all Mac development setup scripts
---

# Complete Script Guide

> **Comprehensive documentation for all development setup scripts**

## One-Line Installer

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)"
```

Append `-- --skip-prompts` to run non-interactively, and set the `SETUP_OPTIONAL` env variable to pick which optional scripts run:

```bash
SETUP_OPTIONAL="5 6 8 12" sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)" -- --skip-prompts
```

Run `./setup.sh --dry-run` (alias `-n`) to preview every change without mutating your system. `setup.sh` also logs the full run to `~/mac-setup-YYYY-MM-DD.log` and prints an aggregate **Setup Summary** at the end.

## Quick Navigation

- [Essential Scripts](#essential-scripts) - Always installed first
- [Optional Scripts](#optional-scripts) - Choose what you need  
- [Usage Examples](#usage-examples) - Common developer setups
- [Troubleshooting](#troubleshooting) - Fix common issues
- [Customization](#customization) - Add your own tools

---

## Script Overview

### Essential Scripts (Auto-Installed)

| Script | Runtime | Dependencies | Purpose |
|--------|---------|--------------|---------|
| `01-system.sh` | ~5 min | None | System foundation |
| `02-terminal.sh` | ~3 min | 01-system | Modern terminal |
| `03-version-managers.sh` | ~10 min | 01-system | Language versions |

### Optional Scripts (Your Choice)

| # | Script | Runtime | Best For | Key Tools |
|---|--------|---------|----------|-----------|
| 4 | `04-languages.sh` | ~8 min | Backend devs | Java, Go, Ruby |
| 5 | `05-frontend.sh` | ~12 min | Web/mobile devs | Vue, React, Storyblok, Sanity |
| 6 | `06-dev-apps.sh` | ~15 min | All developers | VS Code, Cursor, Claude Code, kiro-cli, Git tools |
| 7 | `07-mobile.sh` | ~12 min | Android devs | Android Studio + env (iOS/RN 12) |
| 8 | `08-productivity.sh` | ~8 min | Productivity focus | Rectangle, Maccy, Mockoon |
| 9 | `09-database.sh` | ~10 min | Full-stack devs | PostgreSQL, DBeaver, pgAdmin, Supabase |
| 10 | `10-devops.sh` | ~12 min | Frontend deployment | ngrok, kubectl, Terraform, utilities |
| 11 | `11-fonts.sh` | ~3 min | Better coding | Fira Code, JetBrains Mono |
| 12 | `12-expo-rn.sh` | ~30 min | Expo/RN devs | Watchman, Android Studio, iOS, EAS |
| 13 | `13-macos-defaults.sh` | ~1 min | Tuned macOS | Keyboard, Finder, Dock, screenshots |

> Optional scripts span the range **4-13**.

---

## Essential Scripts

### 1⃣ System Requirements (`01-system.sh`)

**Foundation for everything else**

```bash
./scripts/01-system.sh
```

**What it installs:**
- **Xcode Command Line Tools** - Required for most development tools
- **Homebrew** - Package manager for macOS
- **System Configuration** - Show hidden files in Finder

**Why it's essential:** Every other script depends on Homebrew and Xcode CLI tools.

---

### 2⃣ Terminal & Shell (`02-terminal.sh`)

**Beautiful, productive terminal environment**

```bash  
./scripts/02-terminal.sh
```

**What it installs:**
- **iTerm2** - Better terminal with Dracula theme
- **Oh My Zsh** - Powerful shell framework  
- **PowerLevel10k** - Beautiful prompt with git info
- **Zsh Plugins** - Autosuggestions, syntax highlighting, zsh-completions
- **Development Aliases** - Git shortcuts, better file listing

**Post-install steps:**
```bash
# Configure the prompt
p10k configure

# Import Dracula theme manually:
# iTerm2 → Preferences → Profiles → Colors → Import → Dracula.itermcolors
```

---

### 3⃣ Version Managers (`03-version-managers.sh`)

**Manage multiple language versions**

```bash
./scripts/03-version-managers.sh  
```

**What it installs:**
- **Volta** - Fast Node.js version manager
- **pyenv** - Python version manager
- **Node.js** - Latest LTS automatically
- **pnpm** - Fast, disk-efficient package manager (via Volta)
- **bun** - All-in-one JS runtime & package manager (via Homebrew tap `oven-sh/bun`)
- **Python** - Versions 3.9.6, 3.10.13, 3.12.1

**Usage examples:**
```bash
# Node.js management
volta install node@20
volta pin node@18

# Package managers
pnpm install
bun install

# Python management  
pyenv install 3.11.5
pyenv global 3.12.1
pyenv local 3.11.5
```

---

## Optional Scripts

### 4⃣ Programming Languages (`04-languages.sh`)

**Backend development languages**

```bash
./scripts/04-languages.sh
```

**Perfect for:** Backend developers, full-stack developers

**What it installs:**
- **Java JDK 17** - With JAVA_HOME configuration
- **Go** - Latest stable version
- **Ruby** - Latest stable version

**Usage examples:**
```bash
# Java
java --version
javac HelloWorld.java

# Go  
go version
go mod init myproject

# Ruby
ruby --version
gem install bundler
```

---

### 5⃣ Frontend Tools (`05-frontend.sh`)

**Complete web and mobile development toolkit**

```bash
./scripts/05-frontend.sh
```

**Perfect for:** Frontend developers, mobile developers, full-stack developers

**What it installs:**
- **TypeScript** - Type-safe JavaScript
- **Vue CLI & Nuxt CLI** - Vue.js ecosystem
- **React Native CLI** - Mobile development
- **Expo CLI & EAS CLI** - Expo platform
- **Vite** - Lightning-fast build tool
- **Turbo (Turborepo)** - High-performance monorepo build system (via Volta)
- ▲ **Vercel CLI** - Deploy and manage Vercel projects (via Volta)
- **Storyblok CLI** - Headless CMS
- **Sanity CLI** - Content management
- **Watchman** - File watching for React Native

**Usage examples:**
```bash
# Vue.js
vue create my-vue-app
nuxt init my-nuxt-app

# React Native
npx react-native@latest init MyApp
npx create-expo-app@latest MyExpoApp

# Build tools
npm create vite@latest my-vite-app

# Headless CMS
storyblok init
sanity init
```

---

### 6⃣ Development Apps (`06-dev-apps.sh`)

**Essential code editors and development tools**

```bash
./scripts/06-dev-apps.sh
```

**Perfect for:** All developers

**What it installs:**
- **Visual Studio Code** - With 20+ carefully chosen extensions
- **Cursor** - AI-powered code editor
- **TextMate** - Lightweight option
- **Claude Code** - Anthropic's terminal coding agent (installed via Homebrew)
- **kiro-cli** - AWS agentic CLI (installed via the official kiro install script)
- **Git Tools** - git-flow, GitHub CLI, GitHub Desktop
- **Git configuration** - `git lg` graph alias, sensible defaults (`init.defaultBranch=main`, `push.autoSetupRemote=true`, `pull.ff=only`, `merge.conflictStyle=zdiff3`), and git-delta set as the pager

**Key VS Code Extensions:**
- **AI Assistants:** GitHub Copilot
- **Languages:** Vue Language Features, Python, Go
- **Git:** GitLens, GitHub Pull Requests  
- **Code Quality:** ESLint, Prettier, EditorConfig
- **Productivity:** Auto Close Tag, Better Comments, Path Intellisense

**Usage examples:**
```bash
# VS Code
code .
code myfile.js

# GitHub CLI
gh auth login
gh repo create myrepo
gh pr create

# Git Flow
git flow init
git flow feature start myfeature
```

---

### 7⃣ Mobile Development (`07-mobile.sh`)

**Android Studio + the Android environment (iOS/React Native script 12)**

```bash
./scripts/07-mobile.sh
```

**Perfect for:** Android developers. For iOS + the full Expo/React Native
toolchain (xcodes, ios-deploy, CocoaPods, SwiftLint, Watchman, JDK 17,
Maestro), run script 12 (`./scripts/12-expo-rn.sh`).

**What it installs:**
- **Android Studio** - Full Android IDE
- **Android environment** - `ANDROID_HOME` + SDK paths in `~/.zshenv`

**Manual steps required:**
1. **Open Android Studio**, install the SDK (API 33+) and create an AVD
2. **For iOS/React Native:** run `./scripts/12-expo-rn.sh`

**Usage examples:**
```bash
# Android emulator
$ANDROID_HOME/emulator/emulator -avd Pixel_API_35

# Full Expo/React Native + iOS toolchain
./scripts/12-expo-rn.sh
```

---

### 8⃣ Productivity Tools (`08-productivity.sh`)

**Workflow optimization applications**

```bash
./scripts/08-productivity.sh
```

**Perfect for:** Anyone wanting better productivity

**What it installs:**
- **Rectangle** - Window management
- **Maccy** - Clipboard history manager
- **Obsidian** - Note-taking application
- **Browsers** - Firefox, Brave for testing
- **Developer utilities** - OrbStack, Postman, Figma
- **Mockoon** - Mock API server
- **Expo Orbit** - Manage Expo builds and simulators
- **DevToys** - Developer Swiss Army knife
- **Signal** - Secure messaging
- **WiFiman** - Network diagnostics

**Setup required after installation:**
- **Rectangle:** Configure shortcuts (++arrows)
- **Maccy:** Set clipboard shortcut (+Shift+V)
- **Obsidian:** Create vault, configure sync (optional)

**Productivity shortcuts:**
```bash
CMD+OPT+Left        # Snap window left
CMD+OPT+Right       # Snap window right  
CMD+Shift+V         # Clipboard history
```

---

### 9⃣ Database Tools (`09-database.sh`)

**Database development and management**

```bash
./scripts/09-database.sh
```

**Perfect for:** Full-stack developers, backend developers

**What it installs:**
- **PostgreSQL 15** - Production database with auto-start
- **DBeaver Community Edition** - Universal database GUI client  
- **pgAdmin 4** - PostgreSQL administration GUI
- **Supabase CLI** - Backend-as-a-service platform

**Usage examples:**
```bash
# PostgreSQL
createdb myproject
psql myproject
brew services start postgresql@15

# Supabase
supabase init
supabase start
supabase login

# Connection string
postgresql://localhost:5432/myproject
```

---

### DevOps Tools (`10-devops.sh`)

**Frontend deployment and command line utilities**

```bash
./scripts/10-devops.sh
```

**Perfect for:** Frontend developers, deployment workflows

**What it installs:**
- **ngrok** - Local tunneling for sharing dev servers
- **UpCloud CLI (upctl)** - Manage UpCloud infrastructure
- **kubectl** (kubernetes-cli) - Kubernetes command line
- **Tilt** - Local Kubernetes development
- **Terraform** - Infrastructure as code (via `hashicorp/tap`)
- **Command line utilities** - jq, fzf, eza, wget, tree
- **JSON processing** - jq for API responses
- **Fuzzy finding** - fzf for terminal productivity
- **Modern CLI tools** - git-delta, ripgrep (`rg`), fd, bat, zoxide, lazygit, direnv, atuin, tldr (tealdeer), btop, dust, duf
- **Shell integration** - fzf key bindings (Ctrl-T / Alt-C) plus zoxide, direnv, and atuin shell init wired into `~/.zshrc` (atuin owns Ctrl-R history search)

**Usage examples:**  
```bash
# Local tunneling
ngrok http 3000  # Share local dev server

# UpCloud
upctl server list

# Kubernetes
kubectl get pods
tilt up

# Infrastructure as code
terraform init
terraform plan

# Command line utilities
jq '.data[] | .name' api.json  # Process JSON
fzf                          # Fuzzy find files
eza -la                      # Better file listing

# Modern CLI tools
rg "TODO"                    # Fast recursive search (ripgrep)
fd config                    # Fast file finder
bat file.js                  # Syntax-highlighted cat
z myproject                  # Jump to dir (zoxide)
lazygit                      # Terminal Git UI
btop                         # Resource monitor
# atuin owns Ctrl-R for shell history search
```

---

### 1⃣1⃣ Developer Fonts (`11-fonts.sh`)

**Beautiful coding fonts**

```bash
./scripts/11-fonts.sh
```

**Perfect for:** All developers

**What it installs:**
- **Fira Code** - Popular with ligatures
- **JetBrains Mono** - Excellent readability
- **Additional fonts** - Programming-optimized typefaces

**After installation:**
Update font settings in:
- **VS Code:** Settings Font Family "Fira Code"
- **iTerm2:** Preferences Profiles Text Font
- **Terminal:** Preferences Profiles Font

---

### 1⃣2⃣ Expo & React Native (`12-expo-rn.sh`)

**Complete local Expo and React Native development environment**

```bash
./scripts/12-expo-rn.sh
```

**Perfect for:** Expo developers, React Native developers

**What it installs:**
- **Watchman** - File watching for React Native
- **OpenJDK 17** - Required for Android builds
- **Android Studio** - Full Android IDE and SDK
- **iOS toolchain** - xcodes, ios-deploy, CocoaPods, SwiftLint
- **Expo, React Native & EAS CLIs** - via Volta
- **Maestro** - Mobile UI testing

**Manual steps required:**
1. **Install Xcode** from App Store (~15GB download)
2. **Accept license:** `sudo xcodebuild -license accept`
3. **Create Android AVDs** in Android Studio

**Usage examples:**
```bash
# Expo
npx create-expo-app@latest MyExpoApp
npx expo start

# EAS builds
eas build --platform ios
eas update

# UI testing
maestro test flow.yaml
```

---

### 1⃣3⃣ macOS Defaults (`13-macos-defaults.sh`)

**Sensible macOS system tweaks via `defaults write`**

```bash
./scripts/13-macos-defaults.sh
```

**Perfect for:** Anyone wanting a tuned macOS experience

**What it configures:**
- **Keyboard** - Faster key repeat, disable press-and-hold
- **Finder** - Show extensions, path/status bar, default list view
- **Screenshots** - Save to `~/Screenshots`
- **Dock** - Tweaked size, autohide, and behavior
- **Dialogs** - Expanded save/print panels by default

**Note:** Some changes require logging out, or restarting Finder/Dock, to take full effect.

---

## Usage Examples

### Full Stack Web Developer
```bash
./setup.sh
# Choose: 4 5 6 8 9

# Gets you:
# ✅ Languages (Java, Go, Ruby)
# ✅ Frontend (Vue, React, TypeScript, Storyblok, Sanity)  
# ✅ Dev Apps (VS Code, Cursor, Git tools)
# ✅ Productivity (Rectangle, Maccy, Mockoon)
# ✅ Database (PostgreSQL, Supabase, DBeaver)
```

### Mobile App Developer
```bash
./setup.sh  
# Choose: 5 6 7 8 11

# Gets you:
# ✅ Frontend (React Native, Expo, TypeScript)
# ✅ Dev Apps (VS Code with extensions)
# ✅ Mobile (Android Studio, iOS tools)
# ✅ Productivity (Better workflow)
# ✅ Fonts (Better coding experience)
```

### DevOps Engineer
```bash
./setup.sh
# Choose: 4 6 8 9 10

# Gets you:
# ✅ Languages (Go, Java for tooling)
# ✅ Dev Apps (VS Code, Git workflows)
# ✅ Productivity (Rectangle, window management)
# ✅ Database (PostgreSQL for local dev)
# ✅ DevOps (Kubernetes, Terraform, Tilt)
```

### Minimalist Developer
```bash
./setup.sh
# Choose: 6 8

# Gets you:
# ✅ Essential foundation (auto-installed)
# ✅ Dev Apps (VS Code, Git tools)  
# ✅ Productivity (Rectangle, Maccy)
# ❌ No extra languages or specialized tools
```

---

## Troubleshooting

### "Command not found" after installation

```bash
# Reload shell configuration
source ~/.zshrc

# Or completely restart terminal
```

### Homebrew permission issues

```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) $(brew --prefix)/*
```

### Python/Node version problems

```bash
# Check what's active
node --version
python --version

# Reset if needed
volta install node@lts
pyenv global 3.12.1
```

### VS Code 'code' command not working

```bash
# Add to PATH manually
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### PostgreSQL connection issues

```bash
# Restart PostgreSQL
brew services restart postgresql@15

# Check if it's running
brew services list | grep postgresql
```

### Android development issues

```bash
# Check environment variables
echo $ANDROID_HOME
echo $JAVA_HOME

# Verify tools
android --version
java --version
```

---

## Customization

### Adding Tools to Existing Scripts

Edit the script files in `scripts/` directory:

```bash
# Add Node.js package to frontend script
# Edit scripts/05-frontend.sh
install_volta_package "your-package-name"

# Add GUI app to any script  
install_cask_app "App Name" "homebrew-cask-name" "/Applications/App Name.app"

# Add command line tool
brew install your-cli-tool
```

### Creating New Scripts

```bash
# Copy existing script as template
cp scripts/11-fonts.sh scripts/12-custom.sh

# Edit the new script
vim scripts/12-custom.sh

# Add to setup-modular.sh
# Edit the optional_scripts array
```

### Modifying Configurations

**Terminal customization:**
- Edit `scripts/02-terminal.sh` for aliases and zsh config
- Modify PowerLevel10k: `~/.p10k.zsh`

**VS Code extensions:**
- Edit `scripts/06-dev-apps.sh`
- Add to the extensions array

**Database configuration:**
- Edit `scripts/09-database.sh`
- Modify PostgreSQL settings or add new databases

---

## Maintenance

### Update Everything (`update.sh`)

```bash
# Upgrade Homebrew, Volta, Oh My Zsh, and PowerLevel10k in one go
./update.sh

# Preview what would be upgraded
./update.sh --dry-run        # alias: -n
```

### Uninstall / Rollback (`uninstall.sh`)

```bash
# Category-by-category rollback of what the setup installed
./uninstall.sh

# Preview what would be removed
./uninstall.sh --dry-run     # alias: -n
```

### Updating All Tools (manual)

```bash
# Update Homebrew packages
brew update && brew upgrade

# Update Node.js
volta install node@latest

# Update Python
pyenv install 3.12.2
pyenv global 3.12.2

# Update VS Code extensions
# They auto-update, or manually in VS Code
```

### Re-running Scripts

All scripts are safe to re-run:

```bash
# Update specific category
./scripts/05-frontend.sh

# Add new tools or update existing ones
./scripts/06-dev-apps.sh
```

### Health Check

```bash
# Verify installation status
./check-setup.sh

# Check specific tools
node --version
python --version  
code --version
```

---

## Getting Help

1. **Run verification:** `./check-setup.sh`
2. **Check individual script logs** - Each shows detailed output
3. **Re-run specific scripts** to fix issues
4. **Check tool documentation** for specific configuration
5. **Open GitHub issue** for persistent problems

---

## What's Next?

After installation:

1. **Restart terminal** or `source ~/.zshrc`
2. **Configure PowerLevel10k:** `p10k configure`  
3. **Import Dracula theme** in iTerm2
4. **Authenticate services:**
   - `gh auth login` (GitHub)
   - `vercel login` (Vercel)
   - `supabase login` (Supabase)
5. **Configure productivity apps** (Rectangle shortcuts, Maccy)
6. **Start coding!** 

---

<div style="text-align: center; margin: 2rem 0; padding: 2rem; background: #f6f8fa; border-radius: 8px;">
  <h3> Ready to Set Up Your Perfect Dev Environment?</h3>
  <p>
    <a href="https://github.com/allanasp/Setup-Developer-Mac" style="display: inline-block; background: #28a745; color: white; padding: 12px 24px; border-radius: 6px; text-decoration: none; font-weight: bold; margin: 8px;">Get Started Now</a>
  </p>
</div>

---

**[ Back to Home](/)** | **[GitHub Repository ](https://github.com/allanasp/Setup-Developer-Mac)**