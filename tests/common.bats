#!/usr/bin/env bats
#
# Unit tests for scripts/common.sh. Run with: bats tests/common.bats

setup() {
    REPO_ROOT="$(cd "$(dirname "${BATS_TEST_FILENAME}")/.." && pwd)"
    # Isolate HOME so shell-config writers touch a throwaway dir.
    export HOME="${BATS_TEST_TMPDIR}"
    DRY_RUN=false
    # shellcheck source=/dev/null
    source "${REPO_ROOT}/scripts/common.sh"
}

@test "BREW_PREFIX is set to a known prefix" {
    [ "${BREW_PREFIX}" = "/opt/homebrew" ] || [ "${BREW_PREFIX}" = "/usr/local" ]
}

@test "is_dry_run reflects DRY_RUN" {
    DRY_RUN=false
    run is_dry_run
    [ "${status}" -ne 0 ]
    DRY_RUN=true
    run is_dry_run
    [ "${status}" -eq 0 ]
}

@test "print_success emits the message" {
    run print_success "hello world"
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"hello world"* ]]
}

@test "add_to_zshenv writes once and dedups by marker" {
    add_to_zshenv "JAVA_HOME" 'export JAVA_HOME=/first'
    add_to_zshenv "JAVA_HOME" 'export JAVA_HOME=/second'
    grep -q '/first' "${HOME}/.zshenv"
    ! grep -q '/second' "${HOME}/.zshenv"
}

@test "add_to_zshrc supports heredoc and dedups" {
    add_to_zshrc "block marker" <<'EOF'
alias foo=bar
EOF
    add_to_zshrc "block marker" <<'EOF'
alias should=notappear
EOF
    grep -q 'alias foo=bar' "${HOME}/.zshrc"
    ! grep -q 'notappear' "${HOME}/.zshrc"
}

@test "install_brew_formula is a no-op under DRY_RUN" {
    DRY_RUN=true
    run install_brew_formula "ripgrep" "ripgrep"
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"dry-run"* ]]
}

@test "add_to_zshenv does not write under DRY_RUN" {
    DRY_RUN=true
    add_to_zshenv "VOLTA_HOME" 'export VOLTA_HOME=$HOME/.volta'
    [ ! -f "${HOME}/.zshenv" ]
}

@test "_record_result and print_setup_summary count outcomes" {
    export SETUP_RESULTS_FILE="${HOME}/results"
    _record_result "installed:A"
    _record_result "installed:B"
    _record_result "skipped:C"
    _record_result "failed:D"
    run print_setup_summary "${SETUP_RESULTS_FILE}"
    [[ "${output}" == *"Installed: 2"* ]]
    [[ "${output}" == *"Skipped / already present: 1"* ]]
    [[ "${output}" == *"Failed: 1"* ]]
}

@test "app_exists is true for an existing dir" {
    run app_exists "${HOME}"
    [ "${status}" -eq 0 ]
    run app_exists "${HOME}/definitely-not-here"
    [ "${status}" -ne 0 ]
}
