#!/bin/bash
#
# Pre-Commit Tests Hook
# Ensures all tests pass before allowing a commit
#
# Install this hook:
# cp pre-commit-tests.sh .git/hooks/pre-commit
# chmod +x .git/hooks/pre-commit

echo "🧪 Running pre-commit checks..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track if any check failed
FAILED=0

# Function to print error and set failed flag
fail() {
    echo -e "${RED}❌ $1${NC}"
    FAILED=1
}

# Function to print success
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print warning
warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# ============================================
# 1. Check for secrets/API keys
# ============================================
echo "🔍 Checking for secrets..."

SECRETS_PATTERNS=(
    "sk-[a-zA-Z0-9]+"  # Anthropic API keys
    "AIza[0-9A-Za-z\\-_]{35}"  # Google API keys
    "AKIA[0-9A-Z]{16}"  # AWS Access Keys
    "ghp_[a-zA-Z0-9]{36}"  # GitHub Personal Access Tokens
    "password\s*=\s*['\"][^'\"]{8,}['\"]"  # Hardcoded passwords
    "api_key\s*=\s*['\"][^'\"]+['\"]"  # API keys
)

for pattern in "${SECRETS_PATTERNS[@]}"; do
    if git diff --cached --name-only | xargs grep -E "$pattern" 2>/dev/null; then
        fail "Possible secret/API key found! Remove before committing."
        echo "  Pattern: $pattern"
        FAILED=1
    fi
done

if [ $FAILED -eq 0 ]; then
    success "No secrets found"
fi

# Reset for next checks
FAILED=0

# ============================================
# 2. Check for debug code
# ============================================
echo ""
echo "🐛 Checking for debug code..."

DEBUG_PATTERNS=(
    "console\.log"
    "print\("
    "var_dump"
    "dd\("
    "debugger"
)

for pattern in "${DEBUG_PATTERNS[@]}"; do
    matches=$(git diff --cached --name-only | xargs grep -n "$pattern" 2>/dev/null)
    if [ ! -z "$matches" ]; then
        warn "Found debug code: $pattern"
        echo "$matches"
        # Don't fail, just warn
    fi
done

success "Debug code check complete"

# ============================================
# 3. Run Tests (Language-Specific)
# ============================================
echo ""
echo "🧪 Running tests..."

# Python Projects
if [ -f "pytest.ini" ] || [ -f "setup.py" ] || [ -d "tests/" ]; then
    echo "  → Detected Python project"

    if command -v pytest &> /dev/null; then
        pytest --quiet --tb=short
        if [ $? -ne 0 ]; then
            fail "Python tests failed!"
            FAILED=1
        else
            success "Python tests passed"
        fi
    else
        warn "pytest not found. Install with: pip install pytest"
    fi
fi

# JavaScript/Node Projects
if [ -f "package.json" ]; then
    echo "  → Detected Node.js project"

    if [ -f "node_modules/.bin/jest" ] || command -v npm &> /dev/null; then
        npm test -- --passWithNoTests
        if [ $? -ne 0 ]; then
            fail "JavaScript tests failed!"
            FAILED=1
        else
            success "JavaScript tests passed"
        fi
    else
        warn "npm not found"
    fi
fi

# PHP Projects
if [ -f "phpunit.xml" ] || [ -f "phpunit.xml.dist" ]; then
    echo "  → Detected PHP project"

    if command -v phpunit &> /dev/null; then
        phpunit --stop-on-failure
        if [ $? -ne 0 ]; then
            fail "PHP tests failed!"
            FAILED=1
        else
            success "PHP tests passed"
        fi
    else
        warn "phpunit not found"
    fi
fi

# ============================================
# 4. Linting (Optional but recommended)
# ============================================
echo ""
echo "🔍 Running linters..."

# Python Linting
if command -v flake8 &> /dev/null && [ -d "src/" ]; then
    echo "  → Running flake8..."
    flake8 src/ --count --select=E9,F63,F7,F82 --show-source --statistics
    if [ $? -ne 0 ]; then
        warn "Linting issues found (not blocking)"
    else
        success "Python linting passed"
    fi
fi

# JavaScript Linting
if [ -f "node_modules/.bin/eslint" ]; then
    echo "  → Running eslint..."
    node_modules/.bin/eslint . --quiet
    if [ $? -ne 0 ]; then
        warn "ESLint issues found (not blocking)"
    else
        success "JavaScript linting passed"
    fi
fi

# ============================================
# 5. Commit Message Validation (if available)
# ============================================
if [ -f ".git/COMMIT_EDITMSG" ]; then
    COMMIT_MSG=$(cat .git/COMMIT_EDITMSG)

    # Check for Conventional Commits format
    if ! echo "$COMMIT_MSG" | grep -qE "^(feat|fix|docs|style|refactor|test|chore|perf|ci)(\(.+\))?: .+"; then
        warn "Commit message doesn't follow Conventional Commits format"
        echo "  Expected: type(scope): description"
        echo "  Examples: feat: Add login, fix: Resolve bug"
    fi
fi

# ============================================
# Final Result
# ============================================
echo ""
echo "================================"

if [ $FAILED -eq 1 ]; then
    echo -e "${RED}❌ Pre-commit checks FAILED!${NC}"
    echo ""
    echo "Fix the issues above and try again."
    echo ""
    echo "To bypass this hook (NOT RECOMMENDED):"
    echo "  git commit --no-verify"
    exit 1
else
    echo -e "${GREEN}✅ All pre-commit checks passed!${NC}"
    echo "Proceeding with commit..."
    exit 0
fi
