---
title: Credits
description: People, projects and tools that make Mac Frontend Developer Setup possible.
---

# 🙏 Credits

This setup is glue around dozens of fantastic open-source projects. None of this works
without the people behind them.

## Author & maintainer

- **Allan Asp Christensen** ([@allanasp](https://github.com/allanasp)) — author and maintainer.
- All contributors who have opened PRs, filed issues, or suggested tools — thank you.
- See the [contributor list on GitHub](https://github.com/allanasp/Setup-Developer-Mac/graphs/contributors) for the full roll.

## Foundation

The whole house sits on these:

- [Homebrew](https://brew.sh/) — the missing package manager for macOS. ([Homebrew/brew](https://github.com/Homebrew/brew))
- [Oh My Zsh](https://ohmyz.sh/) — the framework that makes zsh livable. ([ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh))
- [PowerLevel10k](https://github.com/romkatv/powerlevel10k) — the prompt theme, by Roman Perepelitsa.
- [iTerm2](https://iterm2.com/) — the terminal emulator.
- [Dracula Theme](https://draculatheme.com/) — colour palette used across iTerm2 and PowerLevel10k.
- [Volta](https://volta.sh/) — the JavaScript tool manager.
- [pyenv](https://github.com/pyenv/pyenv) — the Python version manager.

## JavaScript & frontend ecosystem

- [Node.js](https://nodejs.org/), [npm](https://npmjs.com/), [pnpm](https://pnpm.io/), [Bun](https://bun.sh/)
- [TypeScript](https://www.typescriptlang.org/) by Microsoft
- [Vue](https://vuejs.org/) by Evan You and the Vue team
- [Nuxt](https://nuxt.com/) by the Nuxt team
- [Vite](https://vite.dev/), [create-vite](https://github.com/vitejs/vite/tree/main/packages/create-vite), [Turborepo](https://turbo.build/), [Vercel CLI](https://vercel.com/cli)
- [React Native](https://reactnative.dev/), [Expo](https://expo.dev/), [EAS CLI](https://expo.dev/eas), [@react-native-community/cli](https://github.com/react-native-community/cli)
- [Storyblok CLI](https://www.storyblok.com/), [Sanity CLI](https://www.sanity.io/), [Supabase CLI](https://supabase.com/)
- [Serve](https://github.com/vercel/serve)

## Editors & AI coding agents

- [Visual Studio Code](https://code.visualstudio.com/) by Microsoft
- [Cursor](https://cursor.com/)
- [Claude Code](https://docs.claude.com/en/docs/claude-code) by Anthropic
- [kiro-cli](https://kiro.dev/) by AWS
- [OpenCode](https://opencode.ai/) — terminal AI coding agent
- [TextMate](https://macromates.com/)
- [GitHub Copilot](https://github.com/features/copilot)

## Modern CLI tools

Each of these has a maintainer worth thanking — please star their repos.

- [ripgrep](https://github.com/BurntSushi/ripgrep) (rg) — Andrew Gallant
- [fd](https://github.com/sharkdp/fd) — David Peter
- [bat](https://github.com/sharkdp/bat) — David Peter
- [git-delta](https://github.com/dandavison/delta) — Dan Davison
- [zoxide](https://github.com/ajeetdsouza/zoxide) — Ajeet D'Souza
- [lazygit](https://github.com/jesseduffield/lazygit) — Jesse Duffield
- [direnv](https://direnv.net/) — Ruben Vermeersch
- [atuin](https://atuin.sh/) — Ellie Huxtable
- [eza](https://eza.rocks/) — successor to exa
- [fzf](https://github.com/junegunn/fzf) — Junegunn Choi
- [btop](https://github.com/aristocratos/btop) — Aristocratos
- [dust](https://github.com/bootandy/dust), [duf](https://github.com/muesli/duf)
- [tealdeer](https://github.com/dbrgn/tealdeer) (tldr client) — Danilo Bargen

## DevOps, mobile & database

- [Kubernetes](https://kubernetes.io/), [kubectl](https://kubernetes.io/docs/reference/kubectl/), [Tilt](https://tilt.dev/), [Terraform](https://www.terraform.io/) (HashiCorp)
- [ngrok](https://ngrok.com/), [UpCloud CLI](https://upcloud.com/community/tutorials/upctl-getting-started/)
- [PostgreSQL](https://www.postgresql.org/), [DBeaver](https://dbeaver.io/), [pgAdmin 4](https://www.pgadmin.org/)
- [Android Studio](https://developer.android.com/studio), [Xcode](https://developer.apple.com/xcode/), [CocoaPods](https://cocoapods.org/), [Maestro](https://maestro.mobile.dev/), [xcodes](https://github.com/RobotsAndPencils/xcodes), [SwiftLint](https://github.com/realm/SwiftLint)
- [Java OpenJDK](https://openjdk.org/), [Go](https://go.dev/), [Ruby](https://www.ruby-lang.org/)

## Productivity apps & utilities

- [Rectangle](https://rectangleapp.com/), [Maccy](https://maccy.app/), [Obsidian](https://obsidian.md/)
- [Postman](https://www.postman.com/), [Mockoon](https://mockoon.com/), [Expo Orbit](https://expo.dev/orbit), [DevToys](https://devtoys.app/)
- [Figma](https://figma.com/), [ImageOptim](https://imageoptim.com/), [AppCleaner](https://freemacsoft.net/appcleaner/), [Signal](https://signal.org/), [WireGuard](https://www.wireguard.com/), [Wireshark](https://www.wireshark.org/), [WiFiman](https://www.ui.com/download/wifiman-desktop)
- [Maccy](https://maccy.app/), [Ice](https://github.com/jordanbaird/Ice) by Jordan Baird, [Syncthing](https://syncthing.net/), [OrbStack](https://orbstack.dev/)
- [1Password CLI](https://1password.com/downloads/command-line/), [GitHub CLI](https://cli.github.com/), [GitHub Desktop](https://desktop.github.com/)

## Documentation site

This site is built with:

- [VitePress](https://vitepress.dev/) — static site generator, built on Vite and Vue. ([vuejs/vitepress](https://github.com/vuejs/vitepress))
- [Vue](https://vuejs.org/) and [Vite](https://vite.dev/) — created by Evan You.
- Hosted on [GitHub Pages](https://pages.github.com/), built and deployed via [GitHub Actions](https://github.com/features/actions).

## License notes

Tools installed by this project are governed by their own licenses. The setup scripts
themselves are [MIT-licensed](https://github.com/allanasp/Setup-Developer-Mac/blob/main/LICENSE).
Several casks (Homebrew GUI apps) are proprietary software and have their own terms —
this project only automates installation, it does not redistribute their binaries.

## Found a missing credit?

[Open an issue](https://github.com/allanasp/Setup-Developer-Mac/issues/new) or send a PR
adding the missing project — credits are never finished.
