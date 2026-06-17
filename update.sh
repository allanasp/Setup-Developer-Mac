#!/bin/bash

# Update everything installed by this setup in one go.
#
# Usage:
#   ./update.sh                # Upgrade Homebrew, Volta/Node, Oh My Zsh, PowerLevel10k
#   ./update.sh --dry-run      # Show what would be upgraded without changing anything
#   ./update.sh --outdated     # Report what's stale, do not change anything (exits non-zero if any)
#   ./update.sh --outdated --no-fetch
#                              # Skip network calls (git fetch); use cached state only

set -e # Exit on any error

source "$(dirname "$0")/scripts/common.sh"

OUTDATED_ONLY=false
NO_FETCH=false
for arg in "$@"; do
    case "${arg}" in
        --dry-run | -n) export DRY_RUN=true ;;
        --outdated | -l) OUTDATED_ONLY=true ;;
        --no-fetch) NO_FETCH=true ;;
    esac
done

# --outdated runs separately from the upgrade path: no log file (this is a
# read-only status command), no tee, just structured report on stdout.
if [[ "${OUTDATED_ONLY}" == "true" ]]; then
    print_section "Outdated tooling report"
    check_macos

    OUTDATED_TOTAL=0

    record_outdated() {
        OUTDATED_TOTAL=$((OUTDATED_TOTAL + $1))
    }

    # --- Homebrew formulae & casks ------------------------------------------
    # Note: `brew outdated` compares installed versions against the LOCAL taps
    # cache, so the report is only as fresh as the last `brew update`. Mention
    # this so the user knows whether to re-fetch before trusting the numbers.
    if command_exists brew; then
        echo ""
        print_status "Homebrew formulae (against last-fetched taps — run \`brew update\` for fresh data)"
        formula_lines=$(brew outdated --formula --verbose 2>/dev/null || true)
        if [[ -z "${formula_lines}" ]]; then
            print_success "  up to date"
        else
            echo "${formula_lines}" | sed 's/^/  /'
            record_outdated "$(echo "${formula_lines}" | wc -l | tr -d ' ')"
        fi

        echo ""
        print_status "Homebrew casks"
        cask_lines=$(brew outdated --cask --verbose 2>/dev/null || true)
        if [[ -z "${cask_lines}" ]]; then
            print_success "  up to date"
        else
            echo "${cask_lines}" | sed 's/^/  /'
            record_outdated "$(echo "${cask_lines}" | wc -l | tr -d ' ')"
        fi
    else
        echo ""
        print_warning "Homebrew not installed - skipping"
    fi

    # --- Volta / Node -------------------------------------------------------
    # We don't query npm for the latest LTS here — that's a per-network-call
    # operation per package and gets slow. Just print installed state and the
    # one-liner to refresh.
    echo ""
    if command_exists volta; then
        node_version=$(node --version 2>/dev/null || echo "(none active)")
        print_status "Volta-managed Node"
        echo "  installed: ${node_version}"
        echo "  refresh:   volta install node@lts   (or volta install <pkg>@latest)"
    else
        print_warning "Volta not installed - skipping Node check"
    fi

    # --- Oh My Zsh + custom themes/plugins ----------------------------------
    # `git fetch` is a network call. Skip on --no-fetch (CI offline mode,
    # tests, etc.); the count then reflects the last-known origin state.
    git_behind_count() {
        # git_behind_count <repo_path>
        local repo="$1"
        [[ -d "${repo}/.git" ]] || return 1
        if [[ "${NO_FETCH}" != "true" ]]; then
            git -C "${repo}" fetch --quiet origin 2>/dev/null || return 1
        fi
        git -C "${repo}" rev-list --count HEAD..'@{u}' 2>/dev/null || echo 0
    }

    omz_repos=(
        "${HOME}/.oh-my-zsh"
        "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
        "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
        "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
        "${HOME}/.oh-my-zsh/custom/plugins/zsh-completions"
    )
    echo ""
    print_status "Oh My Zsh + custom themes / plugins"
    if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
        print_warning "  Oh My Zsh not installed - skipping"
    else
        for repo in "${omz_repos[@]}"; do
            [[ -d "${repo}/.git" ]] || continue
            label="$(basename "${repo}")"
            [[ "${repo}" == "${HOME}/.oh-my-zsh" ]] && label="oh-my-zsh (main repo)"
            behind=$(git_behind_count "${repo}" 2>/dev/null || echo "?")
            if [[ "${behind}" == "0" ]]; then
                print_success "  ${label}: up to date"
            elif [[ "${behind}" == "?" ]]; then
                print_warning "  ${label}: could not check (no remote / fetch failed)"
            else
                echo "  ${label}: ${behind} commits behind upstream"
                record_outdated "${behind}"
            fi
        done
    fi

    # --- Setup repo itself --------------------------------------------------
    echo ""
    print_status "Setup-Developer-Mac repo"
    repo_root="$(dirname "$(realpath "$0")")"
    if [[ -d "${repo_root}/.git" ]]; then
        behind=$(git_behind_count "${repo_root}" 2>/dev/null || echo "?")
        if [[ "${behind}" == "0" ]]; then
            print_success "  up to date with origin"
        elif [[ "${behind}" == "?" ]]; then
            print_warning "  could not compare against origin"
        else
            echo "  local is ${behind} commits behind origin/main"
            echo "  See: https://github.com/allanasp/Setup-Developer-Mac/commits/main"
            record_outdated "${behind}"
        fi
    else
        print_warning "  not a git checkout - skipping"
    fi

    # --- Summary ------------------------------------------------------------
    echo ""
    print_section "Summary"
    if [[ "${OUTDATED_TOTAL}" -eq 0 ]]; then
        print_success "Everything tracked is up to date"
        exit 0
    else
        print_warning "${OUTDATED_TOTAL} items ready to upgrade"
        echo "  Run ./update.sh (no flag) to upgrade everything"
        echo "  Or re-run a specific scripts/XX-*.sh to update one category"
        exit 1
    fi
fi

# Log the run
LOG_FILE="${HOME}/mac-update-$(date +%Y-%m-%d).log"
exec > >(tee -a "${LOG_FILE}") 2>&1

print_section "Updating Development Environment"
check_macos

run_step() {
    # run_step "description" command...
    local desc="$1"
    shift
    if is_dry_run; then
        print_status "[dry-run] would ${desc}"
        return 0
    fi
    print_status "${desc}..."
    if "$@"; then
        print_success "${desc} - done"
    else
        print_warning "${desc} - failed (continuing)"
    fi
}

# --- Homebrew -----------------------------------------------------------------
if command_exists brew; then
    run_step "update Homebrew" brew update
    run_step "upgrade Homebrew formulae & casks" brew upgrade
    run_step "clean up Homebrew" brew cleanup
else
    print_warning "Homebrew not installed - skipping"
fi

# --- Volta / Node -------------------------------------------------------------
if command_exists volta; then
    run_step "install latest Node LTS via Volta" volta install node@lts
else
    print_warning "Volta not installed - skipping Node update"
fi

# --- Oh My Zsh ----------------------------------------------------------------
if [[ -f "${HOME}/.oh-my-zsh/tools/upgrade.sh" ]]; then
    run_step "upgrade Oh My Zsh" "${HOME}/.oh-my-zsh/tools/upgrade.sh"
else
    print_warning "Oh My Zsh not installed - skipping"
fi

# --- Custom zsh plugins & PowerLevel10k (git pull) ----------------------------
for repo in \
    "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" \
    "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
    "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
    "${HOME}/.oh-my-zsh/custom/plugins/zsh-completions"; do
    if [[ -d "${repo}/.git" ]]; then
        run_step "update $(basename "${repo}")" git -C "${repo}" pull --ff-only
    fi
done

print_success "Update complete!"
echo ""
echo "📄 Full log saved to: ${LOG_FILE}"
echo "🔄 Restart your terminal (or 'source ~/.zshrc') to pick up changes."
