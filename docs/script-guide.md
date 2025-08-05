---
layout: default
title: Complete Script Guide
description: Detailed documentation for all Mac development setup scripts
---

# 📚 Complete Script Guide

> **Comprehensive documentation for all development setup scripts**

## 🚀 Quick Navigation

- [Essential Scripts](#essential-scripts) - Always installed first
- [Optional Scripts](#optional-scripts) - Choose what you need  
- [Usage Examples](#usage-examples) - Common developer setups
- [Troubleshooting](#troubleshooting) - Fix common issues
- [Customization](#customization) - Add your own tools

---

## 📋 Script Overview

### 🔧 Essential Scripts (Auto-Installed)

| Script | Runtime | Dependencies | Purpose |
|--------|---------|--------------|---------|
| `01-system.sh` | ~5 min | None | System foundation |
| `02-terminal.sh` | ~3 min | 01-system | Modern terminal |
| `03-version-managers.sh` | ~10 min | 01-system | Language versions |

### 📦 Optional Scripts (Your Choice)

| # | Script | Runtime | Best For | Key Tools |
|---|--------|---------|----------|-----------|
| 4 | `04-languages.sh` | ~8 min | Backend devs | Java, Go, Ruby |
| 5 | `05-frontend.sh` | ~12 min | Web/mobile devs | Vue, React, Storyblok, Sanity |
| 6 | `06-dev-apps.sh` | ~15 min | All developers | VS Code, Cursor, Git tools |
| 7 | `07-mobile.sh` | ~25 min | Mobile devs | Android Studio, iOS tools |
| 8 | `08-productivity.sh` | ~8 min | Productivity focus | Raycast, Rectangle, 1Password |
| 9 | `09-database.sh` | ~10 min | Full-stack devs | PostgreSQL, Supabase |
| 10 | `10-devops.sh` | ~12 min | DevOps engineers | Kubernetes, AWS, Docker |
| 11 | `11-fonts.sh` | ~3 min | Better coding | Fira Code, JetBrains Mono |

---

## Essential Scripts

### 1️⃣ System Requirements (`01-system.sh`)

**Foundation for everything else**

```bash
./scripts/01-system.sh
```

**What it installs:**
- ✅ **Xcode Command Line Tools** - Required for most development tools
- ✅ **Homebrew** - Package manager for macOS
- ✅ **System Configuration** - Show hidden files in Finder

**Why it's essential:** Every other script depends on Homebrew and Xcode CLI tools.

---

### 2️⃣ Terminal & Shell (`02-terminal.sh`)

**Beautiful, productive terminal environment**

```bash  
./scripts/02-terminal.sh
```

**What it installs:**
- 🖥️ **iTerm2** - Better terminal with Dracula theme
- 🐚 **Oh My Zsh** - Powerful shell framework  
- ⚡ **PowerLevel10k** - Beautiful prompt with git info
- 🔌 **Zsh Plugins** - Autosuggestions, syntax highlighting
- 📝 **Development Aliases** - Git shortcuts, better file listing

**Post-install steps:**
```bash
# Configure the prompt
p10k configure

# Import Dracula theme manually:
# iTerm2 → Preferences → Profiles → Colors → Import → Dracula.itermcolors
```

---

### 3️⃣ Version Managers (`03-version-managers.sh`)

**Manage multiple language versions**

```bash
./scripts/03-version-managers.sh  
```

**What it installs:**
- 🚀 **Volta** - Fast Node.js version manager
- 🐍 **pyenv** - Python version manager
- 📦 **Node.js** - Latest LTS automatically
- 🐍 **Python** - Versions 3.9.6, 3.10.13, 3.12.1

**Usage examples:**
```bash
# Node.js management
volta install node@20
volta pin node@18

# Python management  
pyenv install 3.11.5
pyenv global 3.12.1
pyenv local 3.11.5
```

---

## Optional Scripts

### 4️⃣ Programming Languages (`04-languages.sh`)

**Backend development languages**

```bash
./scripts/04-languages.sh
```

**Perfect for:** Backend developers, full-stack developers

**What it installs:**
- ☕ **Java JDK 21** - With JAVA_HOME configuration
- 🐹 **Go** - Latest stable version
- 💎 **Ruby** - Latest stable version

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

### 5️⃣ Frontend Tools (`05-frontend.sh`)

**Complete web and mobile development toolkit**

```bash
./scripts/05-frontend.sh
```

**Perfect for:** Frontend developers, mobile developers, full-stack developers

**What it installs:**
- 🔷 **TypeScript** - Type-safe JavaScript
- 🟢 **Vue CLI & Nuxt CLI** - Vue.js ecosystem
- ⚛️ **React Native CLI** - Mobile development
- 🚀 **Expo CLI & EAS CLI** - Expo platform
- ⚡ **Vite** - Lightning-fast build tool
- 📝 **Storyblok CLI** - Headless CMS
- 🎨 **Sanity CLI** - Content management
- 👀 **Watchman** - File watching for React Native

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

### 6️⃣ Development Apps (`06-dev-apps.sh`)

**Essential code editors and development tools**

```bash
./scripts/06-dev-apps.sh
```

**Perfect for:** All developers

**What it installs:**
- 💻 **Visual Studio Code** - With 20+ carefully chosen extensions
- 🤖 **Cursor** - AI-powered code editor
- ⚡ **Zed** - Ultra-fast editor
- 📝 **TextMate** - Lightweight option
- 🔧 **Git Tools** - git-flow, GitHub CLI, GitHub Desktop

**Key VS Code Extensions:**
- **AI Assistants:** GitHub Copilot, AWS Toolkit (Amazon Q)
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

### 7️⃣ Mobile Development (`07-mobile.sh`)

**Complete iOS and Android development**

```bash
./scripts/07-mobile.sh
```

**Perfect for:** Mobile app developers, React Native developers

**What it installs:**
- 🤖 **Android Studio** - Full Android IDE
- 📱 **iOS Tools** - xcodes, SwiftLint, ios-deploy
- 📦 **CocoaPods** - iOS dependency manager
- ☕ **Java JDK** - Required for Android development

**Manual steps required:**
1. **Install Xcode** from App Store (~15GB download)  
2. **Accept license:** `sudo xcodebuild -license accept`
3. **Create Android AVDs** in Android Studio

**Usage examples:**
```bash
# React Native
npx react-native run-android
npx react-native run-ios

# iOS development
pod install
xcodes install --latest

# Android emulator
$ANDROID_HOME/emulator/emulator -avd Pixel_API_35
```

---

### 8️⃣ Productivity Tools (`08-productivity.sh`)

**Workflow optimization applications**

```bash
./scripts/08-productivity.sh
```

**Perfect for:** Anyone wanting better productivity

**What it installs:**
- 🔍 **Raycast** - Advanced Spotlight replacement
- 🪟 **Rectangle** - Window management
- 🔐 **1Password** - Password manager  
- 📋 **Maccy** - Clipboard history
- 🌐 **Browsers** - Firefox, Brave for testing

**Setup required after installation:**
- **Raycast:** Set CMD+Space shortcut, install extensions
- **Rectangle:** Configure shortcuts (⌘+⌥+arrows)
- **1Password:** Sign in, install browser extensions
- **Maccy:** Set clipboard shortcut (⌘+Shift+V)

**Productivity shortcuts:**
```bash
CMD+Space           # Raycast (after setup)
CMD+OPT+Left        # Snap window left
CMD+OPT+Right       # Snap window right  
CMD+Shift+V         # Clipboard history
```

---

### 9️⃣ Database Tools (`09-database.sh`)

**Database development and management**

```bash
./scripts/09-database.sh
```

**Perfect for:** Full-stack developers, backend developers

**What it installs:**
- 🐘 **PostgreSQL 15** - Production database with auto-start
- 🖥️ **Sequel Ace** - Beautiful database GUI  
- ⚡ **Supabase CLI** - Backend-as-a-service platform

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

### 🔟 DevOps Tools (`10-devops.sh`)

**Infrastructure and deployment tools**

```bash
./scripts/10-devops.sh
```

**Perfect for:** DevOps engineers, cloud developers

**What it installs:**
- ☸️ **Kubernetes Tools** - kubectl, helm, kops, kubectx, kubens
- ☁️ **AWS CLI** - Cloud development
- 🐳 **OrbStack** - Docker alternative (faster, lighter)
- 🌐 **Network Tools** - ngrok, wget, jq
- 🔍 **Wireshark** - Network analysis

**Usage examples:**  
```bash
# Kubernetes
kubectl get pods
kubectx                    # Switch contexts
kubens                     # Switch namespaces
helm install myapp ./chart

# AWS
aws configure
aws s3 ls

# Local tunneling
ngrok http 3000
```

---

### 1️⃣1️⃣ Developer Fonts (`11-fonts.sh`)

**Beautiful coding fonts**

```bash
./scripts/11-fonts.sh
```

**Perfect for:** All developers

**What it installs:**
- 🔤 **Fira Code** - Popular with ligatures
- ⚡ **JetBrains Mono** - Excellent readability
- 🎨 **Additional fonts** - Programming-optimized typefaces

**After installation:**
Update font settings in:
- **VS Code:** Settings → Font Family → "Fira Code"
- **iTerm2:** Preferences → Profiles → Text → Font
- **Terminal:** Preferences → Profiles → Font

---

## Usage Examples

### 🌐 Full Stack Web Developer
```bash
./setup.sh
# Choose: 4 5 6 8 9

# Gets you:
# ✅ Languages (Java, Go, Ruby)
# ✅ Frontend (Vue, React, TypeScript, Storyblok, Sanity)  
# ✅ Dev Apps (VS Code, Cursor, Git tools)
# ✅ Productivity (Raycast, Rectangle, 1Password)
# ✅ Database (PostgreSQL, Supabase, Sequel Ace)
```

### 📱 Mobile App Developer
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

### ☸️ DevOps Engineer
```bash
./setup.sh
# Choose: 4 6 8 9 10

# Gets you:
# ✅ Languages (Go, Java for tooling)
# ✅ Dev Apps (VS Code, Git workflows)
# ✅ Productivity (Raycast, window management)
# ✅ Database (PostgreSQL for local dev)
# ✅ DevOps (Kubernetes, AWS, Docker alternative)
```

### 🎯 Minimalist Developer
```bash
./setup.sh
# Choose: 6 8

# Gets you:
# ✅ Essential foundation (auto-installed)
# ✅ Dev Apps (VS Code, Git tools)  
# ✅ Productivity (Raycast, Rectangle)
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

### Updating All Tools

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
   - `aws configure` (AWS)
   - `supabase login` (Supabase)
5. **Configure productivity apps** (Raycast shortcuts, Rectangle)
6. **Start coding!** 🚀

---

<div style="text-align: center; margin: 2rem 0; padding: 2rem; background: #f6f8fa; border-radius: 8px;">
  <h3>🎉 Ready to Set Up Your Perfect Dev Environment?</h3>
  <p>
    <a href="https://github.com/allanasp/Setup-Developer-Mac" style="display: inline-block; background: #28a745; color: white; padding: 12px 24px; border-radius: 6px; text-decoration: none; font-weight: bold; margin: 8px;">Get Started Now</a>
  </p>
</div>

---

**[← Back to Home](index.html)** | **[GitHub Repository →](https://github.com/allanasp/Setup-Developer-Mac)**