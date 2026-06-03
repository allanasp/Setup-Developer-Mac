---
layout: default
title: Complete Tools Guide
description: Comprehensive guide to every tool, language, and framework installed
---

# 🛠️ Complete Tools Guide

> **Everything you need to know about the 100+ tools, languages, and frameworks we install**

This guide provides detailed explanations of every tool included in the setup scripts, helping you understand what each one does and why it's valuable for your development workflow.

## 📋 Quick Navigation

- [System & Foundation Tools](#system--foundation-tools)
- [Terminal & Shell Tools](#terminal--shell-tools)
- [Version Managers](#version-managers)
- [Programming Languages](#programming-languages)
- [Frontend Development](#frontend-development)
- [Development Editors & IDEs](#development-editors--ides)
- [Mobile Development](#mobile-development)
- [Productivity Applications](#productivity-applications)
- [Database Tools](#database-tools)
- [DevOps & Cloud Tools](#devops--cloud-tools)
- [Developer Fonts](#developer-fonts)

---

## System & Foundation Tools

### 🔧 Xcode Command Line Tools
**What it is:** Essential compiler tools and headers for macOS development  
**Why you need it:** Required for compiling code, installing other tools, and using git  
**Key components:** clang, git, make, gcc, swift compiler  
**Size:** ~1.2GB

### 🍺 Homebrew
**What it is:** The missing package manager for macOS  
**Why you need it:** Install, update, and manage thousands of development tools easily  
**Key features:** Simple commands, dependency management, version control  
**Common commands:** `brew install`, `brew upgrade`, `brew search`

### 🔍 System Configuration
**Hidden Files:** Shows hidden files in Finder (like .git, .env files)  
**Why important:** Developers need to see configuration files regularly

---

## Terminal & Shell Tools

### 🖥️ iTerm2
**What it is:** Advanced terminal emulator for macOS  
**Why better than Terminal.app:**
- Split panes and tabs
- Better search functionality
- Customizable hotkeys
- Rich color support
- Built-in paste history

### 🎨 Dracula Theme
**What it is:** Beautiful dark theme with carefully selected colors  
**Benefits:** Reduces eye strain, great contrast, consistent across tools  
**Features:** Syntax highlighting optimized for readability

### 🐚 Oh My Zsh
**What it is:** Framework for managing Zsh configuration  
**Key benefits:**
- 300+ plugins available
- 140+ themes
- Auto-completion
- Git integration
- Easy customization

### ⚡ PowerLevel10k
**What it is:** Fast, flexible Zsh theme  
**Why use it:**
- Shows git status in prompt
- Displays current Python/Node versions
- Execution time for commands
- Current directory shortening
- Customizable segments

### 🔌 Zsh Plugins Installed

#### zsh-autosuggestions
**What it does:** Suggests commands as you type based on history  
**How to use:** Type partial command, press → to accept suggestion  
**Benefit:** Massive time saver for repeated commands

#### zsh-syntax-highlighting
**What it does:** Colors commands as you type  
**Visual cues:** 
- Green = valid command
- Red = command not found
- Underline = valid file path

### 📝 Custom Aliases
**Git shortcuts:**
- `gits` → `git status`
- `gitd` → `git diff`
- `gitl` → `git log`
- `gita` → `git add .`
- `gitc` → `git commit`

**Better commands:**
- `ll` → Detailed file listing
- `la` → Show all files including hidden
- `tree` → Visual directory structure

### 🦊 eza (better ls)
**What it is:** Modern replacement for ls command  
**Improvements:** Colors, git integration, tree view, file icons  
**Why use it:** Much more readable file listings

### 🏃 Warp (Alternative Terminal)
**What it is:** AI-powered terminal with modern UX  
**Key features:**
- Command palette
- AI command suggestions
- Block-based output
- Collaborative features

---

## Version Managers

### 🚀 Volta
**What it is:** Fast, reliable JavaScript tool manager  
**Why use it:**
- Pin Node.js versions per project
- Automatic version switching
- No shell modifications
- Fast installation (Rust-based)
**Manages:** Node.js, npm, pnpm, and any JavaScript CLI tools

### 🐍 pyenv
**What it is:** Python version management tool  
**Why essential:**
- Use multiple Python versions
- Per-project Python versions
- No sudo required
- Virtual environment support
**Pre-installed versions:** 3.9.6, 3.10.13, 3.12.1

### 📦 Package Managers

#### npm
**What it is:** Node Package Manager (comes with Node.js)  
**Used for:** Installing JavaScript packages and tools  
**Registry:** Access to 2+ million packages

#### pnpm (via Volta)
**What it is:** Fast, disk space efficient package manager  
**Key feature:** Uses hard links to save disk space  
**When to use:** Large projects with many dependencies

#### bun (via Homebrew tap oven-sh/bun)
**What it is:** All-in-one JavaScript runtime and package manager  
**Advantages:** Extremely fast installs, built-in bundler, test runner, and runtime  
**When to use:** Greenfield projects and fast local dev workflows

---

## Programming Languages

### ☕ Java (OpenJDK 17)
**What it is:** Popular object-oriented programming language  
**Why included:** Android development, enterprise applications, Spring Boot  
**Key tools:** javac (compiler), java (runtime), jar (archiver)  
**JAVA_HOME:** Automatically configured

### 🐹 Go
**What it is:** Fast, statically typed language by Google  
**Best for:** Microservices, CLI tools, cloud native applications  
**Key features:** Built-in concurrency, fast compilation, simple syntax  
**Popular uses:** Docker, Kubernetes, Terraform are written in Go

### 💎 Ruby
**What it is:** Dynamic, interpreted language  
**Known for:** Ruby on Rails, scripting, DevOps tools  
**Why included:** Many development tools are Ruby-based  
**Package manager:** gem (RubyGems)

### 🟦 TypeScript
**What it is:** JavaScript with static types  
**Why essential:** Type safety, better IDE support, modern JavaScript features  
**Compiles to:** JavaScript  
**Usage:** Frontend frameworks, Node.js backends

### 🐍 Python (via pyenv)
**Versions installed:** 3.9.6, 3.10.13, 3.12.1  
**Why multiple versions:** Different projects require different Python versions  
**Common uses:** Data science, web development, automation, AI/ML

### 📗 Node.js (via Volta)
**What it is:** JavaScript runtime for server-side development  
**LTS version:** Automatically installed (currently 20.x)  
**Includes:** npm, npx for running packages  
**Uses:** Web servers, build tools, CLI applications

---

## Frontend Development

### 🟢 Vue CLI
**What it is:** Standard tooling for Vue.js development  
**Features:** Project scaffolding, dev server, build optimization  
**Creates:** Single Page Applications (SPAs) with Vue.js  
**Command:** `vue create my-app`

### 🟢 Nuxt CLI
**What it is:** Full-stack framework for Vue.js  
**Added features:** Server-side rendering, static site generation, API routes  
**Best for:** SEO-friendly Vue applications  
**Command:** `nuxt init my-app`

### ⚛️ React Native CLI
**What it is:** Build mobile apps using React  
**Targets:** iOS and Android from single codebase  
**Features:** Hot reloading, native module access  
**Command:** `npx react-native init MyApp`

### 🚀 Expo CLI
**What it is:** Framework and platform for React Native  
**Benefits:** Easier setup, OTA updates, managed workflow  
**Includes:** Expo Go app for testing  
**Command:** `npx create-expo-app`

### 📱 EAS CLI
**What it is:** Expo Application Services command line  
**Features:** Build and submit apps to app stores  
**Capabilities:** iOS builds without Mac, automatic submissions  
**Command:** `eas build`, `eas submit`

### ⚡ Vite
**What it is:** Next generation frontend build tool  
**Why fast:** Native ES modules, no bundling in dev  
**Supports:** React, Vue, Svelte, vanilla JS  
**Command:** `npm create vite@latest`

### 🌐 serve
**What it is:** Static file server  
**Use case:** Test production builds locally  
**Features:** HTTPS, CORS, clean URLs  
**Command:** `serve ./dist`

### 🏎️ Turbo (Turborepo)
**What it is:** High-performance build system for JavaScript/TypeScript monorepos  
**Why fast:** Incremental builds, content-aware hashing, remote caching  
**Best for:** Monorepos with multiple apps and packages  
**Installed via:** Volta  
**Command:** `turbo run build`

### ▲ Vercel CLI
**What it is:** Command line for the Vercel deployment platform  
**Features:** Deploy from terminal, manage env vars, pull project config  
**Installed via:** Volta  
**Command:** `vercel`, `vercel deploy`, `vercel env pull`

### 👀 Watchman
**What it is:** File watching service by Facebook  
**Why needed:** React Native uses it for hot reloading  
**Benefits:** Efficient file system monitoring  
**Automatically managed:** Runs in background

### 📝 Storyblok CLI
**What it is:** Headless CMS command line interface  
**Features:** Visual editor, component-based, API-first  
**Use cases:** Marketing sites, content-heavy applications  
**Best for:** Teams with content editors  
**Command:** `storyblok init`

### 🎨 Sanity CLI
**What it is:** Platform for structured content  
**Key features:** Real-time collaboration, powerful query language  
**Studio:** Customizable content management interface  
**Best for:** Complex content models  
**Command:** `sanity init`

---

## Development Editors & IDEs

### 💻 Visual Studio Code
**What it is:** Lightweight but powerful source code editor by Microsoft  
**Why popular:**
- Huge extension marketplace
- Integrated terminal
- Git integration
- IntelliSense
- Debugging support
- Remote development

### 🤖 VS Code Extensions Installed

#### AI Assistants
- **GitHub Copilot:** AI pair programmer, suggests code as you type

#### Language Support
- **Vue - Official:** Vue 3 language support with TypeScript
- **Python:** IntelliSense, linting, debugging for Python
- **Go:** Rich Go language support by Google

#### Git Tools
- **GitLens:** Visualize code authorship, explore repositories
- **GitHub Pull Requests:** Review PRs without leaving VS Code

#### Code Quality
- **ESLint:** JavaScript/TypeScript linting
- **Prettier:** Opinionated code formatter
- **EditorConfig:** Maintain consistent coding styles

#### Productivity
- **Auto Close Tag:** Automatically close HTML/JSX tags
- **Auto Rename Tag:** Rename paired tags
- **Better Comments:** Highlight TODOs, FIXMEs with colors
- **Path Intellisense:** Autocomplete filenames
- **TODO Highlight:** Highlight TODO, FIXME keywords

#### Themes
- **Material Icon Theme:** Beautiful file/folder icons

### 🤖 Cursor
**What it is:** AI-first code editor (VS Code fork)  
**Key features:**
- AI chat in editor
- Code generation
- Refactoring assistance
- Context-aware suggestions
**Best for:** Developers who want deep AI integration

### 🤖 Kiro
**What it is:** AWS agentic IDE for AI-assisted development  
**Key features:**
- Spec-driven, agentic workflows
- AI code generation and refactoring
- Context-aware assistance
**Best for:** Building features with an AI agent in the loop  
**Installed via:** Homebrew cask

### 📝 TextMate
**What it is:** Lightweight macOS text editor  
**Why included:** Quick edits, simple interface  
**Best for:** Configuration files, quick notes

### 🔧 Git & GitHub Tools

#### Git
**Version control:** Track changes, collaborate on code  
**Pre-configured:** Sensible global defaults plus the `git lg` alias for a compact, graphed log  
**Better diffs:** [git-delta](#-git-delta) is wired up as Git's pager for syntax-highlighted diffs

#### git-flow
**What it is:** Git branching model and workflow  
**Branches:** master, develop, feature/*, release/*, hotfix/*  
**Commands:** `git flow init`, `git flow feature start`

#### GitHub CLI (gh)
**What it is:** GitHub's official command line tool  
**Features:**
- Create repos: `gh repo create`
- Manage PRs: `gh pr create`, `gh pr merge`
- Browse issues: `gh issue list`
- GitHub Actions: `gh run list`

#### GitHub Desktop
**What it is:** Visual Git client  
**Best for:** Beginners, visual diff viewing  
**Features:** Branch visualization, conflict resolution

---

## Mobile Development

### 🤖 Android Studio
**What it is:** Official IDE for Android development  
**Based on:** IntelliJ IDEA  
**Includes:**
- Android SDK
- Emulator
- Layout editor
- APK analyzer
- Performance profilers
**Size warning:** ~2-3GB download

### 📱 Android SDK Components
- **Platform Tools:** adb, fastboot
- **Build Tools:** AAPT, dex tools
- **SDK Platforms:** API levels for different Android versions
- **Emulator:** Test apps without physical devices
- **Command Line Tools:** For CI/CD integration

### 🍎 iOS Development Tools

#### xcodes
**What it is:** Manage multiple Xcode versions  
**Why useful:** Different projects need different Xcode versions  
**Features:** Download, install, switch versions easily  
**Command:** `xcodes install 15.0`

#### SwiftLint
**What it is:** Linter for Swift code  
**Purpose:** Enforce Swift style and conventions  
**Integration:** Xcode, command line, CI/CD  
**Rules:** 200+ configurable rules

#### ios-deploy
**What it is:** Install and debug iOS apps from command line  
**Use case:** Deploy to device without Xcode  
**Required for:** React Native iOS development

#### CocoaPods
**What it is:** Dependency manager for iOS  
**Similar to:** npm for JavaScript  
**File:** Podfile defines dependencies  
**Command:** `pod install`

### ☕ Java JDK
**Required for:** Android development  
**Version:** OpenJDK 17  
**JAVA_HOME:** Automatically configured  
**Includes:** javac, java, javadoc, jar

---

## Productivity Applications

### 🪟 Rectangle
**What it is:** Window management app  
**Why essential:** Quickly organize windows with keyboard shortcuts  
**Key shortcuts:**
- `⌘+⌥+←` : Left half
- `⌘+⌥+→` : Right half
- `⌘+⌥+F` : Maximize
- `⌘+⌥+C` : Center
**Pro tip:** Customize shortcuts to your preference


### 📋 Maccy
**What it is:** Clipboard history manager  
**Features:**
- Search clipboard history
- Pin frequent items
- Ignore passwords
- Customizable shortcuts
**Default shortcut:** `⌘+Shift+V`

### 🦊 Firefox Developer Edition
**What it is:** Browser built for developers  
**Special features:**
- Advanced dev tools
- CSS Grid inspector
- Performance tools
- Privacy focused
**Use case:** Cross-browser testing

### 🦁 Brave Browser
**What it is:** Privacy-focused Chromium browser  
**Features:** Built-in ad blocking, Tor mode, crypto wallet  
**For developers:** Test privacy features, PWA development

### 🧪 Mockoon
**What it is:** Local API mock server with a friendly UI  
**Use cases:** Mock REST endpoints, prototype against fake data, test error states  
**Benefit:** Develop the frontend before the backend is ready

### 🛰️ Expo Orbit
**What it is:** Menu bar app for managing Expo and EAS builds  
**Features:** Install and launch builds on simulators/devices, manage updates  
**Best for:** React Native / Expo developers

### 🧰 DevToys
**What it is:** Swiss-army knife of developer utilities  
**Features:** JSON/XML formatters, encoders/decoders, hash generators, regex tester  
**Benefit:** Offline, no need for sketchy web tools

### 💬 Signal
**What it is:** Privacy-focused encrypted messenger  
**Why included:** Secure team communication

### 📶 WiFiman
**What it is:** Network diagnostics and scanning tool  
**Features:** Speed tests, device discovery, signal analysis  
**Use case:** Debug local network and connectivity issues

---

## Database Tools

### 🐘 PostgreSQL 15
**What it is:** Advanced open-source relational database  
**Why PostgreSQL:**
- ACID compliant
- JSON support
- Full-text search
- Extensions (PostGIS, etc.)
- Great performance
**Auto-configured:** Starts on boot, PATH updated

### 🖥️ DBeaver Community Edition
**What it is:** Universal database GUI client  
**Features:**
- Query editor with syntax highlighting
- Visual query builder
- Data export/import tools
- SSH tunneling support
- Multiple database support (PostgreSQL, MySQL, SQLite, etc.)
**Benefits:** Free, cross-platform, extensive database support

### 🐘 pgAdmin 4
**What it is:** Feature-rich management and admin tool for PostgreSQL  
**Features:**
- Visual query tool with explain plans
- Schema and object browser
- Server and database administration
- Backup/restore management
**Benefit:** Purpose-built for PostgreSQL workflows

### ⚡ Supabase CLI
**What it is:** Open source Firebase alternative  
**Built on:** PostgreSQL + real-time subscriptions  
**Features:**
- Authentication
- Real-time database
- Storage
- Edge functions
**Local development:** `supabase start` runs full stack locally  
**Commands:** `supabase init`, `supabase db push`

---

## DevOps & Cloud Tools


### ☁️ UpCloud CLI (upctl)
**What it is:** Command line interface for the UpCloud cloud platform  
**Primary use:** Manage servers, storage, networks, and load balancers  
**Features:** Scriptable provisioning, multiple output formats  
**Command:** `upctl server list`, `upctl server create`

### ☸️ kubectl (kubernetes-cli)
**What it is:** Command line tool for controlling Kubernetes clusters  
**Use cases:** Deploy apps, inspect resources, manage cluster state  
**Command:** `kubectl get pods`, `kubectl apply -f`

### 🔼 Tilt
**What it is:** Toolkit for fast local development on Kubernetes  
**Features:** Live updates, automatic rebuilds, a unified dev dashboard  
**Best for:** Iterating on microservices locally  
**Command:** `tilt up`

### 🏗️ Terraform (hashicorp/tap)
**What it is:** Infrastructure as Code tool by HashiCorp  
**Use cases:** Provision and manage cloud infrastructure declaratively  
**Features:** Plan/apply workflow, state management, huge provider ecosystem  
**Command:** `terraform init`, `terraform plan`, `terraform apply`

### 🐳 OrbStack
**What it is:** Fast, light Docker Desktop alternative  
**Advantages:**
- 70% less CPU usage
- 50% less memory
- Native macOS integration
- Instant startup
**Compatibility:** Works with all Docker commands

### 🌐 Network & Utility Tools

#### ngrok
**What it is:** Expose local servers to the internet  
**Use cases:**
- Webhook development
- Demo local sites to clients
- Mobile app testing with real devices
- API testing with external services
**Security:** HTTPS by default, authentication available  
**Command:** `ngrok http 3000`
**Perfect for:** Sharing local development servers

#### wget
**What it is:** Non-interactive network downloader  
**vs curl:** Better for recursive downloads, resuming  
**Common uses:** Download files, mirror websites

#### jq
**What it is:** Command-line JSON processor  
**Why essential:** Parse API responses, filter JSON data, work with REST APIs  
**Example:** `curl api.example.com | jq '.data[]'`
**Perfect for:** Frontend developers working with APIs

#### tree
**What it is:** Display directory structure as tree  
**Options:** Limit depth, show hidden files, sizes  
**Usage:** `tree -L 2` shows 2 levels deep

#### fzf
**What it is:** Fuzzy finder for command line  
**Integration:** History search (Ctrl+R), file finding, interactive selection  
**Power user tip:** Pipe any list to fzf for interactive selection
**Productivity boost:** Find files and commands instantly

#### Wireshark
**What it is:** Network protocol analyzer  
**Use cases:** Debug API calls, analyze network issues  
**Features:** Packet capture, protocol dissection, filters

### ⚡ Modern CLI Power-Ups

These faster, friendlier replacements and shell enhancements are installed by `10-devops.sh`. The fzf shell integration (Ctrl+R history search, Ctrl+T file finder) is wired up automatically.

#### 🔺 git-delta
**What it is:** A syntax-highlighting pager for git and diff output  
**Why use it:** Side-by-side views, line numbers, and readable highlighting  
**Configured as:** Git's default pager

#### 🔎 ripgrep (rg)
**What it is:** Extremely fast recursive search tool  
**Why use it:** Faster than grep, respects `.gitignore` by default  
**Command:** `rg "pattern"`

#### 📁 fd
**What it is:** Simple, fast alternative to `find`  
**Why use it:** Intuitive syntax, smart defaults, respects `.gitignore`  
**Command:** `fd pattern`

#### 🦇 bat
**What it is:** A `cat` clone with syntax highlighting and Git integration  
**Why use it:** Readable file previews with line numbers  
**Command:** `bat file.ts`

#### 🧭 zoxide
**What it is:** Smarter `cd` that learns your most-used directories  
**Why use it:** Jump to directories by partial name  
**Command:** `z projectname`

#### 🌿 lazygit
**What it is:** Terminal UI for Git  
**Why use it:** Stage, commit, branch, and rebase visually without leaving the terminal  
**Command:** `lazygit`

#### 🧩 direnv
**What it is:** Loads and unloads environment variables per directory  
**Why use it:** Automatic per-project env setup via `.envrc`  
**Command:** `direnv allow`

#### 🕰️ atuin
**What it is:** Magical, searchable shell history  
**Why use it:** Synced, context-aware history with full-text search  
**Command:** Replaces Ctrl+R history search

#### 📖 tldr (tealdeer)
**What it is:** Community-driven simplified man pages with practical examples  
**Why use it:** Quick, example-first command help  
**Command:** `tldr tar`

#### 📊 btop
**What it is:** Resource monitor for CPU, memory, disk, network, and processes  
**Why use it:** A beautiful, modern alternative to `top`/`htop`  
**Command:** `btop`

#### 💾 dust
**What it is:** More intuitive `du` for disk usage  
**Why use it:** Instantly see what's eating disk space, sorted and visualized  
**Command:** `dust`

#### 🧮 duf
**What it is:** A better `df` for free/used disk space  
**Why use it:** Clean, colorized overview of mounts and filesystems  
**Command:** `duf`

---

## Developer Fonts

### 🔤 Fira Code
**What it is:** Monospaced font with programming ligatures  
**Ligatures examples:**
- `!=` becomes `≠`
- `=>` becomes `⇒`
- `===` becomes single connected symbol
**Why use:** Easier to scan code, beautiful appearance

### ⚡ JetBrains Mono
**What it is:** Font designed for developers by JetBrains  
**Features:**
- Increased letter height
- Better readability
- 139 code-specific ligatures
- Multiple weights
**Optimized for:** Long coding sessions

### 🎨 Why Developer Fonts Matter
- **Reduced eye strain:** Optimized letter spacing
- **Better readability:** Distinct characters (0 vs O, 1 vs l)
- **Ligatures:** Multi-character symbols look cleaner
- **Consistency:** Same width for all characters

---

## 🎯 Tool Selection by Role

### Frontend Developer Essentials
- **Editors:** VS Code with extensions
- **Languages:** TypeScript, Node.js
- **Frameworks:** Vue/React tools
- **Build tools:** Vite, Webpack
- **Version control:** Git, GitHub CLI

### Backend Developer Essentials
- **Languages:** Go, Java, Python, Ruby
- **Databases:** PostgreSQL, DBeaver, pgAdmin 4
- **API tools:** Postman, curl, jq
- **Cloud:** UpCloud CLI (upctl)
- **Containers:** OrbStack/Docker

### Mobile Developer Essentials
- **IDEs:** Android Studio, Xcode
- **Frameworks:** React Native, Expo
- **Languages:** TypeScript, Java/Kotlin, Swift
- **Tools:** Watchman, CocoaPods
- **Testing:** Device emulators/simulators

### DevOps Engineer Essentials
- **Orchestration:** kubectl, Tilt
- **Cloud:** UpCloud CLI (upctl)
- **Containers:** OrbStack
- **Scripting:** Python, Go
- **Monitoring:** Wireshark
- **Infrastructure:** Terraform

### Full Stack Developer Essentials
- **Everything above** in moderation
- **Focus on:** VS Code, Git, Docker, one backend language, one frontend framework

---

## 🔧 Making the Most of Your Tools

### Daily Workflow Optimization
1. **Rectangle shortcuts** for window management
2. **Maccy** for clipboard history (⌘+Shift+V)
3. **Terminal aliases** for common commands
4. **VS Code snippets** for boilerplate code

### Performance Tips
- **Volta** auto-switches Node versions
- **pyenv** manages Python versions per project
- **OrbStack** uses less resources than Docker Desktop
- **eza** is faster than ls for large directories
- **fzf** speeds up file/history searching

### Learning Resources
- Run `tldr <command>` for quick examples (install: `npm install -g tldr`)
- Use `man <command>` for detailed documentation
- VS Code: Cmd+Shift+P opens command palette
- Most tools have `--help` flag

---

## 📊 Storage Requirements

**Minimum required:** ~10GB free space  
**Recommended:** 20GB+ free space

**Largest components:**
- Xcode Command Line Tools: ~1.2GB
- Android Studio: ~2-3GB
- PostgreSQL: ~200MB
- Node.js versions: ~100MB each
- Python versions: ~150MB each
- VS Code + extensions: ~500MB

---

**[← Back to Home](index.html)** | **[Script Guide →](script-guide.html)** | **[GitHub Repository →](https://github.com/allanasp/Setup-Developer-Mac)**

---

<div style="text-align: center; margin: 2rem 0; padding: 2rem; background: #f6f8fa; border-radius: 8px;">
  <h3>🚀 Ready to Install These Amazing Tools?</h3>
  <p style="color: #586069; margin: 1rem 0;">Choose exactly what you need with our modular setup</p>
  <p>
    <a href="https://github.com/allanasp/Setup-Developer-Mac" style="display: inline-block; background: #28a745; color: white; padding: 12px 24px; border-radius: 6px; text-decoration: none; font-weight: bold;">Get Started Now</a>
  </p>
</div>