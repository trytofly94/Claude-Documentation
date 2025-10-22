# CLAUDE CODE - Vollständige Dokumentation

**Stand:** 22. Oktober 2025
**Version:** 3.0

Teil der [Claude Ecosystem Dokumentation](README.md)

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

Siehe [Legacy CLI Integration](#5-legacy-cli-integration-terminal-workflows) für Details.

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

#### 5. LEGACY CLI INTEGRATION (Terminal Workflows)

**Für Terminal-Präferenz-Nutzer bleibt die CLI-Integration bestehen**

Während die VS Code Extension eine grafische Oberfläche bietet, ist die klassische CLI-Integration weiterhin vollständig verfügbar und wird aktiv unterstützt.

**Features:**
- **Selection Context Sharing** - Teile ausgewählten Code aus dem IDE mit Claude Code im Terminal
- **Diff Viewing im IDE** - Code-Änderungen werden im IDE angezeigt statt im Terminal
- **File Reference Shortcuts** - Schnelle Datei-Referenzen aus dem Editor
- **Automatic Diagnostic Sharing** - IDE-Fehler und Warnungen werden automatisch geteilt

**Kompatible IDEs:**
- Visual Studio Code
- Cursor
- Windsurf
- VSCodium

**Wann Legacy CLI nutzen:**

✅ **Terminal-Workflows bevorzugt**
- Nutzer, die hauptsächlich im Terminal arbeiten
- Vim/Emacs-Nutzer mit Terminal-Workflows
- tmux/screen Power-User

✅ **SSH/Remote Development**
- Verbindung zu Remote-Servern via SSH
- Development in Cloud-Umgebungen
- Container-basierte Workflows

✅ **Scriptability & Automation**
- CI/CD Pipelines
- Automatisierte Tasks
- Batch-Processing

✅ **Parallele Nutzung**
- VS Code Extension für GUI-Tasks
- CLI für scriptbare Workflows
- Beide Ansätze gleichzeitig nutzbar

**Setup:**

```bash
# CLI-Integration aktivieren (automatisch verfügbar)
claude

# Kombiniert mit IDE-Integration:
# 1. VS Code Extension installieren
# 2. CLI separat nutzen im Terminal
# 3. Beide teilen sich .claude/ Konfiguration
```

**Unterschied Extension vs. CLI:**

| Aspekt | VS Code Extension | Legacy CLI |
|--------|-------------------|------------|
| **Interface** | GUI, Sidebar | Terminal |
| **Diffs** | Inline im Editor | Terminal-Output |
| **Plan Mode** | Grafische Preview | Text-basiert |
| **Auto-Accept** | GUI-Toggle | CLI-Flag |
| **SSH** | ❌ | ✅ |
| **Scriptable** | Limitiert | ✅ Voll |
| **Background** | IDE-abhängig | Komplett unabhängig |

**Best Practice: Hybrid-Ansatz**
- **Extension** für interaktive Feature-Development
- **CLI** für Automatisierung und SSH-Sessions
- **Beide** für optimale Flexibilität

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

### H) API FEATURES (DEVELOPER PLATFORM)

Claude Code und die Claude API bieten erweiterte Features für längere autonome Tasks und persistentes Memory.

#### Context Editing Feature

**Automatisches Bereinigen veralteter Informationen**

Context Editing ist ein neues Feature der Claude API, das automatisch veraltete Informationen im Context Window entfernt und relevanten Context behält. Dies ermöglicht längere autonome Tasks ohne Context-Overflow.

**Wie es funktioniert:**
- **Context Window Management** - Intelligentes Management des verfügbaren Context
- **Auto-Cleanup** - Entfernt outdated Informationen automatisch
- **Relevanter Context bleibt** - Wichtige Informationen werden bewahrt
- **Längere Tasks** - Ermöglicht 30+ Stunden autonomes Coding

**Claude Code Integration:**
Claude Code nutzt Context Editing automatisch bei langen Sessions. Keine manuelle Konfiguration erforderlich.

**API-Usage (für eigene Agents):**
```python
import anthropic

client = anthropic.Anthropic(api_key="your-key")

# Context Editing aktivieren
response = client.messages.create(
    model="claude-sonnet-4-5",
    messages=[...],
    context_editing=True  # NEU
)
```

**Use Cases:**
- ✅ Lange Coding-Sessions (30+ Stunden)
- ✅ Multi-Step Refactorings
- ✅ Iterative Feature-Development
- ✅ Complex Debugging-Sessions

**Benefits:**
- 🚀 Keine manuelle Context-Bereinigung nötig
- 🚀 Fokus auf relevante Informationen
- 🚀 Bessere Performance bei langen Tasks
- 🚀 Automatisches Memory-Management

---

#### Memory Tool

**Persistentes Memory über Context-Window hinaus**

Das Memory Tool ermöglicht es Claude, Informationen langfristig zu speichern – über das Context Window und multiple Sessions hinweg.

**Features:**
- **Langzeit-Speicherung** - Informationen bleiben über Sessions erhalten
- **Multi-Session Memory** - Wissen wird über Sessions hinweg geteilt
- **Strukturiertes Knowledge Management** - Organisierte Speicherung
- **API-gesteuert** - Programmatische Kontrolle über Memory

**Claude Code Integration:**
Aktuell ist das Memory Tool primär für die API verfügbar. Claude Code nutzt alternative Mechanismen:
- `CLAUDE.md` für Projekt-Memory
- Skills für wiederverwendbares Wissen
- Sessions können resumed werden (Konversations-History bleibt)

**API-Usage (für eigene Agents):**
```python
import anthropic

client = anthropic.Anthropic(api_key="your-key")

# Memory Tool nutzen
response = client.messages.create(
    model="claude-sonnet-4-5",
    messages=[...],
    tools=[
        {
            "type": "memory",
            "name": "project_memory",
            "description": "Long-term memory for this project"
        }
    ]
)

# Claude kann jetzt Informationen im Memory speichern und abrufen
# Beispiel: "Remember that we use TypeScript strict mode in this project"
# Bei zukünftigen Requests wird diese Information automatisch verfügbar sein
```

**Use Cases:**
- ✅ **Long-running Projects** - Projektkontext über Wochen/Monate
- ✅ **Persistent User Preferences** - Nutzer-spezifische Einstellungen
- ✅ **Historical Context** - Vergangene Entscheidungen und Begründungen
- ✅ **Team Knowledge** - Geteiltes Wissen über das Team

**Memory vs. CLAUDE.md:**

| Aspekt | Memory Tool (API) | CLAUDE.md (Claude Code) |
|--------|-------------------|-------------------------|
| **Speicherort** | Claude's Backend | Lokales Filesystem |
| **Persistence** | API-managed | Git-versioniert |
| **Sharing** | Über API | Über Git |
| **Auto-Update** | Von Claude gesteuert | Manuell editiert |
| **Verfügbarkeit** | API only | Claude Code & Desktop |

**Best Practice für Claude Code:**
Nutze `CLAUDE.md` für statisches Projekt-Wissen und Skills für wiederverwendbare Workflows. Das Memory Tool ist primär für eigene Agent-Implementations via API relevant.

**Zukünftige Integration:**
Memory Tool könnte in zukünftigen Claude Code Versionen direkt integriert werden, um Project Memory automatisch zu verwalten.

---

### I) WEITERE FEATURES & UPDATES (OKTOBER 2025)

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

