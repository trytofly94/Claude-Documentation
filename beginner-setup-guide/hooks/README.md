# 🪝 Hooks Beispiele für Anfänger

**Stand:** 21. November 2025

## 📋 Was sind Hooks?

Hooks sind **Event-basierte Automatisierung** in Claude Code:
- Werden bei bestimmten Events automatisch ausgeführt
- Können Shell Commands oder Prompts sein
- Helfen bei Konsistenz und Qualität

## 🎯 Hook Types

### 1. **User-Prompt-Submit Hook**
Läuft BEVOR dein Prompt an Claude gesendet wird.

**Use Cases:**
- Context-Prüfung
- Automatische Informationen anhängen
- Reminders

### 2. **Pre-Write Hook** (via Bash)
Läuft BEVOR eine Datei geschrieben wird.

**Use Cases:**
- Backup erstellen
- Validierung
- Formatierung

### 3. **Post-Write Hook** (via Bash)
Läuft NACHDEM eine Datei geschrieben wurde.

**Use Cases:**
- Code Formatierung (black, prettier)
- Tests laufen lassen
- Linting

### 4. **Pre-Commit Hook** (Git-native)
Läuft BEVOR ein Git Commit erstellt wird.

**Use Cases:**
- Tests müssen grün sein
- Linting muss passen
- Keine Secrets im Code

## 📦 Installation

```bash
# In deinem Projekt-Root:
mkdir -p .claude/hooks

# Hooks aus diesem Ordner kopieren:
cp hooks/*.md .claude/hooks/
```

## 📚 Verfügbare Hooks

### 🔍 user-prompt-submit.md
Prüft Context und gibt Warnings.

**Was es macht:**
- Warnt bei zu langem Context
- Erinnert an `/clear` nach mehreren Prompts
- Zeigt aktuelle Session Stats

### 🧪 pre-commit-tests.sh
Führt Tests vor jedem Commit aus.

**Was es macht:**
- Läuft automatisch vor Git Commit
- Führt Test-Suite aus
- Blockt Commit wenn Tests fail

### ✨ post-write-format.sh
Formatiert Code nach dem Schreiben.

**Was es macht:**
- Black für Python
- Prettier für JS/TS
- PHP-CS-Fixer für PHP
- Automatisch nach jedem Write

### 🔒 security-check.sh
Security Pre-Commit Check.

**Was es macht:**
- Scannt nach Secrets (API Keys, Passwords)
- Prüft auf common vulnerabilities
- Blockt Commit bei Security Issues

## 🎓 Eigene Hooks erstellen

### Template: User-Prompt-Submit Hook

```markdown
<!-- .claude/hooks/user-prompt-submit.md -->

Before processing the user's prompt, check:

1. **Context Length**
   - Count messages in conversation
   - If > 20 messages: Suggest `/clear`

2. **Common Mistakes**
   - If prompt contains "test": Remind about TDD
   - If prompt contains "commit": Remind about running tests

3. **Best Practices**
   - Remind about CLAUDE.md standards
   - Check if relevant files are in context
```

### Template: Post-Write Hook (Bash)

```bash
#!/bin/bash
# .claude/hooks/post-write.sh

FILE="$1"  # Der geschriebene File-Path

# Nur für Python Files
if [[ "$FILE" == *.py ]]; then
    echo "🔧 Formatting Python file: $FILE"
    black "$FILE"
    echo "✅ Formatted!"
fi

# Nur für JS Files
if [[ "$FILE" == *.js ]] || [[ "$FILE" == *.jsx ]]; then
    echo "🔧 Formatting JS file: $FILE"
    prettier --write "$FILE"
    echo "✅ Formatted!"
fi
```

**Ausführbar machen:**
```bash
chmod +x .claude/hooks/post-write.sh
```

### Template: Pre-Commit Hook (Git)

```bash
#!/bin/bash
# .git/hooks/pre-commit

echo "🧪 Running pre-commit checks..."

# Tests ausführen
echo "Running tests..."
pytest
if [ $? -ne 0 ]; then
    echo "❌ Tests failed! Commit aborted."
    exit 1
fi

# Linting
echo "Running linter..."
flake8 src/
if [ $? -ne 0 ]; then
    echo "❌ Linting failed! Commit aborted."
    exit 1
fi

# Secrets Check
echo "Checking for secrets..."
if grep -r "sk-[a-zA-Z0-9]" src/; then
    echo "❌ Possible API key found! Commit aborted."
    exit 1
fi

echo "✅ All checks passed!"
exit 0
```

**Installation:**
```bash
cp hooks/pre-commit-tests.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

## 💡 Best Practices

### ✅ Dos

1. **Schnell halten** - Hooks sollten < 2 Sekunden laufen
2. **Informativ** - Zeige was der Hook macht
3. **Nützlich** - Nur Hooks die wirklich helfen
4. **Error Handling** - Was wenn Hook fehlschlägt?
5. **Dokumentieren** - Erkläre was Hook macht

### ❌ Don'ts

1. **Nicht zu viele** - Max 3-4 Hooks
2. **Nicht zu langsam** - Niemand wartet 30s
3. **Nicht zu streng** - Nicht alles blocken
4. **Nicht undokumentiert** - Team muss verstehen

## 🔧 Hook Configuration

### Settings in .claude/settings.json

```json
{
  "hooks": {
    "userPromptSubmit": ".claude/hooks/user-prompt-submit.md",
    "postWrite": ".claude/hooks/post-write.sh",
    "preWrite": ".claude/hooks/pre-write.sh"
  }
}
```

### Hook Execution Control

```bash
# Hook temporär deaktivieren
export SKIP_CLAUDE_HOOKS=1

# Hook für eine Session deaktivieren
claude --skip-hooks

# Spezifischen Hook deaktivieren
# In .claude/settings.json: hook zu null setzen
```

## 📊 Hook Examples für verschiedene Scenarios

### Scenario 1: Solo Developer

**Minimal Setup:**
- `user-prompt-submit.md` - Context Reminders
- `post-write-format.sh` - Auto-Formatting
- Git Pre-Commit - Tests müssen grün sein

### Scenario 2: Team Environment

**Team Setup:**
- Alle Solo Developer Hooks
- `security-check.sh` - Security Scanning
- Git Pre-Push - CI/CD Integration
- Commit Message Validation

### Scenario 3: Production App

**Production Setup:**
- Alle Team Hooks
- Performance Checks
- Database Migration Validation
- Deployment Hooks

## 🐛 Troubleshooting

### Hook wird nicht ausgeführt

**Checken:**
1. Ist Hook in `.claude/hooks/` Ordner?
2. Hat Hook korrekte Permissions? (`chmod +x`)
3. Ist Hook in `settings.json` registriert?
4. Claude neu starten

### Hook schlägt fehl

**Debuggen:**
```bash
# Hook manuell ausführen
bash .claude/hooks/post-write.sh test.py

# Output prüfen
# Error Messages lesen
```

### Hook zu langsam

**Optimieren:**
- Nur nötige Checks
- Parallele Execution
- Caching nutzen
- Async wo möglich

## 🔗 Weiterführend

- **[TOOL_INTERACTIONS.md](../../TOOL_INTERACTIONS.md)** - Wie Hooks mit anderen Tools interagieren
- **[WORKFLOW_GUIDE.md](../WORKFLOW_GUIDE.md)** - Hooks in Workflows integrieren

---

**Hooks automatisieren dein Leben! 🪝**
