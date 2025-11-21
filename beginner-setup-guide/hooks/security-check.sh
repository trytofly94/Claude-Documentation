#!/bin/bash
#
# Security Check Hook
# Scans for common security issues before commit
#
# Install as pre-commit hook:
# cp security-check.sh .git/hooks/pre-commit
# chmod +x .git/hooks/pre-commit

echo "🔒 Running security checks..."
echo ""

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ISSUES_FOUND=0

fail() {
    echo -e "${RED}🚨 SECURITY ISSUE: $1${NC}"
    ISSUES_FOUND=1
}

warn() {
    echo -e "${YELLOW}⚠️  Security Warning: $1${NC}"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# ============================================
# 1. Secrets Detection
# ============================================
echo "🔑 Checking for exposed secrets..."

# Get staged files
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM)

# API Keys patterns
API_KEY_PATTERNS=(
    # Anthropic
    'sk-ant-[a-zA-Z0-9\-_]{95}'

    # OpenAI
    'sk-[a-zA-Z0-9]{48}'

    # AWS
    'AKIA[0-9A-Z]{16}'
    'aws_secret_access_key.*=.*[A-Za-z0-9/+=]{40}'

    # Google
    'AIza[0-9A-Za-z\-_]{35}'

    # GitHub
    'ghp_[a-zA-Z0-9]{36}'
    'github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59}'

    # Generic patterns
    'api_key.*=.*["\047][^"\047]{20,}["\047]'
    'api_secret.*=.*["\047][^"\047]{20,}["\047]'
    'apikey.*=.*["\047][^"\047]{20,}["\047]'
    'access_token.*=.*["\047][^"\047]{20,}["\047]'
    'secret_key.*=.*["\047][^"\047]{20,}["\047]'
)

for pattern in "${API_KEY_PATTERNS[@]}"; do
    matches=$(echo "$STAGED_FILES" | xargs grep -En "$pattern" 2>/dev/null || true)
    if [ ! -z "$matches" ]; then
        fail "Possible API key/secret found!"
        echo "$matches" | while read line; do
            echo "  📍 $line"
        done
        echo ""
    fi
done

if [ $ISSUES_FOUND -eq 0 ]; then
    success "No exposed secrets found"
fi

# ============================================
# 2. Password Detection
# ============================================
echo ""
echo "🔐 Checking for hardcoded passwords..."

PASSWORD_PATTERNS=(
    'password\s*=\s*["\047][^"\047]{6,}["\047]'
    'pwd\s*=\s*["\047][^"\047]{6,}["\047]'
    'passwd\s*=\s*["\047][^"\047]{6,}["\047]'
    'DB_PASSWORD\s*=\s*["\047][^"\047]+["\047]'
)

for pattern in "${PASSWORD_PATTERNS[@]}"; do
    matches=$(echo "$STAGED_FILES" | xargs grep -En "$pattern" 2>/dev/null || true)
    if [ ! -z "$matches" ]; then
        # Exclude comments and example configs
        matches=$(echo "$matches" | grep -v "^\s*#" | grep -v "^\s*//" | grep -v "example" || true)
        if [ ! -z "$matches" ]; then
            fail "Hardcoded password found!"
            echo "$matches" | while read line; do
                echo "  📍 $line"
            done
            echo ""
        fi
    fi
done

# ============================================
# 3. SQL Injection Vulnerabilities
# ============================================
echo ""
echo "💉 Checking for SQL injection risks..."

SQL_PATTERNS=(
    # Python - string concatenation in SQL
    'cursor\.execute\([^?]*\+[^?]*\)'
    'cursor\.execute\([^?]*%[^?]*\)'
    'query.*=.*["\047].*\+.*["\047]'

    # PHP - unsanitized SQL
    '\$wpdb->query\(\s*\$'
    'mysql_query\([^$]*\$'

    # JavaScript - string templates in SQL
    'query.*=.*`.*\$\{.*\}.*`'
)

for pattern in "${SQL_PATTERNS[@]}"; do
    matches=$(echo "$STAGED_FILES" | xargs grep -En "$pattern" 2>/dev/null || true)
    if [ ! -z "$matches" ]; then
        warn "Possible SQL injection vulnerability"
        echo "$matches" | while read line; do
            echo "  📍 $line"
        done
        echo "  💡 Use parameterized queries or ORM methods"
        echo ""
    fi
done

# ============================================
# 4. XSS Vulnerabilities (Web)
# ============================================
echo ""
echo "🌐 Checking for XSS vulnerabilities..."

XSS_PATTERNS=(
    # PHP - unescaped output
    'echo\s+\$_(GET|POST|REQUEST)'
    'print\s+\$_(GET|POST|REQUEST)'

    # WordPress - unescaped output
    'echo\s+\$[a-zA-Z_]+(?!.*esc_)'

    # JavaScript - innerHTML with variables
    'innerHTML\s*=.*\+'
    'innerHTML\s*=.*\$\{'
)

