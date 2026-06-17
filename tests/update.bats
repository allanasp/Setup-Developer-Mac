#!/usr/bin/env bats
#
# Integration tests for update.sh --outdated. Run with: bats tests/update.bats
#
# Strategy: fake HOME under BATS_TEST_TMPDIR, stub brew/node/git binaries on
# PATH where each test needs them, and run update.sh as a subprocess with
# --no-fetch so the tests don't reach the network. OSTYPE is forced to darwin
# so check_macos() lets us through on the Linux CI runner.

setup() {
    REPO_ROOT="$(cd "$(dirname "${BATS_TEST_FILENAME}")/.." && pwd)"
    export HOME="${BATS_TEST_TMPDIR}"
    export OSTYPE="darwin25"
    # Start with a minimal PATH; individual tests prepend a stubbin dir when
    # they need a fake brew / node / etc.
    export PATH="/usr/bin:/bin"
    mkdir -p "${BATS_TEST_TMPDIR}/stubbin"
}

stub() {
    # stub <name> <heredoc-body>
    local name="$1"
    local body="$2"
    local path="${BATS_TEST_TMPDIR}/stubbin/${name}"
    printf '%s\n' "${body}" >"${path}"
    chmod +x "${path}"
    export PATH="${BATS_TEST_TMPDIR}/stubbin:${PATH}"
}

@test "--outdated exits 0 and says everything is up to date when nothing is installed" {
    run "${REPO_ROOT}/update.sh" --outdated --no-fetch
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"Everything tracked is up to date"* ]]
}

@test "--outdated reports brew formula drift and exits non-zero" {
    stub brew '#!/bin/sh
case "$1 $2" in
    "outdated --formula")
        echo "eza (0.18.0) < 0.23.4"
        echo "ripgrep (14.0.3) < 14.1.1"
        ;;
    "outdated --cask")
        : # nothing
        ;;
esac'
    run "${REPO_ROOT}/update.sh" --outdated --no-fetch
    [ "${status}" -eq 1 ]
    [[ "${output}" == *"eza (0.18.0) < 0.23.4"* ]]
    [[ "${output}" == *"ripgrep (14.0.3) < 14.1.1"* ]]
    [[ "${output}" == *"2 items ready to upgrade"* ]]
}

@test "--outdated reports cask drift separately from formula drift" {
    stub brew '#!/bin/sh
case "$1 $2" in
    "outdated --formula") : ;;
    "outdated --cask")
        echo "iterm2 (3.4.21) != 3.5.10"
        ;;
esac'
    run "${REPO_ROOT}/update.sh" --outdated --no-fetch
    [ "${status}" -eq 1 ]
    [[ "${output}" == *"iterm2 (3.4.21) != 3.5.10"* ]]
    [[ "${output}" == *"Homebrew formulae"* ]]
    [[ "${output}" == *"Homebrew casks"* ]]
}

@test "--outdated prints the Node version when Volta is on PATH" {
    stub volta '#!/bin/sh
echo "Volta 2.0.0"'
    stub node '#!/bin/sh
echo "v24.16.0"'
    run "${REPO_ROOT}/update.sh" --outdated --no-fetch
    [[ "${output}" == *"Volta-managed Node"* ]]
    [[ "${output}" == *"v24.16.0"* ]]
    [[ "${output}" == *"volta install node@lts"* ]]
}

@test "--outdated notes Volta is missing when not on PATH" {
    run "${REPO_ROOT}/update.sh" --outdated --no-fetch
    [[ "${output}" == *"Volta not installed - skipping"* ]]
}

@test "--no-fetch suppresses git fetch calls" {
    # Set up a fake repo to detect whether git fetch was invoked.
    mkdir -p "${HOME}/.oh-my-zsh/.git"
    # Stub git so any `git fetch` would be visible — but with --no-fetch we
    # never call it. Use a sentinel file to make the assertion concrete.
    stub git '#!/bin/sh
if [ "$1" = "-C" ] && [ "$3" = "fetch" ]; then
    touch "'"${BATS_TEST_TMPDIR}"'/fetch-was-called"
fi
# Defer the rest to real git so rev-list etc. still work.
exec /usr/bin/git "$@"'
    run "${REPO_ROOT}/update.sh" --outdated --no-fetch
    [ ! -f "${BATS_TEST_TMPDIR}/fetch-was-called" ]
}

@test "--outdated --help-style invocation does not require sudo or network" {
    # Sanity: the entire --outdated path is read-only and finishes in <2s on
    # an empty environment. Mostly guards against a future regression that
    # accidentally re-introduces a mutation.
    run "${REPO_ROOT}/update.sh" --outdated --no-fetch
    [ "${status}" -eq 0 ]
    # Should not write a log file (--outdated skips the tee/exec block).
    ! ls "${HOME}"/mac-update-*.log >/dev/null 2>&1
}
