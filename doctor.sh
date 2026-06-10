#!/bin/bash

# doctor.sh — diagnose common environment breakage from this setup
#
# Sister to ./check-setup.sh: that one says "did it install?", this one
# says "is it still wired up correctly?". Catches state drift that
# wouldn't break installs but does break daily use — e.g. an `alias
# ls="eza"` line surviving an `eza` uninstall, leaving plain `ls` broken.
#
# Usage:
#   ./doctor.sh                # diagnose only — never mutate the system
#   ./doctor.sh --auto-fix     # apply safe fixes for the issues it can repair
#   ./doctor.sh --dry-run      # combine with --auto-fix to preview fixes
#   ./doctor.sh -h             # this help text
#
# Exit codes:
#   0  — no issues, or all issues were auto-fixed
#   1  — issues remain (either --auto-fix wasn't passed, or some checks
#        have no automatic fix)

set -uo pipefail

source "$(dirname "$0")/scripts/common.sh"

DOCTOR_AUTO_FIX=false
DOCTOR_ISSUES=0
DOCTOR_FIXED=0
DOCTOR_OK=0

print_help() {
    cat <<'EOF'
Usage: ./doctor.sh [--auto-fix] [--dry-run]

Diagnose common environment breakage from the Mac Developer Setup.

Options:
  --auto-fix, -f   Apply safe fixes for issues the doctor knows how to repair
  --dry-run,  -n   Combined with --auto-fix, show what would change without
                   touching the system
  --help,     -h   Show this help text
EOF
}

for arg in "$@"; do
    case "${arg}" in
        --auto-fix | -f) DOCTOR_AUTO_FIX=true ;;
        --dry-run | -n) export DRY_RUN=true ;;
        --help | -h)
            print_help
            exit 0
            ;;
        *)
            print_error "Unknown argument: ${arg}"
            print_help
            exit 2
            ;;
    esac
done

# Counters & shared output helpers ----------------------------------------------

doctor_pass() {
    print_success "$1"
    DOCTOR_OK=$((DOCTOR_OK + 1))
}

doctor_fail() {
    print_warning "$1"
    DOCTOR_ISSUES=$((DOCTOR_ISSUES + 1))
}

doctor_fix_applied() {
    print_success "Fix applied: $1"
    DOCTOR_FIXED=$((DOCTOR_FIXED + 1))
}

# Portable in-place edit (BSD sed and GNU sed disagree on -i syntax). Writes to
# a temp file and moves it over, which avoids the platform split entirely.
sed_inplace() {
    local script="$1"
    local file="$2"
    local tmp="${file}.doctor.$$"
    if sed -E "${script}" "${file}" >"${tmp}"; then
        mv "${tmp}" "${file}"
    else
        rm -f "${tmp}"
        return 1
    fi
}

# Backup a file with a timestamp suffix so the user can `mv` it back if our fix
# does the wrong thing. Returns the backup path on stdout.
backup_file() {
    local file="$1"
    local backup
    backup="${file}.doctor-$(date +%Y%m%d-%H%M%S)"
    cp "${file}" "${backup}"
    echo "${backup}"
}

# Individual checks ------------------------------------------------------------

# 1. eza alias consistency
#
# Bug we've actually hit: `02-terminal.sh` writes `alias ls="eza"` etc. into
# ~/.zshrc. If the user later removes eza (or never installed it), every plain
# `ls` errors with "command not found: eza". The user has to figure out the
# alias is the culprit and edit ~/.zshrc by hand.
check_eza_alias_consistency() {
    local zshrc="${HOME}/.zshrc"
    if ! grep -qE 'alias ls=.?eza' "${zshrc}" 2>/dev/null; then
        doctor_pass "eza alias: no alias configured"
        return 0
    fi
    if command_exists eza; then
        doctor_pass "eza alias: alias present and eza installed"
        return 0
    fi
    doctor_fail "alias ls=\"eza\" in ~/.zshrc but eza is not installed (plain \`ls\` will error)"
    echo "    Fix: brew install eza"
    echo "    Or:  remove the eza alias block (apply with --auto-fix)"
    if [[ "${DOCTOR_AUTO_FIX}" == "true" ]]; then
        if is_dry_run; then
            print_status "[dry-run] would strip eza alias lines from ${zshrc}"
            DOCTOR_FIXED=$((DOCTOR_FIXED + 1))
        else
            local backup
            backup=$(backup_file "${zshrc}")
            # Drop the "Better ls with eza" header comment and the four known
            # alias lines. Conservative: nothing else in the block is touched,
            # so a hand-edited alias for `tree` that doesn't reference eza
            # survives.
            sed_inplace '/^# Better ls with eza/d;/^alias (ls|ll|la|tree)=.?eza/d' "${zshrc}"
            doctor_fix_applied "stripped eza alias lines from ~/.zshrc (backup: ${backup})"
        fi
    fi
    return 1
}

