# 🌿 Git Workflow für Anfänger (mit Claude Code)

**Stand:** 21. November 2025
**Fokus:** Professionelle Versionskontrolle von Anfang an

---

## 📋 Inhaltsverzeichnis

1. [Git Basics - Was du wissen musst](#1-git-basics)
2. [Feature Branch Workflow](#2-feature-branch-workflow)
3. [Commit Best Practices](#3-commit-best-practices)
4. [Mit Claude committen](#4-mit-claude-committen)
5. [Pull Requests erstellen](#5-pull-requests-erstellen)
6. [Konflikt-Lösung](#6-konflikt-lösung)
7. [Typische Anfänger-Fehler](#7-typische-anfänger-fehler)

---

## 1. Git Basics

### 🎯 Die Git-Philosophie

**Git ist wie ein Zeitstrahl für deinen Code:**
- Jeder **Commit** = Ein Snapshot zu einem Zeitpunkt
- **Branches** = Parallele Zeitlinien für verschiedene Features
- **Main Branch** = Die "sichere" Production-Version

### 📊 Die wichtigsten Git Commands

```bash
# Status anzeigen (was ist geändert?)
git status

# Änderungen anzeigen
git diff

# Dateien zum Commit hinzufügen
git add datei.py
git add .  # Alle Dateien

# Commit erstellen
git commit -m "Beschreibung der Änderung"

# History anzeigen
git log --oneline

# Branches anzeigen
git branch

# Neuen Branch erstellen
git branch feature/mein-feature

# Zu Branch wechseln
git checkout feature/mein-feature

# Oder beides in einem:
git checkout -b feature/mein-feature

# Pushen zu GitHub
git push origin feature/mein-feature

# Pullen von GitHub
git pull origin main
```

### 🗺️ Git Status verstehen

```bash
$ git status

On branch feature/login
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   src/auth/login.py    # ← Staged (wird commitet)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes)
        modified:   src/auth/register.py # ← Unstaged (wird NICHT commitet)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test/test_auth.py                # ← Neue Datei (Git kennt sie nicht)
```

**Was bedeutet das?**
- **Staged** - Mit `git add` hinzugefügt, wird beim nächsten Commit gespeichert
- **Unstaged** - Geändert aber nicht hinzugefügt
- **Untracked** - Neue Datei, die Git noch nicht kennt

---

## 2. Feature Branch Workflow

### 🌳 Der empfohlene Workflow für Anfänger

**Grundregel:** Main Branch bleibt immer stabil, Features entwickelst du in separaten Branches.

### 📐 Der komplette Ablauf

#### **Schritt 1: Neues Feature starten**

```bash
# Stelle sicher du bist auf main und up-to-date
git checkout main
git pull origin main

# Erstelle neuen Feature Branch
git checkout -b feature/user-login

# Branch auf GitHub pushen (upstream setzen)
git push -u origin feature/user-login
```

**💡 Branch-Naming Convention:**
- `feature/beschreibung` - Neue Features
- `bugfix/beschreibung` - Bug Fixes
- `docs/beschreibung` - Dokumentation
- `refactor/beschreibung` - Code Refactoring

**Beispiele:**
- `feature/user-authentication`
- `bugfix/password-reset-email`
- `docs/api-documentation`

#### **Schritt 2: Entwickeln & Committen**

```bash
# Code schreiben...

# Status prüfen
git status

# Änderungen reviewen
git diff

# Hinzufügen
git add src/auth/login.py test/test_login.py

# Committen
git commit -m "feat: Add user login with bcrypt hashing"

# Weitere Änderungen...
git add .
git commit -m "test: Add tests for login edge cases"

# Pushen zu GitHub
git push
```

#### **Schritt 3: Pull Request erstellen**

```bash
# Mit GitHub CLI (empfohlen):
gh pr create --title "Add user login feature" --body "
## Summary
- Implements user login with email/password
- Uses bcrypt for password hashing
- Adds comprehensive tests

## Testing
- All unit tests pass
- Manual testing completed
"

# Oder über GitHub Web Interface:
# https://github.com/dein-username/dein-repo/compare/feature/user-login
```

#### **Schritt 4: Review & Merge**

```bash
# Jemand reviewt deinen Code (oder du selbst nach 1 Tag)

# Wenn approved → Merge via GitHub UI
# Oder via CLI:
gh pr merge --squash
```

#### **Schritt 5: Aufräumen**

```bash
# Zurück zu main
git checkout main

# Latest pullen (inkl. deinem gemergeten Feature)
git pull origin main

# Feature Branch löschen (lokal)
git branch -d feature/user-login

# Feature Branch löschen (remote)
git push origin --delete feature/user-login
```

### 🎨 Visualisiert

```
main:     o---o---o---o---o---o  ← Bleibt stabil
               \           /
feature/login:  o---o---o---o    ← Feature entwickeln, dann mergen
```

---

## 3. Commit Best Practices

### ✅ Was macht einen guten Commit aus?

#### **1. Kleine, fokussierte Commits**

**❌ Schlecht:**
```bash
git commit -m "Fixed stuff and added feature and changed config"
```
- Zu viel auf einmal
- Schwer zu reviewen
- Schwer zu revertn

**✅ Gut:**
```bash
git commit -m "feat: Add user login endpoint"
git commit -m "test: Add tests for login endpoint"
git commit -m "docs: Update API documentation with login endpoint"
```
- Jeder Commit = Eine logische Änderung
- Einfach zu verstehen
- Einfach zu reverten wenn nötig

#### **2. Aussagekräftige Commit Messages**

**Conventional Commits Format:**
```
<type>: <subject>

<body> (optional)
```

**Types:**
- `feat:` - Neues Feature
- `fix:` - Bug Fix
- `docs:` - Dokumentation
- `style:` - Formatierung (kein Code-Change)
- `refactor:` - Code-Umstrukturierung
- `test:` - Tests hinzufügen/ändern
- `chore:` - Build, Dependencies, etc.

**Beispiele:**

```bash
# Neues Feature
git commit -m "feat: Add password reset functionality"

# Bug Fix
git commit -m "fix: Prevent SQL injection in login query"

# Dokumentation
git commit -m "docs: Add installation instructions to README"

# Refactoring
git commit -m "refactor: Extract validation logic into separate class"

# Tests
git commit -m "test: Add integration tests for user API"
```

**Mit Body (für komplexere Commits):**
```bash
git commit -m "feat: Add email notification system

- Implements async email sending with Celery
- Adds templates for welcome, password reset, etc.
- Configures SMTP settings
- Adds retry logic for failed sends

Closes #123"
```

#### **3. Tests laufen vor Commit**

```bash
# Immer vor dem Commit:
pytest tests/                    # Python
npm test                         # JavaScript
phpunit                          # PHP

# Nur committen wenn Tests grün sind!
git commit -m "feat: Add new feature"
```

#### **4. Was committe ich NICHT?**

**❌ NIEMALS committen:**
```bash
# Secrets/Credentials
.env
config/secrets.json
api_keys.txt

# Dependencies
node_modules/
venv/
vendor/

# Build Artifacts
dist/
build/
*.pyc
__pycache__/

# IDE Files
.vscode/
.idea/
*.swp

# OS Files
.DS_Store
Thumbs.db
```

**✅ .gitignore verwenden:**
```bash
# .gitignore für Python-Projekt
__pycache__/
*.py[cod]
*$py.class
.env
venv/
.pytest_cache/
.coverage
```

---

## 4. Mit Claude committen

### 🤖 Claude kann Git Operations übernehmen!

Claude ist **hervorragend** in Git-Automatisierung. Nutze es!

#### **Workflow: Claude erstellt Commit**

```bash
# In Claude Session:
"Erstelle einen Git Commit für die Login-Implementierung
mit einer guten Commit Message nach Conventional Commits"

# Claude macht:
# 1. git status
# 2. git diff (reviewt Changes)
# 3. git add (relevante Files)
# 4. git commit mit guter Message
```

**Was Claude automatisch macht:**
- ✅ Prüft welche Files geändert wurden
- ✅ Erstellt aussagekräftige Commit Message
- ✅ Verwendet Conventional Commits Format
- ✅ Berücksichtigt Context aus CLAUDE.md

#### **Workflow: Claude erstellt Pull Request**

```bash
# In Claude Session:
"Erstelle einen Pull Request für dieses Feature"

# Claude macht:
# 1. git status (prüfen ob committed)
# 2. git push (falls noch nicht gepusht)
# 3. gh pr create (mit guter Description)
```

#### **Beispiel Claude PR Description:**

```markdown
## Summary
- Implements user authentication with JWT tokens
- Adds login/logout endpoints
- Implements password hashing with bcrypt
- Adds rate limiting to prevent brute force

## Changes
- `src/auth/login.py` - Login logic
- `src/auth/middleware.py` - JWT verification
- `test/test_auth.py` - Comprehensive tests

## Testing
✅ All 47 tests passing
✅ Test coverage: 94%
✅ Manual testing completed

## Security Considerations
- Passwords hashed with bcrypt (cost factor 12)
- JWTs expire after 24h
- Rate limiting: 5 attempts per minute
```

**💡 Tipp:** Claude schreibt bessere Commit Messages als die meisten Menschen!

---

## 5. Pull Requests erstellen

### 🔀 Was ist ein Pull Request?

**Pull Request (PR)** = "Bitte merge meinen Feature Branch in Main"

### 📝 Anatomy eines guten PRs

#### **1. Titel**
```
Add user authentication with JWT
```
- Kurz und präzise
- Beschreibt was das Feature macht

#### **2. Description**

```markdown
## Problem / Motivation
Users need to be able to log in securely to access protected features.

## Solution
Implements JWT-based authentication with the following features:
- Email/password login
- Secure password hashing (bcrypt)
- Token-based session management
- Logout functionality

## Changes
- Added `LoginView` in `src/auth/views.py`
- Added JWT middleware in `src/auth/middleware.py`
- Added tests in `test/test_auth.py`

## Testing
- [x] Unit tests pass (47/47)
- [x] Integration tests pass
- [x] Manual testing completed
- [x] Security review done

## Screenshots
![Login Form](./screenshots/login-form.png)

## Breaking Changes
None

## Related Issues
Closes #123
```

#### **3. Review Checklist**

Bevor du PR erstellst:
- ✅ Alle Tests laufen
- ✅ Code ist dokumentiert
- ✅ Keine Secrets committed
- ✅ .gitignore korrekt
- ✅ Commit Messages sauber
- ✅ Code selbst reviewed

### 🤝 Code Review Prozess

#### **Als Author:**
```bash
# PR erstellen
gh pr create --title "Add authentication" --body "..."

# Feedback bekommen
# → Änderungen machen

# Änderungen pushen (PR updated automatisch)
git add .
git commit -m "fix: Address review feedback"
git push

# Wenn approved → Merge
```

#### **Als Reviewer:**
```bash
# PR anschauen
gh pr checkout 42

# Code reviewen
# - Funktioniert es?
# - Ist es verständlich?
# - Gibt es Security-Probleme?
# - Sind Tests vorhanden?

# Approve
gh pr review 42 --approve

# Oder Changes requested
gh pr review 42 --request-changes --body "Bitte XYZ ändern"
```

---

## 6. Konflikt-Lösung

### ⚔️ Was sind Merge Conflicts?

**Szenario:**
```
Du änderst:     login.py Zeile 10: password_hash = bcrypt.hash(...)
Kollege ändert: login.py Zeile 10: password_hash = sha256(...)

Git: "Ich weiß nicht welche Version richtig ist! ⚠️"
```

### 🔧 Conflicts lösen - Step by Step

#### **1. Conflict erkennen**

```bash
$ git merge main
Auto-merging src/auth/login.py
CONFLICT (content): Merge conflict in src/auth/login.py
Automatic merge failed; fix conflicts and then commit the result.
```

#### **2. Konflikt-Datei öffnen**

```python
# src/auth/login.py

def hash_password(password):
<<<<<<< HEAD
    # Deine Version (Feature Branch)
    password_hash = bcrypt.hash(password)
=======
    # Version aus main
    password_hash = sha256(password)
>>>>>>> main
    return password_hash
```

#### **3. Entscheiden & Lösen**

```python
# Option 1: Deine Version behalten
def hash_password(password):
    password_hash = bcrypt.hash(password)
    return password_hash

# Option 2: Main Version behalten
def hash_password(password):
    password_hash = sha256(password)
    return password_hash

# Option 3: Kombinieren/Kompromiss
def hash_password(password):
    # Upgrade zu bcrypt (sicherer als sha256)
    password_hash = bcrypt.hash(password, rounds=12)
    return password_hash
```

#### **4. Markierungen entfernen & committen**

```bash
# Conflict Markers entfernen:
# <<<<<<< HEAD
# =======
# >>>>>>> main

# Als gelöst markieren
git add src/auth/login.py

# Merge abschließen
git commit -m "Merge main into feature/auth - resolved conflicts"
```

### 💡 Conflicts vermeiden

**Best Practices:**
- ✅ **Oft mergen** - Main regelmäßig in Feature Branch mergen
- ✅ **Kleine Branches** - Große Features in kleinere PRs aufteilen
- ✅ **Kommunizieren** - Wenn 2 Leute an selber Datei arbeiten → Abstimmen
- ✅ **Schnell mergen** - Feature Branches nicht monatelang offen lassen

#### **Mit Claude lösen:**

```bash
# In Claude Session:
"Ich habe einen Merge Conflict in login.py.
Hier ist die Datei: [paste file]
Welche Version soll ich behalten?"

# Claude analysiert und empfiehlt
```

---

## 7. Typische Anfänger-Fehler

### ❌ Fehler & ✅ Lösungen

#### **Fehler 1: Direkt auf main committen**

```bash
# ❌ Falsch:
git checkout main
# ... code ändern ...
git commit -m "Add feature"

# ✅ Richtig:
git checkout main
git checkout -b feature/mein-feature
# ... code ändern ...
git commit -m "Add feature"
```

#### **Fehler 2: Riesige Commits**

```bash
# ❌ Falsch:
# 50 Dateien geändert, 2000 Lines Added
git add .
git commit -m "Implemented everything"

# ✅ Richtig:
git add src/auth/login.py test/test_login.py
git commit -m "feat: Add login endpoint"

git add src/auth/register.py test/test_register.py
git commit -m "feat: Add registration endpoint"

# Mehrere kleine, fokussierte Commits
```

#### **Fehler 3: Tests nicht laufen vor Commit**

```bash
# ❌ Falsch:
git commit -m "feat: Add feature"
git push
# ... Tests breaken ...
# ... CI/CD failed ...

# ✅ Richtig:
pytest tests/              # Tests ERST
git commit -m "feat: Add feature"
git push
```

#### **Fehler 4: Secrets committen**

```bash
# ❌ Falsch:
git add .env
git commit -m "Add config"
# → .env mit API Keys ist jetzt in Git History! ⚠️

# ✅ Richtig:
# .gitignore erstellen:
echo ".env" >> .gitignore
git add .gitignore
git commit -m "chore: Add .gitignore"

# .env.example für Dokumentation:
cp .env .env.example
# .env.example: Secrets durch Platzhalter ersetzen
git add .env.example
```

#### **Fehler 5: Kryptische Commit Messages**

```bash
# ❌ Falsch:
git commit -m "fix"
git commit -m "update"
git commit -m "changes"
git commit -m "asdf"

# ✅ Richtig:
git commit -m "fix: Prevent SQL injection in login"
git commit -m "feat: Add password reset email"
git commit -m "docs: Update API documentation"
git commit -m "test: Add unit tests for auth module"
```

#### **Fehler 6: Force Push auf shared Branches**

```bash
# ❌ Falsch (wenn andere auch am Branch arbeiten):
git push --force

# ✅ Richtig:
# Wenn du alleine am Branch arbeitest: OK
# Wenn andere auch arbeiten: NIEMALS force push!
# Stattdessen: merge conflicts normal lösen
```

---

## 🎓 Zusammenfassung

### **Die 7 Git Gebote für Anfänger:**

1. **Main Branch ist heilig** - Nie direkt drauf entwickeln
2. **Feature Branches für alles** - Jedes Feature = eigener Branch
3. **Kleine, fokussierte Commits** - Ein Commit = Eine logische Änderung
4. **Gute Commit Messages** - Conventional Commits Format nutzen
5. **Tests vor Commit** - Nur grüne Tests committen
6. **Secrets NIEMALS committen** - .gitignore verwenden
7. **Oft committen & pushen** - Nicht alles am Ende auf einmal

### **Claude hilft dir:**

✅ Commit Messages schreiben
✅ Pull Requests erstellen
✅ Conflicts analysieren
✅ Git Commands ausführen
✅ Best Practices einhalten

### **Cheat Sheet:**

```bash
# Täglicher Workflow:
git checkout main               # Zu main wechseln
git pull                        # Latest holen
git checkout -b feature/xyz     # Neuer Branch
# ... coden ...
git add .                       # Changes stagen
git commit -m "feat: ..."       # Committen
git push -u origin feature/xyz  # Pushen
gh pr create                    # PR erstellen

# Wenn PR gemerged:
git checkout main               # Zurück zu main
git pull                        # Latest holen (inkl. deinem Feature)
git branch -d feature/xyz       # Branch löschen
```

---

## 🚀 Nächste Schritte

✅ Erstelle dein erstes Repository mit Feature Branch Workflow
✅ Übe Commits mit Conventional Commits Format
✅ Erstelle deinen ersten Pull Request
✅ Schau dir [WORKFLOW_GUIDE.md](./WORKFLOW_GUIDE.md) an für Claude Integration

---

**Git ist anfangs verwirrend, aber mit Übung wird es zur zweiten Natur! 💪**
