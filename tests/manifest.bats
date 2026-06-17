#!/usr/bin/env bats
#
# Integration tests for manifest.sh. Run with: bats tests/manifest.bats
#
# Strategy: each test sets a fake HOME under BATS_TEST_TMPDIR and prepends a
# stub bin/ directory to PATH that provides deterministic brew/volta/pyenv
# fakes. jq stays on the real PATH (manifest.sh hard-requires it) so the
# tests can shell out to jq themselves to assert against the JSON.

setup() {
    REPO_ROOT="$(cd "$(dirname "${BATS_TEST_FILENAME}")/.." && pwd)"
    export HOME="${BATS_TEST_TMPDIR}"
    STUB_BIN="${BATS_TEST_TMPDIR}/bin"
    mkdir -p "${STUB_BIN}"
    # jq (and realpath on macOS) come from Homebrew. Resolve jq's dir from
    # the inherited PATH once, then rebuild PATH so stubs win first but jq /
    # other Homebrew CLIs are still reachable.
    local jq_dir
    jq_dir="$(dirname "$(command -v jq)")"
    export PATH="${STUB_BIN}:${jq_dir}:/usr/bin:/bin"
}

# Helper — write a stub binary that emits the given stdout for any args.
stub() {
    local name="$1"
    shift
    cat >"${STUB_BIN}/${name}" <<EOF
#!/bin/bash
cat <<'STUBOUT'
$*
STUBOUT
EOF
    chmod +x "${STUB_BIN}/${name}"
}

@test "manifest with no args prints help and exits 0" {
    run "${REPO_ROOT}/manifest.sh"
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"Usage:"* ]]
    [[ "${output}" == *"export"* ]]
}

@test "manifest -h prints help" {
    run "${REPO_ROOT}/manifest.sh" -h
    [ "${status}" -eq 0 ]
    [[ "${output}" == *"Usage:"* ]]
}

@test "unknown command exits 2" {
    run "${REPO_ROOT}/manifest.sh" bogus
    [ "${status}" -eq 2 ]
    [[ "${output}" == *"Unknown command"* ]]
}

@test "unknown export arg exits 2" {
    run "${REPO_ROOT}/manifest.sh" export --bogus
    [ "${status}" -eq 2 ]
    [[ "${output}" == *"Unknown export arg"* ]]
}

@test "export produces valid JSON with expected top-level keys" {
    # No brew/volta/pyenv stubs → those sections fall back to empty defaults.
    run "${REPO_ROOT}/manifest.sh" export
    [ "${status}" -eq 0 ]
    # Pipe output through jq for validation + key extraction.
    keys=$(jq -r 'keys | join(",")' <<<"${output}")
    [[ "${keys}" == *"schema_version"* ]]
    [[ "${keys}" == *"exported_at"* ]]
    [[ "${keys}" == *"host"* ]]
    [[ "${keys}" == *"setup_repo"* ]]
    [[ "${keys}" == *"homebrew"* ]]
    [[ "${keys}" == *"volta"* ]]
    [[ "${keys}" == *"pyenv"* ]]
    [[ "${keys}" == *"curl_installs"* ]]
}

@test "schema_version is 1" {
    run "${REPO_ROOT}/manifest.sh" export
    [ "${status}" -eq 0 ]
    [ "$(jq -r '.schema_version' <<<"${output}")" = "1" ]
}

@test "missing brew → empty homebrew arrays" {
    run "${REPO_ROOT}/manifest.sh" export
    [ "${status}" -eq 0 ]
    [ "$(jq -r '.homebrew.formulae | length' <<<"${output}")" = "0" ]
    [ "$(jq -r '.homebrew.casks | length' <<<"${output}")" = "0" ]
    [ "$(jq -r '.homebrew.taps | length' <<<"${output}")" = "0" ]
}

@test "stubbed brew → formulae array is populated" {
    cat >"${STUB_BIN}/brew" <<'EOF'
#!/bin/bash
case "$*" in
    "list --formula -1") printf 'jq\ngit\nfd\n' ;;
    "list --cask -1") printf 'firefox\niterm2\n' ;;
    tap) printf 'homebrew/cask\nhashicorp/tap\n' ;;
    *) ;;
esac
EOF
    chmod +x "${STUB_BIN}/brew"
    run "${REPO_ROOT}/manifest.sh" export
    [ "${status}" -eq 0 ]
    [ "$(jq -r '.homebrew.formulae | length' <<<"${output}")" = "3" ]
    [ "$(jq -r '.homebrew.formulae[1]' <<<"${output}")" = "git" ]
    [ "$(jq -r '.homebrew.casks | length' <<<"${output}")" = "2" ]
    [ "$(jq -r '.homebrew.taps | length' <<<"${output}")" = "2" ]
}

@test "stubbed volta → node version + packages parsed" {
    cat >"${STUB_BIN}/volta" <<'EOF'
#!/bin/bash
# `volta list --format=plain` output
cat <<'OUT'
runtime node@20.11.0
package typescript@5.4.0 / tsc / node@20.11.0
package @vue/cli@5.0.8 / vue / node@20.11.0
OUT
EOF
    chmod +x "${STUB_BIN}/volta"
    # node --version is read separately
    cat >"${STUB_BIN}/node" <<'EOF'
#!/bin/bash
echo "v20.11.0"
EOF
    chmod +x "${STUB_BIN}/node"
    run "${REPO_ROOT}/manifest.sh" export
    [ "${status}" -eq 0 ]
    [ "$(jq -r '.volta.node' <<<"${output}")" = "v20.11.0" ]
    [ "$(jq -r '.volta.packages | length' <<<"${output}")" = "2" ]
    [ "$(jq -r '.volta.packages[0]' <<<"${output}")" = "typescript" ]
    [ "$(jq -r '.volta.packages[1]' <<<"${output}")" = "@vue/cli" ]
}

@test "stubbed pyenv → versions + global" {
    cat >"${STUB_BIN}/pyenv" <<'EOF'
#!/bin/bash
case "$*" in
    "versions --bare") printf '3.11.7\n3.12.1\n' ;;
    global) printf '3.12.1\n' ;;
esac
EOF
    chmod +x "${STUB_BIN}/pyenv"
    run "${REPO_ROOT}/manifest.sh" export
    [ "${status}" -eq 0 ]
    [ "$(jq -r '.pyenv.versions | length' <<<"${output}")" = "2" ]
    [ "$(jq -r '.pyenv.global' <<<"${output}")" = "3.12.1" ]
}

@test "Oh My Zsh + PowerLevel10k presence reflected in curl_installs" {
    mkdir -p "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
    run "${REPO_ROOT}/manifest.sh" export
    [ "${status}" -eq 0 ]
    [ "$(jq -r '.curl_installs.oh_my_zsh' <<<"${output}")" = "true" ]
    [ "$(jq -r '.curl_installs.powerlevel10k' <<<"${output}")" = "true" ]
}

@test "--compact mode emits single-line JSON" {
    run "${REPO_ROOT}/manifest.sh" export --compact
    [ "${status}" -eq 0 ]
    # One non-empty line of output.
    line_count=$(printf '%s\n' "${output}" | grep -c .)
    [ "${line_count}" -eq 1 ]
    # Still valid JSON.
    echo "${output}" | jq -e . >/dev/null
}

# Note: a "missing jq" test was considered but skipped — recent macOS bundles
# /usr/bin/jq, which is on the same PATH the script needs for dirname/awk/etc.
# Isolating one without losing the other isn't worth the test scaffolding.
