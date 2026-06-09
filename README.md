# 🚀 Mac Frontend Developer Setup

> **👉 [START HERE](docs/start-here.md) for quick setup** or continue reading for full details

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-Compatible-brightgreen.svg)](https://www.apple.com/macos/)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Homebrew](https://img.shields.io/badge/Package%20Manager-Homebrew-orange.svg)](https://brew.sh/)

> **🎨 Tailored for Frontend Developers!** Automate your entire Mac development environment setup with a single command. This comprehensive script installs and configures 80+ essential tools, applications, and settings optimized for **modern frontend development**, including React, Vue, React Native, and the complete JavaScript/TypeScript ecosystem.

## 🎯 Who This Is For

**Primary Focus: Frontend Developers** working with:
- **React** ecosystem (Create React App, Next.js, Gatsby)
- **Vue.js** ecosystem (Vue CLI, Nuxt.js, Vite)
- **React Native** mobile development
- **TypeScript** and modern JavaScript
- **Node.js** backend development
- **JAMstack** and modern web architectures

**Also Great For:**
- Fullstack JavaScript developers (MERN, MEAN, etc.)
- Mobile app developers using React Native/Expo
- Web developers using modern build tools (Vite, Webpack, Parcel)

## ✨ Features

### 🛠️ **Frontend-First Development Stack**
- **JavaScript/TypeScript Ecosystem**: Node.js (via Volta), npm, pnpm, bun
- **Frontend Frameworks**: Vue CLI, Nuxt CLI (plus React/Svelte project support via npx)
- **Build & Monorepo Tools**: Vite, Turbo (Turborepo), Vercel CLI, serve
- **Mobile Development**: React Native CLI, Expo CLI, EAS CLI, iOS/Android tools
- **Headless CMS**: Storyblok CLI, Sanity CLI
- **Backend Support**: Python (pyenv), Java JDK, Go, Ruby for fullstack needs
- **Package Managers**: Volta (Node.js), pyenv (Python), CocoaPods, Homebrew

### 🎨 **Code Editors & IDEs**
- Visual Studio Code with 20+ essential extensions
- Cursor AI-powered editor
- TextMate, Claude Code (terminal coding agent), kiro-cli (AWS agentic CLI)
- iTerm2 with Dracula theme configuration
- Oh My Zsh with PowerLevel10k theme and productivity plugins

### 📱 **Mobile Development**
- Complete React Native setup (iOS & Android)
- Android Studio with proper Java JDK configuration
- iOS development tools (xcodes, SwiftLint, ios-deploy, CocoaPods)
- Xcode Command Line Tools
- **⚠️ Note**: iOS development requires manual Xcode installation from App Store (cannot be automated)

### ☁️ **DevOps & Cloud Tools**
- UpCloud CLI (upctl) for managing UpCloud infrastructure
- Kubernetes (kubectl), Tilt, and Terraform for infrastructure & orchestration
- ngrok for sharing local development servers
- Command line utilities (jq, fzf, eza, wget, tree)
- Modern CLI tools: git-delta (syntax-highlighted diffs), ripgrep (rg), fd, bat, zoxide (smart cd), lazygit (git TUI), direnv, atuin (searchable shell history, owns Ctrl-R), tldr, btop, dust, duf — plus fzf shell integration (Ctrl-T files, Alt-C cd)
- Docker alternative with OrbStack
- Database tools (PostgreSQL, DBeaver, pgAdmin 4, Supabase CLI)

### 🤖 **AI Coding Assistants**
- GitHub Copilot (via VS Code extension)
- Claude Code (Anthropic's terminal coding agent, via Homebrew)
- kiro-cli (AWS agentic CLI, installed via the official kiro install script)
- OpenCode AI terminal coding agent

### 🎯 **Productivity & Utilities**
- **Window Management**: Rectangle
- **Note Taking**: Obsidian for documentation
- **Clipboard / Menubar**: Maccy clipboard manager, Ice menubar organizer
- **API Tooling**: Postman, Mockoon (API mocking)
- **Mobile**: Expo Orbit (build & simulator launcher)
- **Dev Utilities**: DevToys (developer Swiss-army knife)
- **Messaging**: Signal
- **File Management**: Hidden files enabled, better file listing with eza
- **Network Tools**: ngrok for local tunneling, Wireshark & WiFiman for debugging, WireGuard VPN

## 🚀 Quick Start

### One-line Install (Fastest)

Bootstrap everything from a fresh Mac with a single command — it installs Xcode
Command Line Tools if needed, clones the repo, and launches the setup:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)"
```

For a fully unattended run (CI / scripted machines):

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)" -- --skip-prompts
```

> In non-interactive mode all optional scripts install by default. Set
> `SETUP_OPTIONAL="5 6 8 11"` to pick specific ones, or `SETUP_OPTIONAL=""` to skip them.

### Interactive Setup (Manual clone)

```bash
# Clone the repository
git clone https://github.com/allanasp/Setup-Developer-Mac.git
cd Setup-Developer-Mac

# Interactive setup - guides you through each step
./setup.sh

# Non-interactive setup (for automation)
./setup.sh --skip-prompts

# Preview installs/config without changing anything
./setup.sh --dry-run    # or -n
```

> Every run is logged to `~/mac-setup-YYYY-MM-DD.log`, and an aggregate Setup
> Summary (installed / skipped / failed) is printed at the end.

### 🎯 Interactive Experience
The setup now **guides you through each step** with configuration prompts:
- ✅ Install script → ⚙️ Configure → ✅ Verify → Continue  
- Each tool gets properly configured before moving to the next
- No more guessing what to do after installation!
```

> 🌐 **[View Documentation Website](https://allanasp.github.io/Setup-Developer-Mac)** - Beautiful, interactive documentation

**Example selections:**
- Type `5 6 9` → Install Frontend Tools, Dev Apps, Database Tools
- Type `all` → Install everything
- Press Enter after essentials → Just core development environment

### Individual Script Installation

```bash
# Run specific scripts as needed
./scripts/01-system.sh        # Essential: System requirements
./scripts/05-frontend.sh      # Frontend development tools
./scripts/09-database.sh      # Database tools
```

### Verify Your Installation

```bash
# Check what's installed and get version information
./check-setup.sh
```

## 📋 Available Scripts

### 🔧 Essential Scripts (Auto-Installed)
| Script | Description | Contents |
|--------|-------------|----------|
| `01-system.sh` | System Requirements | Xcode CLI Tools, Homebrew |
| `02-terminal.sh` | Terminal & Shell | iTerm2, Oh My Zsh, PowerLevel10k, Dracula theme |
| `03-version-managers.sh` | Version Managers | Volta (Node.js), pyenv (Python) |

### 📦 Optional Scripts (Choose What You Need)
| # | Script | Description | Key Tools |
|---|--------|-------------|-----------|
| 4 | `04-languages.sh` | Programming Languages | Java, Go, Ruby |
| 5 | `05-frontend.sh` | Frontend Tools | TypeScript, Vue, React Native, Vite, Turbo, Vercel, Storyblok, Sanity |
| 6 | `06-dev-apps.sh` | Development Apps | VS Code + extensions, Cursor, Claude Code, kiro-cli, Git tools |
| 7 | `07-mobile.sh` | Mobile Development | Android Studio + Android env (iOS/RN → script 12) |
| 8 | `08-productivity.sh` | Productivity Tools | Rectangle, Obsidian, Maccy, Mockoon, Expo Orbit |
| 9 | `09-database.sh` | Database Tools | PostgreSQL, DBeaver, pgAdmin 4, Supabase CLI |
| 10 | `10-devops.sh` | DevOps Tools | ngrok, UpCloud, Kubernetes, Tilt, Terraform |
| 11 | `11-fonts.sh` | Developer Fonts | Fira Code, JetBrains Mono |
| 12 | `12-expo-rn.sh` | Expo + React Native Local Dev | Watchman, JDK 17, Maestro, iOS/Android toolchain |
| 13 | `13-macos-defaults.sh` | macOS System Tweaks | Fast key repeat, Finder hidden files/extensions, screenshots to ~/Screenshots, Dock autohide, expanded save/print panels |

> 📖 **[Complete Script Guide](docs/script-guide.md)** - Detailed documentation for each script
> 🛠️ **[Tools Guide](docs/tools-guide.md)** - Comprehensive info on all tools installed

<details>
<summary><strong>🔧 System Tools & Package Managers</strong></summary>

- Xcode Command Line Tools
- Homebrew package manager
- Git with improved configuration
- GitHub CLI and GitHub Desktop
</details>

<details>
<summary><strong>💻 Programming Languages & Runtimes</strong></summary>

- **Node.js** (latest LTS via Volta version manager)
- **Python** (3.9.6, 3.10.13, 3.12.1 via pyenv)
- **Java JDK** (OpenJDK 17 with JAVA_HOME configuration)
- **Go** (latest stable version)
- **Ruby** (latest stable version)
- **TypeScript** (global compiler)
</details>

<details>
<summary><strong>📦 Package Managers</strong></summary>

- npm (Node.js default, updated to latest)
- pnpm (Performant Node.js package manager)
- bun (fast all-in-one JavaScript runtime & package manager)
- CocoaPods (iOS dependency manager)
</details>

<details>
<summary><strong>🎨 Editors & Development Environment</strong></summary>

- **Visual Studio Code** with CLI integration
- **Cursor** AI-powered code editor
- **iTerm2** with Dracula theme and black background
- **Oh My Zsh** with PowerLevel10k theme
- **Warp** modern terminal with AI features
</details>

<details>
<summary><strong>🌐 Frontend Development</strong></summary>

- Vue CLI and Nuxt CLI
- React Native CLI and Expo CLI
- Vite project creator
- Create React App
- Serve static file server
</details>

<details>
<summary><strong>📱 Mobile Development</strong></summary>

- Android Studio
- iOS development tools (xcodes, SwiftLint, ios-deploy)
- React Native dependencies (Watchman, JDK)
- CocoaPods for iOS dependency management
</details>

<details>
<summary><strong>☸️ DevOps & Cloud</strong></summary>

- **Command line utilities**: jq, fzf, eza, wget, tree
- **Modern CLI tools**: git-delta, ripgrep (rg), fd, bat, zoxide, lazygit, direnv, atuin, tldr, btop, dust, duf (with fzf shell integration: Ctrl-T, Alt-C)
- **UpCloud CLI** (upctl) for cloud infrastructure
- **Kubernetes** (kubectl), **Tilt**, **Terraform**
- **OrbStack** (Docker alternative)
- **PostgreSQL** database server
</details>

<details>
<summary><strong>🤖 AI Development Tools</strong></summary>

- GitHub Copilot (VS Code extension)
- Claude Code (Anthropic's terminal coding agent, via Homebrew)
- kiro-cli (AWS agentic CLI, installed via official kiro install script)
- OpenCode AI terminal coding agent
</details>

<details>
<summary><strong>🎯 Productivity Applications</strong></summary>

- **Rectangle** (window management)
- **Maccy** (clipboard manager)
- **Obsidian** (note-taking)
- **Firefox & Brave** (additional browsers for testing)
</details>

<details>
<summary><strong>🔧 Developer Utilities</strong></summary>

- **Database**: DBeaver Community Edition, pgAdmin 4
- **API Testing**: Postman, Mockoon
- **Mobile**: Expo Orbit
- **Design**: Figma
- **Network**: ngrok (local tunneling), Wireshark, WiFiman
- **File Management**: ImageOptim, AppCleaner
- **Command Line**: eza, wget, jq, tree, fzf
</details>

## 🔍 VS Code Extensions Included

The script automatically installs essential VS Code extensions:

- **Language Support**: Vue.volar, Python, Go, TypeScript
- **Git Integration**: GitLens, GitHub Pull Requests
- **AI Assistants**: GitHub Copilot
- **Code Quality**: ESLint, Prettier, EditorConfig
- **Productivity**: Auto Close Tag, Better Comments, Path Intellisense
- **Themes**: Material Icon Theme
- **Remote Development**: Remote Containers, Remote SSH

## ⚙️ Custom Configurations

### 🖥️ **Terminal Enhancements**
- **iTerm2**: Configured with Dracula theme for beautiful colors
- **Oh My Zsh**: Includes autosuggestions and syntax highlighting
- **PowerLevel10k**: Modern, informative prompt theme
- **Custom Aliases**: Git shortcuts, better file listing, development shortcuts

### 🔍 **System Settings**
- **Hidden Files**: Enabled in Finder for better development workflow
- **Git Configuration**: `git lg` graph alias, delta as the pager, and sensible defaults (`init.defaultBranch=main`, `push.autoSetupRemote`, `pull.ff=only`)
- **Shell Environment**: Optimized PATH and environment variables

### 📁 **Directory Structure**
The script creates a organized development directory structure:
```
~/Developer/
├── Projects/     # Your main projects
├── Learning/     # Learning and tutorial projects  
└── Playground/   # Experimental code
```

## 🏃‍♂️ Usage

### Modular Setup (Recommended)
```bash
# Interactive setup - choose what you need
./setup.sh

# Example: Install specific tools
# Type: 5 6 9
# Installs: Frontend Tools + Dev Apps + Database Tools
```

### Individual Scripts
```bash
# Install just what you need
./scripts/01-system.sh      # System essentials
./scripts/05-frontend.sh    # Web development tools
./scripts/09-database.sh    # Database tools

# Make scripts executable if needed
chmod +x scripts/*.sh
```

### Verification
```bash
# Check installation status with versions
./check-setup.sh
```

### Updates (Every 6 Months)
```bash
# Upgrade everything at once (brew, Volta/Node, Oh My Zsh, PowerLevel10k)
./update.sh
./update.sh --dry-run       # preview without changing anything

# Or re-run specific scripts to update tools
./scripts/05-frontend.sh    # Update frontend tools
./scripts/06-dev-apps.sh    # Update development apps

# Or run full modular setup again
./setup.sh
```

### Uninstall / Rollback
```bash
# Roll back installed casks/formulae/Volta packages, with per-category confirmation
./uninstall.sh
./uninstall.sh --dry-run    # preview what would be removed
```

## 📋 Post-Installation Steps

### Essential Configuration
1. **Restart terminal** or run `source ~/.zshrc`
2. **PowerLevel10k**: Pre-configured with Dracula colors! (run `p10k configure` to customize)
3. **Import Dracula theme**: iTerm2 → Preferences → Colors → Import `Dracula.itermcolors`

### Verify Everything Works
4. **Run the setup checker**: `./check-setup.sh`
   - Shows what's installed and working ✅
   - Identifies any issues ❌  
   - Displays version information 🔧
   - Gives overall completion percentage 📊

### Authentication Setup
5. **GitHub CLI**: `gh auth login`
6. **Supabase**: `supabase login` (if using)
7. **Vercel**: `vercel login` (if using)

### Productivity Apps (if installed)
8. **Rectangle**: Configure window shortcuts (⌘+⌥+arrows)
9. **Maccy**: Set clipboard shortcut (⌘+Shift+V)
10. **Obsidian**: Create vault, configure sync (optional)

### Mobile Development (if script 7 chosen)
12. **Install Xcode** from App Store (~15GB download)
13. **Accept Xcode license**: `sudo xcodebuild -license accept`
14. **Create Android AVDs** in Android Studio

> 📖 **[Post-Installation Guide](docs/post-installation.md)** - Detailed post-installation instructions

## 🔧 Customization

### Adding New Tools
Edit individual scripts in the `scripts/` directory:

```bash
# Add to specific script (e.g., scripts/05-frontend.sh)
install_volta_package "your-node-package"

# Add GUI app to any script
install_cask_app "App Name" "cask-name" "/Applications/App Name.app"

# Add command line tool
brew install your-tool
```

### Creating Custom Scripts
```bash
# Create new script
cp scripts/11-fonts.sh scripts/12-custom.sh

# Edit and customize
# Add to setup-modular.sh optional_scripts array
```

### Modifying Configurations
- **Terminal setup**: Edit `scripts/02-terminal.sh`
- **VS Code extensions**: Edit `scripts/06-dev-apps.sh`
- **Database tools**: Edit `scripts/09-database.sh`

## 📊 System Requirements

- **macOS**: 10.15 (Catalina) or later
- **Architecture**: Intel or Apple Silicon (M1/M2/M3)
- **Disk Space**: ~15GB for full installation (30GB+ if including Xcode)
- **Internet**: Required for downloading packages

## ⚠️ Important Limitations

### iOS Development Requires Manual Steps
- **Xcode cannot be installed via Homebrew** due to Apple's licensing restrictions
- **Xcode must be downloaded from Mac App Store** (~15GB download)
- **Some iOS tools require full Xcode** (like SwiftLint)
- **The script will prompt you** whether to install iOS development tools
- **You can skip iOS development** and install it later if needed

### What This Means:
- ✅ **Android development** is fully automated
- ✅ **Web development** is fully automated  
- ⚠️ **iOS development** requires manual Xcode installation after running the script
- 🔄 **You can choose** to skip iOS tools during setup

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Show Your Support

If this project helped you set up your development environment, please give it a star! ⭐

## 📚 Related Projects

- [Homebrew](https://brew.sh/) - The missing package manager for macOS
- [Oh My Zsh](https://ohmyz.sh/) - Framework for managing Zsh configuration
- [Volta](https://volta.sh/) - JavaScript tool manager
- [pyenv](https://github.com/pyenv/pyenv) - Python version management

## 🏷️ Keywords

`mac-setup` `developer-tools` `homebrew` `nodejs` `python` `react-native` `ios-development` `android-development` `kubernetes` `devops` `ai-coding` `github-copilot` `vscode` `productivity` `automation` `shell-script` `macos-configuration`

---

## 🎯 Common Usage Examples

### Full Stack Developer
```bash
./setup.sh
# Choose: 4 5 6 8 9 (Languages, Frontend, Dev Apps, Productivity, Database)
```

### Mobile Developer
```bash
./setup.sh
# Choose: 5 6 7 8 11 (Frontend, Dev Apps, Mobile, Productivity, Fonts)
```

### DevOps Engineer
```bash
./setup.sh
# Choose: 4 6 8 9 10 (Languages, Dev Apps, Productivity, Database, DevOps)
```

### Minimalist Setup
```bash
./setup.sh
# Choose: 6 8 (Just Dev Apps + Productivity)
```

---

**Made with ❤️ for the developer community**

> 📖 **[Script Guide](docs/script-guide.md)** | 🧭 **[Start Here](docs/start-here.md)** | 🩺 **[Setup Checker](docs/setup-checker.md)** | 🚀 **[Post-Installation](docs/post-installation.md)**