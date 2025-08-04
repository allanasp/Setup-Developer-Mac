# 🚀 Complete Mac Developer Setup & Configuration Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-Compatible-brightgreen.svg)](https://www.apple.com/macos/)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Homebrew](https://img.shields.io/badge/Package%20Manager-Homebrew-orange.svg)](https://brew.sh/)

> **Automate your entire Mac development environment setup with a single command!** This comprehensive script installs and configures 80+ essential development tools, applications, and settings for modern web development, mobile development, and DevOps workflows.

## ✨ Features

### 🛠️ **Complete Development Stack**
- **Programming Languages**: Node.js (via Volta), Python (via pyenv), Java JDK, Go, Ruby
- **Package Managers**: npm, Yarn Berry, pnpm, Homebrew, CocoaPods
- **Version Managers**: Volta (Node.js), pyenv (Python), xcodes (Xcode)
- **Frontend Tools**: Vue CLI, Nuxt CLI, React Native CLI, Expo CLI, Vite

### 🎨 **Code Editors & IDEs**
- Visual Studio Code with 20+ essential extensions
- Cursor AI-powered editor
- iTerm2 with black background configuration
- Oh My Zsh with PowerLevel10k theme and productivity plugins

### 📱 **Mobile Development**
- Complete React Native setup (iOS & Android)
- Android Studio with proper Java JDK configuration
- iOS development tools (xcodes, SwiftLint, ios-deploy, CocoaPods)
- Xcode Command Line Tools
- **⚠️ Note**: iOS development requires manual Xcode installation from App Store (cannot be automated)

### ☸️ **DevOps & Cloud Tools**
- Kubernetes toolkit (kubectl, helm, kops, kubectx, kubens)
- AWS CLI for cloud development
- Docker alternative with OrbStack
- Database tools (PostgreSQL, Sequel Ace)

### 🤖 **AI Coding Assistants**
- GitHub Copilot (via VS Code extension)
- Amazon Q Developer (via AWS CLI integration)
- Claude Code terminal assistant
- AWS Toolkit for VS Code

### 🎯 **Productivity & Utilities**
- **Window Management**: Rectangle, Raycast (Spotlight replacement)
- **Security**: 1Password integration
- **Clipboard**: Maccy clipboard manager
- **File Management**: Hidden files enabled, better file listing with eza
- **Network Tools**: ngrok for local tunneling, Wireshark for debugging

## 🚀 Quick Start

### One-Command Installation

```bash
# Clone and run the setup script
git clone https://github.com/yourusername/mac-dev-setup.git
cd mac-dev-setup
./setup.sh
```

### Verify Your Installation

```bash
# Check what's installed and get version information
./check-setup.sh
```

## 📋 What Gets Installed

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
- **Java JDK** (OpenJDK 21 with JAVA_HOME configuration)
- **Go** (latest stable version)
- **Ruby** (latest stable version)
- **TypeScript** (global compiler)
</details>

<details>
<summary><strong>📦 Package Managers</strong></summary>

- npm (Node.js default, updated to latest)
- Yarn Berry (Facebook's modern package manager)
- pnpm (Performant Node.js package manager)
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

- **Kubernetes**: kubectl, helm, kops, kubectx, kubens
- **AWS CLI** for cloud development
- **OrbStack** (Docker alternative)
- **PostgreSQL** database server
</details>

<details>
<summary><strong>🤖 AI Development Tools</strong></summary>

- GitHub Copilot (VS Code extension)
- Amazon Q Developer (AWS integration)
- Claude Code terminal assistant
- AWS Toolkit for VS Code
</details>

<details>
<summary><strong>🎯 Productivity Applications</strong></summary>

- **Raycast** (advanced Spotlight replacement)
- **Rectangle** (window management)
- **1Password** (password manager)
- **Maccy** (clipboard manager)
- **Firefox & Brave** (additional browsers for testing)
</details>

<details>
<summary><strong>🔧 Developer Utilities</strong></summary>

- **Database**: Sequel Ace (PostgreSQL/MySQL GUI)
- **API Testing**: Postman
- **Design**: Figma
- **Network**: ngrok (local tunneling), Wireshark
- **File Management**: ImageOptim, AppCleaner
- **Command Line**: eza, wget, jq, tree, fzf
</details>

## 🔍 VS Code Extensions Included

The script automatically installs essential VS Code extensions:

- **Language Support**: Vue.volar, Python, Go, TypeScript
- **Git Integration**: GitLens, GitHub Pull Requests
- **AI Assistants**: GitHub Copilot, Amazon Q (AWS Toolkit)
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
- **Git Configuration**: Improved defaults with useful aliases
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

### Initial Setup
```bash
# Make the script executable (already done in repo)
chmod +x setup.sh

# Run the complete setup
./setup.sh
```

### Verification
```bash
# Check installation status with versions
./check-setup.sh
```

### Updates (Every 6 Months)
```bash
# Re-run the script to update everything
./setup.sh
```

## 📋 Manual Steps After Installation

1. **Install Xcode** from App Store (for iOS development)
2. **Configure PowerLevel10k**: Run `p10k configure`
3. **Setup GitHub CLI**: Run `gh auth login`
4. **Configure AWS CLI**: Run `aws configure` for Amazon Q access
5. **Setup Rectangle**: Configure window management shortcuts
6. **Initialize Git Flow**: Run `git flow init` in your projects
7. **Configure Raycast**: Set CMD+Space shortcut
8. **Setup 1Password**: Sign in and configure browser extensions

## 🔧 Customization

### Adding New Tools
Edit `setup.sh` and add your tools using the provided helper functions:

```bash
# For GUI applications
install_cask_app "App Name" "cask-name" "/Applications/App Name.app"

# For command line tools
brew install tool-name

# For Node.js tools
volta install package-name
```

### Modifying Configurations
- **iTerm2 colors**: Edit the defaults write section around line 111
- **Zsh aliases**: Modify the EOF section around line 153
- **VS Code extensions**: Update the extensions array around line 446

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

**Made with ❤️ for the developer community**