#!/usr/bin/env bats
#
# Integration tests for doctor.sh. Run with: bats tests/doctor.bats
#
# Strategy: each test sets a fake HOME under BATS_TEST_TMPDIR and a PATH that
# excludes the tools we want to look "uninstalled" (eza, brew, volta). Then we
# invoke ./doctor.sh as a subprocess and assert against its output. Checks for
# tools that aren't on the test PATH no-op as designed, so the test isolates
# one check at a time.

setup() {
    REPO_ROOT="$(cd "$(dirname "${BATS_TEST_FILENAME}")/.." && pwd)"
    export HOME="${BATS_TEST_TMPDIR}"
    # Strip /opt/homebrew, /usr/local, and the user's volta to keep checks
    # that depend on those tools quiet during tests.
    export PATH="/usr/bin:/bin"
}

@test "doctor passes when nothing relevant is configured" {
    # Empty HOME → every check should fall through its "not installed, skipping"
    # or "no alias configured" branch and pass cleanly.
    run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"Checks passed: 5"* ]]
}

@test "doctor flags eza alias when eza is uninstalled" {
    cat >"${HOME}/.zshrc" <<'EOF'
# Better ls with eza
alias ls="eza"
alias ll="eza -l"
alias tree="eza --tree"
EOF
    run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 1 ]
    [[ "${output}" == *"eza is not installed"* ]]
    [[ "${output}" == *"Issues found:"* ]]
}

@test "doctor --auto-fix --dry-run does not mutate .zshrc" {
    cat >"${HOME}/.zshrc" <<'EOF'
alias ls="eza"
EOF
    local before
    before=$(cat "${HOME}/.zshrc")
    run "${REPO_ROOT}/doctor.sh" --auto-fix --dry-run
    [[ "${output}" == *"[dry-run] would strip eza alias lines"* ]]
    [ "$(cat "${HOME}/.zshrc")" = "${before}" ]
}

@test "doctor --auto-fix strips eza alias lines and leaves a backup" {
    cat >"${HOME}/.zshrc" <<'EOF'
# Better ls with eza
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias tree="eza --tree"
alias gits="git status"
EOF
    run "${REPO_ROOT}/doctor.sh" --auto-fix
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"stripped eza alias lines"* ]]
    # The eza aliases should be gone…
    ! grep -q 'alias ls="eza"' "${HOME}/.zshrc"
    ! grep -q 'alias tree="eza' "${HOME}/.zshrc"
    # …but the unrelated git alias survives untouched.
    grep -q 'alias gits="git status"' "${HOME}/.zshrc"
    # And a timestamped backup was created.
    ls "${HOME}"/.zshrc.doctor-* >/dev/null
}

@test "doctor flags missing brew shellenv when brew exists on PATH" {
    # Stub a brew on PATH but leave .zprofile without the shellenv eval.
    mkdir -p "${BATS_TEST_TMPDIR}/stubbin"
    cat >"${BATS_TEST_TMPDIR}/stubbin/brew" <<'EOF'
#!/bin/sh
echo "Homebrew 4.5.0"
EOF
    chmod +x "${BATS_TEST_TMPDIR}/stubbin/brew"
    PATH="${BATS_TEST_TMPDIR}/stubbin:${PATH}" run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 1 ]
    [[ "${output}" == *"brew shellenv"* ]]
}

@test "doctor --auto-fix appends brew shellenv to .zprofile" {
    mkdir -p "${BATS_TEST_TMPDIR}/stubbin"
    printf '#!/bin/sh\necho stub\n' >"${BATS_TEST_TMPDIR}/stubbin/brew"
    chmod +x "${BATS_TEST_TMPDIR}/stubbin/brew"
    PATH="${BATS_TEST_TMPDIR}/stubbin:${PATH}" run "${REPO_ROOT}/doctor.sh" --auto-fix
    grep -q 'brew shellenv' "${HOME}/.zprofile"
}

@test "doctor flags Volta env when ~/.volta exists but VOLTA_HOME is unset" {
    mkdir -p "${HOME}/.volta"
    run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 1 ]
    [[ "${output}" == *"VOLTA_HOME is not exported"* ]]
}

@test "doctor accepts VOLTA_HOME in .zshenv (not just .zshrc)" {
    mkdir -p "${HOME}/.volta"
    cat >"${HOME}/.zshenv" <<'EOF'
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
EOF
    run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"Volta env: VOLTA_HOME wired up in ~/.zshenv"* ]]
}

@test "doctor flags stale xcode-select path" {
    mkdir -p "${BATS_TEST_TMPDIR}/stubbin"
    cat >"${BATS_TEST_TMPDIR}/stubbin/xcode-select" <<'EOF'
#!/bin/sh
echo "/Applications/Xcode-DELETED.app/Contents/Developer"
EOF
    chmod +x "${BATS_TEST_TMPDIR}/stubbin/xcode-select"
    PATH="${BATS_TEST_TMPDIR}/stubbin:${PATH}" run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 1 ]
    [[ "${output}" == *"xcode-select points at"* ]]
    [[ "${output}" == *"no longer exists"* ]]
}

@test "doctor flags missing ZSH theme files" {
    mkdir -p "${HOME}/.oh-my-zsh"
    cat >"${HOME}/.zshrc" <<'EOF'
ZSH_THEME="ghost-theme/ghost-theme"
EOF
    run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 1 ]
    [[ "${output}" == *"ZSH_THEME=\"ghost-theme/ghost-theme\""* ]]
    [[ "${output}" == *"no theme files found"* ]]
}

@test "doctor finds custom-themes-dir layout (powerlevel10k)" {
    mkdir -p "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
    touch "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
    cat >"${HOME}/.zshrc" <<'EOF'
ZSH_THEME="powerlevel10k/powerlevel10k"
EOF
    run "${REPO_ROOT}/doctor.sh"
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"ZSH theme: \"powerlevel10k/powerlevel10k\" found"* ]]
}

@test "doctor --help exits 0 and prints usage" {
    run "${REPO_ROOT}/doctor.sh" --help
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"Usage:"* ]]
}

@test "doctor rejects unknown flags with exit 2" {
    run "${REPO_ROOT}/doctor.sh" --not-a-flag
    [ "${status}" -eq 2 ]
    [[ "${output}" == *"Unknown argument"* ]]
}
