#!/bin/bash
#
# Post-Write Formatting Hook
# Automatically formats code after Claude writes a file
#
# This hook runs after Claude uses the Write or Edit tool
# It formats the file according to language-specific standards

FILE="$1"

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "⚠️  File not found: $FILE"
    exit 0
fi

echo "🔧 Post-write formatting for: $FILE"

# Python Files
if [[ "$FILE" == *.py ]]; then
    echo "  → Formatting Python with black..."

    # Check if black is installed
    if command -v black &> /dev/null; then
        black "$FILE" --quiet
        echo "  ✅ Python formatted"
    else
        echo "  ⚠️  black not installed. Install with: pip install black"
    fi

    # Optional: Also run isort for imports
    if command -v isort &> /dev/null; then
        isort "$FILE" --quiet
        echo "  ✅ Imports sorted"
    fi
fi

# JavaScript/TypeScript Files
if [[ "$FILE" == *.js ]] || [[ "$FILE" == *.jsx ]] || [[ "$FILE" == *.ts ]] || [[ "$FILE" == *.tsx ]]; then
    echo "  → Formatting JS/TS with prettier..."

    if command -v prettier &> /dev/null; then
        prettier --write "$FILE" --loglevel silent
        echo "  ✅ JS/TS formatted"
    elif [ -f "node_modules/.bin/prettier" ]; then
        node_modules/.bin/prettier --write "$FILE" --loglevel silent
        echo "  ✅ JS/TS formatted"
    else
        echo "  ⚠️  prettier not installed. Install with: npm install -g prettier"
    fi
fi

# PHP Files
if [[ "$FILE" == *.php ]]; then
    echo "  → Formatting PHP..."

    # PHP-CS-Fixer (if available)
    if command -v php-cs-fixer &> /dev/null; then
        php-cs-fixer fix "$FILE" --quiet
        echo "  ✅ PHP formatted"
    else
        # Fallback to phpcbf
        if command -v phpcbf &> /dev/null; then
            phpcbf "$FILE" --standard=PSR12 > /dev/null 2>&1
            echo "  ✅ PHP formatted (phpcbf)"
        else
            echo "  ⚠️  No PHP formatter found. Install php-cs-fixer or phpcs"
        fi
    fi
fi

# JSON Files
if [[ "$FILE" == *.json ]]; then
    echo "  → Formatting JSON..."

    # Check if python is available (usually is)
    if command -v python3 &> /dev/null; then
        python3 -m json.tool "$FILE" > "${FILE}.tmp" && mv "${FILE}.tmp" "$FILE"
        echo "  ✅ JSON formatted"
    fi
fi

# CSS/SCSS Files
if [[ "$FILE" == *.css ]] || [[ "$FILE" == *.scss ]]; then
    echo "  → Formatting CSS/SCSS with prettier..."

    if command -v prettier &> /dev/null; then
        prettier --write "$FILE" --loglevel silent
        echo "  ✅ CSS/SCSS formatted"
    elif [ -f "node_modules/.bin/prettier" ]; then
        node_modules/.bin/prettier --write "$FILE" --loglevel silent
        echo "  ✅ CSS/SCSS formatted"
    fi
fi

# HTML Files
if [[ "$FILE" == *.html ]]; then
    echo "  → Formatting HTML with prettier..."

    if command -v prettier &> /dev/null; then
        prettier --write "$FILE" --loglevel silent
        echo "  ✅ HTML formatted"
    elif [ -f "node_modules/.bin/prettier" ]; then
        node_modules/.bin/prettier --write "$FILE" --loglevel silent
        echo "  ✅ HTML formatted"
    fi
fi

# Markdown Files
if [[ "$FILE" == *.md ]]; then
    echo "  → Formatting Markdown with prettier..."

    if command -v prettier &> /dev/null; then
        prettier --write "$FILE" --loglevel silent --prose-wrap always
        echo "  ✅ Markdown formatted"
    elif [ -f "node_modules/.bin/prettier" ]; then
        node_modules/.bin/prettier --write "$FILE" --loglevel silent --prose-wrap always
        echo "  ✅ Markdown formatted"
    fi
fi

echo "✨ Post-write formatting complete!"
exit 0
