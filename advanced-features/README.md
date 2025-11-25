# 🚀 Advanced Features - Wenn du bereit bist

**Hinweis:** Diese Features sind **optional**! Nur nutzen wenn die Basis sitzt.

---

## 🎯 Wann sollte ich upgraden?

### Du bist bereit für Advanced Features wenn:

✅ Du die 4 Basis-Phasen (Explore → Plan → Code → Commit) beherrschst
✅ Du mindestens 5-10 Sessions mit Claude hattest
✅ Du Git Basics verstehst (add, commit, status)
✅ Du mit dem minimalen Setup zufrieden bist
✅ Du dir mehr Automatisierung wünschst

### Du solltest NOCH WARTEN wenn:

❌ Du dich mit der Basis noch unsicher fühlst
❌ Du Claude's Verhalten noch nicht verstehst
❌ Git noch verwirrend ist
❌ Du lieber erstmal mehr Projekte machen willst

**Kein Stress!** Die Advanced Features laufen nicht weg. Nutze sie wenn DU bereit bist!

---

## 📊 Feature-Level System

### **Level 1: Basis** (beginner-setup-guide/)
**Was:** Minimales Setup
**Für wen:** Anfänger, erstes Kennenlernen
**Features:**
- 4 Phasen Workflow
- Minimale Templates (README, session-notes, CLAUDE.md)
- Git Basics
- System-CLAUDE.md (Limits)

👉 **Du bist hier!** Master das erstmal.

---

### **Level 2: Git Integration** (Git-Advanced)
**Was:** Professionelles Git/GitHub
**Für wen:** Wenn du sicherer mit Git bist
**Features:**
- Feature Branch Workflow
- Pull Requests
- Conflict Resolution
- Conventional Commits
- GitHub CLI Integration

**Upgrade wenn:**
- Basis sitzt
- Du mit anderen zusammenarbeiten willst
- Du professioneller versionieren willst

**Wo finden:** `advanced-workflows/GIT_WORKFLOW.md`

---

### **Level 3: Slash Commands** (Automatisierung)
**Was:** Wiederverwendbare Prompt-Templates
**Für wen:** Wenn du oft gleiche Aufgaben hast
**Features:**
- `/plan-feature` - Feature-Planung
- `/test-code` - Tests schreiben
- `/review-code` - Code Review
- `/commit-changes` - Git Commits
- `/wordpress-debug` - WordPress Debugging
- Eigene Commands erstellen

**Upgrade wenn:**
- Du merkst du gibst oft gleiche Prompts
- Du Workflows automatisieren willst
- Du schneller arbeiten willst

**Wo finden:** `slash-commands/`

---

### **Level 4: Hooks** (Event-Automation)
**Was:** Event-basierte Automatisierung
**Für wen:** Wenn du Konsistenz erzwingen willst
**Features:**
- Auto-Formatierung nach File Write
- Tests vor Commit erzwingen
- Security Scans
- Context Reminders
- Custom Hooks

**Upgrade wenn:**
- Du oft vergisst zu formatieren/testen
- Du in Teams arbeitest
- Du Quality Gates willst
- Du wiederholbare Checks automatisieren willst

**Wo finden:** `hooks/`

---

### **Level 5: Advanced Workflows** (Profi)
**Was:** Komplexe Entwicklungs-Patterns
**Für wen:** Erfahrene Entwickler
**Features:**
- Test-Driven Development (TDD)
- Visual Iteration mit Screenshots
- Multi-Claude Patterns
- Checklists für komplexe Tasks
- Context Management Strategien
- Codebase Q&A

**Upgrade wenn:**
- Du große Projekte managst
- Du TDD lernen willst
- Du mehrere Claude Instanzen nutzen willst
- Du sehr fortgeschritten arbeitest

**Wo finden:** `advanced-workflows/WORKFLOW_GUIDE.md`

---

### **Level 6: Full Templates** (Projekt-Typen)
**Was:** Ausführliche CLAUDE.md für verschiedene Stacks
**Für wen:** Wenn du große Projekte startest
**Features:**
- Python (Flask, Django, FastAPI)
- PHP/WordPress (Themes, Plugins)
- HTML/CSS/JavaScript (Frontend)
- Full-Stack (React + Backend)
- Testing Konfiguration
- CI/CD Integration

**Upgrade wenn:**
- Du neue große Projekte startest
- Du professionelle Standards willst
- Du in Teams arbeitest
- Du Best Practices erzwingen willst

**Wo finden:** `full-templates/CLAUDE_MD_TEMPLATE.md`

---

## 🎓 Upgrade-Pfad (Empfohlen)

### Monat 1: Basis
- ✅ Installation
- ✅ Basis-Templates nutzen
- ✅ 4 Phasen lernen
- ✅ 5-10 kleine Projekte

### Monat 2: Git Advanced
- ✅ Feature Branches lernen
- ✅ Pull Requests erstellen
- ✅ GitHub Integration
- ✅ Conventional Commits

### Monat 3: Automatisierung
- ✅ 2-3 Slash Commands nutzen
- ✅ Eigenen Command erstellen
- ✅ Post-Write Formatierung Hook
- ✅ Pre-Commit Tests Hook

### Monat 4+: Profi
- ✅ TDD ausprobieren
- ✅ Multi-Claude nutzen
- ✅ Full Template für Haupt-Projekt
- ✅ Eigenes Workflow-System bauen

**Hinweis:** Das ist nur ein Vorschlag! Geh in deinem Tempo.

---

## 📚 Feature-Übersicht

### Slash Commands (`slash-commands/`)

