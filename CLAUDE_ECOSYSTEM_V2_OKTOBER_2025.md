# UMFASSENDE RECHERCHE: CLAUDE CODE, CLAUDE DESKTOP & MCP ECOSYSTEM

**Zielgruppe:** Entwickler mit Anthropic Pro-Abo  
**Plattform:** macOS  
**Stand:** 22. Oktober 2025  
**Version:** 2.0 - Vollständig aktualisiert mit Claude Code 2.0, Sonnet 4.5, Security Features

---

## STATUS DER RECHERCHE

- [x] SCHRITT 1: Claude Code Dokumentation ✅
- [x] SCHRITT 2: Claude Desktop Dokumentation ✅
- [x] SCHRITT 3: MCP Allgemein ✅
- [x] SCHRITT 4: MCP Filesystem Server ✅
- [x] SCHRITT 5: Interaktionen & Workflows ✅
- [x] SCHRITT 6: Praktische Aspekte ✅

**RECHERCHE ABGESCHLOSSEN** - Alle Sektionen befüllt

---

## 🆕 WICHTIGSTE UPDATES OKTOBER 2025

### Claude Code 2.0 (September 2025 Release)

**Revolutionary Updates für Autonomes Coding:**

🖥️ **VS Code Extension (Beta)**
- Native IDE-Integration mit Sidebar
- Real-time Inline Diffs
- Plan Mode für Preview vor Execution
- Kompatibel: VS Code, Cursor, Windsurf

🔄 **Checkpoints System**
- Auto-Save von Code + Konversation
- 30-Tage Retention
- 3 Restore-Modi (Chat only, Code only, Both)
- ESC ESC oder /rewind

⚡ **Performance & Features**
- **30+ Stunden** autonomes Coding (Sonnet 4.5)
- **Background Tasks** - Parallele Processes
- **Terminal v2.0** - Ctrl+R History, ~3x schneller
- **Tab-Thinking** - Extended Reasoning on demand

### Claude Sonnet 4.5 (Neues Default-Model)

🥇 **77.2%** auf SWE-bench Verified - **Bestes Coding-Model weltweit**  
💻 **61.4%** auf OSWorld Computer Use (+19 Prozentpunkte)  
⚡ Pricing unverändert: $3/$15 per million tokens

### Security & API Updates

🔒 **Security Features**
- `/security-review` Command - Auto-Analyse für Vulnerabilities
- GitHub Actions Integration für CI/CD
- OWASP Top 10, SQL Injection, XSS Detection

📦 **Skills & API**
- `/v1/skills` API Endpoint für programmatische Verwaltung
- Context Editing für längere Tasks
- Memory Tool für persistentes Memory

🌐 **Weitere Updates**
- Claude for Chrome Extension (Max Users)
- "Imagine with Claude" Research Preview
- Consumer Terms Update (Opt-in Model Training)