# 2. Homebrew shellenv loaded for login shells
#
# Without this, non-interactive shells (cron, login hooks, IDEs that spawn a
# bash subshell) won't see brew-installed binaries on PATH. setup.sh's stage-A
# pause exists partly because of this — but if the user manually deleted the
# eval line or installed brew before this setup, the line is missing.
check_brew_shellenv_loaded() {
    if ! command_exists brew; then
        doctor_pass "brew shellenv: brew not installed, skipping"
        return 0
    fi
    local zprofile="${HOME}/.zprofile"
    if grep -q 'brew shellenv' "${zprofile}" 2>/dev/null; then
        doctor_pass "brew shellenv: loaded from ~/.zprofile"
        return 0
    fi
    doctor_fail "brew is installed but \`brew shellenv\` is not loaded from ~/.zprofile"
    echo "    Fix: append \`eval \"\$(${BREW_PREFIX}/bin/brew shellenv)\"\` to ~/.zprofile"
    if [[ "${DOCTOR_AUTO_FIX}" == "true" ]]; then
        if is_dry_run; then
            print_status "[dry-run] would append brew shellenv line to ${zprofile}"
            DOCTOR_FIXED=$((DOCTOR_FIXED + 1))
        else
            echo "eval \"\$(${BREW_PREFIX}/bin/brew shellenv)\"" >>"${zprofile}"
            doctor_fix_applied "appended brew shellenv to ~/.zprofile"
        fi
    fi
    return 1
}

# 3. Volta home on PATH for non-interactive shells
#
# Volta's installer appends VOLTA_HOME + path to ~/.zshrc. If that line is
# missing but ~/.volta exists, every spawned shell can't find node/npm. The
# user typically discovers this when a VS Code task or a cron job that
# expects node silently fails.
check_volta_env_configured() {
    if [[ ! -d "${HOME}/.volta" ]]; then
        doctor_pass "Volta env: Volta not installed, skipping"
        return 0
    fi
    # Volta env can legitimately live in either ~/.zshenv (the cleaner choice —
    # sourced by all shells including non-interactive) or ~/.zshrc (the default
    # Volta installer target). Accept either.
    local target=""
    for candidate in "${HOME}/.zshenv" "${HOME}/.zshrc"; do
        if grep -q 'VOLTA_HOME\|.volta/bin' "${candidate}" 2>/dev/null; then
            target="${candidate}"
            break
        fi
    done
    if [[ -n "${target}" ]]; then
        doctor_pass "Volta env: VOLTA_HOME wired up in ${target/${HOME}/~}"
        return 0
    fi
    doctor_fail "~/.volta exists but VOLTA_HOME is not exported from ~/.zshenv or ~/.zshrc (non-login shells will miss node)"
    echo "    Fix: re-run ./scripts/03-version-managers.sh, or apply with --auto-fix"
    if [[ "${DOCTOR_AUTO_FIX}" == "true" ]]; then
        local zshenv="${HOME}/.zshenv"
        if is_dry_run; then
            print_status "[dry-run] would append Volta env block to ${zshenv}"
            DOCTOR_FIXED=$((DOCTOR_FIXED + 1))
        else
            {
                echo ""
                echo "# Volta — Node.js version manager (added by doctor.sh)"
                echo 'export VOLTA_HOME="$HOME/.volta"'
                echo 'export PATH="$VOLTA_HOME/bin:$PATH"'
            } >>"${zshenv}"
            doctor_fix_applied "appended Volta env block to ~/.zshenv"
        fi
    fi
    return 1
}