for pattern in "${XSS_PATTERNS[@]}"; do
    matches=$(echo "$STAGED_FILES" | xargs grep -En "$pattern" 2>/dev/null || true)
    if [ ! -z "$matches" ]; then
        warn "Possible XSS vulnerability"
        echo "$matches" | while read line; do
            echo "  📍 $line"
        done
        echo "  💡 Escape output: esc_html(), htmlspecialchars(), textContent"
        echo ""
    fi
done

# ============================================
# 5. Dangerous Functions
# ============================================
echo ""
echo "⚠️  Checking for dangerous functions..."

DANGEROUS_PATTERNS=(
    # PHP
    'eval\('
    'exec\('
    'shell_exec\('
    'system\('
    'passthru\('

    # Python
    'eval\('
    'exec\('
    '__import__\('

    # JavaScript
    'eval\('
    'Function\('
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    matches=$(echo "$STAGED_FILES" | xargs grep -En "$pattern" 2>/dev/null || true)
    if [ ! -z "$matches" ]; then
        warn "Dangerous function usage: $pattern"
        echo "$matches" | while read line; do
            echo "  📍 $line"
        done
        echo "  💡 Avoid using these functions if possible"
        echo ""
    fi
done

# ============================================
# 6. File Upload Vulnerabilities
# ============================================
echo ""
echo "📤 Checking file upload security..."

UPLOAD_PATTERNS=(
    # PHP - unrestricted file upload
    'move_uploaded_file\('
    '\$_FILES'
)

for pattern in "${UPLOAD_PATTERNS[@]}"; do
    matches=$(echo "$STAGED_FILES" | xargs grep -En "$pattern" 2>/dev/null || true)
    if [ ! -z "$matches" ]; then
        warn "File upload code found - ensure proper validation!"
        echo "  💡 Checklist:"
        echo "    - Validate file type (MIME and extension)"
        echo "    - Validate file size"
        echo "    - Sanitize filename"
        echo "    - Store outside webroot or randomize names"
        echo ""
    fi
done

# ============================================
# 7. Insecure Configurations
# ============================================
echo ""
echo "⚙️  Checking for insecure configurations..."

# Check if sensitive files are being committed
SENSITIVE_FILES=(
    ".env"
    ".env.local"
    ".env.production"
    "credentials.json"
    "secrets.json"
    "private.key"
    "id_rsa"
    "*.pem"
    "*.p12"
)

for file in "${SENSITIVE_FILES[@]}"; do
    if echo "$STAGED_FILES" | grep -q "$file"; then
        fail "Attempting to commit sensitive file: $file"
        echo "  💡 Add to .gitignore: echo '$file' >> .gitignore"
        echo ""
    fi
done

# ============================================
# 8. WordPress-Specific Checks
# ============================================
if echo "$STAGED_FILES" | grep -q "\.php$"; then
    echo ""
    echo "🔌 Running WordPress-specific checks..."

    # Check for nonce validation in forms
    if echo "$STAGED_FILES" | xargs grep -l "<form" 2>/dev/null | xargs grep -L "wp_nonce_field" 2>/dev/null; then
        warn "Form found without nonce protection"
        echo "  💡 Add: wp_nonce_field('action_name', 'nonce_field_name')"
        echo ""
    fi

    # Check for direct database queries without $wpdb->prepare
    matches=$(echo "$STAGED_FILES" | xargs grep -En '\$wpdb->(query|get_results|get_row)\([^$]*\$' 2>/dev/null || true)
    if [ ! -z "$matches" ]; then
        warn "Unprepared database query found"
        echo "$matches" | while read line; do
            echo "  📍 $line"
        done
        echo "  💡 Use: \$wpdb->prepare()"
        echo ""
    fi
fi

# ============================================
# Final Report
# ============================================
echo ""
echo "================================"

if [ $ISSUES_FOUND -eq 1 ]; then
    echo -e "${RED}🚨 SECURITY ISSUES FOUND!${NC}"
    echo ""
    echo "Please fix the critical security issues above before committing."
    echo ""
    echo "⚠️  To bypass (NOT RECOMMENDED unless false positive):"
    echo "  git commit --no-verify"
    echo ""
    exit 1
else
    echo -e "${GREEN}✅ No critical security issues found!${NC}"
    echo ""
    echo "⚠️  Note: This is a basic check. Always:"
    echo "  - Review code manually"
    echo "  - Run security scanners"
    echo "  - Follow OWASP guidelines"
    echo "  - Keep dependencies updated"
    echo ""
    exit 0
fi
