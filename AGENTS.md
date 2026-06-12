# AGENTS.md

Conventions for any AI coding agent (Claude Code, Cursor, kiro-cli, OpenCode, Aider, etc.)
working on this repo. If you're an agent, read this before editing.

## What this repo is

Modular Bash scripts that bootstrap a macOS development environment from scratch —
Homebrew, terminal, version managers, frontend toolchain, mobile toolchain, databases,
DevOps tools. Target: macOS on Intel + Apple Silicon. Pure Bash; no Node.js / Python /
Ruby in the project itself.

## Project layout

```
setup.sh              Main orchestrator with interactive prompts
check-setup.sh        Verifies what's installed and prints versions
doctor.sh             Diagnoses environment drift (dead aliases, broken PATH, …); --auto-fix repairs known issues
update.sh             Upgrades brew, Volta, Oh My Zsh, PowerLevel10k
uninstall.sh          Rolls back casks, formulae and Volta packages
install.sh            One-line bootstrapper (curl | sh entrypoint)
scripts/
  common.sh           Shared helpers (print_*, check_*, install_*, is_dry_run)
  01-system.sh        Xcode CLT + Homebrew                       (essential)
  02-terminal.sh      iTerm2, Oh My Zsh, PowerLevel10k           (essential)
  03-version-managers.sh  Volta, pyenv                           (essential)
  04..13-*.sh         Optional categories
docs/                 VitePress documentation site (GitHub Pages)
```

## Script pattern

Every script in `scripts/` follows the same shape:

```bash
#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

print_section "Category Name"
check_macos
check_homebrew

print_status "Installing tool..."
if brew install tool; then
    print_success "Tool installed"
else
    print_error "Installation failed"
    return 1
fi

# TODO list for manual steps the user has to do after install
echo "📋 TODO: Manual Configuration"
echo "□ Step 1: ..."
```

## Helpers (from `scripts/common.sh`)

- `print_status "msg"` — blue info line
- `print_success "msg"` — green ✓ line
- `print_warning "msg"` — yellow ⚠ line
- `print_error "msg"` — red ✗ line
- `print_section "title"` — section header banner
- `check_macos` / `check_homebrew` — preconditions, exit on failure
- `command_exists <cmd>` — `command -v` wrapper
- `is_dry_run` — returns 0 if `DRY_RUN=true`; use to gate side-effects
- `install_cask_app "Name" "cask" "/Applications/Name.app"` — idempotent cask install
- `install_volta_package "pkg"` — idempotent global Node package install

## Idempotency

Every script must be safe to re-run. Always check before installing or modifying config.

```bash
# Check before installing apps
if [[ -d "/Applications/App.app" ]]; then
    print_success "App already installed"
else
    brew install --cask app
fi

# Check before appending to shell config
if ! grep -q 'CONFIG' ~/.zshrc 2>/dev/null; then
    echo 'export CONFIG="value"' >> ~/.zshrc
fi
```

## Cross-arch (Intel + Apple Silicon)

Homebrew lives in `/opt/homebrew` on Apple Silicon, `/usr/local` on Intel. Never
hardcode either — detect:

```bash
if [[ $(uname -m) == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
```

## Dry-run support

All scripts respect `DRY_RUN=true` (set by `setup.sh --dry-run`). Wrap any
side-effecting branch:

```bash
if is_dry_run; then
    print_status "[dry-run] would install foo"
else
    brew install foo
fi
```

## Adding a new tool

1. Pick the right `scripts/XX-category.sh` (or create a new one and register it
   in `setup.sh`'s `optional_scripts` + `optional_descriptions` arrays).
2. Use `install_cask_app` / `install_volta_package` if it fits, otherwise hand-write
   the install with the idempotency + dry-run patterns above.
3. Add a `📋 TODO` line for any manual step the user has to do after install.
4. Add a verification entry in `check-setup.sh` (`command_exists` or app-path check).
5. Add a rollback entry in `uninstall.sh` (CASKS / FORMULAE / VOLTA_PKGS array).
6. Add an entry to `data/tools.json` (the single source of truth for the catalogue)
   and run `make docs` — this regenerates the tool catalogue in `README.md` and
   `docs/tools-guide.md`. CI fails on drift via `make docs-check`.
7. Update `docs/script-guide.md` and `docs/setup-checker.md` separately if the
   tool needs script-level or checker-level documentation.

## Adding a configuration prompt

`setup.sh` pauses after each script with a `prompt_configuration` block. Add a
case for new scripts:

```bash
"06-dev-apps.sh")
    prompt_configuration "Development Apps" "
- Sign in to VS Code (Settings Sync)
- Run: gh auth login
- Verify: code --version
"
    ;;
```

## Testing

```bash
# Syntax check
bash -n scripts/XX-category.sh

# Idempotence — must be safe to run twice in a row
./scripts/XX-category.sh
./scripts/XX-category.sh

# Verify installs
./check-setup.sh

# Diagnose environment drift (and optionally apply fixes)
./doctor.sh
./doctor.sh --auto-fix --dry-run

# Dry-run end-to-end
./setup.sh --dry-run

# Unit tests (bats)
bats tests/
```

CI runs ShellCheck + the test runner via `.github/workflows/main.yml` — keep
warnings clean.

## Anti-patterns

- ❌ Hardcoded `/opt/homebrew` or `/usr/local` paths without arch detection
- ❌ `brew install x` without success/failure branches
- ❌ Scripts that crash on re-run (missing existence checks)
- ❌ Side-effects inside the `dry-run` branch
- ❌ Updating a script but forgetting `check-setup.sh` / `uninstall.sh` / docs
- ❌ Skipping the `📋 TODO` section when manual steps are required
- ❌ `ls` in scripts — `ls` is aliased to `eza` in the user's shell; use `/bin/ls`
  or a different approach if running inside the user's interactive shell

## Branching & commit style

**Always work on a feature branch and open a PR — do not push directly to
`main`.** Branch names use the same type prefixes as the
[Conventional Commits](https://www.conventionalcommits.org/) spec for commit
messages:

- `feat/<slug>` — new feature (e.g. `feat/doctor-command`)
- `fix/<slug>` — bug fix (e.g. `fix/eza-alias-guard`)
- `refactor/<slug>` — code restructuring without behaviour change
- `ci/<slug>` — CI / workflow changes
- `docs/<slug>` — docs-only changes
- `chore/<slug>` — deps bumps and housekeeping

One logical change per branch. Every PR — whether opened via `gh pr create`
or the GitHub UI — runs the full `validate` job before it can merge; that
job has caught real bugs in earlier work (security-scan allowlist misses,
formatting issues) that would otherwise have shipped to main.

Commit message: Conventional Commits prefix on the subject (`feat:`, `fix:`,
`docs:`, `chore:`, `ci:`, `refactor:`), body explains *why*, not *what*.

## Docs site

Lives in `docs/` as a VitePress project. Package manager is **Bun** (lockfile is
`docs/bun.lock`, do not regenerate it with npm). Local dev:

```bash
cd docs
bun install      # first time
bun run dev      # http://localhost:5173/Setup-Developer-Mac/
bun run build    # static output → docs/.vitepress/dist
```

`docs/.vitepress/config.mts` controls nav + sidebar. New top-level guides need to
be added to the sidebar config and linked from `docs/index.md`. The site deploys
to GitHub Pages via the `build-docs` + `deploy-docs` jobs in
`.github/workflows/main.yml` on every push to `main` — those steps run Node 24 +
Bun and use `actions/upload-pages-artifact` + `actions/deploy-pages`.