**📖 Detaillierte Informationen:**
- [Claude Code 2.0 Features](#f-claude-code-20---neue-features-september-2025)
- [VS Code Extension](#vs-code-extension-setup-guide)
- [Checkpoints Guide](#checkpoints-system-deep-dive)
- [Security Features](#g-security-features-neu---oktober-2025)

---

## SCHRITT 1: CLAUDE CODE DOKUMENTATION

### A) KERNFUNKTIONEN & CLI-BEFEHLE

**Installation:**
```bash
npm install -g @anthropic-ai/claude-code
# oder via Homebrew (Beta):
brew install claude-code
```

**Hauptbefehle:**

1. **`claude`** - Startet interaktive Session
   - Beim ersten Start: Login erforderlich (Claude.ai oder Claude Console Account)
   - Automatische Workspace-Erstellung ("Claude Code")

2. **`claude -p "prompt"`** - Print Mode (nicht-interaktiv/"headless")
   - Für programmatische Nutzung und CI/CD
   - Beispiel: `tail -f app.log | claude -p "Slack me if you see anomalies"`

3. **`claude --permission-mode [normal|auto|plan]`**
   - **normal**: Fragt vor jeder Dateiänderung
   - **auto**: Auto-Accept Mode (akzeptiert alle Edits)
   - **plan**: Plan Mode (kein Ausführen, nur Planung)
   - Wechsel während Session: `Shift+Tab` zum Durchschalten

4. **`claude --agents '{...}'`** - Subagenten inline definieren
   ```bash
   claude --agents '{"code-reviewer": {...}, "debugger": {...}}'
   ```

5. **`claude --dangerously-skip-permissions`** - ⚠️ Überspringt alle Berechtigungsfragen

**🆕 Neue Commands (Claude Code 2.0 - September 2025):**
```bash
/rewind            # Checkpoint wiederherstellen (ESC ESC als Shortcut)
/usage             # Token-Usage & Statistiken anzeigen
/security-review   # Automatische Security-Analyse (siehe Sektion G)
Tab                # Toggle Extended Thinking für komplexe Tasks
```

**Interaktive Modi-Shortcuts:**
- `Shift+Tab`: Wechsel zwischen Permission Modes
- `/config`: Öffnet Settings Interface
- `/allowed-tools`: Tool-Berechtigungen verwalten
- **`Ctrl+R`**: Searchable Prompt History (v2.0 - frühere Prompts wiederverwenden)
- **`ESC ESC`**: Quick Checkpoint Rewind (v2.0 - zurück zum letzten State)
- **`Tab`**: Toggle Extended Thinking (v2.0 - Deep Reasoning aktivieren)

**Kernfähigkeiten:**
- ✅ Automatisches Lesen aller Projektdateien (kein manuelles Context-Adding)
- ✅ Direktes Editieren von Dateien
- ✅ Ausführen von Bash-Befehlen
- ✅ Git-Integration (Commits erstellen möglich)
- ✅ Web-Suche für aktuelle Informationen
- ✅ MCP-Integration (Google Drive, Figma, Slack, etc.)
- ✅ Zugriff auf eigene Dokumentation (kann Fragen zu Features beantworten)
- ✅ Unix-Philosophy: Composable und scriptable
- ✅ **30+ Stunden autonomes Coding** (Sonnet 4.5)
- ✅ **Checkpoints für Safe Autonomy** (v2.0)
- ✅ **Background Tasks für Parallel Work** (v2.0)

**🚀 Aktuelle Performance (Oktober 2025):**

**Claude Sonnet 4.5** ist Default-Model (seit September 2025):
- **77.2%** auf SWE-bench Verified → **Best coding model in the world**
- **61.4%** auf OSWorld Computer Use Benchmark (+19 Prozentpunkte vs. Sonnet 4)
- **30+ Stunden** kontinuierliches autonomes Coding ohne Context-Loss
- **Pricing unverändert**: $3 Input / $15 Output per million tokens

**Verfügbare Modelle:**
```bash
/model  # Modell wechseln

# Verfügbar:
- Claude Sonnet 4.5 (Default, empfohlen für Coding)
- Claude Opus 4.1 (komplexeste Reasoning-Tasks)
- Claude Haiku 4.5 (schnellstes Model)
```

### B) .claude Ordner Konfiguration

Der `.claude/` Ordner ist das Herz der Projektkonfiguration. Hier sind alle strukturellen Elemente:

**📁 Verzeichnisstruktur:**
```
.claude/
├── settings.json              # Projekt-Settings (im Git)
├── settings.local.json        # Lokale Settings (nicht im Git, wird auto-ignoriert)
├── CLAUDE.md                  # Projekt-Memory/Kontext
├── agents/                    # Subagenten (Markdown-Dateien)
│   ├── code-reviewer.md
│   └── debugger.md
├── commands/                  # Slash Commands (Markdown-Dateien)
│   ├── fix-issue.md
│   └── security-review.md
└── skills/                    # Skills (Ordner mit SKILL.md)
    └── my-skill/
        ├── SKILL.md           # Hauptdatei (erforderlich)
        ├── reference.md       # Zusätzliche Docs
        ├── scripts/           # Hilfsskripte
        └── templates/         # Templates
```

**1. CLAUDE.md (Projekt-Memory)**
- Kontext für das Projekt, den Claude automatisch liest
- Kann auch als `CLAUDE.md` im Projektroot liegen
- Alternative: `~/.claude/CLAUDE.md` für globalen Kontext
- Verwendung: Projektbeschreibung, wichtige Konventionen, häufige Aufgaben

**2. Slash Commands (`.claude/commands/`)**
- **User-invoked**: Nutzer tippt explizit `/command`
- Markdown-Dateien mit optionalem YAML Frontmatter
- Können Argumente akzeptieren: `/fix-issue 123`
- Beispiel:
  ```markdown
  ---
  name: fix-issue
  description: Fix a GitHub issue
  ---
  Find and fix issue #$ARGUMENTS. Follow these steps:
  1. Understand the issue
  2. Locate relevant code
  3. Implement solution
  4. Add tests
  ```
- Können auch global sein: `~/.claude/commands/` für alle Projekte

**3. Skills (`.claude/skills/`)**
- **Model-invoked**: Claude entscheidet selbst, wann sie verwendet werden
- Jeder Skill ist ein Ordner mit `SKILL.md` (Pflicht)
- YAML Frontmatter mit `name` und `description` (entscheidend für Discovery!)
- Beispiel-Struktur:
  ```markdown
  ---
  name: Generating Commit Messages
  description: Generates clear commit messages from git diffs. Use when writing commit messages.
  ---
  # Generating Commit Messages
  ## Instructions
  1. Run `git diff --staged`
  2. Suggest commit message with:
     - Summary under 50 characters
     - Detailed description
  ```
- Können auch von Plugins kommen
- Unterschied zu Commands: Skills werden automatisch verwendet, Commands manuell

**4. Subagenten (`.claude/agents/`)**
- Markdown-Dateien mit YAML Frontmatter
- Spezialisierte AI-Assistenten mit eigenen Prompts und Tool-Berechtigungen
- Können inline oder als Dateien definiert werden
- Beispiel:
  ```markdown
  ---
  name: code-reviewer
  description: Expert code reviewer. Use proactively after code changes.
  prompt: You are a senior code reviewer. Focus on quality, security, best practices.
  tools: ["Read", "Grep", "Glob", "Bash"]
  model: sonnet
  ---
  ```
- Auch global möglich: `~/.claude/agents/`

**5. settings.json**
- Hierarchisches Settings-System (siehe nächster Abschnitt)
- Definiert Permissions, Hooks, Environment Variables, Plugins
- `.claude/settings.json`: Im Git, für Team geteilt
- `.claude/settings.local.json`: Nicht im Git, persönliche Präferenzen

**Interaktion zwischen Komponenten:**
- **CLAUDE.md** wird von **Skills** referenziert via `@CLAUDE.md`
- **Subagenten** haben Zugriff auf **Skills**
- **Slash Commands** können **Subagenten** aufrufen
- **Hooks** (in settings.json) reagieren auf Tool-Events
- **Plugins** können alle Komponenten bündeln (Commands, Agents, Hooks, MCP-Server)

### C) PROJEKT-STRUKTUR

**Settings-Hierarchie (von niedrigster zu höchster Priorität):**

1. **Enterprise Managed Settings** (höchste Priorität)
   - macOS: `/Library/Application Support/ClaudeCode/managed-settings.json`
   - Linux/WSL: `/etc/claude-code/managed-settings.json`
   - Windows: `C:\ProgramData\ClaudeCode\managed-settings.json`
   - ⚠️ Überschreibt alle anderen Settings (für Unternehmensrichtlinien)

2. **User Settings** (global)
   - `~/.claude/settings.json`
   - Gilt für alle Projekte des Nutzers

3. **Project Settings**
   - `.claude/settings.json` (im Git, mit Team geteilt)
   - `.claude/settings.local.json` (nicht im Git, persönlich)

**settings.json - Beispiel-Struktur:**
```json
{
  "permissions": {
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test:*)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Bash(curl:*)",
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)"
    ]
  },
  "env": {
    "NODE_ENV": "development",
    "CUSTOM_VAR": "value"
  },
  "enabledPlugins": {
    "formatter@company-tools": true,
    "deployer@company-tools": true
  },
  "extraKnownMarketplaces": {
    "company-tools": {
      "source": "github",
      "repo": "company/claude-plugins"
    }
  }
}
```

**Environment Variables:**
- Alle Environment Variables können auch in `settings.json` definiert werden
- Wichtige Built-in Variables:
  - `CLAUDE_CODE_REMOTE`: `"true"` wenn in Web-Umgebung
  - `CLAUDE_ENV_FILE`: Pfad für persistente Env-Vars in Hooks
  - `CLAUDE_CODE_USE_VERTEX=1`: Nutzt Google Vertex AI
  - `CLAUDE_CODE_ENABLE_TELEMETRY`: Telemetrie ein/aus

**Konfiguration via CLI:**
- `/config`: Öffnet Tabbed Settings Interface (im interaktiven Modus)
- `/allowed-tools`: Tool-Berechtigungen verwalten

**Optimale Projektstruktur:**
```
my-project/
├── .claude/
│   ├── settings.json          # Team-weite Konfiguration
│   ├── settings.local.json    # Persönliche Overrides
│   ├── CLAUDE.md              # Projekt-Kontext
│   ├── agents/                # Projekt-spezifische Subagenten
│   ├── commands/              # Projekt-spezifische Commands
│   └── skills/                # Projekt-spezifische Skills
├── CLAUDE.md                  # Alternative Position
├── .gitignore                 # Sollte .claude/settings.local.json enthalten
└── [restliche Projektdateien]
```

### D) AGENTIC CODING WORKFLOWS

**Was bedeutet "Agentic Coding"?**
Claude Code ist ein autonomer Agent, der:
- Selbstständig Dateien liest und schreibt
- Bash-Befehle ausführt
- Tests laufen lässt und auf Fehler reagiert
- Git-Commits erstellt
- Iterativ arbeitet, bis das Ziel erreicht ist

**Interaktiv vs. Autonom:**

**Interaktiver Modus** (`claude`):
- Standard-Modus mit Benutzer-Interaktion
- Claude fragt um Erlaubnis vor Dateiänderungen (Normal Mode)
- Nutzer kann jederzeit eingreifen und steuern
- Ideal für: Exploration, iterative Entwicklung, Lernen

**Autonomer Modus** (mehrere Varianten):
1. **Auto-Accept Mode**: `Shift+Tab` zum Aktivieren
   - Akzeptiert alle Edits automatisch
   - Anzeige: `⏵⏵ accept edits on`
   
2. **Print Mode** (`claude -p "prompt"`):
   - "Headless" Betrieb ohne Interaktion
   - Für CI/CD und Automatisierung
   - Gibt nur Ergebnis zurück
   
3. **Plan Mode** (`--permission-mode plan`):
   - Claude plant nur, führt nicht aus
   - Anzeige: `⏸ plan mode on`
   - Ideal für: Code-Exploration, Architekturplanung

**Typische Workflows:**

**1. Feature-Entwicklung:**
```bash
claude
> "Implement OAuth2 authentication for our API"
# Claude wird:
# - Architektur planen
# - Notwendige Dateien identifizieren
# - Code schreiben
# - Tests erstellen
# - Sicherstellen dass alles funktioniert
```

**2. Bug-Fixing:**
```bash
claude
> "Fix the login bug where users see blank screen after wrong credentials"
# Claude wird:
# - Relevante Dateien finden
# - Problem analysieren
# - Fix implementieren
# - Testen
```

**3. CI/CD Integration:**
```bash
claude -p "If there are new text strings, translate them to French and raise a PR"
# Programmatischer Aufruf ohne Interaktion
```

**4. Log-Monitoring:**
```bash
tail -f app.log | claude -p "Slack me if you see anomalies"
# Streaming-Input verarbeiten
```

**CLI-Tools Integration:**

Claude Code hat Zugriff auf:
- **Bash-Tool**: Kann beliebige CLI-Tools ausführen
- **Read/Write Tools**: Dateisystem-Operationen
- **Grep/Glob Tools**: Codebase durchsuchen
- **Git-Tools**: Git-Operationen

**Custom Tools via Hooks:**
Hooks erlauben es, Custom Commands vor/nach Tool-Execution auszuführen.

Beispiel in `settings.json`:
```json
{
  "hooks": {
    "afterWrite": {
      "**/*.py": "black $FILE"  // Auto-Format nach Python-Datei-Änderung
    },
    "beforeWrite": {
      "**/production.config": "exit 1"  // Blockiere Produktion-Configs
    }
  }
}
```

**Subagenten für spezialisierte Tasks:**
Subagenten ermöglichen Aufgaben-Delegation:
```bash
claude --agents '{
  "code-reviewer": {
    "description": "Use after code changes",
    "prompt": "You are a senior code reviewer",
    "tools": ["Read", "Grep"],
    "model": "sonnet"
  },
  "debugger": {
    "description": "For errors and test failures",
    "prompt": "Expert debugger",
    "tools": ["Bash", "Read", "Write"]
  }
}'
```

**Best Practices:**
- ✅ Sei spezifisch: "Fix login bug with blank screen" statt "fix bug"
- ✅ Nutze Plan Mode für Exploration
- ✅ Nutze Auto-Accept für bekannte, sichere Aufgaben
- ✅ Definiere klare Permissions für sensible Bereiche
- ✅ Erstelle Subagenten für wiederkehrende Aufgaben

---

**🔧 CLI-TOOLS INTEGRATION - DETAILLIERTE ANLEITUNG**

Claude Code kann **beliebige CLI-Tools** via Bash-Tool integrieren und nutzen. Hier sind alle Methoden:

**Methode 1: Direkte Nutzung (Einfachste)**
```bash
claude
> "Run npm test and analyze the results"
# Claude führt automatisch aus: Bash(npm test)
# Analysiert Output und gibt Zusammenfassung

> "Check outdated dependencies"
# Claude: Bash(npm outdated)
```

**Methode 2: Via Hooks (Automatisch nach Events)**
```json
{
  "hooks": {
    "afterWrite": {
      "**/*.py": "black $FILE",              // Auto-format Python
      "**/*.ts": "prettier --write $FILE",   // Auto-format TypeScript
      "**/*.go": "gofmt -w $FILE"            // Auto-format Go
    },
    "beforeBash": {
      "*": "echo 'Running: $COMMAND' >> ~/.claude/audit.log"
    },
    "afterBash": {
      "npm test*": "notify-send 'Tests complete'"  // Desktop notification
    }
  }
}
```

**Methode 3: In Slash Commands einbinden**
```markdown
---
name: lint-fix
description: Runs linter and auto-fixes issues
---

# Lint and Fix

Execute these commands:
1. `npm run lint -- --fix`
2. `git add -u`
3. Report what was fixed
```

Verwendung: `/lint-fix`

**Methode 4: Via Subagenten mit Tool-Restrictions**
```markdown
---
name: test-runner
description: Runs tests and analyzes failures
tools: ["Bash", "Read", "Write"]
model: sonnet
---

You are a test automation specialist.

Always run tests with appropriate flags:
- JavaScript: `npm test -- --coverage`
- Python: `pytest --cov --verbose`
- Go: `go test -cover ./...`
```

**Methode 5: In Skills integrieren**
```markdown
---
name: Database Operations
description: Database migration and schema management. Use for Prisma, TypeORM tasks.
---

# Database Operations Skill

## Available Commands
- `npx prisma migrate dev --name [name]` - Create migration
- `npx prisma migrate deploy` - Deploy to production
- `npx prisma db push` - Push schema without migration
- `npx prisma studio` - Open DB GUI

## Workflow
1. Check migration status: `npx prisma migrate status`
2. Create/apply migration
3. Verify with `prisma studio`
```

**📦 Beispiele für häufige CLI-Tool-Integrationen:**

**Package Managers:**
```bash
# npm/yarn
> "Install lodash and update package.json"
# Bash(npm install lodash)

> "Add TypeScript as dev dependency"
# Bash(npm install -D typescript)

# pip
> "Install requirements and create virtual env"
# Bash(python -m venv venv && source venv/bin/activate && pip install -r requirements.txt)
```

**Docker & Containers:**
```bash
> "Build docker image and tag as v1.2.3"
# Bash(docker build -t myapp:v1.2.3 .)

> "Show running containers with health status"
# Bash(docker ps --format 'table {{.Names}}\t{{.Status}}')

> "Check container logs for errors"
# Bash(docker logs myapp 2>&1 | grep -i error)
```

**Database Tools:**
```bash
> "Create new Prisma migration for user roles"
# Bash(npx prisma migrate dev --name add-user-roles)

> "Run database seeds"
# Bash(npx prisma db seed)

> "Backup PostgreSQL database"
# Bash(pg_dump mydb > backup.sql)
```

**AWS CLI:**
```bash
> "List S3 buckets and their sizes"
# Bash(aws s3 ls | awk '{print $3}' | xargs -I {} sh -c 'echo -n "{}: "; aws s3 ls s3://{}/ --recursive | awk "{sum+=\$3} END {print sum}"')

> "Check EC2 instances status"
# Bash(aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key==`Name`].Value|[0]]' --output table)
```

**Git Operations (via Bash):**
```bash
> "Show git log with branch graph"
# Bash(git log --oneline --graph --all -20)

> "Find commits by author in last month"
# Bash(git log --author="John" --since="1 month ago" --oneline)

> "Clean up merged branches"
# Bash(git branch --merged | grep -v "main\|master\|develop" | xargs -n 1 git branch -d)
```

**Custom Scripts:**
```bash
> "Run our custom deployment script to staging"
# Bash(./scripts/deploy.sh staging)

> "Execute data migration script"
# Bash(python scripts/migrate_data.py --env production)
```

**🔒 Permissions & Sicherheit für CLI-Tools:**

**Explizit erlaubte Commands:**
```json
{
  "permissions": {
    "allow": [
      "Bash(npm test*)",
      "Bash(npm run lint*)",
      "Bash(git status)",
      "Bash(git log*)",
      "Bash(git diff*)",
      "Bash(docker ps*)",
      "Bash(docker logs*)",
      "Bash(kubectl get*)",
      "Bash(aws s3 ls*)"
    ],
    "deny": [
      "Bash(rm -rf*)",
      "Bash(sudo*)",
      "Bash(curl*://*/secrets*)",
      "Bash(chmod 777*)",
      "Bash(git push --force*)"
    ]
  }
}
```

**Best Practices für CLI-Tool-Integration:**

✅ **Permissions definieren**: Allow-List für erlaubte Commands
✅ **Deny gefährliche Commands**: `rm -rf`, `sudo`, force-push
✅ **Audit Logging**: Via Hooks alle Commands loggen
✅ **Tool-Verfügbarkeit prüfen**: `which tool` vor Nutzung
✅ **Fehlerbehandlung**: Claude prüft Exit-Codes automatisch
✅ **Environment Setup**: In `sessionStart` Hooks
✅ **Idempotenz**: Commands sollten mehrfach ausführbar sein

**🎯 Fortgeschrittenes Beispiel: Multi-Tool-Workflow**

**.claude/commands/full-ci-check.md:**
```markdown
---
name: full-ci-check
description: Runs complete CI/CD checks locally
---

# Full CI Check

Run the complete CI pipeline locally:

1. **Linting**
   ```bash
   npm run lint
   ```

2. **Type Checking**
   ```bash
   npm run typecheck
   ```

3. **Tests**
   ```bash
   npm test -- --coverage
   ```

4. **Build**
   ```bash
   npm run build
   ```

5. **Security Audit**
   ```bash
   npm audit
   ```

Report:
- ✅ What passed
- ❌ What failed
- 📊 Coverage percentage
- 🔒 Security vulnerabilities found
```

**Hook-basierte Tool-Automation:**
```json
{
  "hooks": {
    "sessionStart": [
      {
        "type": "command",
        "command": "if [ ! -d node_modules ]; then npm install; fi"
      }
    ],
    "afterWrite": {
      "**/*.py": "black $FILE && pylint $FILE",
      "**/*.ts": "prettier --write $FILE && eslint --fix $FILE",
      "**/*.rs": "rustfmt $FILE && cargo clippy"
    },
    "beforeBash": {
      "npm run deploy*": "read -p 'Deploy to production? (y/n) ' -n 1 -r; echo; [[ $REPLY =~ ^[Yy]$ ]]"
    }
  }
}
```

**💡 Pro-Tips:**

1. **Wrapper-Scripts für komplexe Tools:**
   ```bash
   # scripts/safe-deploy.sh
   #!/bin/bash
   ENV=$1
   if [ "$ENV" = "production" ]; then
     echo "Production deployment requires manual approval"
     exit 1
   fi
   ./deploy.sh $ENV
   ```

2. **Tool-Verfügbarkeit-Check in Skills:**
   ```markdown
   Before using kubectl, verify:
   - `which kubectl` returns path
   - `kubectl version` succeeds
   - Current context is correct: `kubectl config current-context`
   ```

3. **Output-Parsing für strukturierte Daten:**
   ```bash
   > "Get JSON output of docker containers"
   # Bash(docker ps --format '{{json .}}' | jq -s '.')
   ```

4. **Kombinierte Tool-Chains:**
   ```bash
   > "Find largest files and compress them"
   # Bash(find . -type f -size +10M -exec gzip {} \;)
   ```

**🔍 Debugging CLI-Tool-Integration:**

```bash
# Check was ausgeführt wurde
tail -f ~/.claude/audit.log

# Permissions testen
claude --allowed-tools "Bash(echo*)" -p "Run echo test"

# Hooks debuggen
# In settings.json: Hooks mit "echo" Commands testen
{
  "hooks": {
    "beforeBash": {
      "*": "echo 'About to run: $COMMAND'"
    }
  }
}
```

**Häufige CLI-Tools Referenz:**

| Tool | Use-Case | Permission Pattern |
|------|----------|-------------------|
| npm/yarn | Package Management | `Bash(npm install*)`, `Bash(npm test*)` |
| git | Version Control | `Bash(git status)`, `Bash(git log*)` |
| docker | Containers | `Bash(docker ps*)`, `Bash(docker logs*)` |
| kubectl | Kubernetes | `Bash(kubectl get*)`, `Bash(kubectl describe*)` |
| aws-cli | AWS Ops | `Bash(aws s3*)`, `Bash(aws ec2*)` |
| gcloud | GCP Ops | `Bash(gcloud compute*)` |
| terraform | Infrastructure | `Bash(terraform plan)`, `Bash(terraform apply)` |
| prisma | Database ORM | `Bash(npx prisma migrate*)` |
| pytest | Python Testing | `Bash(pytest*)` |
| cargo | Rust Build | `Bash(cargo build)`, `Bash(cargo test)` |



### E) INTEGRATION

**Git-Integration:**
- ✅ Claude kann Git-Commits erstellen
- ✅ Automatisches Ignorieren von `.claude/settings.local.json`
- ✅ Git Worktrees für parallele Task-Isolation:
  ```bash
  # Worktree erstellen
  git worktree add ../project-feature-a -b feature-a
  cd ../project-feature-a
  claude
  # Isolierte Claude Code Instanz in separatem Branch
  ```
- ✅ Branch-Management möglich
- ⚠️ PR-Erstellung: Über CI/CD oder manuell

**Web-Version (Claude Code on the Web):**
- Research Preview verfügbar
- Startet Claude Code aus der Claude App
- Ideal für:
  - Fragen zu Code-Architektur
  - Bugfixes und Routine-Tasks
  - Parallele Arbeit (mehrere Bugs gleichzeitig)
  - Repos nicht auf lokalem Rechner
  - Backend-Änderungen mit Tests
- Auch auf Claude iOS App verfügbar
- Sessions können vom Web zum Terminal übertragen werden

**Web-Umgebung Details:**
- Universal Image mit vorinstallierten Toolchains
- Auto-Clone des Repositories (Default Branch)
- Netzwerk konfigurierbar (kein/limitiert/voll)
- `CLAUDE_CODE_REMOTE=true` Environment Variable in Web-Sessions
- SessionStart Hooks für Environment-Setup

**VS Code Extension (Beta):**
- Native IDE-Erfahrung ohne Terminal
- Installation via Marketplace
- Claude direkt in Sidebar
- Für Nutzer die GUI bevorzugen

**Entwicklungstools-Integration:**
- **npm/pip**: Voller Package-Management Support
- **Testing Frameworks**: Jest, pytest, etc. automatisch nutzbar
- **Linters**: Kann via Hooks integriert werden
- **Formatters**: Auto-Format via afterWrite Hooks

**MCP (Model Context Protocol):**
- Volle Integration (siehe MCP-Sektion)
- Zugriff auf externe Datenquellen:
  - Google Drive
  - Figma
  - Slack
  - Custom MCP-Server
- MCP-Server können in `settings.json` oder global konfiguriert werden

**API & SDK (Claude Agent SDK):**
- Früher "Claude Code SDK", jetzt "Claude Agent SDK"
- Build Custom Agents auf Claude Code Infrastruktur
- TypeScript & Python Support
- Features:
  - Context Management
  - File Operations
  - Code Execution
  - Web Search
  - MCP Extensibility
  - Permissions System
- Migration Guide verfügbar: `@anthropic-ai/claude-code` → `@anthropic-ai/claude-agent-sdk`

**Enterprise Features:**
- Managed Settings für Unternehmensrichtlinien
- Managed MCP Configuration
- AWS/GCP Hosting möglich
- Zentrales Cost-Tracking via Workspaces

### F) OUTPUT STYLES

**Was sind Output Styles?**
Output Styles sind **gespeicherte System-Prompt-Konfigurationen**, die Claudes Verhalten und Antwort-Stil in Claude Code definieren. Sie erlauben es, Claude Code als verschiedene Agent-Typen zu nutzen, während die Core-Capabilities erhalten bleiben.

**⚠️ WICHTIG:** Output Styles sind spezifisch für **Claude Code** (nicht Desktop/Web)

**Unterschied zu anderen Konfigurationen:**

| Feature | Was es macht | Scope |
|---------|-------------|-------|
| **Output Styles** | Modifiziert System Prompt direkt | Session/Project |
| **CLAUDE.md** | Fügt User Message nach System Prompt hinzu | Project/User |
| **--append-system-prompt** | Hängt an System Prompt an | CLI Flag |
| **Slash Commands** | Gespeicherte User-Prompts | User-invoked |
| **Subagenten** | Spezialisierte Agents mit eigenen Prompts | Task-specific |

**Built-in Output Styles:**

**1. Default (Standard)**
- Existierender System Prompt von Claude Code
- Optimiert für Software Engineering Tasks
- Effiziente, prägnante Ausgabe
- Verifies Code mit Tests

**2. Explanatory (Lernmodus)**
- Bietet "Insights" während der Arbeit
- Erklärt Implementation-Entscheidungen
- Hilft Codebase-Patterns zu verstehen
- Ideal für: Onboarding, Code-Learning

**3. Learning (Interaktiv)**
- Collaborative "Learn-by-Doing" Mode
- Claude teilt nicht nur Insights, sondern fordert User auf Code beizutragen
- Erstellt `TODO(human)` Markers im Code
- User implementiert strategische Code-Teile selbst

**Output Style wechseln:**

**Via Slash Command:**
```bash
# Menü öffnen
/output-style

# Direkt wechseln
/output-style explanatory
/output-style learning
/output-style default

# Auch via /config Menü zugänglich
```

**Speicherort:**
- Änderungen werden in `.claude/settings.local.json` gespeichert
- Gelten auf Projekt-Level

**Custom Output Styles erstellen:**

**Mit Claude's Hilfe:**
```bash
/output-style:new I want an output style that acts as a security expert 
                 focusing on vulnerability detection
```

**Manuell erstellen:**

**Speicherorte:**
- User-Level: `~/.claude/output-styles/my-style.md` (über alle Projekte)
- Project-Level: `.claude/output-styles/my-style.md` (projekt-spezifisch)

**Format:**
```markdown
---
name: My Custom Style
description: A brief description of what this style does
---

# Custom Style Instructions

You are an interactive CLI tool that helps users with software engineering tasks.

[Your custom instructions here...]

## Specific Behaviors

- Be verbose in explanations
- Always show alternative approaches
- Focus on security and best practices

## Response Format

- Start with a brief summary
- Provide detailed reasoning
- End with actionable next steps
```

**Was Output Styles tun:**

✅ **Ersetzen** die default Software-Engineering Instructions
✅ **Behalten** Core-Capabilities (File-Ops, Bash, Tools, TODOs)
✅ **Definieren** komplett neues Verhalten
✅ **Persistent** über Sessions hinweg (Project-Level)

**Was Output Styles NICHT tun:**

❌ Ändern nicht CLAUDE.md (läuft separat)
❌ Überschreiben nicht `--append-system-prompt`
❌ Beeinflussen nicht Subagenten (die haben eigene Prompts)

**Beispiel-Use-Cases:**

**Security Auditor Style:**
```markdown
---
name: Security Auditor
description: Focuses on security vulnerabilities and best practices
---

You are a security-focused code auditor. For every change:
1. Identify potential security vulnerabilities
2. Check for common OWASP Top 10 issues
3. Validate input sanitization
4. Review authentication/authorization
5. Flag any hardcoded secrets
```

**Performance Optimizer Style:**
```markdown
---
name: Performance Optimizer
description: Optimizes code for speed and efficiency
---

You are a performance optimization expert. Always:
- Profile before optimizing
- Consider Big O complexity
- Look for unnecessary operations
- Suggest caching strategies
- Identify bottlenecks
```

**Documentation Writer Style:**
```markdown
---
name: Documentation Writer
description: Focuses on creating comprehensive documentation
---

You are a technical documentation specialist. For every task:
- Write clear, concise documentation
- Include code examples
- Add JSDoc/docstrings
- Create README sections
- Update CHANGELOG
```

**Best Practices:**

✅ **Eine klare Rolle definieren** im System Prompt
✅ **Specific Behaviors** dokumentieren
✅ **Response Format** spezifizieren
✅ **Use-Cases** im Description nennen (für Discoverability)
✅ **Testen** mit verschiedenen Tasks

**Debugging Output Styles:**

```bash
# Aktuellen Style anzeigen
/config  # Zeigt current output style

# Style zurücksetzen
/output-style default

# Settings prüfen
cat .claude/settings.local.json | grep output
```

**Technische Details:**

- Output Styles schalten **Software-Engineering-spezifische** Teile des System Prompts "aus"
- Non-default Styles excludieren:
  - Code generation Instructions
  - Concise output Requirements
  - Test verification Instructions
- Stattdessen: Eigene Custom Instructions werden eingesetzt
- System Prompt bleibt für Core-Funktionalität (Tools, Files, etc.)

**Kombination mit anderen Features:**

- **Mit CLAUDE.md**: CLAUDE.md wird als User Message NACH System Prompt hinzugefügt
- **Mit Subagenten**: Subagenten haben ihre eigenen System Prompts (unabhängig von Output Style)
- **Mit Hooks**: Hooks funktionieren unabhängig vom Output Style
- **Mit Skills**: Skills werden vom Output Style beeinflusst (folgen dem definierten Verhalten)

**Häufige Fragen:**

**Q: Output Style vs. Subagent?**
A: 
- **Output Style**: Ändert Hauptagent für gesamte Session
- **Subagent**: Spezialisierter Agent für spezifische Tasks

**Q: Kann ich mehrere Output Styles gleichzeitig nutzen?**
A: Nein, immer nur ein Output Style aktiv pro Session

**Q: Wird Output Style mit Team geteilt?**
A: Nur wenn in `.claude/output-styles/` (nicht `.local`) und in Git committed

**Q: Performance-Impact?**
A: Minimal - nur System Prompt wird modifiziert


### F) CLAUDE CODE 2.0 - NEUE FEATURES (SEPTEMBER 2025)

#### 🎯 ÜBERBLICK

Claude Code 2.0 (Release: 29. September 2025) ist die größte Evolution seit Launch.  
Powered by **Claude Sonnet 4.5** ermöglicht **30+ Stunden autonomes Coding**.

**Die 4 Säulen:**
1. 🖥️ **VS Code Extension** - Native IDE-Integration  
2. 🔄 **Checkpoints** - Safe Autonomy durch State-Management  
3. ⚙️ **Background Tasks** - Parallele Processes  
4. 🎨 **Terminal v2.0** - Performance-Boost, modernere UX

---

#### 1. VS CODE EXTENSION (BETA)

**Native IDE-Integration seit September 2025**

**Key Features:**
- **Sidebar Panel** - Dedicated Claude Code Panel in VS Code
- **Inline Diffs** - Code-Änderungen direkt im Editor
- **Plan Mode** - Review von Plänen vor Execution
- **Auto-Accept** - Optional für vertrauenswürdige Tasks
- **Real-time Feedback** - Live-Anzeige aller Operationen

**Installation:** VS Code Marketplace → "Claude Code" (Anthropic)

**Kompatibilität:** VS Code, Cursor, Windsurf, VSCodium

⚠️ **Security:** Mit auto-edit kann Claude IDE-Configs modifizieren.  
**Empfehlung:** Deny `.vscode/**` in permissions.

**vs. Legacy CLI:**
- **Extension:** GUI, Inline Diffs, Plan Mode
- **CLI:** Terminal, Scriptable, SSH-geeignet
- Beide parallel nutzbar!

---

#### 2. CHECKPOINTS SYSTEM

**Auto-Save von Code-State + Konversation**

**Nutzung:**
```bash
ESC ESC    # Quick Rewind
/rewind    # Explicit mit Auswahl
```

**3 Restore-Modi:**
1. **Chat only** - Rewind Konversation, Code bleibt
2. **Code only** - Rewind Code, Konversation bleibt
3. **Both** - Kompletter Reset

**Features:**
- 30-Tage Retention
- Session-persistent
- Auto-Erstellung bei Prompts

⚠️ Gilt nur für Claude's Edits, nicht User's Änderungen

**Top Use-Case:** "Entgiften" fehlgelaufener Konversationen

---

#### 3. BACKGROUND TASKS

**Parallele Long-Running Processes**

**Beispiel:**
```bash
> "Start dev server in background, then refactor"
# Server läuft → Claude arbeitet parallel
```

**Use Cases:** Dev Servers, Test Watchers, Build Processes

**Config:**
```json
{
  "hooks": {
    "sessionStart": [{
      "command": "npm run dev",
      "background": true
    }]
  }
}
```

---

#### 4. TERMINAL V2.0

**Updates:**
- **Ctrl+R** - Searchable Prompt History
- **~3x Performance** - Schneller, weniger Lag
- **Besseres UI** - Klarere Status-Anzeige

**Tab-Thinking:**
- Tab-Taste für Extended Thinking
- Ersetzt "think hard" (deprecated)
- "ultrathink" bleibt verfügbar (max budget)

---

### G) SECURITY FEATURES (NEU - OKTOBER 2025)

#### /security-review Command

**Auto-Analyse für Vulnerabilities:**
```bash
/security-review              # Ganzes Projekt
/security-review src/auth/   # Verzeichnis
```

**Prüft:** SQL Injection, XSS, Auth-Flaws, Secrets, Dependencies, OWASP Top 10

**Output:** Severity (Critical/High/Medium/Low), Fixes, Inline-Comments

#### GitHub Actions Integration

```yaml
# .github/workflows/claude-security.yml
jobs:
  security:
    steps:
      - uses: anthropic/claude-security-action@v1
        with:
          api-key: ${{ secrets.CLAUDE_API_KEY }}
```

**Features:** Auto-PR-Comments, Severity-Blocking, Fix-Recommendations

---

### H) WEITERE FEATURES & UPDATES (OKTOBER 2025)

**"Imagine with Claude"** (Research Preview)
- Real-time Software Generation, Max Users only

**Claude for Chrome**
- Jetzt für Max Users, Computer Use Capabilities

**Claude Agent SDK** (Rebranding)
- Früher "Claude Code SDK"
- General-purpose Agent Building

**Verfügbare Modelle (Update):**
- Claude Sonnet 4.5 (Default) - 77.2% SWE-bench
- Claude Opus 4.1
- Claude Haiku 4.5

**Consumer Terms Update:**
- Opt-in Model Training (Free/Pro/Max)
- 5-Jahr Retention vs. 30 Tage



### I) URSPRÜNGLICHE WEITERE FEATURES

**Plugin-System:**
- Erweiterung durch Plugins (Commands, Agents, Hooks, MCP-Server)
- Plugins werden über Marketplaces verteilt
- Konfiguration:
  ```json
  {
    "enabledPlugins": {
      "formatter@company-tools": true,
      "analyzer@security-plugins": false
    },
    "extraKnownMarketplaces": {
      "company-tools": {
        "source": "github",
        "repo": "company/claude-plugins"
      }
    }
  }
  ```
- Plugins können eigene Skills bündeln

**Tool-System mit Permissions:**
Verfügbare Tools:
- **Read**: Dateien lesen
- **Write**: Dateien schreiben
- **Bash**: Shell-Befehle ausführen
- **Grep**: Codebase durchsuchen
- **Glob**: Dateien nach Pattern finden
- **Git**: Git-Operationen (implizit via Bash)

Fine-Grained Permissions:
```json
{
  "permissions": {
    "allow": [
      "Bash(npm run test:*)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Read(./.env)",
      "Write(./secrets/**)"
    ]
  }
}
```

**Hooks-System:**
Custom Commands vor/nach Tool-Execution:
- `beforeWrite` / `afterWrite`
- `beforeBash` / `afterBash`
- `beforeRead` / `afterRead`
- `sessionStart` / `sessionEnd`

Beispiel-Anwendungen:
- Auto-Formatting nach Code-Änderungen
- Sicherheits-Checks vor Bash-Execution
- Environment-Setup bei Session-Start
- Blockieren von sensiblen File-Operations

**SessionStart Hooks:**
- Für Environment-Setup und Dependency-Installation
- Persistente Environment Variables via `CLAUDE_ENV_FILE`
- Unterscheidung Local vs. Remote via `CLAUDE_CODE_REMOTE`

**Context Management:**
- Automatisches Lesen relevanter Dateien
- Intelligent Context Compaction
- Prompt Caching für Performance
- Kein manuelles Context-Adding nötig

**Web-Search Integration:**
- Claude hat Zugriff auf aktuelle Web-Informationen
- Für Dokumentation, Best Practices, etc.
- Automatisch verfügbar, keine Konfiguration nötig

**Self-Documentation:**
- Claude hat Zugriff auf eigene Dokumentation
- Kann Fragen zu Features beantworten
- Immer aktuell, unabhängig von installierter Version

**Monitoring & Logging:**
- Telemetrie konfigurierbar via `CLAUDE_CODE_ENABLE_TELEMETRY`
- OTEL-Integration für Enterprise:
  ```json
  {
    "env": {
      "OTEL_METRICS_EXPORTER": "otlp"
    }
  }
  ```

**Multi-Task Support:**
- Git Worktrees für parallele Task-Isolation
- Mehrere Claude Code Instanzen gleichzeitig möglich
- Jede Instanz mit eigenem Kontext

**Streaming & Piping:**
- Unix-Philosophy: Composable und scriptable
- Beispiele:
  - `tail -f app.log | claude -p "alert on errors"`
  - `git diff | claude -p "write commit message"`

**Authentication:**
- Claude.ai Account (Rate Limits)
- Claude Console Account (API Credits, kein Rate Limit)
- Beide Accounts können unter gleicher E-Mail existieren
- Automatische Workspace-Erstellung bei erster Authentifizierung

**Workspace Management:**
- Zentrales Cost-Tracking
- Organisation-weite Verwaltung
- Automatisch erstellt beim ersten Login

**Development Container:**
- Reference Implementation verfügbar
- Für standardisierte Entwicklungsumgebungen

---

## SCHRITT 2: CLAUDE DESKTOP DOKUMENTATION

### A) KERNFUNKTIONEN

**Claude Desktop vs. Web-Version:**

Claude Desktop ist eine eigenständige Desktop-Anwendung (verfügbar für Windows und macOS), die folgende Vorteile gegenüber der Web-Version bietet:

**Hauptunterschiede:**
- ✅ **MCP-Integration**: Volle Model Context Protocol Unterstützung
- ✅ **Lokaler Dateizugriff**: Via MCP Filesystem Server
- ✅ **Offline-Verfügbarkeit**: Desktop-App funktioniert ohne Browser
- ✅ **Native Leistung**: Bessere Performance als Web-App
- ✅ **Desktop-Integration**: Systembenachrichtigungen, native UI

**Basis-Features (gleich wie Web):**
- Konversationen mit Claude (alle Modelle verfügbar)
- Artifacts (Code, HTML, React, Markdown, SVG, Mermaid, PDFs)
- Extended Thinking (aktivierbar für komplexe Aufgaben)
- Analysis Tool (Code-Ausführung für Datenanalyse, bis 30MB Excel-Dateien)
- Vision (Bilderkennung und -analyse, auch PDFs mit visuellen Elementen)
- Styles (Anpassung der Antwortweise von Claude)
- Voice Dictation (Spracheingabe)

**Desktop-Spezifische UI:**
- Native Window Management
- Systemtray-Integration
- Keyboard Shortcuts (nativ)
- MCP Server Indicator (Hammer-Icon ⚙️ unten rechts im Input-Bereich)


**Verfügbare Modelle (Oktober 2025):**
- **Claude Sonnet 4.5** (Empfohlen: höchste Intelligenz, Agents & Coding)
- **Claude Haiku 4.5** (Schnellstes Model, Near-Frontier Performance)
- **Claude Opus 4.1** (Komplexeste Herausforderungen)


**Aktuelle Features (2025):**
- ✅ Agent Skills (Pre-built & Custom für Dokumente: PPTX, XLSX, DOCX, PDF)
- ✅ Artifacts Publishing & Remixing
- ✅ Google Docs Integration (Pro, Team, Enterprise)
- ✅ Projects (siehe nächster Abschnitt)
- ✅ Erweiterte PDF-Unterstützung mit visueller Analyse

### B) PROJECTS (PROJEKTE)

**Was sind Projects?**
Projects sind Workspaces in Claude Desktop (und claude.ai), die es ermöglichen, Claude mit internem Wissen zu "erden" (grounding). Verfügbar für Pro, Max, Team und Enterprise Kunden.

**Projekt-Wissensbank:**
- Hochladen von Dokumenten und Dateien
- Automatisch in allen Konversationen des Projekts verfügbar
- Claude hat permanenten Zugriff auf hochgeladene Inhalte
- Ideal für: Style Guides, Codebases, Interview-Transkripte, frühere Arbeiten

**Unterstützte Dateitypen:**
Basierend auf den Claude Apps Features:
- **Dokumente**: PDF, DOCX, TXT, MD, HTML
- **Daten**: CSV, TSV, XLSX (bis 30MB mit Analysis Tool)
- **Code**: Alle gängigen Programmiersprachen
- **Bilder**: PNG, JPG, WEBP (für Vision)

**Limits & Größen:**
- Excel-Dateien: Bis zu 30MB
- ⚠️ **Hinweis**: Spezifische Limits für Projektgröße nicht in der gefundenen Dokumentation erwähnt
- Empfohlen: Relevante Dokumente auswählen statt gesamte Codebase

**Projekt-Erstellung:**
- Direkt von der Home Page aus
- Projektname und Beschreibung definieren
- Dokumente hochladen
- Konversationen im Projekt-Kontext starten

**Projekt-Organisation:**
- Chip Labels in Recent Chats (klickbar für schnellen Zugriff)
- Projekt-spezifische Konversationen
- Getrennte Kontexte für verschiedene Projekte

**Synchronisation & Speicherung:**
- Cloud-basierte Speicherung
- Verfügbar auf allen Geräten (Desktop, Web, Mobile)
- Team-Projekte: Geteilt zwischen Teammitgliedern

**Best Practices:**
- ✅ Klare Projektbeschreibungen für besseren Kontext
- ✅ Relevante Dokumente gruppieren
- ✅ Style Guides und Konventionen dokumentieren
- ✅ Regelmäßige Aktualisierung der Projekt-Dokumente

**Unterschied zu CLAUDE.md (Claude Code):**
- **Projects (Desktop/Web)**: Cloud-basiert, UI-gesteuert, für alle Konversationen
- **CLAUDE.md (Claude Code)**: Dateisystem-basiert, projekt-lokal, für CLI-Sessions

### C) MCP-INTEGRATION IN DESKTOP

**Konfigurationsdatei-Pfad (macOS):**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Format der Konfigurationsdatei:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/allowed/files"
      ]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<YOUR_TOKEN>"
      }
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

**MCP-Server Einbindung:**

1. **Config-Datei bearbeiten**: `claude_desktop_config.json` erstellen/editieren
2. **Server definieren**: Name, Command, Args, (optional) Env-Vars
3. **Claude Desktop neu starten**: Damit Config geladen wird
4. **Hammer-Icon prüfen**: Unten rechts im Input-Bereich erscheint ⚙️
5. **Tools verfügbar**: Click auf Icon zeigt verfügbare Tools

**Transport-Typen:**

**1. STDIO (Standard für lokal):**
```json
{
  "filesystem": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path"]
  }
}
```

**2. HTTP (für remote Server):**
- Verwendet HTTP POST für Client-zu-Server Messages
- Optional: Server-Sent Events für Streaming
- Authentifizierung via Bearer Tokens, API Keys, Custom Headers
- Empfohlen: OAuth für Token-Erhalt

**3. SSE (Server-Sent Events):**
- Für Streaming-Fähigkeiten
- Primär von Cloud-Services verwendet

**Out-of-the-box verfügbare MCP-Server (Beispiele):**

**Official Reference Servers:**
- `@modelcontextprotocol/server-filesystem` - Sicherer Dateizugriff
- `@modelcontextprotocol/server-memory` - Knowledge Graph Memory
- `@modelcontextprotocol/server-github` - Git Repository Tools
- `@modelcontextprotocol/server-fetch` - Web Content Fetching
- `@modelcontextprotocol/server-sequential-thinking` - Dynamisches Problem-Solving

**Community & Company Servers (via Cloud):**
- Notion, Linear, Slack, Google Drive, Figma
- Vercel, Netlify, Cloudflare
- Airtable, Monday, Box
- Zapier (8.000+ Apps), Workato
- Canva, Invideo, Stytch
- GitHub Registry: Hunderte weitere Server

**Installation von MCP-Servern:**

**TypeScript/Node.js:**
```bash
npx -y @modelcontextprotocol/server-memory
```

**Python:**
```bash
uvx server-name  # Empfohlen
# oder
pip install server-name
```

**MCP Server Indicator:**
- Erscheint unten rechts im Konversations-Input (Hammer-Icon)
- Click zeigt: Verfügbare Tools von allen verbundenen Servern
- Resources via `@` im Prompt durchsuchbar
- Prompts via `/` als Slash Commands verfügbar

**Berechtigungen & Kontrolle:**
- **Explizite Zustimmung**: Jede Tool-Aktion erfordert User-Approval
- **Transparenz**: Anzeige welcher Server welche Tools bereitstellt
- **Sichere Ausführung**: Tools laufen mit definierten Permissions

### D) SKILLS & CUSTOM INSTRUCTIONS

**Agent Skills in Claude Desktop:**

Agent Skills sind filesystem-basierte Ressourcen, die Claude domänen-spezifische Expertise verleihen. Unterschied zu Prompts: Skills laden on-demand und eliminieren wiederholte Anweisungen über mehrere Konversationen hinweg.

**Pre-built Agent Skills (Anthropic):**
Verfügbar für alle User auf claude.ai und Claude Desktop:
- **PowerPoint (PPTX)**: Präsentations-Erstellung und -Bearbeitung
- **Excel (XLSX)**: Spreadsheet-Operationen und Datenanalyse
- **Word (DOCX)**: Dokument-Erstellung und -Bearbeitung
- **PDF**: PDF-Manipulation und -Extraktion

Diese Skills arbeiten automatisch im Hintergrund bei Dokument-Erstellung.

**Custom Skills:**

**Verfügbarkeit:**
- Pro, Max, Team, Enterprise Plans (mit Code Execution aktiviert)
- ⚠️ **Wichtig**: Custom Skills sind **individuell pro Nutzer**, NICHT org-weit
- Keine zentrale Admin-Verwaltung für Custom Skills in Claude.ai

**Upload-Methode (Claude.ai/Desktop):**
- Via Settings > Features
- Als ZIP-Datei hochladen
- Skill-Struktur im ZIP:
  ```
  my-skill/
  ├── SKILL.md (erforderlich)
  ├── reference.md (optional)
  ├── scripts/ (optional)
  └── templates/ (optional)
  ```

**Skill-Architektur:**
- Filesystem-basiert im VM Environment
- **Progressive Disclosure**: Information wird stufenweise geladen
- **Kein Netzwerkzugriff**: Skills können keine API-Calls machen
- **Keine Runtime Package Installation**: Nur pre-installed Packages

**Unterschied Claude Code vs. Claude.ai/Desktop:**
- **Claude Code**: Filesystem-basiert (persönlich/projekt), kein API-Upload
- **Claude.ai**: Workspace-wide via API, individuell per Nutzer via UI
- **Claude Desktop**: Gleich wie claude.ai (individuell per Nutzer)

**Custom Instructions / Styles:**

**Styles (Neu in 2025):**
- Anpassung wie Claude antwortet
- Personalisierung für individuelle Bedürfnisse
- Konfigurierbar in Settings

**System Prompts:**
- ⚠️ **Hinweis**: Für Claude.ai/Desktop werden System Prompts NICHT veröffentlicht
- Claude Code: CLAUDE.md oder `--append-system-prompt` für Custom Instructions

**Interaktion Skills & MCP:**
- Skills laufen im Code Execution Container
- MCP-Server sind separate Prozesse
- Skills können keine direkten MCP-Calls machen
- Aber: MCP-Tools können in Workflows mit Skills kombiniert werden



**Box Integration Skills (NEU - Oktober 2025):**
- Read/Write Box Content
- Transform Files zu PPTX/XLSX/DOCX
- Organisation Standards einhalten
- Installation: Via MCP (`box` Server)

**Skills API Update (`/v1/skills`):**
- Programmatische Skill-Verwaltung
- Versionierung möglich
- Nur für Pro, Max, Team, Enterprise mit Code Execution


**Best Practices für Custom Skills:**
- ✅ Klare, spezifische Beschreibungen für Discovery
- ✅ Domain-Expertise in SKILL.md dokumentieren
- ✅ Beispiele und Best Practices inkludieren
- ✅ Skills für wiederkehrende Aufgaben erstellen


### F) CLAUDE CODE 2.0 - NEUE FEATURES (SEPTEMBER 2025)

#### 🎯 ÜBERBLICK

Claude Code 2.0 (Release: 29. September 2025) ist die größte Evolution seit Launch.  
Powered by **Claude Sonnet 4.5** ermöglicht **30+ Stunden autonomes Coding**.

**Die 4 Säulen:**
1. 🖥️ **VS Code Extension** - Native IDE-Integration  
2. 🔄 **Checkpoints** - Safe Autonomy durch State-Management  
3. ⚙️ **Background Tasks** - Parallele Processes  
4. 🎨 **Terminal v2.0** - Performance-Boost, modernere UX

---

#### 1. VS CODE EXTENSION (BETA)

**Native IDE-Integration seit September 2025**

**Key Features:**
- **Sidebar Panel** - Dedicated Claude Code Panel in VS Code
- **Inline Diffs** - Code-Änderungen direkt im Editor
- **Plan Mode** - Review von Plänen vor Execution
- **Auto-Accept** - Optional für vertrauenswürdige Tasks
- **Real-time Feedback** - Live-Anzeige aller Operationen

**Installation:** VS Code Marketplace → "Claude Code" (Anthropic)

**Kompatibilität:** VS Code, Cursor, Windsurf, VSCodium

⚠️ **Security:** Mit auto-edit kann Claude IDE-Configs modifizieren.  
**Empfehlung:** Deny `.vscode/**` in permissions.

**vs. Legacy CLI:**
- **Extension:** GUI, Inline Diffs, Plan Mode
- **CLI:** Terminal, Scriptable, SSH-geeignet
- Beide parallel nutzbar!

---

#### 2. CHECKPOINTS SYSTEM

**Auto-Save von Code-State + Konversation**

**Nutzung:**
```bash
ESC ESC    # Quick Rewind
/rewind    # Explicit mit Auswahl
```

**3 Restore-Modi:**
1. **Chat only** - Rewind Konversation, Code bleibt
2. **Code only** - Rewind Code, Konversation bleibt
3. **Both** - Kompletter Reset

**Features:**
- 30-Tage Retention
- Session-persistent
- Auto-Erstellung bei Prompts

⚠️ Gilt nur für Claude's Edits, nicht User's Änderungen

**Top Use-Case:** "Entgiften" fehlgelaufener Konversationen

---

#### 3. BACKGROUND TASKS

**Parallele Long-Running Processes**

**Beispiel:**
```bash
> "Start dev server in background, then refactor"
# Server läuft → Claude arbeitet parallel
```

**Use Cases:** Dev Servers, Test Watchers, Build Processes

**Config:**
```json
{
  "hooks": {
    "sessionStart": [{
      "command": "npm run dev",
      "background": true
    }]
  }
}
```

---

#### 4. TERMINAL V2.0

**Updates:**
- **Ctrl+R** - Searchable Prompt History
- **~3x Performance** - Schneller, weniger Lag
- **Besseres UI** - Klarere Status-Anzeige

**Tab-Thinking:**
- Tab-Taste für Extended Thinking
- Ersetzt "think hard" (deprecated)
- "ultrathink" bleibt verfügbar (max budget)

---

### G) SECURITY FEATURES (NEU - OKTOBER 2025)

#### /security-review Command

**Auto-Analyse für Vulnerabilities:**
```bash
/security-review              # Ganzes Projekt
/security-review src/auth/   # Verzeichnis
```

**Prüft:** SQL Injection, XSS, Auth-Flaws, Secrets, Dependencies, OWASP Top 10

**Output:** Severity (Critical/High/Medium/Low), Fixes, Inline-Comments

#### GitHub Actions Integration

```yaml
# .github/workflows/claude-security.yml
jobs:
  security:
    steps:
      - uses: anthropic/claude-security-action@v1
        with:
          api-key: ${{ secrets.CLAUDE_API_KEY }}
```

**Features:** Auto-PR-Comments, Severity-Blocking, Fix-Recommendations

---

### H) WEITERE FEATURES & UPDATES (OKTOBER 2025)

**"Imagine with Claude"** (Research Preview)
- Real-time Software Generation, Max Users only

**Claude for Chrome**
- Jetzt für Max Users, Computer Use Capabilities

**Claude Agent SDK** (Rebranding)
- Früher "Claude Code SDK"
- General-purpose Agent Building

**Verfügbare Modelle (Update):**
- Claude Sonnet 4.5 (Default) - 77.2% SWE-bench
- Claude Opus 4.1
- Claude Haiku 4.5

**Consumer Terms Update:**
- Opt-in Model Training (Free/Pro/Max)
- 5-Jahr Retention vs. 30 Tage



### I) URSPRÜNGLICHE WEITERE FEATURES

**Analysis Tool:**
- Code-Ausführung für Berechnungen und Datenanalyse
- Unterstützt Excel-Dateien bis 30MB
- Erweiterte mathematische Operationen via math.js:
  - Symbolische Differentiation
  - Lineare Algebra
  - Trigonometrie
  - High-Precision Math
- Targeted Edits in Artifacts möglich

**Artifacts:**
- Generierung und Verfeinerung von Content
- Unterstützte Typen:
  - Text-Dokumente (Markdown)
  - Interaktive HTML/React
  - SVG-Grafiken
  - Mermaid-Diagramme
  - PDFs
- **Publishing & Remixing**: Artifacts können geteilt und geremixed werden
- Experimental Feature (verfügbar für alle Plans)

**Google Docs Integration:**
- Verfügbar für Pro, Team, Enterprise Accounts
- Direkter Zugriff auf Google Docs
- Kollaboration mit Claude über Docs

**Voice Dictation:**
- Spracheingabe in Mobile Apps
- Desktop-App: ⚠️ Keine explizite Erwähnung in Dokumentation

**Extended Thinking:**
- Aktivierbar für komplexe Aufgaben
- Zeigt Reasoning-Prozess von Claude
- Budget Tokens konfigurierbar
- Nützlich für Debugging und Verständnis

**Computer Use (API-Feature, nicht Desktop-spezifisch):**
- Beta-Feature für Desktop-Automatisierung
- Screenshot Capture & Mouse/Keyboard Control
- Primär über API verfügbar
- Erfordert Beta Header: `computer-use-2025-01-24`

**Logging (macOS):**
- Logs in: `~/Library/Logs/Claude/`
- `mcp.log`: Allgemeine MCP-Verbindungen
- `mcp-server-SERVERNAME.log`: Server-spezifische Errors
- Monitoring via: `tail -n 20 -f ~/Library/Logs/Claude/mcp*.log`

**Plattform-Verfügbarkeit:**
- Desktop: Windows & macOS
- Web: claude.ai
- Mobile: iOS & Android
- Alle Plattformen synchronisiert (gleicher Account)

---

## SCHRITT 3: MCP (MODEL CONTEXT PROTOCOL) - ALLGEMEIN

### A) GRUNDKONZEPT & ARCHITEKTUR

**Was ist MCP?**
Das Model Context Protocol (MCP) ist ein **offenes, standardisiertes Protokoll** für die Kommunikation zwischen KI-Anwendungen (Clients) und Datenquellen (Servern). Es ermöglicht LLMs wie Claude, sicher und kontrolliert auf lokale Ressourcen und externe Services zuzugreifen.

**Kernidee:** Statt für jede Integration eigene Schnittstellen zu bauen, definiert MCP ein universelles Protokoll, das von vielen Clients und Servern genutzt wird.

**Architektur-Komponenten:**

**1. MCP Clients:**
- Anwendungen, die MCP-Server nutzen (z.B. Claude Desktop, Claude Code)
- Verwalten 1:1 Verbindungen zu Servern
- Kontrollieren User-Permissions für Tool-Aufrufe
- Beispiele: Claude Desktop, Custom Apps via Agent SDK

**2. MCP Servers:**
- Leichtgewichtige Programme, die spezifische Fähigkeiten bereitstellen
- Können lokal (STDIO) oder remote (HTTP/SSE) laufen
- Stellen Tools, Resources und Prompts bereit
- Beispiele: Filesystem Server, GitHub Server, Slack Server

**3. Data Sources:**
- **Lokal**: Computer-Dateien, Datenbanken, lokale Services
- **Remote**: Externe APIs, Cloud Services

**Architektur-Schichten:**

**Transport Layer:**
- Verwaltet Kommunikationskanäle und Authentifizierung
- **STDIO Transport**: Für lokale Server (stdin/stdout)
- **HTTP Transport**: HTTP POST + optional Server-Sent Events
- **SSE Transport**: Streamable HTTP für remote Server
- Authentifizierung: Bearer Tokens, API Keys, OAuth 2.0

**Protocol Layer (Data Layer):**
- JSON-RPC 2.0 basiert
- Lifecycle Management: Verbindungsaufbau, Capability Negotiation
- Core Primitives: Tools, Resources, Prompts
- Utility Features: Notifications, Progress Tracking

**Verbindungsablauf:**
1. Client initiiert Verbindung zu Server
2. Capability Negotiation (Server teilt mit was er kann)
3. Client nutzt Tools/Resources/Prompts des Servers
4. Server führt Aktionen aus und gibt Ergebnisse zurück

**Beispiel-Flow (Filesystem Access):**
```
Claude Desktop (Client)
    ↓
MCP Protocol (JSON-RPC 2.0)
    ↓
Filesystem Server (MCP Server)
    ↓
Lokales Dateisystem
```

**Sicherheitskonzept:**
- **User Consent**: Explizite Zustimmung für jede Tool-Aktion
- **Scoped Access**: Server definieren genau was sie zugreifen können
- **Roots**: Clients definieren Filesystem-Grenzen für Server
- **Permissions**: Fine-Grained Control über Tool-Nutzung

### B) MCP-KOMPONENTEN

MCP bietet drei Hauptbausteine für Server-Funktionalität:

**1. MCP RESOURCES**

**Was sind Resources?**
- Strukturierter Zugriff auf Informationen (Context für KI)
- Datei-ähnliche Daten, die Clients lesen können
- Beispiele: API-Responses, Dateiinhalte, Datenbank-Schemas

**Eigenschaften:**
- Jede Resource hat **eindeutige URI** (z.B. `file:///path/to/doc.md`)
- Deklarierter **MIME-Type** für Content-Handling
- Können **Text, JSON, strukturierte Daten** oder Binärdaten sein
- **Application-driven**: Host-App entscheidet wie Context verwendet wird

**URI-Schemes:**
- `file://` - Filesystem-ähnliche Ressourcen (nicht zwingend physisches FS)
- `http://` / `https://` - Web-Ressourcen (wenn Client direkt laden kann)
- Custom Schemes möglich

**Discovery:**
- Via `@` im Prompt (Claude Desktop/Code)
- Resources erscheinen neben Dateien im Autocomplete
- Optional: **Resource Templates** mit Parametern
- **Subscriptions**: Client kann Updates zu Resources abonnieren

**Resource Capabilities:**
```json
{
  "capabilities": {
    "resources": {
      "subscribe": true,
      "listChanged": true
    }
  }
}
```

---

**2. MCP TOOLS**

**Was sind Tools?**
- Funktionen, die vom LLM aufgerufen werden können
- **Model-controlled**: KI entscheidet wann Tool verwendet wird
- Ermöglichen KI-Aktionen auszuführen

**Eigenschaften:**
- **JSON Schema**: Typisierte Inputs und Outputs
- **Single Operation**: Jedes Tool macht eine klar definierte Operation
- **User Consent**: Kann vor Ausführung User-Zustimmung erfordern
- **Discovery**: LLM entdeckt und nutzt Tools automatisch

**Beispiel-Tools:**
- `get_weather(location)` - Wetterdaten abrufen
- `search_files(query)` - Dateien suchen
- `create_ticket(title, description)` - Ticket erstellen
- `send_email(to, subject, body)` - E-Mail senden

**Trust & Safety:**
- UI-Anzeige verfügbarer Tools
- User kann Tools pro Interaktion aktivieren/deaktivieren
- Granulare Permissions möglich
- Confirmation Dialogs für kritische Aktionen

---

**3. MCP PROMPTS**

**Was sind Prompts?**
- Wiederverwendbare Templates für Interaktionen
- **User-controlled**: Erfordern explizite Aufrufung
- Showcase wie MCP-Server am besten genutzt werden

**Eigenschaften:**
- **Strukturierte Templates** mit erwarteten Inputs
- **Context-aware**: Können auf Resources & Tools referenzieren
- **Parameterized**: Können Argumente akzeptieren
- Als **Slash Commands** verfügbar (z.B. `/mcp__servername__promptname`)

**Beispiel-Anwendung:**
```
Prompt: "Plan a Vacation"
1. Nutzt Resources: Calendar (Verfügbarkeit), Travel History
2. Nutzt Tools: search_flights(), book_hotel(), update_calendar()
3. Ergebnis: Comprehensive Workflow über mehrere Server
```

---

**UNTERSCHIEDE IM ÜBERBLICK:**

| Feature | Resources | Tools | Prompts |
|---------|-----------|-------|---------|
| **Kontrolle** | Application | Model | User |
| **Zweck** | Context bereitstellen | Aktionen ausführen | Workflows templaten |
| **Discovery** | `@` Symbol | Automatisch | `/` Slash Commands |
| **User Consent** | Optional | Empfohlen | Implizit (User ruft auf) |
| **Beispiel** | `file://docs/guide.md` | `create_file()` | `/plan-vacation` |

---

**WEITERE MCP-KONZEPTE:**

**Sampling:**
- Server können Client bitten, vom LLM zu samplen
- Ermöglicht Server-initiierte LLM-Interaktionen
- Client kontrolliert Rate Limits und Modell-Auswahl

**Notifications:**
- Real-time Updates von Servern zu Clients
- Beispiele: Resource-Änderungen, Status-Updates
- Push-basiert statt Polling

**Progress Tracking:**
- Für lang laufende Operationen
- Server können Progress-Updates senden
- UI kann Fortschritt anzeigen

**Callbacks:**
- ⚠️ Nicht explizit in Core-Spec erwähnt, aber via Sampling möglich

### C) VERFÜGBARE MCP-SERVER

**Official Reference Servers (Anthropic):**

| Server | Beschreibung | Package |
|--------|--------------|---------|
| **Filesystem** | Sicherer Dateizugriff mit konfigurierbaren Zugriffskontrolllen | `@modelcontextprotocol/server-filesystem` |
| **Memory** | Knowledge Graph-basiertes persistentes Memory System | `@modelcontextprotocol/server-memory` |
| **GitHub** | Git Repository Tools (read, search, manipulate) | `@modelcontextprotocol/server-github` |
| **Fetch** | Web Content Fetching und Conversion für LLM-Nutzung | `@modelcontextprotocol/server-fetch` |
| **Sequential Thinking** | Dynamisches Problem-Solving durch Thought Sequences | `@modelcontextprotocol/server-sequential-thinking` |
| **Everything** | Reference/Test Server mit Prompts, Resources, Tools | (Referenz-Implementation) |
| **Git** | Tools für Git-Repositories | `@modelcontextprotocol/server-git` |

**Company/Official Integrations (Cloud-based):**

**Produktivität & Collaboration:**
- **Notion** - Read docs, update pages, manage tasks
- **Linear** - Issue tracking und project management
- **Slack** - Team communication (via MCP)
- **Google Drive** - (Erwähnt, aber kein spezifischer MCP-Server gefunden)
- **Figma** - Design access (erwähnt)
- **Monday** - Board management, CRM activities
- **Box** - Enterprise content, unstructured data insights

**Development & DevOps:**
- **GitHub** - Code management (auch official reference server)
- **Vercel** - Documentation, project/deployment management, logs
- **Netlify** - Website creation, deployment, secrets, access control
- **Cloudflare** - Application building, traffic analysis, security

**Data & Analytics:**
- **Airtable** - Read/write records, manage bases and tables

**Communication & Meeting:**
- **Fireflies** - Meeting transcripts und summaries insights

**Media & Design:**
- **Canva** - Browse, summarize, autofill, generate Canva designs
- **Invideo** - Video creation capabilities
- **Cloudinary** - Upload, manage, transform, analyze media assets

**Automation & Integration:**
- **Zapier** - Connect to ~8,000 apps via automation platform
- **Workato** - Access any application, workflows, data via Workato

**Other:**
- **Stytch** - Configure and manage authentication services

**Installation (Beispiele):**

**Via Claude Code CLI:**
```bash
# HTTP Transport (Cloud Services)
claude mcp add --transport http notion https://mcp.notion.com/mcp
claude mcp add --transport http linear https://mcp.linear.app/mcp
claude mcp add --transport http vercel https://mcp.vercel.com/

# SSE Transport
claude mcp add --transport sse monday https://mcp.monday.com/sse

# STDIO (Local)
claude mcp add-json filesystem '{"type":"stdio","command":"npx","args":["-y","@modelcontextprotocol/server-filesystem","/path"]}'
```

**Via NPX (Claude Desktop Config):**
```bash
npx -y @modelcontextprotocol/server-memory
npx -y @modelcontextprotocol/server-filesystem /path/to/files
```

**Community Servers:**
- **GitHub Repository**: Hunderte Community-Server verfügbar
- **MCP Servers Repository**: Offizielle Sammlung
  - Resources Section: Projekte und Ressourcen
  - Community Section: Community-maintained Servers
  - Archived Section: Nicht mehr aktiv gewartete Server

**Registry & Discovery:**
- GitHub: https://github.com/modelcontextprotocol/servers
- MCP Official Site: https://modelcontextprotocol.io/examples
- Community Contributions: Aktive Entwicklung neuer Server

**Server-Entwicklung:**
- **MCP SDKs**: TypeScript, Python (weitere geplant)
- **MCP Inspector**: Development Tool für Server-Testing
- **Templates**: Reference Implementations verfügbar
- **Dokumentation**: https://modelcontextprotocol.io/docs/develop/build-server

**⚠️ Archived Servers (nicht mehr maintained):**
- EverArt - AI image generation
- AWS KB Retrieval - Retrieval from AWS Knowledge Base

### E) MCP-KONFIGURATION

**Konfigurationsdateien-Formate:**

**1. Claude Desktop (`claude_desktop_config.json`):**
```json
{
  "mcpServers": {
    "server-name": {
      "command": "command-to-run",
      "args": ["arg1", "arg2"],
      "env": {
        "ENV_VAR": "value"
      }
    }
  }
}
```

**Pfade:**
- macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
- Windows: `%APPDATA%\Claude\claude_desktop_config.json`
- Linux: `~/.config/Claude/claude_desktop_config.json`

**2. Claude Code (`.mcp.json`):**

Claude Code verwendet hierarchische Konfiguration:

**Scopes (Priorität niedrig → hoch):**
1. **User Scope**: `~/.claude/.mcp.json` (global)
2. **Project Scope**: `.claude/.mcp.json` (projekt-weit)
3. **Local Scope**: `.claude/.mcp.local.json` (nicht in Git)

**Format:**
```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "https://api.example.com/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    },
    "local-tool": {
      "type": "stdio",
      "command": "/path/to/tool",
      "args": ["--option"],
      "env": {
        "VAR": "value"
      }
    }
  }
}
```

**Environment Variable Expansion:**
```json
{
  "mcpServers": {
    "dynamic": {
      "type": "http",
      "url": "${API_BASE_URL:-https://default.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

Syntax:
- `${VAR}` - Expandiert zu Wert von VAR
- `${VAR:-default}` - VAR wenn gesetzt, sonst default
- Fehlende Variable ohne Default → Config-Parse-Error

**3. Enterprise Managed MCP (Enterprise deployments):**
```
macOS: /Library/Application Support/ClaudeCode/managed-mcp.json
Linux/WSL: /etc/claude-code/managed-mcp.json
Windows: C:\ProgramData\ClaudeCode\managed-mcp.json
```

- Höchste Priorität
- Überschreibt User-/Project-Konfigurationen
- Für Unternehmensrichtlinien

**MCP-Server Registrierung:**

**Via Claude Code CLI:**
```bash
# HTTP Server
claude mcp add --transport http name https://url

# STDIO Server
claude mcp add-json name '{"type":"stdio","command":"cmd","args":[]}'

# Mit Scope
claude mcp add --scope user --transport http name https://url

# Import aus Claude Desktop
claude mcp import-from-desktop
# → Interaktiver Dialog zur Auswahl
```

**OAuth 2.0 für Cloud-Server:**
Claude Code unterstützt OAuth 2.0 für sichere Verbindungen zu Cloud-basierten MCP-Servern.

**Server-Konflikt-Auflösung:**
Bei Servern mit gleichem Namen in mehreren Scopes:
1. **Local** (höchste Priorität)
2. **Project**
3. **User** (niedrigste Priorität)

**Resources Discovery:**
- Resources via `@` Symbol im Prompt
- Autocomplete zeigt alle verfügbaren Resources
- Kombiniert mit File-Autocomplete

**Prompts als Slash Commands:**
- Format: `/mcp__servername__promptname`
- Argumente: Space-separated nach Command
- Beispiel: `/mcp__weather__forecast Berlin Germany`

**Environment Variables für MCP:**

**Claude Code:**
- `CLAUDE_CODE_REMOTE` - "true" in Web-Umgebungen
- Custom Env-Vars in `.mcp.json` definierbar

**Best Practices:**
- ✅ Environment Variables für Secrets (nicht hardcoded)
- ✅ `.mcp.local.json` für lokale API-Keys (nicht in Git)
- ✅ Team-Config in `.mcp.json` (shared, in Git)
- ✅ Absolute Pfade für STDIO commands
- ✅ OAuth für Cloud-Services statt API-Keys

**Debugging:**
```bash
# Claude Desktop Logs (macOS)
tail -f ~/Library/Logs/Claude/mcp*.log

# Claude Code MCP Status
claude mcp list
claude mcp import-from-desktop  # Zeigt verfügbare Server
```

---

## SCHRITT 4: MCP FILESYSTEM SERVER (SPEZIELL)

### B) FUNKTIONEN

**Verfügbare Tools (9 Tools gesamt):**

**1. read_file**
- **Beschreibung**: Liest den Inhalt einer Datei
- **Parameter**: `path` (required) - Dateipfad
- **Returns**: Dateiinhalt als String

**2. read_multiple_files**
- **Beschreibung**: Liest mehrere Dateien auf einmal (Batch-Operation)
- **Parameter**: `paths` (required) - Array von Dateipfaden
- **Returns**: Array von Dateiinhalten
- **Performance**: Effizienter als mehrere einzelne Aufrufe

**3. write_file**
- **Beschreibung**: Schreibt Inhalt in eine Datei
- **Parameter**: 
  - `path` (required) - Dateipfad
  - `content` (required) - Zu schreibender Inhalt
- **Verhalten**: Erstellt Datei wenn nicht vorhanden, überschreibt sonst

**4. edit_file** (für große Dateien optimiert)
- **Beschreibung**: Editiert Datei mit Diff-basiertem Approach
- **Ideal für**: Große Dateien, Token-Effizienz
- **Parameter**: 
  - `path` (required)
  - `edits` - Strukturierte Edit-Operationen
  - `dryRun` (optional) - Preview ohne Änderung

**5. create_directory**
- **Beschreibung**: Erstellt neues Verzeichnis
- **Parameter**: `path` (required) - Verzeichnispfad
- **Verhalten**: Erstellt auch Parent-Directories wenn nötig

**6. list_directory**
- **Beschreibung**: Listet Verzeichnisinhalte
- **Parameter**: `path` (required) - Verzeichnispfad
- **Returns**: Array von Dateien/Verzeichnissen mit Metadata (Name, Type, Size, Modified Date)

**7. list_allowed_directories**
- **Beschreibung**: Zeigt alle erlaubten Verzeichnisse
- **Parameter**: None
- **Returns**: Array aller konfigurierten Allowed Directories
- **Nützlich für**: Debugging, Konfigurationsprüfung

**8. directory_tree**
- **Beschreibung**: Zeigt Verzeichnisstruktur als Baum
- **Parameter**: 
  - `path` (required) - Root-Verzeichnis
  - `max_depth` (optional) - Maximale Tiefe
- **Performance**: Depth-Limit nutzen für große Verzeichnisse

**9. search_files / move_file / get_file_info**
- **search_files**: Sucht Dateien nach Pattern
  - `path` (required) - Suchpfad
  - `pattern` (optional) - Regex/Glob Pattern
- **move_file**: Verschiebt/Umbenennt Datei
- **get_file_info**: Liefert Metadata (Size, Permissions, Timestamps)

**Erweiterte Features (je nach Implementation):**

**Streaming Capabilities:**
- Für große Dateien: Progressive Lesevorgänge
- Verhindert Token-Overflow bei großen Files

**File Watching:**
- Manche Implementationen bieten Change-Tracking
- Real-time Benachrichtigungen bei Dateiänderungen

**Duplicate Detection:**
- `find_duplicate_files` - Findet identische Dateien
- Hash-basierte Vergleiche

### D) KONFIGURATIONSBEISPIELE

**1. Claude Desktop Configuration (macOS):**

**Datei**: `~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/username/Desktop",
        "/Users/username/Documents",
        "/Users/username/Projects"
      ]
    }
  }
}
```

**2. Claude Code Configuration:**

**Via CLI:**
```bash
claude mcp add-json filesystem '{
  "type":"stdio",
  "command":"npx",
  "args":[
    "-y",
    "@modelcontextprotocol/server-filesystem",
    "/path/to/allowed/dir"
  ]
}'
```

**Via `.mcp.json`:**
```json
{
  "mcpServers": {
    "filesystem": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "${HOME}/Documents",
        "${HOME}/Projects"
      ]
    }
  }
}
```

**3. Mit Environment Variables:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "${ALLOWED_DIR_1:-/tmp}",
        "${ALLOWED_DIR_2}"
      ],
      "env": {
        "LOG_LEVEL": "DEBUG"
      }
    }
  }
}
```

