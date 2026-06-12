#!/bin/bash
# generate-docs.sh — render data/tools.json into README.md + docs/tools-guide.md.
#
# Both target files contain marker blocks of the form:
#   <!-- TOOLS:BEGIN:<region> -->
#   ...generated content...
#   <!-- TOOLS:END:<region> -->
# This script replaces the content between matching markers in-place. Anything
# outside the markers is left alone, so the rest of each file stays hand-written.
#
# Usage:
#   scripts/lib/generate-docs.sh            # regenerate everything
#   scripts/lib/generate-docs.sh --check    # exit non-zero if files would change
#
# Requires: jq.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DATA="${ROOT}/data/tools.json"
README="${ROOT}/README.md"
TOOLS_GUIDE="${ROOT}/docs/tools-guide.md"

CHECK_MODE=0
[[ "${1:-}" == "--check" ]] && CHECK_MODE=1

command -v jq >/dev/null || { echo "jq is required" >&2; exit 1; }
[[ -f "$DATA" ]] || { echo "missing $DATA" >&2; exit 1; }

# ----------------------------------------------------------
# Renderers (write to stdout). Each takes no args; reads $DATA.
# ----------------------------------------------------------

# Icon img tag from simple-icons, or empty string if no icon.
# Used as a jq filter applied to each tool object.
ICON_FILTER='
  def icon_tag:
    if .icon == null then ""
    else "<img src=\"https://cdn.simpleicons.org/\(.icon)\" width=\"14\" alt=\"\" align=\"center\"/> "
    end;
'

render_readme_overview() {
  jq -r "${ICON_FILTER}"'
    .scripts as $scripts
    | .tools as $tools
    | $scripts[]
    | . as $s
    | "### \($s.number). \($s.title) \(if $s.tier == "essential" then "_(essential, auto-installed)_" else "_(optional)_" end)\n\n*`\($s.file)` — \($s.summary)*\n\n| Tool | What it is | Kind |\n|---|---|---|\n" +
      ([$tools[] | select(.script_id == $s.id)
        | "| \(. | icon_tag)**\(.name)** | \(.description) | \(.kind) |"] | join("\n")) +
      "\n"
  ' "$DATA"
}

render_tools_guide_sections() {
  jq -r "${ICON_FILTER}"'
    .scripts as $scripts
    | .tools as $tools
    | $scripts[]
    | . as $s
    | "## \($s.title)\n\n> **Category:** \(if $s.tier == "essential" then "Essential" else "Optional" end) — installed by `\($s.file)`. \($s.summary)\n" +
      ([$tools[] | select(.script_id == $s.id)
        | "\n### \(. | icon_tag)\(.name)\n\n**Kind:** \(.kind)  \n**What it is:** \(.description)" +
          (if .url == null then "" else "  \n**Homepage:** [\(.url)](\(.url))" end)
      ] | join("\n")) +
      "\n"
  ' "$DATA"
}

# ----------------------------------------------------------
# In-place marker replacement.
# replace_block <file> <region-name> <content-cmd>
# ----------------------------------------------------------
replace_block() {
  local file="$1" region="$2" content_cmd="$3"
  local begin="<!-- TOOLS:BEGIN:${region} -->"
  local end="<!-- TOOLS:END:${region} -->"
  local tmp body_tmp

  [[ -f "$file" ]] || { echo "missing $file" >&2; return 1; }

  if ! grep -qF "$begin" "$file" || ! grep -qF "$end" "$file"; then
    echo "warn: markers for region '$region' not found in $file — skipping" >&2
    return 0
  fi

  # Write generated content to a tempfile, then have awk splice it in via
  # getline. Passing multi-line content through -v is unreliable.
  body_tmp="$(mktemp)"
  tmp="$(mktemp)"
  trap 'rm -f "$body_tmp" "$tmp"' RETURN

  "$content_cmd" > "$body_tmp"

  awk -v begin="$begin" -v end="$end" -v body_file="$body_tmp" '
    function emit_body(   line) {
      while ((getline line < body_file) > 0) print line
      close(body_file)
    }
    BEGIN { skip = 0 }
    {
      if (skip == 1) {
        if (index($0, end) > 0) {
          emit_body()
          print
          skip = 0
        }
        next
      }
      print
      if (index($0, begin) > 0) {
        skip = 1
      }
    }
  ' "$file" > "$tmp"

  # Sanity: never replace a non-empty file with an empty one.
  if [[ ! -s "$tmp" && -s "$file" ]]; then
    echo "error: generated output for $file is empty — aborting" >&2
    return 1
  fi

  if cmp -s "$file" "$tmp"; then
    return 0
  fi

  if [[ "$CHECK_MODE" == "1" ]]; then
    echo "would update: $file [region: $region]" >&2
    return 2
  fi

  cp "$tmp" "$file"
  echo "updated: $file [region: $region]"
}

# ----------------------------------------------------------
# Main
# ----------------------------------------------------------
rc=0
replace_block "$README"     "overview"     render_readme_overview     || rc=$?
replace_block "$TOOLS_GUIDE" "catalogue"    render_tools_guide_sections || rc=$?

if [[ "$CHECK_MODE" == "1" && "$rc" != "0" ]]; then
  echo "docs are out of date — run scripts/lib/generate-docs.sh" >&2
  exit 1
fi

exit 0
