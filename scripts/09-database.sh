#!/bin/bash

# Database Tools Setup
# Installs: PostgreSQL, Sequel Ace

set -e  # Exit on any error

# Source common functions
source "$(dirname "$0")/common.sh"

print_section "Database Tools Setup"

check_macos
check_homebrew

# Database tools
print_status "Installing database tools..."
print_status "Installing PostgreSQL..."
brew install postgresql@15
brew services start postgresql@15
print_success "PostgreSQL installed and started"

# Database GUI
install_cask_app "Sequel Ace" "sequel-ace" "/Applications/Sequel Ace.app"

print_success "Database tools setup completed!"
echo ""
echo "Installed database tools:"
echo "• PostgreSQL 15 (running and auto-start enabled)"
echo "• Sequel Ace (database GUI)"
echo ""
echo "PostgreSQL usage:"
echo "• Create database: createdb your_project_name"
echo "• Connect: psql your_project_name"
echo "• Default connection: postgresql://localhost:5432"
echo ""
echo "Next steps:"
echo "• Test PostgreSQL: createdb testdb && psql testdb"
echo "• Run DevOps tools setup: ./scripts/10-devops.sh"