**4. Docker-basiert:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "--volume=/host/path:/container/path",
        "ghcr.io/mark3labs/mcp-filesystem-server:latest",
        "/container/path"
      ]
    }
  }
}
```

**5. Dynamische Roots (Empfohlen):**

Statt statische Verzeichnisse zu definieren:
- **Roots Protocol**: MCP Clients können Allowed Directories dynamisch aktualisieren
- **Vorteil**: Keine Server-Restarts nötig bei Verzeichnisänderungen
- **Support**: Clients müssen `roots/list_changed` Notifications unterstützen

**Workflow:**
1. Server startet OHNE Command-Line Args (oder mit minimal set)
2. Client sendet `roots` via MCP Protocol
3. Server akzeptiert dynamisch die erlaubten Verzeichnisse
4. Bei Änderungen: Client sendet `roots/list_changed` Notification

**Wichtig**: 
- ⚠️ Server MUSS entweder Command-Line Args ODER Roots-Support haben
- Ohne beides: Initialization Error

**Best Practices:**
- ✅ **Absolute Pfade** nutzen (keine relativen Pfade)
- ✅ **Minimale Berechtigungen**: Nur benötigte Verzeichnisse freigeben
- ✅ **Keine sensitiven Daten**: Nicht `/` oder Home-Root freigeben
- ✅ **Logging**: `LOG_LEVEL=DEBUG` für Troubleshooting
- ✅ **Batch-Operationen**: `read_multiple_files` statt mehrerer Einzelaufrufe

### E) LIMITIERUNGEN

**Zugriffsbeschränkungen:**

**1. Allowed Directories Only:**
- Server kann NUR auf explizit freigegebene Verzeichnisse zugreifen
- Pfade außerhalb → "Directory not allowed" Error
- Keine Symlink-Traversierung außerhalb Allowed Dirs

**2. Path Validation:**
- **Strict Path Checking**: Verhindert Directory Traversal Attacks
- Path Canonicalization vor Zugriff
- Keine `../` Tricks möglich

**3. Permissions:**
- Server läuft mit **User-Permissions** des startenden Users
- Keine Privilege Escalation möglich
- File-Permissions des OS werden respektiert

**Funktionale Einschränkungen:**

**1. Kein Netzwerkzugriff:**
- Filesystem Server kann keine Remote-APIs aufrufen
- Keine HTTP-Requests von Server selbst
- Nur lokales Filesystem

**2. Synchrone Operationen:**
- Manche Implementationen: Blocking I/O
- Performance-Impact bei sehr großen Dateien oder Verzeichnissen
- Lösungen: 
  - Streaming für große Files
  - Depth-Limits für `directory_tree`
  - Pattern für `search_files` spezifizieren

**3. Binary Files:**
- Primär für Text-Dateien optimiert
- Binary Files: Base64-Encoding oder separate Handling
- Große Binär-Dateien können Token-Limits sprengen

**Performance-Limitierungen:**

**1. Große Verzeichnisse:**
- `list_directory` auf Verzeichnisse mit 1000+ Dateien → langsam
- `search_files` rekursiv auf große Trees → Time-Consuming
- **Lösung**: Patterns nutzen, max_depth setzen

**2. Token Limits:**
- Sehr große Dateien können Context-Window sprengen
- **Lösung**: `edit_file` statt `read_file` für große Files

**3. Concurrent Access:**
- Bei parallelen Writes: Race Conditions möglich
- Keine Built-in Locking Mechanismen
- User muss Synchronisation selbst managen

**Bekannte Issues:**

**1. Relative vs. Absolute Paths:**
- **Problem**: Relative Pfade werden relativ zu Server Working Directory interpretiert
- **Lösung**: IMMER absolute Pfade nutzen

**2. Permission Denied:**
- **Ursache**: Docker hat keinen Zugriff auf Host-Verzeichnisse
- **Lösung**: Korrekte Volume-Mounts (`--volume`)

**3. Server nicht erkannt:**
- **Ursache**: Config-Datei nicht korrekt, Server nicht neu gestartet
- **Lösung**: 
  - Claude Desktop neu starten
  - Logs prüfen: `~/Library/Logs/Claude/mcp-server-filesystem.log`
  - `list_allowed_directories` Tool aufrufen zum Testen

**4. Environment Variable Expansion:**
- **Ursache**: Variable nicht gesetzt, kein Default-Wert
- **Lösung**: `${VAR:-default}` Syntax nutzen

**Sicherheitsüberlegungen:**

**1. Keine Sandbox-Escape:**
- Server ist NICHT sandboxed
- Kann beliebige Bash-Commands ausführen (wenn kombiniert mit Tools)
- ⚠️ Vorsicht bei User-Generated Paths

**2. Sensitive Data:**
- Filesystem Server sollte NICHT auf folgende zugreifen:
  - `/etc/` (System-Configs)
  - `~/.ssh/` (SSH Keys)
  - `~/.aws/` (AWS Credentials)
  - `.env` Files mit Secrets

**3. Audit Logging:**
- Keine Built-in Audit-Logs für File-Operations
- Für Enterprise: Custom Logging-Wrapper empfohlen

**Was der Filesystem Server NICHT kann:**

❌ Netzwerk-Requests (HTTP, FTP, etc.)
❌ Datenbank-Zugriff (nutze separate DB-Server)
❌ File-Compression (ZIP, TAR)
❌ File-Encryption
❌ Binary-File-Manipulation (Bilder editieren, etc.)
❌ Git-Operations (nutze GitHub/Git MCP Server)
❌ Remote Filesystem Mounts (SMB, NFS)
❌ Cloud Storage (S3, GCS - nutze separate Server)

---

## SCHRITT 5: INTERAKTIONEN & WORKFLOWS

### A) CLAUDE DESKTOP + MCP FILESYSTEM

**Was wird dadurch möglich?**

Mit dem MCP Filesystem Server erhält Claude Desktop direkten, kontrollierten Zugriff auf lokale Dateien. Dies kombiniert die Chat-Oberfläche von Claude Desktop mit leistungsstarken Dateisystem-Operationen.

**Core-Capabilities:**
- 📁 **Lokaler Dateizugriff**: Lesen, Schreiben, Durchsuchen von Dateien
- 📋 **Context aus Dateien**: Automatisches Laden relevanter Dateien in Konversationen
- ✏️ **Code-Editing**: Direktes Modifizieren von Code-Dateien
- 📊 **Datenanalyse**: Excel-Dateien mit Analysis Tool + Filesystem kombinieren
- 🔍 **Code-Review**: Entire Codebase durchsuchen und analysieren
- 📝 **Dokumentation**: Docs schreiben und direkt speichern

**5 Anwendungsbeispiele:**

**1. Codebase-Analyse und Refactoring**
```
User: "Analysiere alle Python-Dateien in ~/Projects/myapp und liste mir alle 
       TODO-Kommentare auf. Erstelle dann eine Markdown-Datei mit der Übersicht."

