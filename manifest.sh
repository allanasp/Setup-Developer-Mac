#!/bin/bash

# manifest.sh — export installed state to a portable JSON document
#
# The "dotfiles for tooling" gap: setup.sh installs things, check-setup.sh
# verifies them, doctor.sh diagnoses drift — but there's no way to capture
# the full installed surface so you can clone it onto a new Mac. This
# command emits a JSON manifest covering every install method this project
# uses (Homebrew, Volta, pyenv, curl-installed CLIs) so a later
# `manifest.sh import` step can reproduce it elsewhere.
#
# Usage:
#   ./manifest.sh export                     # write JSON to stdout
#   ./manifest.sh export > my-mac.json       # capture to a file
#   ./manifest.sh export --pretty            # pretty-print (default; here for clarity)
#   ./manifest.sh export --compact           # one-line JSON (smaller, scriptable)
#   ./manifest.sh -h                         # this help text
#
# Schema is versioned (schema_version: 1). Future imports will gate on the
# version so reading an old manifest from a newer project version still works.

set -uo pipefail

source "$(dirname "$0")/scripts/common.sh"

print_help() {
    cat <<'EOF'
Usage:
  ./manifest.sh export [--pretty|--compact]   Emit installed-state JSON to stdout
  ./manifest.sh -h | --help                   Show this help

The export covers:
  - Homebrew formulae, casks and taps
  - Volta-managed Node version + global packages
  - pyenv-managed Python versions + global pin
  - Curl-installed tools (Oh My Zsh, PowerLevel10k, kiro-cli, OpenCode, …)
  - Setup-Developer-Mac repo commit so an import can pin to the same code

The manifest is plain JSON; pipe it through jq for filtering/comparison.
EOF
}

# Render a possibly-empty newline-delimited list (e.g. brew list output) as a
# JSON array. Empty input becomes []. jq is required and checked once up top.
lines_to_json_array() {
    awk 'NF' | jq -R . | jq -s .
}

# Safely encode a single value as a JSON string. Empty input → "".
string_to_json() {
    jq -nR --arg v "$(cat)" '$v'
}

