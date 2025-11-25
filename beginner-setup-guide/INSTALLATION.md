# 🛠️ Installation - Claude Code Basis Setup

**Dauer:** 10-15 Minuten
**Voraussetzungen:** Node.js installiert

💻 **Noch nie mit Terminal gearbeitet?** Lies zuerst: [TERMINAL_GUIDE.md](TERMINAL_GUIDE.md) (5 Min)

---

## ✅ Voraussetzungen prüfen

```bash
# Node.js Version prüfen (mind. 18.x)
node --version

# npm Version prüfen
npm --version
```

**Falls Node.js nicht installiert:**
- Download: https://nodejs.org/ (LTS Version)
- Installieren und Terminal neu starten

---

## 📦 Claude Code installieren

```bash
# Global installieren
npm install -g @anthropic-ai/claude-code

# Installation prüfen
claude --version
```

**Bei Problemen:**
- Stelle sicher dass npm global install permissions hat
- macOS/Linux: Evtl. `sudo` nötig
- Windows: Als Administrator ausführen

---

## 🔑 Authentifizierung

```bash
# Claude starten (erste Authentifizierung)
claude
```

Beim ersten Start wirst du nach deinem **Anthropic API Key** gefragt.

### API Key bekommen:
1. Gehe zu https://console.anthropic.com/
2. Login mit deinem Anthropic Account
3. Navigiere zu "Settings" → "API Keys"
4. Erstelle neuen Key oder kopiere bestehenden
5. Key in Terminal eingeben

**💡 Wichtig:** Du brauchst ein **Anthropic Pro oder Max Abo** für Claude Code!

---

## 🏗️ Projekt Setup

### Schritt 1: Zu deinem Projekt wechseln

```bash
# Bestehendes Projekt
cd /pfad/zu/deinem/projekt

# Oder neues Projekt erstellen
mkdir mein-projekt
cd mein-projekt
```

### Schritt 2: Git initialisieren

```bash
# Git Repository initialisieren (falls noch nicht vorhanden)
git init

# Check ob Git funktioniert
git status
```

**Falls Git nicht installiert:**
- Download: https://git-scm.com/downloads
- Installieren und Terminal neu starten

### Schritt 3: Templates kopieren

```bash
# Wenn du das Repository geklont hast:
cp Claude-Documentation/beginner-setup-guide/templates/README.md ./README.md
cp Claude-Documentation/beginner-setup-guide/templates/session-notes.md ./session-notes.md
cp Claude-Documentation/beginner-setup-guide/templates/CLAUDE.md ./CLAUDE.md

# System-Verhalten einrichten
mkdir -p ~/.claude
cp Claude-Documentation/beginner-setup-guide/system/CLAUDE.md ~/.claude/CLAUDE.md
```

**Oder manuell erstellen:**
- Öffne die Templates in `beginner-setup-guide/templates/`
- Kopiere den Inhalt in neue Dateien in deinem Projekt
- Passe die Platzhalter an (Projekt-Name, Tech Stack, etc.)

### Schritt 4: Templates anpassen

Öffne die kopierten Dateien und fülle aus:

**README.md:**
```markdown
# Mein WordPress Theme Projekt  ← Dein Projektname

**Tech Stack:** PHP, WordPress, HTML/CSS  ← Deine Technologien

## Was macht dieses Projekt?
Ein custom WordPress Theme für...  ← Deine Beschreibung
```

**CLAUDE.md:**
```markdown
# Mein WordPress Theme

## Tech Stack
- PHP 8.1
- WordPress 6.4
- Custom Theme (kein Framework)

## Wichtige Dateien
- functions.php: Theme Setup
- style.css: Styles
...
```

**session-notes.md:**
```markdown
# Session Notes

## 2025-11-25: Projekt Setup

### Aufgabe
- Claude Code Setup durchführen

### Durchgeführt
- Templates kopiert und angepasst
- Git initialisiert

### Für nächste Session
- [ ] Erstes Feature implementieren
```

---

## 🎯 Erste Session

### Claude starten

**Option 1: Mit Permissions (Standard)**
```bash
# Im Projekt-Ordner
claude
```
Claude fragt bei jeder Aktion um Erlaubnis.
**Gut für:** Lernen, volle Kontrolle

**Option 2: Ohne Permission-Prompts (Anfänger empfohlen!)**
```bash
# Im Projekt-Ordner
claude --dangerously-skip-permissions
```
Claude arbeitet ohne nachzufragen.
**Gut für:** Flüssiges Arbeiten, weniger Unterbrechungen
⚠️ Nur in DEINEN eigenen Projekten nutzen!

💡 **Tipp für Anfänger:** Start mit `--dangerously-skip-permissions` - der Name klingt dramatischer als es ist!

👉 **Mehr Details:** [TERMINAL_GUIDE.md](TERMINAL_GUIDE.md#-claude-code-starten)

### Test: Claude testen

```bash
# In Claude:
"Lies bitte die README.md und erkläre mir was dieses Projekt macht."

# Claude sollte:
# 1. README.md lesen
# 2. Projekt erklären
# 3. Fragen ob du was brauchst
```

**Funktioniert es?** ✅ Super, du bist ready!

**Funktioniert nicht?** → Siehe Troubleshooting unten

---

## 🐛 Troubleshooting

### Problem: "Command not found: claude"

**Lösung:**
```bash
# NPM global bin path prüfen
npm config get prefix

# Sollte in PATH sein
echo $PATH

# Falls nicht, zu Shell Config hinzufügen:
# ~/.bashrc oder ~/.zshrc
export PATH="$PATH:$(npm config get prefix)/bin"

# Shell neu laden
source ~/.bashrc  # oder ~/.zshrc
```

### Problem: "API key not found"

**Lösung:**
```bash
# API Key manuell setzen
export ANTHROPIC_API_KEY='sk-ant-...'

# Oder in Config File:
mkdir -p ~/.claude
echo '{"apiKey": "sk-ant-..."}' > ~/.claude/config.json
```

### Problem: "Permission denied"

**Lösung macOS/Linux:**
```bash
# npm global ohne sudo ermöglichen
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Zu PATH hinzufügen
export PATH="$PATH:~/.npm-global/bin"

# Claude neu installieren
npm install -g @anthropic-ai/claude-code
```

**Lösung Windows:**
- PowerShell/CMD als Administrator öffnen
- Installation nochmal durchführen

### Problem: Git funktioniert nicht

**Lösung:**
```bash
# Git config setzen
git config --global user.name "Dein Name"
git config --global user.email "deine@email.com"

# Test
git status
```

---

## ✅ Installation Checklist

Prüfe ob alles funktioniert:

- [ ] `claude --version` zeigt Version
- [ ] `git status` funktioniert
- [ ] Templates kopiert und angepasst
- [ ] `~/.claude/CLAUDE.md` existiert
- [ ] Claude startet ohne Fehler
- [ ] Claude kann Dateien lesen

**Alles checked?** 🎉 Du bist ready für [BASIS_WORKFLOW.md](BASIS_WORKFLOW.md)!

---

## 🚀 Nächste Schritte

1. ✅ Installation abgeschlossen
2. → [BASIS_WORKFLOW.md](BASIS_WORKFLOW.md) lesen (10 Min)
3. → Erste Session mit Claude!

---

**Bei weiteren Problemen:**
- Claude Code Docs: https://code.claude.com/docs
- GitHub Issues: https://github.com/anthropics/claude-code/issues