Claude:
1. Nutzt list_directory auf ~/Projects/myapp
2. Liest alle .py Dateien mit read_multiple_files
3. Analysiert TODOs
4. Erstellt todos.md mit write_file
```

**2. Automatische Dokumentations-Erstellung**
```
User: "Erstelle eine README.md für mein Projekt basierend auf den Dateien 
       in ~/Projects/webapp"

Claude:
1. Durchsucht directory_tree für Projektstruktur
2. Liest package.json / requirements.txt
3. Analysiert main files
4. Schreibt README.md mit write_file direkt ins Projekt
```

**3. Log-Datei-Analyse**
```
User: "Analysiere die letzten Fehler in ~/logs/app.log und fasse die 
       häufigsten Fehlertypen zusammen"

Claude:
1. Liest app.log mit read_file
2. Analysiert Error-Patterns
3. Erstellt Summary
4. Optional: Schreibt error-summary.md
```

**4. Batch-Datei-Operationen**
```
User: "Finde alle .txt Dateien in ~/Documents die 'wichtig' enthalten 
       und verschiebe sie nach ~/Documents/Important"

Claude:
1. search_files mit Pattern "*.txt" 
2. read_multiple_files für Content-Check
3. create_directory für ~/Documents/Important
4. move_file für jede relevante Datei
```

**5. Projekt-Template-Setup**
```
User: "Erstelle mir ein neues React-Projekt in ~/Projects/new-app 
       mit Standard-Struktur"

Claude:
1. create_directory für ~/Projects/new-app
2. create_directory für src, public, components
3. write_file für package.json, index.html, App.jsx
4. Erstellt .gitignore, README.md
5. Gibt Instructions für npm install
```

**Workflow-Patterns:**

**Pattern 1: Read → Analyze → Write**
```
1. read_file / read_multiple_files
2. Claude analysiert Content
3. write_file für Ergebnisse/Reports
```

**Pattern 2: Search → Filter → Process**
```
1. search_files mit Pattern
2. read_multiple_files für Details
3. Batch-Processing (move, edit, etc.)
```

**Pattern 3: Directory Exploration → Selective Operation**
```
1. list_directory oder directory_tree für Overview
2. User wählt relevante Files
3. Gezielte Operations auf ausgewählten Files
```

**Kombination mit anderen Claude Desktop Features:**

**+ Projects:**
- Projekt-Wissensbank mit MCP Filesystem kombinieren
- Claude hat Kontext aus Project + Zugriff auf aktuelle Files

**+ Analysis Tool:**
- Excel-Dateien via Filesystem laden
- Analysis Tool für Datenverarbeitung
- Ergebnisse zurück speichern

**+ Artifacts:**
- Code in Artifacts erstellen
- Via MCP Filesystem direkt in echte Dateien schreiben
- React-Components von Artifacts → echte Files

**+ Extended Thinking:**
- Komplexe Codebase-Analysen mit Extended Thinking
- Durchdachte Refactorings über mehrere Dateien

**Best Practices:**

✅ **Explizite Pfade**: Immer klare, absolute Pfade nennen
✅ **Batch wo möglich**: `read_multiple_files` statt Einzelaufrufe
✅ **Confirmation**: Wichtige Änderungen vor Write bestätigen
✅ **Backups**: Vor großen Änderungen: Backup empfehlen
✅ **Scoped Access**: Nur benötigte Verzeichnisse freigeben

### C) KOMBINIERTE NUTZUNG

**Kann man Claude Desktop und Claude Code zusammen nutzen?**

**Ja, absolut!** Claude Desktop und Claude Code sind komplementäre Tools mit unterschiedlichen Stärken. Sie können im selben Workflow genutzt werden.

**Unterschiede im Überblick:**

| Feature | Claude Desktop | Claude Code |
|---------|----------------|-------------|
| **Interface** | GUI (Chat) | CLI (Terminal) |
| **Dateizugriff** | Via MCP Filesystem | Direkter Dateizugriff |
| **Autonomie** | Interaktiv, pro Tool Approval | Autonom, batch-fähig |
| **Ideal für** | Exploration, Planung, Review | Execution, Automation, CI/CD |
| **Context** | Projects (Cloud) | CLAUDE.md (Local) |
| **Skills** | Pre-built + Custom (UI Upload) | Custom (Filesystem) |
| **Git** | Indirekt (via MCP) | Direkt integriert |
| **Best Use** | Fragen, Analyse, Design | Coding, Testing, Deployment |

**Komplementäre Szenarien:**

**Szenario 1: Design → Implementation**
```
1. Claude Desktop: Architektur planen, Design diskutieren
   - Projects mit Requirements, Specs laden
   - Entscheidungen treffen
   - Plan als Artifact generieren

2. Claude Code: Implementation ausführen
   - cd project-dir
   - claude "Implement the authentication system as per plan.md"
   - Autonom: Code schreiben, testen, committen
```

**Szenario 2: Code Review → Fixes**
```
1. Claude Desktop: Code Review
   - Via MCP Filesystem: Dateien lesen
   - Probleme identifizieren
   - Review-Report erstellen

2. Claude Code: Fixes implementieren
   - claude "Fix the issues mentioned in review-report.md"
   - Tests schreiben
   - Auto-commit mit aussagekräftiger Message
```

**Szenario 3: Datenanalyse → Automation**
```
1. Claude Desktop: Explorative Datenanalyse
   - Excel-Dateien mit Analysis Tool untersuchen
   - Insights gewinnen
   - Visualisierungen erstellen

2. Claude Code: Automatisierung
   - Skript schreiben basierend auf Analyse
   - CI/CD Pipeline für regelmäßige Reports
   - claude -p "Generate daily report from data.csv"
```

**Claude Desktop als Workflow-Guide für non-IT Users:**

**Kann Claude Desktop Nutzer zur Verwendung von Claude Code anleiten?**
**Ja!** Das ist ein sehr praktisches Szenario für Teams mit IT-Setup durch Fachmann, aber Nutzung durch weniger IT-versierte User.

**Setup-Voraussetzung:**
- IT-Fachmann richtet ein:
  - Claude Code installiert
  - `.claude/` Ordner mit Commands, Agents, Skills
  - Vorkonfigurierte Workflows
  - `CLAUDE.md` mit Projekt-Context
  
**Workflow-Anleitung via Claude Desktop:**

```
User (in Claude Desktop): 
"Ich muss den Daten-Report für Q4 erstellen. Was muss ich tun?"

Claude Desktop (mit Projects-Context über Team-Workflows):
"Kein Problem! Hier sind die Schritte:

1. Öffne dein Terminal (Anleitung für dein macOS)
2. Navigiere zum Projekt-Ordner:
   cd ~/Projects/quarterly-reports
   
3. Führe diesen Befehl aus:
   claude /generate-q4-report
   
4. Claude Code wird jetzt:
   - Die Excel-Dateien aus ~/data/q4 lesen
   - Die Analyse durchführen
   - Den Report als PowerPoint erstellen
   - Eine Preview öffnen
   
5. Wenn alles gut aussieht, bestätige mit 'ja'
   Der Report wird dann nach ~/reports/q4-2024.pptx gespeichert

Soll ich dir jeden Schritt genauer erklären?"

User: "Ja, wie öffne ich das Terminal?"

Claude Desktop:
"Auf deinem Mac:
1. Drücke Cmd + Space
2. Tippe 'Terminal'
3. Drücke Enter
..."
```

**Vorkonfigurierte Commands für einfache Nutzung:**

IT-Fachmann erstellt in `.claude/commands/`:

**`/generate-q4-report.md`:**
```markdown
---
name: generate-q4-report
description: Erstellt Q4 Quartals-Report
---

Ich werde jetzt den Q4-Report erstellen:

1. Lese alle Excel-Dateien aus ~/data/q4/
2. Aggregiere die Zahlen
3. Erstelle PowerPoint-Präsentation nach Corporate-Template
4. Speichere nach ~/reports/q4-2024.pptx

Starte automatisch und frage nur bei Problemen nach.
```

**`/deploy-website.md`:**
```markdown
---
name: deploy-website
description: Deployed die Website auf den Server
---

Deployment-Prozess:
1. Tests laufen lassen
2. Build erstellen
3. Auf Staging deployen
4. Bei Erfolg: Auf Production deployen

Automatischer Ablauf mit Confirmation vor Production.
```

**Vorteile dieses Setups:**

✅ **Non-IT Users**: Können komplexe Tasks via simple Commands ausführen
✅ **Konsistenz**: Workflows sind standardisiert und getestet
✅ **Sicherheit**: IT-Team kontrolliert was möglich ist (Permissions)
✅ **Support**: Claude Desktop als "Handbuch" für Anleitung
✅ **Self-Service**: User sind unabhängig für Routine-Tasks

**Beispiel-Interaktion mit Guidance:**

```
User: "Der Command hat einen Fehler geworfen"

Claude Desktop:
"Okay, lass uns das Problem finden:

1. Kopiere bitte die Fehlermeldung hier rein
2. Lauf diesen Befehl um Logs zu sehen:
   cat ~/.claude/logs/last-session.log
   
Poste dann die letzten 10 Zeilen hier, dann helfe ich dir."

[User postet Logs]

Claude Desktop:
"Ah, ich sehe das Problem! Die Datei ~/data/q4/sales.xlsx fehlt.
Lösung:
1. Prüfe ob die Datei existiert:
   ls ~/data/q4/
   
2. Falls nicht da: Kopiere sie vom Netzlaufwerk:
   cp /Volumes/CompanyData/Q4/sales.xlsx ~/data/q4/
   
3. Dann versuch den Command nochmal:
   claude /generate-q4-report"
```

**Best Practices für IT-Setup:**

**1. Slash Commands für alles Wichtige:**
```
/generate-report
/deploy-app
/backup-database
/create-invoice
/send-newsletter
```

**2. Subagenten für Spezialaufgaben:**
```
.claude/agents/
  ├── report-generator.md
  ├── deployment-assistant.md
  └── backup-specialist.md
```

**3. Skills für Domain-Wissen:**
```
.claude/skills/
  ├── company-workflows/
  ├── data-formats/
  └── deployment-procedures/
```

**4. CLAUDE.md als Runbook:**
```markdown
# Team Project

## Häufige Aufgaben
- Q4 Report: `/generate-q4-report`
- Website deployen: `/deploy-website`
- Backup: `/backup-database`

## Wichtige Hinweise
- Nie in /production/ direkt ändern
- Immer Tests vor Deployment laufen lassen
- Bei Fragen: Claude Desktop nutzen
```

**Workflow-Dokumentation für Teams:**

IT erstellt ein "Onboarding"-Dokument in Claude Desktop Projects:
- Welche Commands gibt es?
- Wann welchen Command nutzen?
- Was tun bei Fehlern?
- Eskalation zu IT bei kritischen Issues

**Resultat:**
→ Non-IT User können autonome Coding-Tasks ausführen
→ Mit Claude Desktop als interaktivem Handbuch
→ IT-Team hat Kontrolle durch vorkonfigurierte Workflows
→ Produktivität steigt, IT-Tickets sinken

---

## SCHRITT 6: PRAKTISCHE ASPEKTE

### B) KONFIGURATIONSDATEIEN - ÜBERSICHT

**Alle Config-Dateien mit Pfaden (macOS):**

**CLAUDE DESKTOP:**

1. **MCP-Server Konfiguration**
   ```
   ~/Library/Application Support/Claude/claude_desktop_config.json
   ```
   - Format: JSON mit `mcpServers` Object
   - Definiert: MCP-Server (command, args, env)
   - Restart erforderlich: Ja (nach Änderungen)

2. **Logs**
   ```
   ~/Library/Logs/Claude/
   ├── mcp.log                          # Allgemeine MCP-Logs
   └── mcp-server-SERVERNAME.log        # Server-spezifische Logs
   ```
   - Monitoring: `tail -f ~/Library/Logs/Claude/mcp*.log`

**CLAUDE CODE:**

1. **User-Level Settings (Global)**
   ```
   ~/.claude/settings.json              # User-weite Einstellungen
   ~/.claude/.mcp.json                  # User-weite MCP-Server
   ~/.claude/CLAUDE.md                  # Globaler Context (optional)
   ```

2. **User-Level Components**
   ```
   ~/.claude/
   ├── settings.json                    # Globale Settings
   ├── .mcp.json                        # Globale MCP-Server
   ├── CLAUDE.md                        # Globaler Context
   ├── agents/                          # Globale Subagenten
   │   ├── code-reviewer.md
   │   └── debugger.md
   ├── commands/                        # Globale Slash Commands
   │   ├── security-review.md
   │   └── fix-issue.md
   └── skills/                          # Globale Skills
       └── my-skill/
           └── SKILL.md
   ```

3. **Project-Level Settings**
   ```
   project-dir/.claude/
   ├── settings.json                    # Team-Settings (in Git)
   ├── settings.local.json              # Lokale Settings (nicht in Git)
   ├── .mcp.json                        # Projekt MCP-Server (in Git)
   ├── .mcp.local.json                  # Lokale MCP-Server (nicht in Git)
   ├── CLAUDE.md                        # Projekt-Context
   ├── agents/                          # Projekt-Subagenten
   ├── commands/                        # Projekt-Commands
   └── skills/                          # Projekt-Skills
   ```

4. **Projekt-Root Alternative**
   ```
   project-dir/CLAUDE.md                # Alternative zu .claude/CLAUDE.md
   ```

**ENTERPRISE MANAGED (Optional):**

1. **Enterprise Policy Settings**
   ```
   macOS:  /Library/Application Support/ClaudeCode/managed-settings.json
   Linux:  /etc/claude-code/managed-settings.json
   Windows: C:\ProgramData\ClaudeCode\managed-settings.json
   ```

2. **Enterprise MCP Configuration**
   ```
   macOS:  /Library/Application Support/ClaudeCode/managed-mcp.json
   Linux:  /etc/claude-code/managed-mcp.json
   Windows: C:\ProgramData\ClaudeCode\managed-mcp.json
   ```

**KONFIGURATIONSFORMAT - ÜBERSICHT:**

**1. settings.json (Claude Code):**
```json
{
  "permissions": {
    "allow": ["Bash(npm test)", "Read(~/.zshrc)"],
    "deny": ["Read(./.env)", "Write(./secrets/**)"]
  },
  "env": {
    "NODE_ENV": "development",
    "API_KEY": "${API_KEY}"
  },
  "enabledPlugins": {
    "plugin-name@marketplace": true
  },
  "hooks": {
    "afterWrite": {
      "**/*.py": "black $FILE"
    }
  }
}
```

**2. .mcp.json (Claude Code MCP-Server):**
```json
{
  "mcpServers": {
    "server-name": {
      "type": "http|stdio|sse",
      "url": "https://api.example.com/mcp",
      "command": "/path/to/command",
      "args": ["arg1", "arg2"],
      "env": {
        "API_KEY": "${API_KEY:-default}"
      }
    }
  }
}
```

**3. claude_desktop_config.json:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path"],
      "env": {}
    }
  }
}
```

**4. CLAUDE.md (Projekt-Context):**
```markdown
# Project Name

## Context
This project is about...

## Important Conventions
- Use TypeScript strict mode
- All API endpoints start with /api/v1

## Common Tasks
- Run tests: `npm test`
- Deploy: Use `/deploy` command

@AGENTS.md for team information
```

**5. Command File (.claude/commands/command-name.md):**
```markdown
---
name: command-name
description: What this command does
---

# Command Instructions

1. Step one
2. Step two

Use $ARGUMENTS for user input.
```

**6. Skill File (.claude/skills/skill-name/SKILL.md):**
```markdown
---
name: Skill Name
description: When to use this skill. Trigger words here.
---

# Skill Name

## Instructions
Detailed guidance for Claude...

## Examples
Example usage...
```

**7. Subagent File (.claude/agents/agent-name.md):**
```markdown
---
name: agent-name
description: Agent purpose
prompt: "You are an expert in..."
tools: ["Read", "Write", "Bash"]
model: "sonnet"
---

Additional context for the agent...
```

**PRIORITIES & OVERRIDES:**

**Settings Hierarchie (niedrig → hoch):**
```
Enterprise Managed Settings (höchste Priorität)
    ↓
User Settings (~/.claude/settings.json)
    ↓
Project Settings (.claude/settings.json)
    ↓
Local Settings (.claude/settings.local.json)
```

**MCP-Server Hierarchie (niedrig → hoch):**
```
User Scope (~/.claude/.mcp.json)
    ↓
Project Scope (.claude/.mcp.json)
    ↓
Local Scope (.claude/.mcp.local.json)
```

**Git-Verwaltung:**

**In Git committen:**
```
.claude/settings.json
.claude/.mcp.json
.claude/CLAUDE.md
.claude/agents/
.claude/commands/
.claude/skills/
CLAUDE.md
```

**NICHT in Git (Auto-Ignored):**
```
.claude/settings.local.json
.claude/.mcp.local.json
```

**Empfohlene .gitignore Einträge:**
```gitignore
.claude/settings.local.json
.claude/.mcp.local.json
```

**Schnellreferenz - Wichtigste Befehle:**

```bash
# Claude Code Config öffnen
/config

# MCP-Server Status
claude mcp list

# Import aus Claude Desktop
claude mcp import-from-desktop

# Check Installation
claude doctor

# Logs anzeigen (macOS)
tail -f ~/Library/Logs/Claude/mcp*.log
```

### C) TROUBLESHOOTING & FAQ

**HÄUFIGSTE PROBLEME UND LÖSUNGEN:**

---

**PROBLEM 1: MCP-Server erscheint nicht in Claude Desktop**

**Symptom:** Kein Hammer-Icon (⚙️) sichtbar nach Konfiguration

**Lösungen:**
1. **Claude Desktop neu starten** (wichtig!)
   - Komplett schließen (nicht nur Fenster)
   - Neu öffnen
   
2. **Config-Datei prüfen**
   - Pfad: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - JSON-Syntax korrekt? (kein Komma am Ende, Quotes richtig)
   - Validator: `cat config.json | python -m json.tool`

3. **Absolute Pfade verwenden**
   - ❌ Falsch: `~/Desktop`
   - ✅ Richtig: `/Users/username/Desktop`

4. **Logs prüfen**
   ```bash
   tail -n 50 ~/Library/Logs/Claude/mcp.log
   tail -n 50 ~/Library/Logs/Claude/mcp-server-filesystem.log
   ```

5. **Node.js installiert?**
   ```bash
   node --version  # Sollte v18+ sein
   ```

---

**PROBLEM 2: "Directory not allowed" Fehler (Filesystem Server)**

**Symptom:** Filesystem-Tools funktionieren nicht, Error-Message

**Lösungen:**
1. **Pfad in Allowed Directories?**
   - Tool aufrufen: `list_allowed_directories`
   - Prüfen ob Pfad gelistet ist

2. **Absolute Pfade in Config**
   ```json
   {
     "filesystem": {
       "args": [
         "-y",
         "@modelcontextprotocol/server-filesystem",
         "/Users/username/Documents",  // ✅
         "~/Desktop"                    // ❌
       ]
     }
   }
   ```

3. **Pfad existiert?**
   ```bash
   ls /Users/username/Documents
   ```

4. **Parent-Directory zugreifen**
   - Filesystem Server braucht Zugriff auf Parent
   - Statt `/Users/username/Projects/project1`
   - Besser: `/Users/username/Projects` freigeben

---

**PROBLEM 3: Environment Variables nicht expandiert**

**Symptom:** `${VAR}` erscheint wörtlich statt Wert

**Lösungen:**
1. **Variable gesetzt?**
   ```bash
   echo $API_KEY
   ```

2. **Default-Wert nutzen**
   ```json
   "${API_KEY:-default-value}"
   ```

3. **Variable im Kontext setzen**
   - Claude Code: In `settings.json` unter `"env"`
   - Claude Desktop: In Server-Config unter `"env"`

4. **Shell vs. JSON**
   - Shell-Expansion: In `.mcp.json` von Claude Code
   - Keine Expansion: In `claude_desktop_config.json`

---

**PROBLEM 4: Claude Code Commands funktionieren nicht**

**Symptom:** Slash Commands werden nicht erkannt

**Lösungen:**
1. **Richtiges Verzeichnis?**
   ```bash
   pwd  # Sollte Projektverzeichnis sein
   ls .claude/commands/
   ```

2. **YAML Frontmatter korrekt?**
   ```markdown
   ---
   name: command-name
   description: What it does
   ---
   
   # Rest of file...
   ```

3. **Dateiname vs. Command-Name**
   - Datei: `fix-issue.md`
   - Command: `/fix-issue` (aus name in Frontmatter)

4. **Globale vs. Projekt-Commands**
   - Global: `~/.claude/commands/`
   - Projekt: `.claude/commands/`
   - Konflikt: Projekt überschreibt Global

---

**PROBLEM 5: Permission Denied Errors**

**Symptom:** Filesystem-Operationen schlagen fehl mit Permission Error

**Lösungen:**
1. **Docker Volume-Mounts** (bei Docker-Setup)
   ```json
   {
     "filesystem": {
       "command": "docker",
       "args": [
         "run", "-i", "--rm",
         "--volume=/host/path:/container/path",  // Wichtig!
         "ghcr.io/mark3labs/mcp-filesystem-server:latest",
         "/container/path"
       ]
     }
   }
   ```

2. **File-Permissions prüfen**
   ```bash
   ls -la /path/to/file
   chmod 644 file  # Wenn nötig
   ```

3. **User-Rechte**
   - Server läuft mit User-Permissions
   - Bei Docker: Container-User vs. Host-User

---

**PROBLEM 6: Hooks funktionieren nicht**

**Symptom:** afterWrite Hook wird nicht ausgeführt

**Lösungen:**
1. **Syntax in settings.json prüfen**
   ```json
   {
     "hooks": {
       "afterWrite": {
         "**/*.py": "black $FILE"
       }
     }
   }
   ```

2. **Tool installiert?**
   ```bash
   which black  # Hook-Command muss verfügbar sein
   ```

3. **$FILE Variable**
   - Wird von Claude Code ersetzt
   - Mit echtem Dateipfad

4. **Error in Hook?**
   - Logs prüfen
   - Hook-Command manuell testen

---

**PROBLEM 7: Subagenten werden nicht gefunden**

**Symptom:** Subagent nicht verfügbar trotz Definition

**Lösungen:**
1. **Datei-Location**
   ```
   .claude/agents/agent-name.md    # Projekt
   ~/.claude/agents/agent-name.md  # Global
   ```

2. **YAML Frontmatter**
   ```markdown
   ---
   name: agent-name
   description: Clear description
   prompt: "System prompt for agent"
   tools: ["Read", "Write"]
   model: "sonnet"
   ---
   ```

3. **Description wichtig**
   - Claude wählt Agents basierend auf Description
   - Spezifische Trigger-Wörter nutzen

---

**PROBLEM 8: Skills werden nicht verwendet**

**Symptom:** Skill existiert, wird aber von Claude nicht genutzt

**Lösungen:**
1. **Description zu vage**
   ```markdown
   ---
   name: Data Analysis
   description: Analyze data  # ❌ Zu vage
   ---
   ```
   
   Besser:
   ```markdown
   ---
   name: Sales Data Analysis
   description: Analyze sales data in Excel files and CRM exports.
                Use for sales reports, pipeline analysis, revenue tracking.  # ✅
   ---
   ```

2. **Skill-Discovery**
   - Claude wählt Skills automatisch basierend auf Trigger-Wörtern
   - Description muss passende Keywords haben

3. **SKILL.md vorhanden?**
   ```bash
   ls .claude/skills/my-skill/SKILL.md
   ```

---

**PROBLEM 9: API Rate Limits**

**Symptom:** "Rate limit exceeded" Errors

**Lösungen:**
1. **Account-Typ prüfen**
   - Claude.ai Account: Hat Rate Limits
   - Claude Console Account: Keine Rate Limits (pay per use)

2. **Zwischen Accounts wechseln**
   ```bash
   claude  # Startet Login-Flow neu
   ```

3. **Batch Operations**
   - `read_multiple_files` statt einzelne Calls
   - Weniger API-Requests

---

**PROBLEM 10: Claude Code im falschen Directory**

**Symptom:** Claude sieht Projektdateien nicht

**Lösungen:**
1. **Working Directory prüfen**
   ```bash
   pwd
   cd /correct/project/path
   claude
   ```

2. **Root-Directory für Session**
   - Claude Code arbeitet relativ zum Start-Directory
   - Immer von Projekt-Root starten

---

**FAQ - ALLGEMEINE FRAGEN:**

**Q: Wie viel kostet Claude Code / Desktop?**
A: 
- **Claude Desktop**: Free (mit Free-Plan), Included in Pro/Max Plans
- **Claude Code CLI**: 
  - Via Claude.ai Account (Pro/Max): Included
  - Via Claude Console: Pay-per-use (API Credits)

**Q: Funktioniert MCP nur mit Claude?**
A: Nein! MCP ist ein offenes Protokoll. Andere Clients können MCP-Server ebenfalls nutzen. Claude Desktop und Claude Code sind nur Beispiele.

**Q: Kann ich eigene MCP-Server schreiben?**
A: Ja! Mit MCP SDKs (TypeScript, Python). Siehe: https://modelcontextprotocol.io/docs/develop/build-server

**Q: Sind meine Daten sicher?**
A: 
- Lokale MCP-Server (STDIO): Daten bleiben lokal
- Remote MCP-Server (HTTP): Daten gehen zu externem Service
- User Consent: Jede Tool-Aktion erfordert Bestätigung
- Permissions: Fine-grained Control möglich

**Q: Kann Claude Code/Desktop auf sensible Daten zugreifen?**
A: Nur wenn explizit freigegeben:
- Filesystem Server: Nur allowed directories
- Permissions in settings.json definieren
- Best Practice: Minimal Privileges

**Q: Was passiert wenn Config fehlerhaft ist?**
A: 
- Claude Desktop: Server lädt nicht, kein Hammer-Icon
- Claude Code: Parse Error bei start
- Lösung: Logs prüfen, JSON validieren

**Q: Wie update ich Claude Code?**
A: 
- Auto-Update: Standardmäßig aktiv
- Manuell: `npm install -g @anthropic-ai/claude-code@latest`
- Disable: `DISABLE_AUTOUPDATER=1` in env oder settings.json

**Q: Claude kann bestimmte Dateien nicht lesen?**
A: Prüfen:
1. Datei in allowed directory?
2. Read-Permission in settings.json erlaubt?
3. File-Permissions auf OS-Level korrekt?

---

**WO FINDET MAN HILFE?**

**Dokumentation:**
- Claude Code: https://docs.claude.com/en/docs/claude-code
- MCP: https://modelcontextprotocol.io
- Claude Desktop: https://support.claude.com

**Support:**
- Anthropic Support: https://support.claude.com
- GitHub Issues: https://github.com/modelcontextprotocol/servers/issues
- Community Discussions: https://github.com/orgs/modelcontextprotocol/discussions

**Debugging Tools:**
```bash
# Claude Code Doctor
claude doctor

# Logs verfolgen
tail -f ~/Library/Logs/Claude/mcp*.log

# MCP-Server Status
claude mcp list

# Config prüfen (Interactive Mode)
/config
```

**Best Practices für Support-Anfragen:**
1. ✅ Logs beifügen
2. ✅ Config-Dateien teilen (ohne Secrets!)
3. ✅ Exakte Fehlermeldungen kopieren
4. ✅ Versions-Nummern angeben (`claude --version`, `node --version`)
5. ✅ Reproduktionsschritte beschreiben

---

## QUELLEN & REFERENZEN

- Claude Code Docs: https://docs.claude.com/en/docs/claude-code
- MCP Docs: https://modelcontextprotocol.io
- MCP Spec: https://spec.modelcontextprotocol.io