cmd_export() {
    local format="pretty"
    for arg in "$@"; do
        case "${arg}" in
            --pretty) format="pretty" ;;
            --compact) format="compact" ;;
            *)
                print_error "Unknown export arg: ${arg}"
                return 2
                ;;
        esac
    done

    if ! command_exists jq; then
        print_error "manifest export requires jq" >&2
        echo "Install with: brew install jq" >&2
        return 1
    fi

    # --- Homebrew ---------------------------------------------------------
    local brew_formulae='[]' brew_casks='[]' brew_taps='[]'
    if command_exists brew; then
        brew_formulae=$(brew list --formula -1 2>/dev/null | lines_to_json_array)
        brew_casks=$(brew list --cask -1 2>/dev/null | lines_to_json_array)
        brew_taps=$(brew tap 2>/dev/null | lines_to_json_array)
    fi

    # --- Volta -------------------------------------------------------------
    local volta_node='""' volta_packages='[]'
    if command_exists volta; then
        volta_node=$(node --version 2>/dev/null | string_to_json)
        # `volta list --format=plain` emits lines like
        #   package <name>@<ver> / <bin> / node@<x>
        # We want just <name>. Strip the trailing @version — not the first
        # @, since scoped packages like @vue/cli start with one.
        volta_packages=$(volta list --format=plain 2>/dev/null |
            awk '/^package/ {sub(/@[^@]*$/, "", $2); print $2}' |
            lines_to_json_array)
    fi

    # --- pyenv -------------------------------------------------------------
    local pyenv_versions='[]' pyenv_global='""'
    if command_exists pyenv; then
        pyenv_versions=$(pyenv versions --bare 2>/dev/null | lines_to_json_array)
        # pyenv global can print multiple lines if multiple versions are
        # pinned simultaneously; join with comma so the manifest is one string.
        pyenv_global=$(pyenv global 2>/dev/null | paste -sd, - | string_to_json)
    fi

    # --- Curl-installed tools ---------------------------------------------
    # Record presence + best-effort version for each tool whose install isn't
    # mediated by brew/volta/pyenv. Lets a later import know whether the curl
    # one-liner needs to run.
    json_bool() { [[ "$1" == "true" ]] && echo true || echo false; }
    omz_present=$([[ -d "${HOME}/.oh-my-zsh" ]] && echo true || echo false)
    p10k_present=$([[ -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]] && echo true || echo false)
    kiro_version=""
    if command_exists kiro; then
        kiro_version=$(kiro --version 2>/dev/null | head -n1)
    fi
    opencode_version=""
    if command_exists opencode; then
        opencode_version=$(opencode --version 2>/dev/null | head -n1)
    fi
    maestro_version=""
    if command_exists maestro; then
        maestro_version=$(maestro --version 2>/dev/null | head -n1)
    fi

    # --- Setup repo metadata ----------------------------------------------
    local repo_remote='""' repo_commit='""' repo_branch='""'
    local repo_root
    repo_root="$(dirname "$(realpath "$0")")"
    if [[ -d "${repo_root}/.git" ]]; then
        repo_remote=$(git -C "${repo_root}" remote get-url origin 2>/dev/null | string_to_json)
        repo_commit=$(git -C "${repo_root}" rev-parse HEAD 2>/dev/null | string_to_json)
        repo_branch=$(git -C "${repo_root}" rev-parse --abbrev-ref HEAD 2>/dev/null | string_to_json)
    fi

    # --- Host metadata ----------------------------------------------------
    local host_name host_arch host_macos
    host_name=$(hostname)
    host_arch=$(uname -m)
    host_macos=$(sw_vers -productVersion 2>/dev/null || echo "")

    # --- Compose ----------------------------------------------------------
    # macOS bash 3.2 + `set -u` treats an empty "${arr[@]}" as an unbound
    # variable; use ${arr[@]+...} to expand only when the array has elements.
    local jq_flags=()
    [[ "${format}" == "compact" ]] && jq_flags+=(-c)

    jq -n ${jq_flags[@]+"${jq_flags[@]}"} \
        --arg exported_at "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
        --arg host_name "${host_name}" \
        --arg host_arch "${host_arch}" \
        --arg host_macos "${host_macos}" \
        --arg kiro_version "${kiro_version}" \
        --arg opencode_version "${opencode_version}" \
        --arg maestro_version "${maestro_version}" \
        --argjson brew_formulae "${brew_formulae}" \
        --argjson brew_casks "${brew_casks}" \
        --argjson brew_taps "${brew_taps}" \
        --argjson volta_node "${volta_node}" \
        --argjson volta_packages "${volta_packages}" \
        --argjson pyenv_versions "${pyenv_versions}" \
        --argjson pyenv_global "${pyenv_global}" \
        --argjson repo_remote "${repo_remote}" \
        --argjson repo_commit "${repo_commit}" \
        --argjson repo_branch "${repo_branch}" \
        --argjson omz_present "${omz_present}" \
        --argjson p10k_present "${p10k_present}" \
        '{
            schema_version: 1,
            exported_at: $exported_at,
            host: {
                name: $host_name,
                arch: $host_arch,
                macos: $host_macos
            },
            setup_repo: {
                remote: $repo_remote,
                commit: $repo_commit,
                branch: $repo_branch
            },
            homebrew: {
                formulae: $brew_formulae,
                casks: $brew_casks,
                taps: $brew_taps
            },
            volta: {
                node: $volta_node,
                packages: $volta_packages
            },
            pyenv: {
                versions: $pyenv_versions,
                global: $pyenv_global
            },
            curl_installs: {
                oh_my_zsh: $omz_present,
                powerlevel10k: $p10k_present,
                kiro_cli: (if $kiro_version == "" then null else $kiro_version end),
                opencode: (if $opencode_version == "" then null else $opencode_version end),
                maestro: (if $maestro_version == "" then null else $maestro_version end)
            }
        }'
}

# ----------------------------------------------------------------------------

if [[ $# -eq 0 ]]; then
    print_help
    exit 0
fi

case "$1" in
    export)
        shift
        cmd_export "$@"
        ;;
    -h | --help)
        print_help
        exit 0
        ;;
    *)
        print_error "Unknown command: $1"
        print_help
        exit 2
        ;;
esac
