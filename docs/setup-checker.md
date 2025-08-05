---
layout: default
title: Setup Checker
description: Verify your Mac development environment installation
---

# 🔍 Setup Checker - Verify Your Installation

The setup checker (`check-setup.sh`) verifies your Mac development environment and shows you exactly what's working and what needs attention.

## 🚀 Quick Start

```bash
# After running the main setup
./check-setup.sh
```

## 📊 What It Shows

### ✅ Installed Tools
- Lists all installed development tools
- Shows version information where available
- Confirms tools are working properly

### ❌ Missing or Issues
- Identifies tools that failed to install
- Highlights configuration issues
- Suggests fixes for common problems

### 📈 Completion Percentage
- Overall setup completion rate
- Breakdown by category (frontend, mobile, devops, etc.)
- Progress tracking for partial installations

## 🎯 Example Output

```bash
🔍 Checking Mac Development Setup (with versions)...

=== System Requirements ===
[✓] Xcode Command Line Tools (xcode-select version 2395)
[✓] Homebrew (Homebrew 4.1.11)
[✓] Git (git version 2.42.0)

=== Terminal & Shell ===  
[✓] iTerm2 (Build 3.4.19)
[✓] Oh My Zsh (~/.oh-my-zsh)
[✓] PowerLevel10k (~/.oh-my-zsh/custom/themes/powerlevel10k)
[✓] Zsh plugins (autosuggestions, syntax-highlighting)

=== Frontend Development ===
[✓] Node.js (v20.5.0 via Volta)
[✓] npm (9.8.0)
[✓] TypeScript (5.1.6)
[✓] Vue CLI (5.0.8)
[✓] Vite (4.4.9)
[✗] React Native CLI - not installed

=== Development Apps ===
[✓] Visual Studio Code (1.81.1)
[✓] VS Code Extensions (20 installed)
[✓] Cursor (0.8.0)
[✗] Zed - not installed

📊 Setup Status: 85% Complete (34/40 tools installed)
🎯 Frontend Focus: 95% Complete (19/20 tools)
📱 Mobile Development: 60% Complete (3/5 tools)
```

## 🛠️ Categories Checked

### Essential Components
- **System Requirements**: Xcode CLI tools, Homebrew, Git
- **Terminal & Shell**: iTerm2, Oh My Zsh, PowerLevel10k, plugins
- **Version Managers**: Volta (Node.js), pyenv (Python)

### Frontend Development (Core Focus)
- **JavaScript Ecosystem**: Node.js, npm, yarn, pnpm
- **TypeScript**: Compiler and language server
- **Frontend Frameworks**: Vue CLI, React tools, Angular CLI
- **Build Tools**: Vite, Webpack, create-react-app
- **Mobile**: React Native CLI, Expo CLI

### Development Tools
- **Editors**: VS Code, Cursor, Zed
- **Extensions**: 20+ VS Code extensions
- **Git Tools**: GitHub CLI, Git aliases
- **Terminal Tools**: Advanced shell configuration

### Optional Components
- **Mobile Development**: Android Studio, iOS tools, simulators
- **Productivity**: Raycast, Rectangle, 1Password, Maccy
- **Database**: PostgreSQL, Sequel Ace, Supabase CLI
- **DevOps**: Docker alternatives, Kubernetes, AWS CLI
- **Developer Fonts**: Fira Code, JetBrains Mono

## 🔧 Common Issues & Fixes

### Node.js Not Found
```bash
# Restart terminal or reload shell
source ~/.zshrc

# Verify Volta installation
volta --version
```

### VS Code Extensions Missing
```bash
# Manually install extensions
code --install-extension bradlc.vscode-tailwindcss
code --install-extension esbenp.prettier-vscode
```

### PowerLevel10k Not Working
```bash
# Reconfigure PowerLevel10k
p10k configure

# Check theme installation
ls ~/.oh-my-zsh/custom/themes/powerlevel10k
```

### Homebrew Issues
```bash
# Update Homebrew
brew update

# Check for issues
brew doctor
```

## 📈 Using Results for Troubleshooting

### High Completion Rate (90%+)
- ✅ Setup was successful
- Focus on configuring installed tools
- Run individual scripts for missing items

### Medium Completion Rate (70-89%)
- 🔧 Some components failed to install
- Check internet connection during setup
- Re-run specific category scripts

### Low Completion Rate (<70%)
- ❌ Major installation issues
- Check system requirements (macOS version, disk space)
- Consider running setup again with `--skip-prompts`

## ⚡ Advanced Usage

### Check Specific Categories
```bash
# Check just frontend tools
./scripts/05-frontend.sh --check-only

# Check just development apps  
./scripts/06-dev-apps.sh --check-only
```

### Export Results
```bash
# Save results to file
./check-setup.sh > setup-results.txt

# Check in CI/automated environments
SKIP_INTERACTIVE=true ./check-setup.sh
```

### Integration with Setup
```bash
# Run checker after setup
./setup.sh && ./check-setup.sh

# Check before re-running setup
./check-setup.sh && ./setup.sh --skip-prompts
```

## 🎯 Frontend Developer Focus

The checker prioritizes frontend development tools and shows specific metrics for:

- **JavaScript/TypeScript ecosystem completeness**
- **React/Vue/Angular framework readiness** 
- **Mobile development (React Native) status**
- **Modern build tool availability**
- **Developer experience tool coverage**

This helps frontend developers quickly see if their environment is ready for:
- Building React/Vue applications
- Developing React Native mobile apps
- Modern JavaScript/TypeScript development
- Full-stack development with Node.js

---

## 🔄 What's Next?

After running the checker:

1. **100% Complete**: You're ready to develop! 🎉
2. **Missing Tools**: Re-run specific scripts or `./setup.sh`
3. **Configuration Issues**: Check the [Post-Installation Guide](post-installation.html)
4. **Still Having Issues**: [Report a bug](https://github.com/allanasp/Setup-Developer-Mac/issues)

The setup checker ensures your Mac development environment is not just installed, but actually working and ready for productive frontend development! 🚀