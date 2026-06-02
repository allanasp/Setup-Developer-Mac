#!/bin/bash

# Database Tools Setup
# Installs: PostgreSQL, DBeaver Community Edition, Supabase CLI

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Database Tools Setup"

check_macos
check_homebrew

# Database tools
print_status "Installing database tools..."
install_brew_formula "postgresql@15" "PostgreSQL 15"
if brew services start postgresql@15; then
    print_success "PostgreSQL service started"
else
    print_warning "PostgreSQL service may already be running - continuing"
fi

# Add PostgreSQL to PATH (architecture-aware prefix from common.sh)
if ! grep -q "postgresql@15" ~/.zshrc 2>/dev/null; then
    echo '' >> ~/.zshrc
    echo '# PostgreSQL' >> ~/.zshrc
    echo "export PATH=\"${BREW_PREFIX}/opt/postgresql@15/bin:\${PATH}\"" >> ~/.zshrc
    print_success "PostgreSQL added to PATH in .zshrc"
fi

# Add to current session
export PATH="${BREW_PREFIX}/opt/postgresql@15/bin:${PATH}"
print_success "PostgreSQL installed and started"

# Database GUIs
install_cask_app "DBeaver Community Edition" "dbeaver-community" "/Applications/DBeaver.app"
install_cask_app "pgAdmin 4" "pgadmin4" "/Applications/pgAdmin 4.app"

# Supabase CLI
if command_exists supabase; then
    print_success "Supabase CLI already installed"
else
    install_brew_formula "supabase/tap/supabase" "Supabase CLI"
fi

print_success "Database tools setup completed!"
echo ""
echo "Installed database tools:"
echo "• PostgreSQL 15 (running and auto-start enabled)"
echo "• DBeaver Community Edition (universal database GUI)"
echo "• pgAdmin 4 (PostgreSQL-focused GUI)"
echo "• Supabase CLI (backend-as-a-service)"
echo ""
echo "📋 TODO: Database Setup & Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "□ DBeaver Setup (Database GUI)"
echo "  → Open DBeaver"
echo "  → Create new connection: PostgreSQL"
echo "  → Connection settings: Host: localhost, Port: 5432"
echo "  → Database: postgres, Username: $USER"
echo "  → Test connection and save"
echo ""
echo "□ Supabase Account (for cloud database projects)"
echo "  → Sign up: https://supabase.com"
echo "  → Login: supabase login"
echo ""
echo "PostgreSQL usage (local - no account needed):"
echo "• Create database: createdb your_project_name"
echo "• Connect: psql your_project_name"
echo "• Default connection: postgresql://localhost:5432"
echo ""
echo "Supabase CLI usage (after authentication):"
echo "• Initialize project: supabase init"
echo "• Start local dev: supabase start"
echo "• Link to cloud project: supabase link --project-ref <project-ref>"
echo ""
echo "Next steps:"
echo "• Test PostgreSQL: createdb testdb && psql testdb"
echo "• Run DevOps tools setup: ./scripts/10-devops.sh"