**Verfügbare Commands:**
- `plan-feature.md` - Strukturierte Feature-Planung
- `test-code.md` - TDD & Testing
- `review-code.md` - Code Review + Security
- `commit-changes.md` - Git Commits
- `wordpress-debug.md` - WordPress Debugging

**Installation:**
```bash
mkdir -p .claude/commands
cp advanced-features/slash-commands/*.md .claude/commands/
```

**Usage:**
```
/plan-feature User Authentication
/test-code src/auth/login.py
/review-code src/payment.php
```

---

### Hooks (`hooks/`)

**Verfügbare Hooks:**
- `user-prompt-submit.md` - Context Management Reminders
- `post-write-format.sh` - Auto-Format (Python, JS, PHP)
- `pre-commit-tests.sh` - Tests vor Commit
- `security-check.sh` - Security Scanning

**Installation:**
```bash
mkdir -p .claude/hooks
cp advanced-features/hooks/* .claude/hooks/
chmod +x .claude/hooks/*.sh
```

**Configuration:**
```json
// .claude/settings.json
{
  "hooks": {
    "userPromptSubmit": ".claude/hooks/user-prompt-submit.md",
    "postWrite": ".claude/hooks/post-write-format.sh"
  }
}
```

---

### Advanced Workflows (`advanced-workflows/`)

**Verfügbare Guides:**
- `WORKFLOW_GUIDE.md` - Erweiterte Workflows (TDD, Visual Iteration, etc.)
- `GIT_WORKFLOW.md` - Professionelles Git/GitHub

**Themen:**
- Test-Driven Development
- Visual Iteration mit Screenshots
- Multi-Claude Patterns
- Checklists für komplexe Tasks
- Context Management
- Feature Branch Workflow
- Pull Requests
- Conflict Resolution

---

### Full Templates (`full-templates/`)

**Verfügbare Templates:**
- Python (Flask, Django, FastAPI, Scripts)
- PHP/WordPress (Themes, Plugins, Custom Sites)
- HTML/CSS/JavaScript (Frontend)
- Full-Stack (React + Backend)

**Features pro Template:**
- Ausführliche Projekt-Beschreibung
- Tech Stack Details
- Coding Standards
- Testing Setup
- Git Workflow
- Common Commands
- Security Checklists
- Bekannte Probleme

---

## 🎯 Wie installiere ich Features?

### Option 1: Einzelne Features kopieren

```bash
# Nur Slash Commands
cp advanced-features/slash-commands/*.md .claude/commands/

# Nur Hooks
cp advanced-features/hooks/* .claude/hooks/
chmod +x .claude/hooks/*.sh

# Nur ein Template
cp advanced-features/full-templates/python-template.md ./CLAUDE.md
```

### Option 2: Alles auf einmal (nicht empfohlen für Anfänger!)

```bash
# Alle Slash Commands
mkdir -p .claude/commands
cp advanced-features/slash-commands/*.md .claude/commands/

# Alle Hooks
mkdir -p .claude/hooks
cp advanced-features/hooks/* .claude/hooks/
chmod +x .claude/hooks/*.sh

# .claude/settings.json erstellen
cat > .claude/settings.json <<EOF
{
  "hooks": {
    "userPromptSubmit": ".claude/hooks/user-prompt-submit.md",
    "postWrite": ".claude/hooks/post-write-format.sh"
  }
}
EOF
```

**⚠️ Warnung:** Nicht alles auf einmal aktivieren! Fang klein an.

---

## 💡 Tipps für den Upgrade

### ✅ DO

1. **Eins nach dem anderen**
   - Nicht alle Features auf einmal
   - Master ein Feature bevor du das nächste hinzufügst

2. **Testen**
   - Teste jedes Feature einzeln
   - Verstehe was es macht

3. **Anpassen**
   - Passe Features an deine Bedürfnisse an
   - Lösche was du nicht brauchst

4. **Dokumentieren**
   - Notiere in session-notes.md welche Features du nutzt
   - Hilft später zu verstehen

### ❌ DON'T

1. **Nicht überwältigen**
   - Nicht alle 20 Slash Commands auf einmal
   - Fang mit 2-3 an

2. **Nicht blind kopieren**
   - Verstehe was der Code macht
   - Besonders bei Hooks (die laufen automatisch!)

3. **Nicht zwingen**
   - Wenn ein Feature nicht zu deinem Workflow passt: Lass es weg
   - Du musst nicht alles nutzen

---

## 🆘 Hilfe & Support

### Bei Problemen mit Advanced Features:

1. **Dokumentation lesen**
   - Jedes Feature hat eigene Docs
   - Lies die README in den Ordnern

2. **Auf Basis zurückfallen**
   - Features deaktivieren
   - Zurück zu basics
   - Neu aufbauen

3. **Community fragen**
   - GitHub Discussions
   - Reddit r/ClaudeAI

### Debugging

```bash
# Hook funktioniert nicht?
bash .claude/hooks/post-write-format.sh test.py

# Slash Command funktioniert nicht?
cat .claude/commands/plan-feature.md

# Settings prüfen
cat .claude/settings.json
```

---

## 🎉 Zusammenfassung

**Advanced Features sind cool - aber optional!**

- ✅ Master die Basis zuerst
- ✅ Upgrade in deinem Tempo
- ✅ Nutze nur was du brauchst
- ✅ Passe alles an dich an

**Du entscheidest!** Nicht das System.

---

**Viel Erfolg beim Upgraden! 🚀**

*PS: Die Basis ist schon mächtig genug für 90% der Tasks. Advanced Features sind das Sahnehäubchen, nicht das Fundament!* 😊
