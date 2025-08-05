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
**Manages:** Node.js, npm, Yarn, and any JavaScript CLI tools

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

#### Yarn Berry
**What it is:** Fast, reliable JavaScript package manager by Facebook  
**Advantages:** Faster installs, better monorepo support, Plug'n'Play mode

#### pnpm
**What it is:** Fast, disk space efficient package manager  
**Key feature:** Uses hard links to save disk space  
**When to use:** Large projects with many dependencies

---

## Programming Languages

### ☕ Java (OpenJDK 21)
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
- **AWS Toolkit:** Includes Amazon Q AI assistant for AWS development

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

### ⚡ Zed
**What it is:** High-performance, multiplayer code editor  
**Built with:** Rust for maximum speed  
**Unique features:** Real-time collaboration, minimal UI  
**Best for:** Performance-critical editing, pair programming

### 📝 TextMate
**What it is:** Lightweight macOS text editor  
**Why included:** Quick edits, simple interface  
**Best for:** Configuration files, quick notes

### 🔧 Git & GitHub Tools

#### Git
**Version control:** Track changes, collaborate on code  
**Pre-configured:** Better defaults and aliases

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
**Version:** OpenJDK 21  
**JAVA_HOME:** Automatically configured  
**Includes:** javac, java, javadoc, jar

---

## Productivity Applications

### 🔍 Raycast
**What it is:** Supercharged Spotlight replacement  
**Key features:**
- Extensible with plugins
- Window management
- Clipboard history
- Snippets
- Quick calculations
- System commands
**Recommended extensions:** GitHub, Linear, Notion, Homebrew

### 🪟 Rectangle
**What it is:** Window management app  
**Why essential:** Quickly organize windows with keyboard shortcuts  
**Key shortcuts:**
- `⌘+⌥+←` : Left half
- `⌘+⌥+→` : Right half
- `⌘+⌥+F` : Maximize
- `⌘+⌥+C` : Center
**Pro tip:** Customize shortcuts to your preference

### 🔐 1Password
**What it is:** Password manager and secure vault  
**Developer features:**
- SSH key management
- Environment secrets
- API credentials
- 2FA codes
- Secure notes
**Integration:** Browser extensions, CLI tool

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

### 🖥️ Sequel Ace
**What it is:** MySQL/MariaDB/PostgreSQL GUI  
**Features:**
- Query editor
- Table designer
- Import/export
- SSH tunneling
- Multiple connections
**Replaces:** Sequel Pro (discontinued)

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

### ☸️ Kubernetes Tools Suite

#### kubectl
**What it is:** Kubernetes command-line tool  
**Purpose:** Deploy applications, inspect resources, view logs  
**Common commands:**
- `kubectl get pods`
- `kubectl apply -f`
- `kubectl logs`
- `kubectl exec`

#### Helm
**What it is:** Kubernetes package manager  
**Purpose:** Deploy complex applications with one command  
**Concepts:** Charts (packages), releases, repositories  
**Usage:** `helm install myapp ./chart`

#### kops
**What it is:** Kubernetes Operations  
**Purpose:** Production-grade Kubernetes cluster provisioning  
**Supports:** AWS (official), GCE, OpenStack  
**Features:** Rolling updates, multi-zone

#### kubectx
**What it is:** Switch between Kubernetes contexts (clusters)  
**Why useful:** Work with multiple clusters easily  
**Command:** `kubectx` lists contexts, `kubectx prod` switches

#### kubens
**What it is:** Switch between Kubernetes namespaces  
**Companion to:** kubectx  
**Usage:** `kubens` lists namespaces, `kubens backend` switches

### ☁️ AWS CLI
**What it is:** Amazon Web Services command line interface  
**Capabilities:** Manage all AWS services from terminal  
**Features:** Profiles, MFA support, output formats  
**Common uses:** S3 operations, EC2 management, Lambda deployment  
**Configuration:** `aws configure` sets up credentials

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
- Demo local sites
- Mobile app testing
- API testing
**Security:** HTTPS by default, authentication available  
**Command:** `ngrok http 3000`

#### wget
**What it is:** Non-interactive network downloader  
**vs curl:** Better for recursive downloads, resuming  
**Common uses:** Download files, mirror websites

#### jq
**What it is:** Command-line JSON processor  
**Why essential:** Parse API responses, filter JSON data  
**Example:** `curl api.example.com | jq '.data[]'`

#### tree
**What it is:** Display directory structure as tree  
**Options:** Limit depth, show hidden files, sizes  
**Usage:** `tree -L 2` shows 2 levels deep

#### fzf
**What it is:** Fuzzy finder for command line  
**Integration:** History search (Ctrl+R), file finding  
**Power user tip:** Pipe any list to fzf for interactive selection

#### Wireshark
**What it is:** Network protocol analyzer  
**Use cases:** Debug API calls, analyze network issues  
**Features:** Packet capture, protocol dissection, filters

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
- **Databases:** PostgreSQL, Sequel Ace
- **API tools:** Postman, curl, jq
- **Cloud:** AWS CLI
- **Containers:** OrbStack/Docker

### Mobile Developer Essentials
- **IDEs:** Android Studio, Xcode
- **Frameworks:** React Native, Expo
- **Languages:** TypeScript, Java/Kotlin, Swift
- **Tools:** Watchman, CocoaPods
- **Testing:** Device emulators/simulators

### DevOps Engineer Essentials
- **Orchestration:** Kubernetes suite
- **Cloud:** AWS CLI
- **Containers:** OrbStack
- **Scripting:** Python, Go
- **Monitoring:** Wireshark
- **Infrastructure:** Terraform (add manually)

### Full Stack Developer Essentials
- **Everything above** in moderation
- **Focus on:** VS Code, Git, Docker, one backend language, one frontend framework

---

## 🔧 Making the Most of Your Tools

### Daily Workflow Optimization
1. **Use Raycast** instead of Spotlight (⌘+Space)
2. **Rectangle shortcuts** for window management
3. **Maccy** for clipboard history (⌘+Shift+V)
4. **Terminal aliases** for common commands
5. **VS Code snippets** for boilerplate code

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