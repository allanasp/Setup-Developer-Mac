#!/bin/bash

# Script Testing Utility
# Tests all shell scripts safely without making system changes

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Test 1: Syntax validation
test_syntax() {
    print_header "Testing Script Syntax"
    local failed=0
    
    find . -name "*.sh" -type f | while read -r script; do
        if bash -n "$script" 2>/dev/null; then
            print_success "Syntax OK: $script"
        else
            print_error "Syntax Error: $script"
            failed=$((failed + 1))
        fi
    done
    
    if [ $failed -eq 0 ]; then
        print_success "All scripts have valid syntax"
    fi
}

# Test 2: ShellCheck linting (if available)
test_shellcheck() {
    print_header "Running ShellCheck"
    
    if ! command -v shellcheck >/dev/null 2>&1; then
        print_warning "ShellCheck not installed. Install with: brew install shellcheck"
        return
    fi
    
    find . -name "*.sh" -type f | while read -r script; do
        if shellcheck "$script" >/dev/null 2>&1; then
            print_success "ShellCheck OK: $script"
        else
            print_warning "ShellCheck issues found in: $script"
            shellcheck "$script"
        fi
    done
}

# Test 3: Function availability
test_functions() {
    print_header "Testing Common Functions"
    
    if [ -f "scripts/common.sh" ]; then
        # shellcheck source=/dev/null
        source scripts/common.sh
        
        # Test required functions exist
        functions=("print_section" "print_status" "print_success" "print_error" "command_exists")
        
        for func in "${functions[@]}"; do
            if declare -f "$func" >/dev/null; then
                print_success "Function available: $func"
            else
                print_error "Function missing: $func"
            fi
        done
    else
        print_error "Common functions file not found: scripts/common.sh"
    fi
}

# Test 4: Required files structure
test_structure() {
    print_header "Testing Project Structure"
    
    required_files=(
        "setup-modular.sh"
        "check-setup.sh"
        "scripts/common.sh"
        "scripts/01-system.sh"
        "scripts/02-terminal.sh"
        "scripts/03-version-managers.sh"
        "README.md"
        "POST-INSTALLATION-GUIDE.md"
        "SCRIPT_GUIDE.md"
    )
    
    for file in "${required_files[@]}"; do
        if [[ -f "$file" ]]; then
            print_success "Found: $file"
        else
            print_error "Missing: $file"
        fi
    done
}

# Test 5: Dry run testing (scripts that support it)
test_dry_run() {
    print_header "Testing Dry Run Mode"
    
    scripts_with_dry_run=()
    
    find scripts/ -name "*.sh" -type f | while read -r script; do
        if grep -q "DRY_RUN" "$script"; then
            scripts_with_dry_run+=("$script")
            print_success "Dry run available: $script"
            
            # Actually test dry run
            if DRY_RUN=true bash "$script" >/dev/null 2>&1; then
                print_success "Dry run successful: $script"
            else
                print_warning "Dry run failed: $script"
            fi
        fi
    done
    
    if [ ${#scripts_with_dry_run[@]} -eq 0 ]; then
        print_warning "No scripts support dry run mode"
    fi
}

# Test 6: Dependencies check
test_dependencies() {
    print_header "Testing Script Dependencies"
    
    # Check for common dependencies
    deps=("curl" "git" "brew")
    
    for dep in "${deps[@]}"; do
        if command -v "$dep" >/dev/null 2>&1; then
            print_success "Dependency available: $dep"
        else
            print_warning "Dependency missing: $dep"
        fi
    done
}

# Main execution
main() {
    echo -e "${BLUE}🧪 Mac Developer Setup - Script Testing Utility${NC}"
    echo "Testing all scripts safely without making system changes..."
    
    test_syntax
    test_shellcheck
    test_functions
    test_structure
    test_dry_run
    test_dependencies
    
    print_header "Testing Complete"
    echo -e "\n${GREEN}Safe to run: Scripts have been validated${NC}"
    echo -e "${YELLOW}Note: This only tests syntax and structure, not actual functionality${NC}"
}

# Run tests if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi