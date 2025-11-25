Erstelle einen sauberen Git Commit mit Best Practices.

## Phase 1: Review Changes

1. **Git Status prüfen**
   ```bash
   git status
   ```
   - Welche Files wurden geändert?
   - Gibt es untracked Files?
   - Was ist staged vs unstaged?

2. **Diff anzeigen**
   ```bash
   git diff
   ```
   - Was wurde konkret geändert?
   - Sind alle Changes relevant?
   - Gibt es Debug-Code der raus sollte?

3. **Change Analysis**
   - Was war die Intention der Changes?
   - Sind alle Changes related (sollten in einen Commit)?
   - Oder sollten es mehrere separate Commits sein?

## Phase 2: Pre-Commit Checks

**⚠️ WICHTIG: Folgendes MUSS vor Commit passieren:**

1. **Tests laufen**
   ```bash
   # Python
   pytest

   # JavaScript
   npm test

   # PHP
   phpunit
   ```
   - ✅ Alle Tests müssen grün sein!
   - ❌ Niemals mit failing tests committen

2. **Linting/Formatting**
   ```bash
   # Python
   black src/
   flake8 src/

   # JavaScript
   npm run lint
   npm run format

   # PHP
   phpcs
   phpcbf
   ```

3. **Secrets Check**
   - Keine API Keys im Code?
   - Keine Passwords?
   - .env File nicht gestaged?
   - Prüfe mit: `git diff --cached`

4. **Debug Code entfernen**
   - Keine `console.log()` / `print()` Statements?
   - Keine commented-out code blocks?
   - Keine TODO comments (oder explizit gewollt)?

## Phase 3: Staging

1. **Intelligentes Staging**
   ```bash
   # Nur relevante Files stagen
   git add <specific-files>

   # NICHT einfach alles:
   # git add .  # ⚠️ Vorsicht!
   ```

2. **Files kategorisieren**
   - Welche Files gehören zusammen?
   - Sollte ich mehrere Commits machen?

3. **Final Diff Review**
   ```bash
   git diff --cached
   ```
   - Nochmal prüfen was committed wird

## Phase 4: Commit Message erstellen

### Conventional Commits Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type bestimmen

- `feat:` - Neues Feature
- `fix:` - Bug Fix
- `docs:` - Dokumentation
- `style:` - Formatierung (kein Logic Change)
- `refactor:` - Code Restructuring
- `test:` - Tests hinzufügen/ändern
- `chore:` - Build, Dependencies, Config
- `perf:` - Performance Improvement
- `ci:` - CI/CD Changes

### Subject Guidelines

- ✅ Imperativ: "Add feature" nicht "Added feature"
- ✅ Kurz: < 50 chars
- ✅ Lowercase nach type
- ✅ Kein Punkt am Ende
- ✅ Beschreibe WAS, nicht WIE

**Beispiele:**

❌ Schlecht:
```
Update stuff
Fixed bug
Changes
```

✅ Gut:
```
feat: Add user password reset functionality
fix: Prevent SQL injection in login query
docs: Update API documentation with new endpoints
refactor: Extract validation logic into separate service
test: Add integration tests for payment flow
```

### Body (optional, aber empfohlen für komplexe Changes)

- Erkläre **WARUM** die Change gemacht wurde
- Beschreibe den **KONTEXT**
- Erkläre **SIDE EFFECTS** falls vorhanden
- Bullet Points OK

**Beispiel:**
```
feat: Add user authentication with JWT

- Implements JWT-based authentication
- Uses bcrypt for password hashing
- Adds rate limiting to prevent brute force
- Includes comprehensive tests

This replaces the old session-based auth system
which had security vulnerabilities.
```

### Footer (optional)

- Breaking Changes: `BREAKING CHANGE: description`
- Issue References: `Closes #123`, `Fixes #456`
- Co-authors: `Co-authored-by: Name <email>`

## Phase 5: Commit erstellen

```bash
git commit -m "$(cat <<'EOF'
type(scope): subject

Body text here
explaining the change.

Closes #123
EOF
)"
```

**Oder für simple commits:**
```bash
git commit -m "feat: Add password reset endpoint"
```

## Phase 6: Verify

1. **Commit History prüfen**
   ```bash
   git log --oneline -1
   ```
   - Ist die Message gut?
   - Falls nicht: `git commit --amend`

2. **Show Commit**
   ```bash
   git show HEAD
   ```
   - Nochmal prüfen was committed wurde

3. **Push** (falls ready)
   ```bash
   git push
   ```

## Final Output Format

Zeige am Ende:

```
✅ Commit erfolgreich erstellt!

📝 Commit Message:
---
[Die erstellte Commit Message]
---

📊 Changes:
- X files changed
- Y insertions(+)
- Z deletions(-)

🔍 Commit Hash: abc123def

✅ Ready to push with: git push
```

Frage dann:
"Soll ich die Changes jetzt pushen?"

## Best Practices Reminder

### ✅ DO

- Klein und fokussiert
- Tests laufen
- Beschreibende Message
- Related Changes zusammen
- Regelmäßig committen

### ❌ DON'T

- Riesige Commits
- "Fixed stuff" Messages
- Failing Tests committen
- Debug Code committen
- Secrets committen
