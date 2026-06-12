# 🚀 Mac Frontend Developer Setup

> **📖 Full documentation: [allanasp.github.io/Setup-Developer-Mac](https://allanasp.github.io/Setup-Developer-Mac/)**
>
> **👉 [START HERE](https://allanasp.github.io/Setup-Developer-Mac/start-here) for the quick-start guide**, or continue reading for the full overview.

[![Docs](https://img.shields.io/badge/docs-allanasp.github.io-blue.svg)](https://allanasp.github.io/Setup-Developer-Mac/)
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

> ✨ **What gets installed?** See the [Detailed Tool Catalogue](#-detailed-tool-catalogue) below — every script with its tools, descriptions, and category tags.

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

> 🌐 **[View Documentation Site](https://allanasp.github.io/Setup-Developer-Mac/)** — searchable VitePress docs with the full guide

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

# Diagnose environment drift (broken aliases, missing PATH, stale xcode-select…)
./doctor.sh
./doctor.sh --auto-fix         # apply safe repairs for known issues
```

## 📚 Detailed Tool Catalogue

Every script with its full tool list, a one-line description, and a category tag.
Scripts 01–03 are **essential** (auto-installed); 04–13 are **optional**.
Generated from [`data/tools.json`](data/tools.json) — edit there and run
`scripts/lib/generate-docs.sh` to update both this section and `docs/tools-guide.md`.

> 📖 **[Complete Script Guide](docs/script-guide.md)** — detailed documentation for each script
> 🛠️ **[Tools Guide](docs/tools-guide.md)** — same catalogue with homepage links per tool

<!-- TOOLS:BEGIN:overview -->
### 1. System Foundation _(essential, auto-installed)_

*`scripts/01-system.sh` — Bootstraps the toolchain everything else builds on.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/xcode" width="14" alt="" align="center"/> **Xcode Command Line Tools** | Apple's compiler suite (clang, git, make, swift). Required by Homebrew and most other tools. | Compiler toolchain |
| <img src="https://cdn.simpleicons.org/homebrew" width="14" alt="" align="center"/> **Homebrew** | The missing package manager for macOS. Every later script builds on `brew`. | Package manager |

### 2. Terminal & Shell _(essential, auto-installed)_

*`scripts/02-terminal.sh` — Modern terminals plus a productive Zsh setup.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/iterm2" width="14" alt="" align="center"/> **iTerm2** | Advanced terminal emulator with split panes, search, paste history. Dracula theme is preconfigured. | Terminal |
| <img src="https://cdn.simpleicons.org/warp" width="14" alt="" align="center"/> **Warp** | Modern AI-powered terminal with block-based output and command palette. | Terminal |
| <img src="https://cdn.simpleicons.org/ohmyzsh" width="14" alt="" align="center"/> **Oh My Zsh** | Framework for managing Zsh config — plugins, themes, completions. | Shell framework |
| **PowerLevel10k** | Extremely fast Zsh prompt theme. Shows git status, runtime info, language versions. | Shell theme |
| **Dracula Theme** | Dark color scheme for iTerm2 + PowerLevel10k. High contrast, low eye strain. | Color scheme |
| **zsh-autosuggestions** | Suggests commands as you type, based on history. Right-arrow to accept. | Shell plugin |
| **zsh-syntax-highlighting** | Colors commands as you type — green for valid, red for typos. | Shell plugin |

### 3. Version Managers & Runtimes _(essential, auto-installed)_

*`scripts/03-version-managers.sh` — Per-project Node and Python versions, plus Bun.*

| Tool | What it is | Kind |
|---|---|---|
| **Volta** | Fast Rust-based Node.js version manager. Pins versions per project automatically. | Version manager |
| <img src="https://cdn.simpleicons.org/python" width="14" alt="" align="center"/> **pyenv** | Python version manager. Multiple versions side by side, per-project pinning. | Version manager |
| <img src="https://cdn.simpleicons.org/nodedotjs" width="14" alt="" align="center"/> **Node.js (LTS)** | JavaScript runtime. Installed at the LTS version via Volta. | Runtime |
| <img src="https://cdn.simpleicons.org/pnpm" width="14" alt="" align="center"/> **pnpm** | Fast, disk-efficient package manager. Default in this setup over npm/yarn. | Package manager |
| <img src="https://cdn.simpleicons.org/bun" width="14" alt="" align="center"/> **Bun** | All-in-one JS runtime, bundler, test runner, package manager. Installed via its own Homebrew tap. | Runtime |

### 4. Programming Languages _(optional)_

*`scripts/04-languages.sh` — Standalone language runtimes for full-stack and mobile work.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/openjdk" width="14" alt="" align="center"/> **OpenJDK 17** | Java 17 runtime. Required by Gradle for Android/React Native builds. | Language runtime |
| <img src="https://cdn.simpleicons.org/go" width="14" alt="" align="center"/> **Go** | Statically-typed language by Google. Used by Docker, Kubernetes, Terraform internally. | Language |
| <img src="https://cdn.simpleicons.org/ruby" width="14" alt="" align="center"/> **Ruby** | Dynamic interpreted language. Required by CocoaPods and many DevOps tools. | Language |

### 5. Frontend & Mobile CLIs _(optional)_

*`scripts/05-frontend.sh` — The heart of the setup — global CLIs for the modern JS ecosystem.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/vuedotjs" width="14" alt="" align="center"/> **Vue CLI** | Scaffolding and tooling for Vue.js projects. | Frontend CLI |
| <img src="https://cdn.simpleicons.org/nuxtdotjs" width="14" alt="" align="center"/> **Nuxt CLI** | Scaffolding and dev tools for Nuxt 3+ apps. | Frontend CLI |
| <img src="https://cdn.simpleicons.org/typescript" width="14" alt="" align="center"/> **TypeScript** | Typed superset of JavaScript. Installed globally. | Language |
| <img src="https://cdn.simpleicons.org/vite" width="14" alt="" align="center"/> **create-vite** | Project scaffold for Vite — fast dev server and bundler. | Scaffolder |
| **serve** | Quick static-file server for testing built sites locally. | CLI |
| <img src="https://cdn.simpleicons.org/turborepo" width="14" alt="" align="center"/> **Turborepo** | Incremental bundler/build system for JS monorepos. | Monorepo tool |
| <img src="https://cdn.simpleicons.org/vercel" width="14" alt="" align="center"/> **Vercel CLI** | Deploy Next.js / Nuxt / static sites to Vercel from the terminal. | Deploy CLI |
| <img src="https://cdn.simpleicons.org/storyblok" width="14" alt="" align="center"/> **Storyblok CLI** | Manage Storyblok headless-CMS spaces and components. | CMS CLI |
| <img src="https://cdn.simpleicons.org/sanity" width="14" alt="" align="center"/> **Sanity CLI** | Scaffold and manage Sanity Studio projects. | CMS CLI |
| <img src="https://cdn.simpleicons.org/react" width="14" alt="" align="center"/> **React Native CLI** | Bare React Native projects (without Expo). | Mobile CLI |
| <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> **Expo CLI** | Run, build, and debug Expo React Native apps. | Mobile CLI |
| <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> **EAS CLI** | Expo Application Services — cloud builds, submits, OTA updates. | Mobile CLI |
| <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> **create-expo-app** | Scaffolder for new Expo projects. | Scaffolder |
| **Watchman** | File-watching daemon by Meta. Required by React Native/Metro for fast rebuilds. | Dev daemon |

### 6. Editors & Git Tools _(optional)_

*`scripts/06-dev-apps.sh` — Editors, AI coding agents, Git tooling.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/git" width="14" alt="" align="center"/> **Git** | Version control. Reinstalled via Homebrew with sane global defaults. | VCS |
| **Git Flow (AVH)** | Git Flow branching model commands. AVH is the maintained fork. | Git extension |
| <img src="https://cdn.simpleicons.org/github" width="14" alt="" align="center"/> **GitHub CLI (gh)** | PRs, issues, and releases from the terminal. | CLI |
| <img src="https://cdn.simpleicons.org/github" width="14" alt="" align="center"/> **GitHub Desktop** | GUI Git client tightly integrated with GitHub. | GUI app |
| **Visual Studio Code** | Microsoft's editor. Installed with a curated 20+ extension pack. | Editor |
| <img src="https://cdn.simpleicons.org/cursor" width="14" alt="" align="center"/> **Cursor** | AI-first fork of VS Code with built-in chat and code edits. | Editor |
| **TextMate** | Lightweight macOS editor — handy for quick edits outside the main editor. | Editor |
| <img src="https://cdn.simpleicons.org/anthropic" width="14" alt="" align="center"/> **Claude Code** | Anthropic's terminal coding agent. | AI agent |
| **kiro-cli** | AWS agentic coding CLI. Installed via the official kiro install script. | AI agent |
| **OpenCode** | Open-source terminal coding agent (via sst/tap). | AI agent |

### 7. Mobile (Android) _(optional)_

*`scripts/07-mobile.sh` — Android Studio + environment. Full RN/iOS env lives in script 12.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/androidstudio" width="14" alt="" align="center"/> **Android Studio** | Official IDE for Android. Sets `ANDROID_HOME` + PATH for SDK tools. | IDE |

### 8. Productivity & Utilities _(optional)_

*`scripts/08-productivity.sh` — Window mgmt, browsers, API tools, and other day-to-day apps.*

| Tool | What it is | Kind |
|---|---|---|
| **Rectangle** | Keyboard-driven window snapping (halves, quarters, thirds). | GUI app |
| **Maccy** | Clipboard history manager. Trigger with a hotkey, fuzzy-search past copies. | GUI app |
| <img src="https://cdn.simpleicons.org/obsidian" width="14" alt="" align="center"/> **Obsidian** | Markdown-based notes with linked references and a graph view. | GUI app |
| <img src="https://cdn.simpleicons.org/1password" width="14" alt="" align="center"/> **1Password CLI** | Read secrets from 1Password in scripts and shells. | CLI |
| <img src="https://cdn.simpleicons.org/googlechrome" width="14" alt="" align="center"/> **Google Chrome** | Reference browser for testing and DevTools work. | Browser |
| <img src="https://cdn.simpleicons.org/firefox" width="14" alt="" align="center"/> **Firefox** | Second engine to test against — different rendering and DevTools. | Browser |
| <img src="https://cdn.simpleicons.org/brave" width="14" alt="" align="center"/> **Brave Browser** | Chromium-based browser with built-in tracker/ad blocking. | Browser |
| **OrbStack** | Lightweight Docker / Linux VM alternative to Docker Desktop. | Container runtime |
| <img src="https://cdn.simpleicons.org/postman" width="14" alt="" align="center"/> **Postman** | API client for designing, testing, and documenting HTTP requests. | API tool |
| **Mockoon** | Local mock API server. Spin up fake REST endpoints in seconds. | API tool |
| <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> **Expo Orbit** | Menubar launcher for Expo dev builds and iOS/Android simulators. | GUI app |
| <img src="https://cdn.simpleicons.org/figma" width="14" alt="" align="center"/> **Figma** | Design and prototyping tool. Desktop app gives Sign In + local fonts. | Design tool |
| **ImageOptim** | Drag-and-drop lossless image compression (PNG/JPEG/SVG). | GUI app |
| <img src="https://cdn.simpleicons.org/wireguard" width="14" alt="" align="center"/> **WireGuard** | Modern fast VPN client. | Network tool |
| **DevToys** | Swiss-army knife of small dev utilities (JSON formatter, hash, regex, base64…). | GUI app |
| <img src="https://cdn.simpleicons.org/signal" width="14" alt="" align="center"/> **Signal** | End-to-end encrypted messenger. | Messenger |
| **WiFiman** | Wi-Fi analyzer + speed test from Ubiquiti. | Network tool |
| **AppCleaner** | Properly uninstall macOS apps, including their support files. | GUI app |
| **Ice** | Menubar organizer — hide and group items in the macOS menubar. | GUI app |
| <img src="https://cdn.simpleicons.org/syncthing" width="14" alt="" align="center"/> **Syncthing** | Peer-to-peer file sync across your own devices. | GUI app |
| <img src="https://cdn.simpleicons.org/wireshark" width="14" alt="" align="center"/> **Wireshark** | Packet analyzer for deep network debugging. | Network tool |

### 9. Databases _(optional)_

*`scripts/09-database.sh` — PostgreSQL plus GUI clients and Supabase tooling.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/postgresql" width="14" alt="" align="center"/> **PostgreSQL 15** | Relational database server. PATH wired via `~/.zshenv`. | Database |
| <img src="https://cdn.simpleicons.org/dbeaver" width="14" alt="" align="center"/> **DBeaver Community Edition** | Cross-platform SQL GUI for Postgres, MySQL, SQLite, and many more. | Database GUI |
| **pgAdmin 4** | Official Postgres GUI — better for Postgres-specific features. | Database GUI |
| <img src="https://cdn.simpleicons.org/supabase" width="14" alt="" align="center"/> **Supabase CLI** | Run Supabase locally, push migrations, manage projects. | DB CLI |

### 10. DevOps & CLI Power-ups _(optional)_

*`scripts/10-devops.sh` — Modern CLI replacements + infrastructure tooling.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/ngrok" width="14" alt="" align="center"/> **ngrok** | Public HTTPS tunnel to a local port — share dev servers and webhooks. | Tunneling |
| **eza** | Modern `ls` replacement with colors, icons, and git status. | CLI |
| **wget** | Recursive HTTP/FTP downloader. Better than `curl` for whole-site mirrors. | CLI |
| **jq** | Command-line JSON processor. Filter, transform, query JSON in pipelines. | CLI |
| **tree** | Visualize directory structures as a tree. | CLI |
| **fzf** | Fuzzy finder. Bound to Ctrl-T (files) and Alt-C (cd) in your shell. | CLI |
| **ripgrep (rg)** | Extremely fast recursive grep. Respects `.gitignore` by default. | CLI |
| **fd** | Friendly, fast `find` replacement. | CLI |
| **bat** | `cat` clone with syntax highlighting and git integration. | CLI |
| **git-delta** | Syntax-highlighted diff viewer. Wired as Git's pager. | Git tool |
| **zoxide** | Smarter `cd` — jumps to recent/frequent dirs by partial name. | CLI |
| **lazygit** | Terminal UI for Git. Staging, branches, rebases without leaving the keyboard. | Git tool |
| **direnv** | Per-directory env vars. Drop a `.envrc`, allow it once, vars load automatically. | CLI |
| **atuin** | Searchable shell history with full context. Owns Ctrl-R after install. | CLI |
| **tldr (tealdeer)** | Quick example-based man pages. Run `tldr tar` instead of reading the manual. | CLI |
| **btop** | Modern resource monitor with mouse support. Replaces `top`/`htop`. | CLI |
| **dust** | More intuitive `du` — bar charts of disk usage by directory. | CLI |
| **duf** | Colorful `df` — clearer view of mounted disks and free space. | CLI |
| **UpCloud CLI (upctl)** | Manage UpCloud infrastructure from the terminal. | Cloud CLI |
| <img src="https://cdn.simpleicons.org/kubernetes" width="14" alt="" align="center"/> **kubectl** | Kubernetes CLI. Inspect resources, apply manifests, exec into pods. | Cloud CLI |
| **Tilt** | Local Kubernetes dev loop — watch, build, deploy on save. | Cloud tool |
| <img src="https://cdn.simpleicons.org/terraform" width="14" alt="" align="center"/> **Terraform** | Infrastructure-as-code. Installed from HashiCorp's tap (BSL license). | Cloud tool |

### 11. Developer Fonts _(optional)_

*`scripts/11-fonts.sh` — Programming fonts with ligatures and Nerd Font glyphs.*

| Tool | What it is | Kind |
|---|---|---|
| **Fira Code** | Programming font with ligatures (`!==` → `≠`, `=>` → `→`). | Font |
| <img src="https://cdn.simpleicons.org/jetbrains" width="14" alt="" align="center"/> **JetBrains Mono** | Highly legible monospace font with ligatures, by JetBrains. | Font |
| **Source Code Pro** | Adobe's open-source monospace family for code. | Font |
| **Hack Nerd Font** | Hack plus Nerd Font glyphs — required for PowerLevel10k icons. | Font |

### 12. Expo + React Native (full env) _(optional)_

*`scripts/12-expo-rn.sh` — Complete local Expo / React Native env, including iOS toolchain. Superset of scripts 04 + 07 for mobile.*

| Tool | What it is | Kind |
|---|---|---|
| **xcodes** | Manage multiple Xcode versions side by side. | iOS toolchain |
| **ios-deploy** | Deploy and debug iOS apps on physical devices from the command line. | iOS toolchain |
| **CocoaPods** | Dependency manager for iOS/macOS projects. | Package manager |
| <img src="https://cdn.simpleicons.org/swift" width="14" alt="" align="center"/> **SwiftLint** | Linter for Swift code, enforcing style and conventions. | Linter |
| **Maestro** | Mobile UI testing framework. `maestro studio` records flows visually. | Mobile QA |

### 13. macOS System Defaults _(optional)_

*`scripts/13-macos-defaults.sh` — Reversible developer-friendly `defaults write` tweaks.*

| Tool | What it is | Kind |
|---|---|---|
| <img src="https://cdn.simpleicons.org/apple" width="14" alt="" align="center"/> **macOS defaults tweaks** | Fast key repeat, no auto-correct, expanded save panels, show hidden files, Dock autohide, screenshots to ~/Screenshots, etc. Reversible. | System config |

<!-- TOOLS:END:overview -->

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
