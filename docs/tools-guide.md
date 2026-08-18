---
title: Complete Tools Guide
description: Comprehensive guide to every tool, language, and framework installed
---

# Complete Tools Guide

> **Everything you need to know about the 90+ tools, languages, and frameworks we install**

This guide is generated from [`data/tools.json`](https://github.com/allanasp/Setup-Developer-Mac/blob/main/data/tools.json),
the single source of truth for what the setup installs. Each tool lists its **category**
(which script installs it, and whether that script is essential or optional), the **kind**
of tool it is, and a short description of what it does.

To update entries, edit `data/tools.json` and run `scripts/lib/generate-docs.sh` —
both this page and the README catalogue are regenerated together.

---

<!-- TOOLS:BEGIN:catalogue -->
## System Foundation

> **Category:** Essential — installed by `scripts/01-system.sh`. Bootstraps the toolchain everything else builds on.

### <img src="https://cdn.simpleicons.org/xcode" width="14" alt="" align="center"/> Xcode Command Line Tools

**Kind:** Compiler toolchain  
**What it is:** Apple's compiler suite (clang, git, make, swift). Required by Homebrew and most other tools.  
**Homepage:** [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/)

### <img src="https://cdn.simpleicons.org/homebrew" width="14" alt="" align="center"/> Homebrew

**Kind:** Package manager  
**What it is:** The missing package manager for macOS. Every later script builds on `brew`.  
**Homepage:** [https://brew.sh](https://brew.sh)

## Terminal & Shell

> **Category:** Essential — installed by `scripts/02-terminal.sh`. Modern terminals plus a productive Zsh setup.

### <img src="https://cdn.simpleicons.org/iterm2" width="14" alt="" align="center"/> iTerm2

**Kind:** Terminal  
**What it is:** Advanced terminal emulator with split panes, search, paste history. Dracula theme is preconfigured.  
**Homepage:** [https://iterm2.com](https://iterm2.com)

### <img src="https://cdn.simpleicons.org/warp" width="14" alt="" align="center"/> Warp

**Kind:** Terminal  
**What it is:** Modern AI-powered terminal with block-based output and command palette.  
**Homepage:** [https://warp.dev](https://warp.dev)

### <img src="https://cdn.simpleicons.org/ohmyzsh" width="14" alt="" align="center"/> Oh My Zsh

**Kind:** Shell framework  
**What it is:** Framework for managing Zsh config — plugins, themes, completions.  
**Homepage:** [https://ohmyz.sh](https://ohmyz.sh)

### PowerLevel10k

**Kind:** Shell theme  
**What it is:** Extremely fast Zsh prompt theme. Shows git status, runtime info, language versions.  
**Homepage:** [https://github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)

### Dracula Theme

**Kind:** Color scheme  
**What it is:** Dark color scheme for iTerm2 + PowerLevel10k. High contrast, low eye strain.  
**Homepage:** [https://draculatheme.com](https://draculatheme.com)

### zsh-autosuggestions

**Kind:** Shell plugin  
**What it is:** Suggests commands as you type, based on history. Right-arrow to accept.  
**Homepage:** [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

### zsh-syntax-highlighting

**Kind:** Shell plugin  
**What it is:** Colors commands as you type — green for valid, red for typos.  
**Homepage:** [https://github.com/zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## Version Managers & Runtimes

> **Category:** Essential — installed by `scripts/03-version-managers.sh`. Per-project Node and Python versions, plus Bun.

### Volta

**Kind:** Version manager  
**What it is:** Fast Rust-based Node.js version manager. Pins versions per project automatically.  
**Homepage:** [https://volta.sh](https://volta.sh)

### <img src="https://cdn.simpleicons.org/python" width="14" alt="" align="center"/> pyenv

**Kind:** Version manager  
**What it is:** Python version manager. Multiple versions side by side, per-project pinning.  
**Homepage:** [https://github.com/pyenv/pyenv](https://github.com/pyenv/pyenv)

### <img src="https://cdn.simpleicons.org/nodedotjs" width="14" alt="" align="center"/> Node.js (LTS)

**Kind:** Runtime  
**What it is:** JavaScript runtime. Installed at the LTS version via Volta.  
**Homepage:** [https://nodejs.org](https://nodejs.org)

### <img src="https://cdn.simpleicons.org/pnpm" width="14" alt="" align="center"/> pnpm

**Kind:** Package manager  
**What it is:** Fast, disk-efficient package manager. Default in this setup over npm/yarn.  
**Homepage:** [https://pnpm.io](https://pnpm.io)

### <img src="https://cdn.simpleicons.org/bun" width="14" alt="" align="center"/> Bun

**Kind:** Runtime  
**What it is:** All-in-one JS runtime, bundler, test runner, package manager. Installed via its own Homebrew tap.  
**Homepage:** [https://bun.sh](https://bun.sh)

## Programming Languages

> **Category:** Optional — installed by `scripts/04-languages.sh`. Standalone language runtimes for full-stack and mobile work.

### <img src="https://cdn.simpleicons.org/openjdk" width="14" alt="" align="center"/> OpenJDK 17

**Kind:** Language runtime  
**What it is:** Java 17 runtime. Required by Gradle for Android/React Native builds.  
**Homepage:** [https://openjdk.org](https://openjdk.org)

### <img src="https://cdn.simpleicons.org/go" width="14" alt="" align="center"/> Go

**Kind:** Language  
**What it is:** Statically-typed language by Google. Used by Docker, Kubernetes, Terraform internally.  
**Homepage:** [https://go.dev](https://go.dev)

### <img src="https://cdn.simpleicons.org/ruby" width="14" alt="" align="center"/> Ruby

**Kind:** Language  
**What it is:** Dynamic interpreted language. Required by CocoaPods and many DevOps tools.  
**Homepage:** [https://www.ruby-lang.org](https://www.ruby-lang.org)

## Frontend & Mobile CLIs

> **Category:** Optional — installed by `scripts/05-frontend.sh`. The heart of the setup — global CLIs for the modern JS ecosystem.

### <img src="https://cdn.simpleicons.org/vuedotjs" width="14" alt="" align="center"/> Vue CLI

**Kind:** Frontend CLI  
**What it is:** Scaffolding and tooling for Vue.js projects.  
**Homepage:** [https://cli.vuejs.org](https://cli.vuejs.org)

### <img src="https://cdn.simpleicons.org/nuxtdotjs" width="14" alt="" align="center"/> Nuxt CLI

**Kind:** Frontend CLI  
**What it is:** Scaffolding and dev tools for Nuxt 3+ apps.  
**Homepage:** [https://nuxt.com](https://nuxt.com)

### <img src="https://cdn.simpleicons.org/typescript" width="14" alt="" align="center"/> TypeScript

**Kind:** Language  
**What it is:** Typed superset of JavaScript. Installed globally.  
**Homepage:** [https://www.typescriptlang.org](https://www.typescriptlang.org)

### <img src="https://cdn.simpleicons.org/vite" width="14" alt="" align="center"/> create-vite

**Kind:** Scaffolder  
**What it is:** Project scaffold for Vite — fast dev server and bundler.  
**Homepage:** [https://vitejs.dev](https://vitejs.dev)

### serve

**Kind:** CLI  
**What it is:** Quick static-file server for testing built sites locally.  
**Homepage:** [https://github.com/vercel/serve](https://github.com/vercel/serve)

### <img src="https://cdn.simpleicons.org/turborepo" width="14" alt="" align="center"/> Turborepo

**Kind:** Monorepo tool  
**What it is:** Incremental bundler/build system for JS monorepos.  
**Homepage:** [https://turbo.build](https://turbo.build)

### <img src="https://cdn.simpleicons.org/vercel" width="14" alt="" align="center"/> Vercel CLI

**Kind:** Deploy CLI  
**What it is:** Deploy Next.js / Nuxt / static sites to Vercel from the terminal.  
**Homepage:** [https://vercel.com/cli](https://vercel.com/cli)

### <img src="https://cdn.simpleicons.org/storyblok" width="14" alt="" align="center"/> Storyblok CLI

**Kind:** CMS CLI  
**What it is:** Manage Storyblok headless-CMS spaces and components.  
**Homepage:** [https://www.storyblok.com](https://www.storyblok.com)

### <img src="https://cdn.simpleicons.org/sanity" width="14" alt="" align="center"/> Sanity CLI

**Kind:** CMS CLI  
**What it is:** Scaffold and manage Sanity Studio projects.  
**Homepage:** [https://www.sanity.io](https://www.sanity.io)

### <img src="https://cdn.simpleicons.org/react" width="14" alt="" align="center"/> React Native CLI

**Kind:** Mobile CLI  
**What it is:** Bare React Native projects (without Expo).  
**Homepage:** [https://reactnative.dev](https://reactnative.dev)

### <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> Expo CLI

**Kind:** Mobile CLI  
**What it is:** Run, build, and debug Expo React Native apps.  
**Homepage:** [https://expo.dev](https://expo.dev)

### <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> EAS CLI

**Kind:** Mobile CLI  
**What it is:** Expo Application Services — cloud builds, submits, OTA updates.  
**Homepage:** [https://expo.dev/eas](https://expo.dev/eas)

### <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> create-expo-app

**Kind:** Scaffolder  
**What it is:** Scaffolder for new Expo projects.  
**Homepage:** [https://docs.expo.dev](https://docs.expo.dev)

### Watchman

**Kind:** Dev daemon  
**What it is:** File-watching daemon by Meta. Required by React Native/Metro for fast rebuilds.  
**Homepage:** [https://facebook.github.io/watchman/](https://facebook.github.io/watchman/)

## Editors & Git Tools

> **Category:** Optional — installed by `scripts/06-dev-apps.sh`. Editors, AI coding agents, Git tooling.

### <img src="https://cdn.simpleicons.org/git" width="14" alt="" align="center"/> Git

**Kind:** VCS  
**What it is:** Version control. Reinstalled via Homebrew with sane global defaults.  
**Homepage:** [https://git-scm.com](https://git-scm.com)

### Git Flow (AVH)

**Kind:** Git extension  
**What it is:** Git Flow branching model commands. AVH is the maintained fork.  
**Homepage:** [https://github.com/petervanderdoes/gitflow-avh](https://github.com/petervanderdoes/gitflow-avh)

### <img src="https://cdn.simpleicons.org/github" width="14" alt="" align="center"/> GitHub CLI (gh)

**Kind:** CLI  
**What it is:** PRs, issues, and releases from the terminal.  
**Homepage:** [https://cli.github.com](https://cli.github.com)

### <img src="https://cdn.simpleicons.org/github" width="14" alt="" align="center"/> GitHub Desktop

**Kind:** GUI app  
**What it is:** GUI Git client tightly integrated with GitHub.  
**Homepage:** [https://desktop.github.com](https://desktop.github.com)

### Visual Studio Code

**Kind:** Editor  
**What it is:** Microsoft's editor. Installed with a curated 20+ extension pack.  
**Homepage:** [https://code.visualstudio.com](https://code.visualstudio.com)

### <img src="https://cdn.simpleicons.org/cursor" width="14" alt="" align="center"/> Cursor

**Kind:** Editor  
**What it is:** AI-first fork of VS Code with built-in chat and code edits.  
**Homepage:** [https://cursor.sh](https://cursor.sh)

### TextMate

**Kind:** Editor  
**What it is:** Lightweight macOS editor — handy for quick edits outside the main editor.  
**Homepage:** [https://macromates.com](https://macromates.com)

### <img src="https://cdn.simpleicons.org/anthropic" width="14" alt="" align="center"/> Claude Code

**Kind:** AI agent  
**What it is:** Anthropic's terminal coding agent.  
**Homepage:** [https://www.anthropic.com/claude-code](https://www.anthropic.com/claude-code)

### kiro-cli

**Kind:** AI agent  
**What it is:** AWS agentic coding CLI. Installed via the official kiro install script.  
**Homepage:** [https://kiro.dev](https://kiro.dev)

### OpenCode

**Kind:** AI agent  
**What it is:** Open-source terminal coding agent (via sst/tap).  
**Homepage:** [https://opencode.ai](https://opencode.ai)

## Mobile (Android)

> **Category:** Optional — installed by `scripts/07-mobile.sh`. Android Studio + environment. Full RN/iOS env lives in script 12.

### <img src="https://cdn.simpleicons.org/androidstudio" width="14" alt="" align="center"/> Android Studio

**Kind:** IDE  
**What it is:** Official IDE for Android. Sets `ANDROID_HOME` + PATH for SDK tools.  
**Homepage:** [https://developer.android.com/studio](https://developer.android.com/studio)

## Productivity & Utilities

> **Category:** Optional — installed by `scripts/08-productivity.sh`. Window mgmt, browsers, API tools, and other day-to-day apps.

### Rectangle

**Kind:** GUI app  
**What it is:** Keyboard-driven window snapping (halves, quarters, thirds).  
**Homepage:** [https://rectangleapp.com](https://rectangleapp.com)

### Maccy

**Kind:** GUI app  
**What it is:** Clipboard history manager. Trigger with a hotkey, fuzzy-search past copies.  
**Homepage:** [https://maccy.app](https://maccy.app)

### <img src="https://cdn.simpleicons.org/obsidian" width="14" alt="" align="center"/> Obsidian

**Kind:** GUI app  
**What it is:** Markdown-based notes with linked references and a graph view.  
**Homepage:** [https://obsidian.md](https://obsidian.md)

### <img src="https://cdn.simpleicons.org/1password" width="14" alt="" align="center"/> 1Password CLI

**Kind:** CLI  
**What it is:** Read secrets from 1Password in scripts and shells.  
**Homepage:** [https://developer.1password.com/docs/cli](https://developer.1password.com/docs/cli)

### <img src="https://cdn.simpleicons.org/googlechrome" width="14" alt="" align="center"/> Google Chrome

**Kind:** Browser  
**What it is:** Reference browser for testing and DevTools work.  
**Homepage:** [https://www.google.com/chrome/](https://www.google.com/chrome/)

### <img src="https://cdn.simpleicons.org/firefox" width="14" alt="" align="center"/> Firefox

**Kind:** Browser  
**What it is:** Second engine to test against — different rendering and DevTools.  
**Homepage:** [https://www.mozilla.org/firefox/](https://www.mozilla.org/firefox/)

### <img src="https://cdn.simpleicons.org/brave" width="14" alt="" align="center"/> Brave Browser

**Kind:** Browser  
**What it is:** Chromium-based browser with built-in tracker/ad blocking.  
**Homepage:** [https://brave.com](https://brave.com)

### OrbStack

**Kind:** Container runtime  
**What it is:** Lightweight Docker / Linux VM alternative to Docker Desktop.  
**Homepage:** [https://orbstack.dev](https://orbstack.dev)

### <img src="https://cdn.simpleicons.org/postman" width="14" alt="" align="center"/> Postman

**Kind:** API tool  
**What it is:** API client for designing, testing, and documenting HTTP requests.  
**Homepage:** [https://www.postman.com](https://www.postman.com)

### Mockoon

**Kind:** API tool  
**What it is:** Local mock API server. Spin up fake REST endpoints in seconds.  
**Homepage:** [https://mockoon.com](https://mockoon.com)

### <img src="https://cdn.simpleicons.org/expo" width="14" alt="" align="center"/> Expo Orbit

**Kind:** GUI app  
**What it is:** Menubar launcher for Expo dev builds and iOS/Android simulators.  
**Homepage:** [https://expo.dev/orbit](https://expo.dev/orbit)

### <img src="https://cdn.simpleicons.org/figma" width="14" alt="" align="center"/> Figma

**Kind:** Design tool  
**What it is:** Design and prototyping tool. Desktop app gives Sign In + local fonts.  
**Homepage:** [https://figma.com](https://figma.com)

### ImageOptim

**Kind:** GUI app  
**What it is:** Drag-and-drop lossless image compression (PNG/JPEG/SVG).  
**Homepage:** [https://imageoptim.com/mac](https://imageoptim.com/mac)

### <img src="https://cdn.simpleicons.org/wireguard" width="14" alt="" align="center"/> WireGuard

**Kind:** Network tool  
**What it is:** Modern fast VPN client.  
**Homepage:** [https://www.wireguard.com](https://www.wireguard.com)

### DevToys

**Kind:** GUI app  
**What it is:** Swiss-army knife of small dev utilities (JSON formatter, hash, regex, base64…).  
**Homepage:** [https://devtoys.app](https://devtoys.app)

### <img src="https://cdn.simpleicons.org/signal" width="14" alt="" align="center"/> Signal

**Kind:** Messenger  
**What it is:** End-to-end encrypted messenger.  
**Homepage:** [https://signal.org](https://signal.org)

### WiFiman

**Kind:** Network tool  
**What it is:** Wi-Fi analyzer + speed test from Ubiquiti.  
**Homepage:** [https://wifiman.com](https://wifiman.com)

### AppCleaner

**Kind:** GUI app  
**What it is:** Properly uninstall macOS apps, including their support files.  
**Homepage:** [https://freemacsoft.net/appcleaner/](https://freemacsoft.net/appcleaner/)

### Ice

**Kind:** GUI app  
**What it is:** Menubar organizer — hide and group items in the macOS menubar.  
**Homepage:** [https://github.com/jordanbaird/Ice](https://github.com/jordanbaird/Ice)

### <img src="https://cdn.simpleicons.org/syncthing" width="14" alt="" align="center"/> Syncthing

**Kind:** GUI app  
**What it is:** Peer-to-peer file sync across your own devices.  
**Homepage:** [https://syncthing.net](https://syncthing.net)

### <img src="https://cdn.simpleicons.org/wireshark" width="14" alt="" align="center"/> Wireshark

**Kind:** Network tool  
**What it is:** Packet analyzer for deep network debugging.  
**Homepage:** [https://www.wireshark.org](https://www.wireshark.org)

## Databases

> **Category:** Optional — installed by `scripts/09-database.sh`. PostgreSQL plus GUI clients and Supabase tooling.

### <img src="https://cdn.simpleicons.org/postgresql" width="14" alt="" align="center"/> PostgreSQL 15

**Kind:** Database  
**What it is:** Relational database server. PATH wired via `~/.zshenv`.  
**Homepage:** [https://www.postgresql.org](https://www.postgresql.org)

### <img src="https://cdn.simpleicons.org/dbeaver" width="14" alt="" align="center"/> DBeaver Community Edition

**Kind:** Database GUI  
**What it is:** Cross-platform SQL GUI for Postgres, MySQL, SQLite, and many more.  
**Homepage:** [https://dbeaver.io](https://dbeaver.io)

### pgAdmin 4

**Kind:** Database GUI  
**What it is:** Official Postgres GUI — better for Postgres-specific features.  
**Homepage:** [https://www.pgadmin.org](https://www.pgadmin.org)

### <img src="https://cdn.simpleicons.org/supabase" width="14" alt="" align="center"/> Supabase CLI

**Kind:** DB CLI  
**What it is:** Run Supabase locally, push migrations, manage projects.  
**Homepage:** [https://supabase.com/docs/guides/cli](https://supabase.com/docs/guides/cli)

## DevOps & CLI Power-ups

> **Category:** Optional — installed by `scripts/10-devops.sh`. Modern CLI replacements + infrastructure tooling.

### <img src="https://cdn.simpleicons.org/ngrok" width="14" alt="" align="center"/> ngrok

**Kind:** Tunneling  
**What it is:** Public HTTPS tunnel to a local port — share dev servers and webhooks.  
**Homepage:** [https://ngrok.com](https://ngrok.com)

### eza

**Kind:** CLI  
**What it is:** Modern `ls` replacement with colors, icons, and git status.  
**Homepage:** [https://eza.rocks](https://eza.rocks)

### wget

**Kind:** CLI  
**What it is:** Recursive HTTP/FTP downloader. Better than `curl` for whole-site mirrors.  
**Homepage:** [https://www.gnu.org/software/wget/](https://www.gnu.org/software/wget/)

### jq

**Kind:** CLI  
**What it is:** Command-line JSON processor. Filter, transform, query JSON in pipelines.  
**Homepage:** [https://jqlang.github.io/jq/](https://jqlang.github.io/jq/)

### tree

**Kind:** CLI  
**What it is:** Visualize directory structures as a tree.  
**Homepage:** [https://github.com/Old-Man-Programmer/tree](https://github.com/Old-Man-Programmer/tree)

### fzf

**Kind:** CLI  
**What it is:** Fuzzy finder. Bound to Ctrl-T (files) and Alt-C (cd) in your shell.  
**Homepage:** [https://github.com/junegunn/fzf](https://github.com/junegunn/fzf)

### ripgrep (rg)

**Kind:** CLI  
**What it is:** Extremely fast recursive grep. Respects `.gitignore` by default.  
**Homepage:** [https://github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)

### fd

**Kind:** CLI  
**What it is:** Friendly, fast `find` replacement.  
**Homepage:** [https://github.com/sharkdp/fd](https://github.com/sharkdp/fd)

### bat

**Kind:** CLI  
**What it is:** `cat` clone with syntax highlighting and git integration.  
**Homepage:** [https://github.com/sharkdp/bat](https://github.com/sharkdp/bat)

### git-delta

**Kind:** Git tool  
**What it is:** Syntax-highlighted diff viewer. Wired as Git's pager.  
**Homepage:** [https://github.com/dandavison/delta](https://github.com/dandavison/delta)

### zoxide

**Kind:** CLI  
**What it is:** Smarter `cd` — jumps to recent/frequent dirs by partial name.  
**Homepage:** [https://github.com/ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide)

### lazygit

**Kind:** Git tool  
**What it is:** Terminal UI for Git. Staging, branches, rebases without leaving the keyboard.  
**Homepage:** [https://github.com/jesseduffield/lazygit](https://github.com/jesseduffield/lazygit)

### direnv

**Kind:** CLI  
**What it is:** Per-directory env vars. Drop a `.envrc`, allow it once, vars load automatically.  
**Homepage:** [https://direnv.net](https://direnv.net)

### atuin

**Kind:** CLI  
**What it is:** Searchable shell history with full context. Owns Ctrl-R after install.  
**Homepage:** [https://atuin.sh](https://atuin.sh)

### tldr (tealdeer)

**Kind:** CLI  
**What it is:** Quick example-based man pages. Run `tldr tar` instead of reading the manual.  
**Homepage:** [https://github.com/tealdeer-rs/tealdeer](https://github.com/tealdeer-rs/tealdeer)

### btop

**Kind:** CLI  
**What it is:** Modern resource monitor with mouse support. Replaces `top`/`htop`.  
**Homepage:** [https://github.com/aristocratos/btop](https://github.com/aristocratos/btop)

### dust

**Kind:** CLI  
**What it is:** More intuitive `du` — bar charts of disk usage by directory.  
**Homepage:** [https://github.com/bootandy/dust](https://github.com/bootandy/dust)

### duf

**Kind:** CLI  
**What it is:** Colorful `df` — clearer view of mounted disks and free space.  
**Homepage:** [https://github.com/muesli/duf](https://github.com/muesli/duf)

### UpCloud CLI (upctl)

**Kind:** Cloud CLI  
**What it is:** Manage UpCloud infrastructure from the terminal.  
**Homepage:** [https://github.com/UpCloudLtd/upcloud-cli](https://github.com/UpCloudLtd/upcloud-cli)

### <img src="https://cdn.simpleicons.org/kubernetes" width="14" alt="" align="center"/> kubectl

**Kind:** Cloud CLI  
**What it is:** Kubernetes CLI. Inspect resources, apply manifests, exec into pods.  
**Homepage:** [https://kubernetes.io/docs/reference/kubectl/](https://kubernetes.io/docs/reference/kubectl/)

### Tilt

**Kind:** Cloud tool  
**What it is:** Local Kubernetes dev loop — watch, build, deploy on save.  
**Homepage:** [https://tilt.dev](https://tilt.dev)

### <img src="https://cdn.simpleicons.org/terraform" width="14" alt="" align="center"/> Terraform

**Kind:** Cloud tool  
**What it is:** Infrastructure-as-code. Installed from HashiCorp's tap (BSL license).  
**Homepage:** [https://www.terraform.io](https://www.terraform.io)

## Developer Fonts

> **Category:** Optional — installed by `scripts/11-fonts.sh`. Programming fonts with ligatures and Nerd Font glyphs.

### Fira Code

**Kind:** Font  
**What it is:** Programming font with ligatures (`!==` → `≠`, `=>` → `→`).  
**Homepage:** [https://github.com/tonsky/FiraCode](https://github.com/tonsky/FiraCode)

### <img src="https://cdn.simpleicons.org/jetbrains" width="14" alt="" align="center"/> JetBrains Mono

**Kind:** Font  
**What it is:** Highly legible monospace font with ligatures, by JetBrains.  
**Homepage:** [https://www.jetbrains.com/lp/mono/](https://www.jetbrains.com/lp/mono/)

### Source Code Pro

**Kind:** Font  
**What it is:** Adobe's open-source monospace family for code.  
**Homepage:** [https://github.com/adobe-fonts/source-code-pro](https://github.com/adobe-fonts/source-code-pro)

### Hack Nerd Font

**Kind:** Font  
**What it is:** Hack plus Nerd Font glyphs — required for PowerLevel10k icons.  
**Homepage:** [https://www.nerdfonts.com](https://www.nerdfonts.com)

## Expo + React Native (full env)

> **Category:** Optional — installed by `scripts/12-expo-rn.sh`. Complete local Expo / React Native env, including iOS toolchain. Superset of scripts 04 + 07 for mobile.

### xcodes

**Kind:** iOS toolchain  
**What it is:** Manage multiple Xcode versions side by side.  
**Homepage:** [https://github.com/XcodesOrg/xcodes](https://github.com/XcodesOrg/xcodes)

### ios-deploy

**Kind:** iOS toolchain  
**What it is:** Deploy and debug iOS apps on physical devices from the command line.  
**Homepage:** [https://github.com/ios-control/ios-deploy](https://github.com/ios-control/ios-deploy)

### CocoaPods

**Kind:** Package manager  
**What it is:** Dependency manager for iOS/macOS projects.  
**Homepage:** [https://cocoapods.org](https://cocoapods.org)

### <img src="https://cdn.simpleicons.org/swift" width="14" alt="" align="center"/> SwiftLint

**Kind:** Linter  
**What it is:** Linter for Swift code, enforcing style and conventions.  
**Homepage:** [https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)

### Maestro

**Kind:** Mobile QA  
**What it is:** Mobile UI testing framework. `maestro studio` records flows visually.  
**Homepage:** [https://maestro.mobile.dev](https://maestro.mobile.dev)

## macOS System Defaults

> **Category:** Optional — installed by `scripts/13-macos-defaults.sh`. Reversible developer-friendly `defaults write` tweaks.

### <img src="https://cdn.simpleicons.org/apple" width="14" alt="" align="center"/> macOS defaults tweaks

**Kind:** System config  
**What it is:** Fast key repeat, no auto-correct, expanded save panels, show hidden files, Dock autohide, screenshots to ~/Screenshots, etc. Reversible.

<!-- TOOLS:END:catalogue -->

---

## Tool Selection by Role

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

## Making the Most of Your Tools

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
- Run `tldr <command>` for quick examples (already installed via `10-devops.sh`)
- Use `man <command>` for detailed documentation
- VS Code: Cmd+Shift+P opens command palette
- Most tools have `--help` flag

---

## Storage Requirements

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

**[Back to Home](/)** | **[Script Guide](/script-guide)** | **[GitHub Repository](https://github.com/allanasp/Setup-Developer-Mac)**

---

<div style="text-align: center; margin: 2rem 0; padding: 2rem; background: #f6f8fa; border-radius: 8px;">
  <h3>Ready to Install These Amazing Tools?</h3>
  <p style="color: #586069; margin: 1rem 0;">Choose exactly what you need with our modular setup</p>
  <p>
    <a href="https://github.com/allanasp/Setup-Developer-Mac" style="display: inline-block; background: #28a745; color: white; padding: 12px 24px; border-radius: 6px; text-decoration: none; font-weight: bold;">Get Started Now</a>
  </p>
</div>
