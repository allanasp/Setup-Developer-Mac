# Mac Developer Setup - Development Makefile
# Provides convenient commands for testing, linting, and formatting

.PHONY: help test lint format check install-deps clean docs docs-check

# Default target
help: ## Show this help message
	@echo "Mac Developer Setup - Development Commands"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Install development dependencies
install-deps: ## Install development dependencies (ShellCheck, etc.)
	@echo "Installing development dependencies..."
	@if ! command -v shellcheck >/dev/null 2>&1; then \
		echo "Installing ShellCheck..."; \
		brew install shellcheck; \
	else \
		echo "✅ ShellCheck already installed"; \
	fi
	@if ! command -v shfmt >/dev/null 2>&1; then \
		echo "Installing shfmt (shell formatter)..."; \
		brew install shfmt; \
	else \
		echo "✅ shfmt already installed"; \
	fi
	@echo "✅ Development dependencies ready"

# Run all tests
test: ## Run all script tests
	@echo "🧪 Running script tests..."
	@./test-runner.sh

# Lint all shell scripts
lint: ## Lint all shell scripts with ShellCheck
	@echo "🔍 Linting shell scripts..."
	@if ! command -v shellcheck >/dev/null 2>&1; then \
		echo "❌ ShellCheck not installed. Run 'make install-deps' first"; \
		exit 1; \
	fi
	@find . -name "*.sh" -type f | while read -r script; do \
		echo "Checking: $$script"; \
		shellcheck "$$script" || exit 1; \
	done
	@echo "✅ All scripts pass linting"

# Format all shell scripts
format: ## Format all shell scripts with shfmt
	@echo "✨ Formatting shell scripts..."
	@if ! command -v shfmt >/dev/null 2>&1; then \
		echo "❌ shfmt not installed. Run 'make install-deps' first"; \
		exit 1; \
	fi
	@find . -name "*.sh" -type f | while read -r script; do \
		echo "Formatting: $$script"; \
		shfmt -w -i 4 -ci "$$script"; \
	done
	@echo "✅ All scripts formatted"

# Check formatting without making changes
check-format: ## Check if scripts are properly formatted
	@echo "🔍 Checking script formatting..."
	@if ! command -v shfmt >/dev/null 2>&1; then \
		echo "❌ shfmt not installed. Run 'make install-deps' first"; \
		exit 1; \
	fi
	@find . -name "*.sh" -type f | while read -r script; do \
		if ! shfmt -d -i 4 -ci "$$script" >/dev/null 2>&1; then \
			echo "❌ Formatting issues in: $$script"; \
			shfmt -d -i 4 -ci "$$script"; \
			exit 1; \
		fi; \
	done
	@echo "✅ All scripts are properly formatted"

# Run syntax check only
check-syntax: ## Check script syntax without execution
	@echo "🔍 Checking script syntax..."
	@find . -name "*.sh" -type f | while read -r script; do \
		echo "Testing syntax: $$script"; \
		bash -n "$$script" || exit 1; \
	done
	@echo "✅ All scripts have valid syntax"

# Full check (lint + format check + syntax)
check: check-syntax lint check-format ## Run all checks (syntax, lint, format)
	@echo "✅ All checks passed"

# Make scripts executable
executable: ## Make all shell scripts executable
	@echo "🔧 Making scripts executable..."
	@find . -name "*.sh" -type f -exec chmod +x {} \;
	@echo "✅ All scripts are now executable"

# Clean temporary files
clean: ## Clean temporary files and caches
	@echo "🧹 Cleaning temporary files..."
	@find . -name "*.tmp" -type f -delete 2>/dev/null || true
	@find . -name ".DS_Store" -type f -delete 2>/dev/null || true
	@echo "✅ Cleanup complete"

# Run GitHub Actions tests locally (requires act)
test-ci: ## Run GitHub Actions tests locally (requires 'act')
	@if ! command -v act >/dev/null 2>&1; then \
		echo "❌ 'act' not installed. Install with: brew install act"; \
		exit 1; \
	fi
	@echo "🚀 Running GitHub Actions locally..."
	@act -j lint-scripts

# Development workflow - format, lint, and test
dev: format lint test ## Development workflow: format, lint, and test
	@echo "🎉 Development checks complete - ready to commit!"

# Test interactive prompts (dry run)
test-interactive: ## Test the interactive prompt system
	@echo "🧪 Testing interactive prompts..."
	@echo "This will run setup in test mode with prompts"
	@DRY_RUN=true ./setup.sh --skip-prompts

# Pre-commit checks
pre-commit: check test docs-check ## Pre-commit checks (use in git hooks)
	@echo "✅ Pre-commit checks passed"

# Regenerate README + tools-guide from data/tools.json
docs: ## Regenerate tool catalogue sections in README + docs/tools-guide.md
	@./scripts/lib/generate-docs.sh

# CI-friendly check that generated docs are in sync with data/tools.json
docs-check: ## Fail if README/tools-guide drift from data/tools.json
	@./scripts/lib/generate-docs.sh --check