# 4. xcode-select points at an existing developer dir
#
# Common after uninstalling Xcode without resetting CLT — `xcode-select -p`
# happily prints a stale path, and every tool that shells out to xcrun blows
# up with cryptic errors.
check_xcode_select_path() {
    if ! command_exists xcode-select; then
        doctor_pass "xcode-select: not present, skipping"
        return 0
    fi
    local dev_dir
    dev_dir=$(xcode-select -p 2>/dev/null || echo "")
    if [[ -z "${dev_dir}" ]]; then
        doctor_fail "xcode-select has no developer directory configured"
        echo "    Fix: xcode-select --install   (or sudo xcode-select -s /Library/Developer/CommandLineTools)"
        return 1
    fi
    if [[ -d "${dev_dir}" ]]; then
        doctor_pass "xcode-select: ${dev_dir}"
        return 0
    fi
    doctor_fail "xcode-select points at \"${dev_dir}\" but that path no longer exists"
    echo "    Fix: sudo xcode-select --reset   (then xcode-select --install if needed)"
    # Not auto-fixing — needs sudo and the right answer depends on whether the
    # user wants full Xcode or just the Command Line Tools.
    return 1
}

# 5. ZSH_THEME points at a theme that exists on disk
#
# Setting ZSH_THEME to a name without the corresponding files (e.g. after
# deleting ~/.oh-my-zsh/custom/themes/powerlevel10k) gives the user a broken
# prompt and a wall of red errors on every new shell.
check_zsh_theme_present() {
    if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
        doctor_pass "ZSH theme: Oh My Zsh not installed, skipping"
        return 0
    fi
    local zshrc="${HOME}/.zshrc"
    local theme
    theme=$(grep -E '^ZSH_THEME=' "${zshrc}" 2>/dev/null | tail -1 | sed -E 's/^ZSH_THEME="?([^"]*)"?$/\1/')
    if [[ -z "${theme}" || "${theme}" == "random" ]]; then
        doctor_pass "ZSH theme: no specific theme pinned"
        return 0
    fi
    # Built-in themes live as a single .zsh-theme file; custom themes are a
    # directory under custom/themes containing a .zsh-theme.
    local builtin="${HOME}/.oh-my-zsh/themes/${theme}.zsh-theme"
    local custom_file="${HOME}/.oh-my-zsh/custom/themes/${theme}.zsh-theme"
    local custom_dir_theme="${HOME}/.oh-my-zsh/custom/themes/${theme##*/}/${theme##*/}.zsh-theme"
    if [[ -f "${builtin}" || -f "${custom_file}" || -f "${custom_dir_theme}" ]]; then
        doctor_pass "ZSH theme: \"${theme}\" found"
        return 0
    fi
    doctor_fail "ZSH_THEME=\"${theme}\" but no theme files found under ~/.oh-my-zsh/{themes,custom/themes}"
    echo "    Fix: re-run ./scripts/02-terminal.sh   (installs PowerLevel10k under custom/themes)"
    return 1
}

# Runner -----------------------------------------------------------------------

print_section "Mac Developer Setup — Doctor"
if [[ "${DOCTOR_AUTO_FIX}" == "true" ]]; then
    if is_dry_run; then
        print_status "Mode: --auto-fix --dry-run (no files will be changed)"
    else
        print_status "Mode: --auto-fix (will apply safe fixes for known issues)"
    fi
else
    print_status "Mode: diagnose only (pass --auto-fix to apply repairs)"
fi
echo ""

# Run each check, but let failures keep going so the user gets the full report.
# set -e would abort on the first non-zero return; the explicit `|| true`
# below opts out per-call.
check_eza_alias_consistency || true
check_brew_shellenv_loaded || true
check_volta_env_configured || true
check_xcode_select_path || true
check_zsh_theme_present || true

echo ""
print_section "Doctor Summary"
print_success "Checks passed: ${DOCTOR_OK}"
if [[ "${DOCTOR_ISSUES}" -gt 0 ]]; then
    print_warning "Issues found:  ${DOCTOR_ISSUES}"
fi
if [[ "${DOCTOR_FIXED}" -gt 0 ]]; then
    print_success "Fixes applied: ${DOCTOR_FIXED}"
fi

# Exit non-zero if any issue remains unresolved, so CI / wrapper scripts can
# detect "still broken".
remaining=$((DOCTOR_ISSUES - DOCTOR_FIXED))
if [[ "${remaining}" -gt 0 ]]; then
    exit 1
fi
exit 0
