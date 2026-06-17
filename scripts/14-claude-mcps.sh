#!/bin/bash

# Claude Code MCP setup — register hosted MCP (Model Context Protocol)
# servers with the Claude Code CLI.
#
# Most of these mirror the same connectors people enable on claude.ai. By
# registering them in Claude Code too, you get the same tool surface in the
# terminal without each project needing to repeat the wiring.
#
# All servers use OAuth (or are public) so no API keys end up on disk — the
# first time Claude reaches one of them it pops a browser tab to authorize.
#
# Requires: `claude` CLI on PATH (installed by 06-dev-apps.sh).

set -e

source "$(dirname "$0")/common.sh"

print_section "Claude Code MCP Setup"
check_macos

# Bail early if Claude CLI isn't on PATH — but make this a soft skip, not a
# hard failure, so the orchestrator can keep going.
if ! command_exists claude; then
    print_warning "Claude CLI not found on PATH."
    echo "Install Claude Code first (./scripts/06-dev-apps.sh) and re-run this script."
    return 0 2>/dev/null || exit 0
fi

# name | transport | url
# Order matches the claude.ai connector list a frontend dev would typically use.
MCPS=(
    "sentry|http|https://mcp.sentry.dev/mcp"
    "posthog|http|https://mcp.posthog.com/mcp"
    "vercel|http|https://mcp.vercel.com"
    "sanity|http|https://mcp.sanity.io"
    "postman|http|https://mcp.postman.com/mcp"
    "expo|http|https://mcp.expo.dev/mcp"
    "mermaid-chart|http|https://mcp.mermaidchart.com/mcp"
    "nuxt-ui|sse|https://mcp.ui.nuxt.com/sse"
    "nuxt|sse|https://mcp.nuxt.com/sse"
)

# Cache the current registration list once — avoids spawning `claude mcp list`
# per server, which is the slow part of this script.
existing=""
if ! is_dry_run; then
    existing=$(claude mcp list 2>/dev/null || true)
fi

added=0
skipped=0
failed=0

for entry in "${MCPS[@]}"; do
    IFS='|' read -r name transport url <<<"${entry}"

    if is_dry_run; then
        print_status "[dry-run] would register MCP: ${name} (${transport}) → ${url}"
        continue
    fi

    if grep -qE "^${name}[[:space:]:]" <<<"${existing}"; then
        print_success "MCP already registered: ${name}"
        skipped=$((skipped + 1))
        continue
    fi

    print_status "Registering MCP: ${name} (${transport})..."
    if claude mcp add --transport "${transport}" "${name}" "${url}" >/dev/null 2>&1; then
        print_success "Registered MCP: ${name}"
        added=$((added + 1))
    else
        print_warning "Failed to register ${name} — add it manually with:"
        echo "    claude mcp add --transport ${transport} ${name} ${url}"
        failed=$((failed + 1))
    fi
done

echo ""
if is_dry_run; then
    print_success "MCP setup (dry-run) complete — ${#MCPS[@]} server(s) would be registered."
else
    print_success "MCP setup complete — ${added} added, ${skipped} already present, ${failed} failed."
fi

echo ""
echo "📋 TODO: Manual MCP Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "□ Authorize each MCP (one-time, per server):"
echo "  → In Claude Code, run /mcp"
echo "  → Pick a server and step through the OAuth browser flow"
echo ""
echo "□ Figma Dev Mode MCP (local-only — not auto-registered)"
echo "  → Open Figma desktop → Preferences → toggle 'Enable local MCP server'"
echo "  → Then: claude mcp add --transport http figma http://127.0.0.1:3845/mcp"
echo "  → Hosted alternative (needs Figma plan with remote MCP):"
echo "    claude mcp add --transport http figma https://mcp.figma.com/mcp"
echo ""
echo "□ Three.js 3D Viewer (no public hosted endpoint)"
echo "  → Connect via claude.ai → Settings → Connectors → Three.js 3D Viewer"
echo "  → Or look up the URL there and add with: claude mcp add --transport http threejs <url>"
echo ""
echo "Useful commands:"
echo "• claude mcp list                  # see registered MCPs"
echo "• claude mcp remove <name>         # remove an MCP"
echo "• /mcp (inside Claude)             # manage / authorize servers interactively"
