---
layout: home
title: Mac Frontend Developer Setup
titleTemplate: false
description: Modular Bash scripts that bootstrap a macOS development environment for frontend developers.

hero:
  name: Mac Developer Setup
  text: Frontend-first macOS environment
  tagline: One command to install Node.js, TypeScript, React Native, databases, AI coding agents and the rest of your frontend toolchain.
  image:
    src: /logo.svg
    alt: Mac Developer Setup
  actions:
    - theme: brand
      text: Get started
      link: /start-here
    - theme: alt
      text: View on GitHub
      link: https://github.com/allanasp/Setup-Developer-Mac

features:
  - icon: 🎨
    title: Frontend-first
    details: Volta-managed Node.js, TypeScript, Vue, React Native, Vite, Turbo, Vercel CLI, Storyblok, Sanity. The full JavaScript/TypeScript ecosystem out of the box.
  - icon: 🧩
    title: Modular by design
    details: 3 essential scripts get you running. 10+ optional scripts let you opt in to mobile, database, DevOps, AI tools, fonts and macOS tweaks one category at a time.
  - icon: 🔁
    title: Safe to re-run
    details: Every script is idempotent — running it twice never breaks anything. Run individual scripts to update specific categories without touching the rest.
  - icon: 🤖
    title: AI coding agents
    details: Installs Claude Code (via Homebrew), kiro-cli (AWS agentic CLI), GitHub Copilot for VS Code, and OpenCode — alongside Cursor and VS Code.
  - icon: 💻
    title: Intel + Apple Silicon
    details: All paths are architecture-aware. Works the same on M-series Macs and older Intel hardware. CI exercises both arches.
  - icon: 🩺
    title: Verified by check-setup.sh
    details: A dedicated checker reports what installed cleanly, what's missing, and current versions — so you can see exactly where your setup stands.

---

## One-line install

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/allanasp/Setup-Developer-Mac/main/install.sh)"
```

Append `-- --skip-prompts` for a non-interactive run, or set `SETUP_OPTIONAL="5 6 8 11"`
to choose which optional scripts install.

## What's installed

| Script | Category | Highlights |
|---|---|---|
| `01-system.sh` | System | Xcode CLT, Homebrew |
| `02-terminal.sh` | Terminal | iTerm2, Oh My Zsh, PowerLevel10k (Dracula) |
| `03-version-managers.sh` | Versioning | Volta (Node), pyenv (Python) |
| `04-languages.sh` | Languages | Java JDK, Go, Ruby |
| `05-frontend.sh` | Frontend | TypeScript, Vue, React Native, Vite, Turbo, Vercel, Storyblok, Sanity |
| `06-dev-apps.sh` | Editors / AI | VS Code, Cursor, TextMate, Claude Code, kiro-cli, OpenCode |
| `07-mobile.sh` | Mobile | Android Studio + env (iOS/RN → script 12) |
| `08-productivity.sh` | Productivity | Rectangle, Obsidian, Maccy, Mockoon, Expo Orbit |
| `09-database.sh` | Database | PostgreSQL, DBeaver, pgAdmin 4, Supabase CLI |
| `10-devops.sh` | DevOps | ngrok, UpCloud, kubectl, Tilt, Terraform |
| `11-fonts.sh` | Fonts | Fira Code, JetBrains Mono, Hack Nerd |
| `12-expo-rn.sh` | Mobile (Expo) | Watchman, JDK 17, Maestro, iOS/Android toolchain |
| `13-macos-defaults.sh` | macOS | Keyboard, Finder, Dock, screenshot dir |

## Next up

- 🧭 [Start Here](/start-here) — minimal quick-start
- 📖 [Script Guide](/script-guide) — what each script installs and why
- 🛠️ [Tools Guide](/tools-guide) — detail on every tool
- 🩺 [Setup Checker](/setup-checker) — verify your install
- 🚀 [Post-Installation](/post-installation) — manual configuration steps
- 🙏 [Credits](/credits) — everyone whose work made this possible
