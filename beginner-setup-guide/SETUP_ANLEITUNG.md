# 🛠️ Claude Code Setup-Anleitung für Anfänger

**Stand:** 21. November 2025
**Dauer:** 30-45 Minuten
**Voraussetzungen:** Node.js installiert, GitHub Account

---

## 📋 Inhaltsverzeichnis

1. [Claude Code installieren](#1-claude-code-installieren)
2. [GitHub CLI einrichten](#2-github-cli-einrichten)
3. [Erstes Projekt initialisieren](#3-erstes-projekt-initialisieren)
4. [.claude/ Ordner konfigurieren](#4-claude-ordner-konfigurieren)
5. [Permissions Management](#5-permissions-management)
6. [MCP Server (optional)](#6-mcp-server-optional)
7. [Erste Schritte](#7-erste-schritte)
8. [Troubleshooting](#8-troubleshooting)

---

## 1. Claude Code installieren

### ✅ Voraussetzungen prüfen

```bash
# Node.js Version prüfen (mind. 18.x)
node --version

# npm Version prüfen
npm --version
```

Falls Node.js nicht installiert ist:
- **Download:** https://nodejs.org/ (LTS Version)
- Installieren und Terminal neu starten

### 📦 Claude Code CLI installieren

```bash
# Global installieren
npm install -g @anthropic-ai/claude-code

# Installation verifizieren
claude --version
```

### 🔑 Authentifizierung

```bash
# Claude starten
claude

# Beim ersten Start wirst du nach deinem API Key gefragt
# Diesen findest du in deinem Anthropic Account:
# https://console.anthropic.com/settings/keys
```

**💡 Tipp:** Du brauchst ein **Anthropic Pro oder Max Abo** für Claude Code.

---

## 2. GitHub CLI einrichten

Die GitHub CLI ermöglicht es Claude, automatisch Pull Requests zu erstellen, Issues zu managen, etc.

### 📥 GitHub CLI installieren

**macOS:**
```bash
brew install gh
```

**Windows:**
```bash
winget install --id GitHub.cli
```

**Linux:**
```bash
# Debian/Ubuntu
sudo apt install gh

# Fedora
sudo dnf install gh
```

### 🔐 GitHub Authentifizierung

```bash
# Login durchführen
gh auth login

# Wähle:
# - GitHub.com
# - HTTPS
# - Login via Browser
```

### ✅ Testen

```bash
# Deine GitHub Infos anzeigen
gh auth status

# Repos auflisten (test)
gh repo list --limit 5
```

---

## 3. Erstes Projekt initialisieren

### 📁 Neues Projekt erstellen

```bash
# Neues Verzeichnis erstellen
mkdir mein-erstes-claude-projekt
cd mein-erstes-claude-projekt

# Git Repository initialisieren
git init

# Erste README erstellen
echo "# Mein erstes Claude Code Projekt" > README.md
git add README.md
git commit -m "Initial commit"
```

### 🌐 GitHub Repository erstellen (optional aber empfohlen)

```bash
# Repository auf GitHub erstellen und pushen
gh repo create mein-erstes-claude-projekt --public --source=. --remote=origin --push
```

---

## 4. `.claude/` Ordner konfigurieren

Der `.claude/` Ordner ist das Herzstück deiner Claude Code Konfiguration.

### 📂 Struktur erstellen

```bash
# In deinem Projekt-Root:
mkdir -p .claude/commands
mkdir -p .claude/hooks
touch .claude/settings.json
touch CLAUDE.md
```

**Ergebnis:**
```
mein-erstes-claude-projekt/
├── .claude/
│   ├── commands/          # Slash Commands
│   ├── hooks/             # Event Hooks
│   └── settings.json      # Projekt-Settings
├── CLAUDE.md              # Projekt-Kontext für Claude
├── README.md
└── .git/
```

### ⚙️ Basis-Settings konfigurieren

Erstelle `.claude/settings.json`:

```json
{
  "model": "claude-sonnet-4-5-20250929",
  "allowedTools": [
    "Bash",
    "Read",
    "Write",
    "Edit",
    "Grep",
    "Glob"
  ],
  "alwaysAllowWrite": false,
  "alwaysAllowRead": true,
  "maxConversationTurns": 50
}
```

**Was bedeutet das?**
- `model`: Welches Claude Modell verwendet wird
- `allowedTools`: Welche Tools ohne Nachfrage erlaubt sind
- `alwaysAllowWrite`: `false` = Claude fragt vor Datei-Änderungen
- `alwaysAllowRead`: `true` = Claude kann Dateien lesen ohne zu fragen
- `maxConversationTurns`: Maximale Konversationslänge

---

## 5. Permissions Management

### 🔒 Sicherheits-Philosophie

**Für Anfänger empfohlen:**
- ✅ **Read** erlauben (damit Claude Dateien analysieren kann)
- ⚠️ **Write/Edit** erst nach Review erlauben
- ⚠️ **Bash** nur für sichere Commands (keine `rm -rf` etc.)

### 📋 Permissions während der Session setzen

```bash
# Claude starten
claude

# In der Session:
/permissions

# Oder spezifisch:
/permissions allow Read Write Edit Grep Glob
```

### 🛡️ Sicherheitstipps

**❌ NICHT erlauben ohne Verständnis:**
- `dangerouslyDisableSandbox`
- Wildcard Bash Commands
- Schreibzugriff auf System-Ordner

**✅ SICHER für Anfänger:**
- Read, Grep, Glob (nur lesen/suchen)
- Write/Edit mit Review (vor Änderungen prüfen)
- Bash für spezifische Commands (npm, git, etc.)

---

## 6. MCP Server (optional)

MCP (Model Context Protocol) Server erweitern Claude's Fähigkeiten.

### 📦 Empfohlene MCP Server für Anfänger

**Filesystem MCP** (Dateizugriff):
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**GitHub MCP** (GitHub Integration):
```bash
npm install -g @modelcontextprotocol/server-github
```

### ⚙️ MCP Konfiguration

Erstelle `.mcp.json` im Projekt-Root:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "${workspaceFolder}"
      ]
    },
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_TOKEN": "${env:GITHUB_TOKEN}"
      }
    }
  }
}
```

**💡 Tipp:** Du kannst MCP Server auch später hinzufügen - nicht notwendig für den Start!

---

## 7. Erste Schritte

### 🎯 Dein erstes CLAUDE.md erstellen

Erstelle `CLAUDE.md` im Projekt-Root (siehe [CLAUDE_MD_TEMPLATE.md](./CLAUDE_MD_TEMPLATE.md) für Vorlagen):

```markdown
# Mein Erstes Claude Projekt

## Projekt-Übersicht
Ein einfaches [Python/PHP/WordPress] Projekt zum Lernen von Claude Code.

## Tech Stack
- Python 3.11
- Git/GitHub
- VS Code

## Coding Standards
- PEP 8 für Python Code
- Docstrings für alle Funktionen
- Type Hints verwenden
- Tests mit pytest

## Testing
```bash
# Tests ausführen
pytest tests/

# Mit Coverage
pytest --cov=src tests/
```

## Git Workflow
- Main Branch bleibt stabil
- Feature Branches: `feature/beschreibung`
- Commits: Klein und fokussiert
- Vor Commit: Tests laufen lassen
```

### 🚀 Claude starten und testen

```bash
# Claude im Projekt starten
cd mein-erstes-claude-projekt
claude

# In Claude:
# 1. Frage: "Erkläre mir die Struktur dieses Projekts"
# 2. Frage: "Welche Dateien siehst du?"
# 3. Request: "Erstelle eine einfache Python hello.py mit Best Practices"
```

### ✅ Verifizieren

Nach dem ersten Claude Durchlauf solltest du haben:
- ✅ Claude hat deine Dateien gelesen
- ✅ Claude hat CLAUDE.md berücksichtigt
- ✅ Claude hat Code mit deinen Standards erstellt
- ✅ Du verstehst was Claude gemacht hat

---

## 8. Troubleshooting

### ❓ Häufige Probleme

#### **Problem: "Command not found: claude"**

**Lösung:**
```bash
# NPM global bin path prüfen
npm config get prefix

# Sollte in deinem PATH sein
echo $PATH

# Falls nicht, zu .bashrc/.zshrc hinzufügen:
export PATH="$PATH:$(npm config get prefix)/bin"
```

#### **Problem: "Anthropic API key not found"**

**Lösung:**
```bash
# API Key setzen
export ANTHROPIC_API_KEY='sk-ant-...'

# Oder in ~/.claude/config.json
{
  "apiKey": "sk-ant-..."
}
```

#### **Problem: GitHub CLI funktioniert nicht**

**Lösung:**
```bash
# Erneut authentifizieren
gh auth logout
gh auth login

# Permissions prüfen
gh auth status
```

#### **Problem: "Permission denied" bei File Operations**

**Lösung:**
```bash
# In Claude Session:
/permissions allow Write Edit

# Oder in .claude/settings.json:
"allowedTools": ["Write", "Edit"]
```

### 📚 Weitere Hilfe

- **Claude Code Docs:** https://code.claude.com/docs
- **GitHub Discussions:** https://github.com/anthropics/claude-code/discussions
- **Reddit:** r/ClaudeAI
- **Diese Dokumentation:** [README.md](./README.md)

---

## 🎉 Geschafft!

Du hast jetzt:
✅ Claude Code installiert und konfiguriert
✅ GitHub CLI eingerichtet
✅ Ein Projekt mit Best-Practice-Struktur
✅ `.claude/` Ordner konfiguriert
✅ Permissions richtig gesetzt
✅ Erste Schritte erfolgreich durchgeführt

### 🚀 Nächste Schritte:

1. **[WORKFLOW_GUIDE.md](./WORKFLOW_GUIDE.md)** lesen - Lerne die täglichen Workflows
2. **[GIT_WORKFLOW.md](./GIT_WORKFLOW.md)** studieren - Git Best Practices
3. **[Slash Commands](./slash-commands/)** installieren - Automatisierung
4. **Erstes echtes Projekt** starten! 🎯

---

**Viel Erfolg! Bei Fragen schau in die anderen Guides oder die Community. 💪**
