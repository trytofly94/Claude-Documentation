# CLAUDE CODE - TOOL-INTERAKTIONEN & SYNERGISMEN

**Stand:** 22. Oktober 2025
**Version:** 1.0

Teil der [Claude Ecosystem Dokumentation](README.md)

---

## 🎯 ÜBERBLICK

Diese Dokumentation beschreibt, wie die verschiedenen Tools und Ansätze in Claude Code miteinander interagieren und welche Synergismen möglich sind.

**Kernkonzept:** Claude Code ist ein hochgradig erweiterbares System, in dem verschiedene Komponenten zusammenarbeiten können:
- **Slash Commands** (User-invoked)
- **Skills** (Model-invoked)
- **Subagenten** (Spezialisierte AI-Assistenten)
- **Hooks** (Event-driven Automation)
- **MCP-Server** (Externe Integrationen)
- **CLAUDE.md** (Projekt-Memory)
- **Output Styles** (System Prompt Modifikation)

---

## 📋 KOMPONENTEN-ÜBERSICHT

### 1. Slash Commands

**Was sind Slash Commands?**
- User-invoked: Der Nutzer ruft sie explizit auf
- Gespeicherte Prompt-Templates in Markdown-Dateien
- Können Argumente akzeptieren: `/fix-issue 123`

**Speicherorte:**
- Projekt: `.claude/commands/`
- Global: `~/.claude/commands/`

**Format:**
```markdown
---
name: command-name
description: Was dieser Command macht (wichtig für SlashCommand Tool!)
---

# Command Instructions

1. Schritt eins
2. Schritt zwei

Nutze $ARGUMENTS für User-Input.
```

**Wichtig:** Das `description` Field ist kritisch, damit Claude den Command via SlashCommand Tool aufrufen kann!

---

### 2. Skills

**Was sind Skills?**
- Model-invoked: Claude entscheidet selbst, wann sie verwendet werden
- Progressive Disclosure System (zwei Ebenen)
- Automatische Discovery basierend auf Description

**Speicherorte:**
- Projekt: `.claude/skills/skill-name/SKILL.md`
- Global: `~/.claude/skills/skill-name/SKILL.md`
- Plugins: Können Skills bündeln

**Format:**
```markdown
---
name: Skill Name
description: Wann dieser Skill verwendet werden soll. Trigger-Wörter hier!
---

# Skill Name

## Instructions
Detaillierte Anweisungen für Claude...

## Examples
Beispiel-Nutzung...
```

**Progressive Disclosure:**
1. **Metadata-Ebene**: Name + Description (immer geladen)
   - Claude prüft, ob Skill relevant ist
   - Verhindert Context-Bloat

2. **Full Content-Ebene**: Komplette Instructions (nur wenn relevant)
   - Wird nur geladen, wenn Claude den Skill als relevant einstuft

**Discovery-Prozess:**
1. Claude evaluiert User-Request
2. Matcht Intent gegen Skill-Descriptions
3. Wählt beste Kandidaten aus
4. Lädt vollen Content nur für relevante Skills
5. Erklärt im Response, warum Skill verwendet wurde

---

### 3. Subagenten

**Was sind Subagenten?**
- Spezialisierte Mini-Agenten mit eigenen:
  - System Prompts
  - Tool-Berechtigungen
  - Separatem Context Window
- Reduzieren Context-Pollution
- Ermöglichen skalierbare, wiederholbare Workflows

**Speicherorte:**
- Projekt: `.claude/agents/`
- Global: `~/.claude/agents/`

**Format:**
```markdown
---
name: agent-name
description: Agent-Zweck. Use PROACTIVELY für automatische Nutzung!
prompt: "Du bist ein Experte in..."
tools: ["Read", "Write", "Bash"]
model: "sonnet"
---

Zusätzlicher Kontext für den Agenten...
```

**Proaktive Nutzung:**
- Füge "use PROACTIVELY" in description ein
- Oder "MUST BE USED" für kritische Agenten
- Claude wird Agent automatisch verwenden

---

### 4. Hooks

**Was sind Hooks?**
- Event-driven Automation
- User-definierte Shell-Commands
- Garantierte Ausführung (nicht LLM-abhängig)
- Laufen an spezifischen Punkten im Lifecycle

**Hook-Typen:**

| Hook | Wann | Kann blockieren? | Use Cases |
|------|------|------------------|-----------|
| **PreToolUse** | Vor Tool-Execution | ✅ Ja (einziger!) | Security-Checks, Validierung |
| **PostToolUse** | Nach erfolgreicher Tool-Execution | ❌ Nein | Linting, Testing, Logging |
| **UserPromptSubmit** | Nach User-Prompt | ❌ Nein | Context-Injection, Logging |
| **SessionStart** | Bei Session-Start | ❌ Nein | Environment-Setup, Dependencies |
| **Stop** | Wenn Agent fertig ist | ❌ Nein | Cleanup, Notifications |
| **Notification** | Bei Claude-Alert | ❌ Nein | Custom Notifications |

**Konfiguration:**
```json
{
  "hooks": {
    "PreToolUse": {
      "Write(**/production/**/**)": "echo 'Production writes blocked!' && exit 1"
    },
    "PostToolUse": {
      "Write(**/*.py)": "black $FILE && pylint $FILE",
      "Write(**/*.ts)": "prettier --write $FILE"
    },
    "SessionStart": [
      {
        "type": "command",
        "command": "npm install",
        "condition": "[ ! -d node_modules ]"
      }
    ]
  }
}
```

**Verfügbare Environment Variables:**
- `$FILE`: Betroffene Datei (bei File-Operations)
- `$COMMAND`: Ausgeführter Command (bei Bash)
- `$CLAUDE_PROJECT_DIR`: Projekt-Root-Pfad
- `$CLAUDE_ENV_FILE`: Pfad für persistente Env-Vars

---

### 5. CLAUDE.md

**Was ist CLAUDE.md?**
- Projekt-Memory / Kontext
- Wird automatisch von Claude gelesen
- Kann von Skills referenziert werden

**Speicherorte:**
- `.claude/CLAUDE.md` (in Git)
- `CLAUDE.md` im Projektroot (Alternative)
- `~/.claude/CLAUDE.md` (global für alle Projekte)

**Format:**
```markdown
# Projektname

## Kontext
Dieses Projekt ist über...

## Wichtige Konventionen
- TypeScript strict mode verwenden
- Alle API-Endpoints starten mit /api/v1

## Häufige Aufgaben
- Tests laufen: `npm test`
- Deploy: `/deploy` Command verwenden

## Referenzen
@agents/code-reviewer.md - Für Code-Reviews
@skills/data-analysis/ - Für Datenanalyse
```

**Integration:**
- CLAUDE.md wird als **User Message** nach System Prompt hinzugefügt
- Skills können CLAUDE.md referenzieren mit `@CLAUDE.md`
- Subagenten haben Zugriff auf CLAUDE.md

---

### 6. Output Styles

**Was sind Output Styles?**
- Modifizieren den System Prompt direkt
- Ändern Claudes Verhalten für gesamte Session
- Projekt-Level persistent

**Speicherorte:**
- User: `~/.claude/output-styles/`
- Projekt: `.claude/output-styles/`

**Wechseln:**
```bash
/output-style              # Menü öffnen
/output-style explanatory  # Direkt wechseln
/output-style learning     # Learning Mode
/output-style default      # Zurück zu Default
```

**Wichtig:** Output Styles beeinflussen **nicht** Subagenten (die haben eigene Prompts)!

---

## 🔄 INTERAKTIONSMUSTER

### Pattern 1: Slash Commands rufen Subagenten auf

**Use Case:** Orchestrierung komplexer Multi-Step-Tasks

**Beispiel:**
```markdown
---
name: feature-complete
description: Complete feature implementation workflow
---

# Feature Complete Workflow

Nutze diese Subagenten in Reihenfolge:

1. **Planner Agent** - Erstelle Feature-Plan
   - Use the **feature-planner** sub agent to create /docs/feature-plan.md for: $ARGUMENTS

2. **Implementation Agent** - Implementiere Feature
   - Use the **code-writer** sub agent to implement based on plan

3. **Test Agent** - Schreibe Tests
   - Use the **test-writer** sub agent to create comprehensive tests

4. **Review Agent** - Review Code
   - Use the **code-reviewer** sub agent to review all changes
```

**Workflow:**
```
User: /feature-complete authentication-system
  → Claude lädt feature-complete Command
  → Command ruft feature-planner Subagent auf
  → Planner erstellt Plan in /docs/feature-plan.md
  → Command ruft code-writer Subagent auf
  → Writer implementiert basierend auf Plan
  → Command ruft test-writer Subagent auf
  → Tester schreibt Tests
  → Command ruft code-reviewer Subagent auf
  → Reviewer prüft alles
```

---

### Pattern 2: Claude ruft Slash Commands programmatisch auf (SlashCommand Tool)

**Use Case:** Claude erkennt, dass ein definierter Workflow passt

**Voraussetzungen:**
- Slash Command muss `description` Field haben
- Command muss user-defined sein (keine built-ins)
- CLAUDE.md oder Skills sollten Command referenzieren

**Beispiel in CLAUDE.md:**
```markdown
# Projekt-Konventionen

## Testing
Wenn du Tests schreibst, nutze den `/write-unit-test` Command automatisch.

## Code Review
Nach größeren Code-Änderungen, rufe `/code-review` auf.
```

**Beispiel Slash Command:**
```markdown
---
name: write-unit-test
description: Schreibt umfassende Unit-Tests für modifizierte Dateien
---

# Write Unit Test

1. Identifiziere geänderte Dateien
2. Analysiere Code-Coverage
3. Schreibe fehlende Tests
4. Nutze project Test-Framework (siehe CLAUDE.md)
```

**Workflow:**
```
User: "Implement login function"
  → Claude implementiert login function
  → Claude sieht in CLAUDE.md: "nutze /write-unit-test"
  → Claude ruft SlashCommand Tool auf
  → SlashCommand Tool führt /write-unit-test aus
  → Tests werden automatisch geschrieben
```

---

### Pattern 3: Skills arbeiten mit CLAUDE.md

**Use Case:** Skill benötigt Projekt-spezifisches Wissen

**CLAUDE.md:**
```markdown
# Data Processing Project

## Data Formats
- Input: CSV with columns: id, name, value, timestamp
- Output: JSON with aggregated metrics
- Timezone: UTC

## Database Schema
@database-schema.sql

## Processing Rules
- Filter out negative values
- Aggregate by day
- Round to 2 decimals
```

**Skill:**
```markdown
---
name: Data Analysis
description: Analyze CSV data and generate reports. Use for data processing tasks.
---

# Data Analysis Skill

## Workflow
1. Read project conventions from @CLAUDE.md
2. Load data according to format specs
3. Apply processing rules from CLAUDE.md
4. Generate output in specified format
```

**Workflow:**
```
User: "Analyze the sales data"
  → Claude matcht Request gegen Skill Description
  → "Data Analysis" Skill wird geladen
  → Skill liest @CLAUDE.md für Format-Specs
  → Skill verarbeitet Daten gemäß CLAUDE.md Rules
  → Generiert Output im korrekten Format
```

---

### Pattern 4: Hooks automatisieren Post-Processing

**Use Case:** Automatische Code-Qualitätssicherung

**settings.json:**
```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/*.py)": "black $FILE && ruff check $FILE",
      "Write(**/*.ts)": "prettier --write $FILE && eslint --fix $FILE",
      "Write(**/*.go)": "gofmt -w $FILE && golangci-lint run $FILE"
    },
    "PreToolUse": {
      "Write(**/production/**)": "echo 'Production writes need approval!' && exit 1"
    }
  }
}
```

**Workflow:**
```
Claude: Schreibt Python-Datei
  → PostToolUse Hook triggert
  → black formatiert Datei automatisch
  → ruff prüft Code-Qualität
  → Ergebnisse werden Claude mitgeteilt
  → Claude kann auf Issues reagieren

User: Versucht Production-File zu ändern
  → PreToolUse Hook triggert
  → Hook blockt Operation (exit 1)
  → User muss explizit zustimmen
```

---

### Pattern 5: Skills + Hooks Kombination

**Use Case:** Skill mit automatischer Validierung

**Skill (Database Migration):**
```markdown
---
name: Database Migration
description: Create and apply database migrations. Use for schema changes.
---

# Database Migration Skill

## Workflow
1. Analyze schema changes needed
2. Generate migration file in db/migrations/
3. Apply migration to development database
4. Verify schema changes
```

**Hook Configuration:**
```json
{
  "hooks": {
    "PostToolUse": {
      "Write(db/migrations/**)": "npm run migration:verify"
    }
  }
}
```

**Workflow:**
```
User: "Add user_role column to users table"
  → Claude aktiviert Database Migration Skill
  → Skill generiert Migration-File
  → PostToolUse Hook triggert
  → migration:verify läuft automatisch
  → Validiert Migration-Syntax
  → Claude erhält Feedback über Erfolg/Fehler
```

---

### Pattern 6: Subagenten mit spezialisierten Tool-Berechtigungen

**Use Case:** Security durch Tool-Isolation

**Subagent (Read-Only Analyzer):**
```markdown
---
name: security-analyzer
description: Analyzes code for security vulnerabilities. Use PROACTIVELY for security reviews.
prompt: "You are a security expert. Analyze code for vulnerabilities."
tools: ["Read", "Grep", "Glob"]  # Nur Lese-Zugriff!
model: "sonnet"
---

Fokus auf OWASP Top 10, SQL Injection, XSS, etc.
```

**Subagent (Code Writer):**
```markdown
---
name: code-writer
description: Implements features and fixes bugs
prompt: "You are a senior developer. Write clean, tested code."
tools: ["Read", "Write", "Bash", "Grep", "Glob"]
model: "sonnet"
---

Follow project conventions in CLAUDE.md
```

**Workflow:**
```
Main Agent: Erhält Feature-Request
  → Delegiert an code-writer Subagent
  → code-writer schreibt Code (hat Write-Zugriff)
  → Main Agent ruft security-analyzer auf
  → security-analyzer prüft Code (nur Read-Zugriff!)
  → Kann keine Änderungen machen, nur berichten
  → Main Agent entscheidet basierend auf Report
```

---

### Pattern 7: Multi-Layer Workflow mit allen Komponenten

**Use Case:** Enterprise-Grade Feature-Development

**Setup:**

**1. CLAUDE.md:**
```markdown
# Enterprise App

## Workflows
- Feature Development: Use /feature-workflow command
- Code Review: Automatic via code-reviewer agent
- Security: Run /security-review before deploy

## Standards
- All features need: tests, docs, security review
- Use TypeScript strict mode
- API versioning: /api/v1/

## References
@skills/api-design/ - For API endpoints
@agents/code-reviewer.md - Auto code review
```

**2. Slash Command (/feature-workflow):**
```markdown
---
name: feature-workflow
description: Complete enterprise feature development workflow
---

# Enterprise Feature Workflow

For feature: $ARGUMENTS

1. Use **api-designer** agent to design API
2. Use **code-writer** agent to implement
3. Use **test-writer** agent for tests
4. Use **doc-writer** agent for documentation
5. Use **security-analyzer** agent for security review
6. Run /code-review command
7. Run /security-review command
```

**3. Hooks (settings.json):**
```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/*.ts)": "prettier --write $FILE && eslint --fix $FILE",
      "Write(**/test/**)": "npm run test:unit"
    },
    "PreToolUse": {
      "Bash(npm run deploy*)": "echo 'Deploy needs approval!' && exit 1"
    }
  }
}
```

**4. Skill (API Design):**
```markdown
---
name: API Design
description: Design RESTful APIs following enterprise standards. Use for new endpoints.
---

# API Design Skill

Reference @CLAUDE.md for API versioning and standards.

## Checklist
- Follow /api/v1/ pattern
- OpenAPI documentation
- Error handling
- Rate limiting design
```

**Complete Workflow:**
```
User: /feature-workflow user-authentication

1. SLASH COMMAND triggert
   → Liest Workflow aus feature-workflow.md

2. API DESIGNER SUBAGENT
   → API Design Skill wird aktiviert (model-invoked)
   → Liest @CLAUDE.md für Standards
   → Designt API gemäß Specs
   → Erstellt OpenAPI docs

3. CODE WRITER SUBAGENT
   → Implementiert API
   → PostToolUse Hook: prettier + eslint laufen automatisch
   → Code wird formatiert

4. TEST WRITER SUBAGENT
   → Schreibt Tests
   → PostToolUse Hook: Tests laufen automatisch
   → Feedback über Erfolg/Fehler

5. DOC WRITER SUBAGENT
   → Schreibt Dokumentation

6. SECURITY ANALYZER SUBAGENT (Read-only!)
   → Prüft Code auf Vulnerabilities
   → Report erstellen

7. SLASH COMMAND: /code-review
   → SlashCommand Tool ruft Review auf
   → code-reviewer agent prüft alles

8. SLASH COMMAND: /security-review
   → Comprehensive Security-Scan

9. User versucht zu deployen
   → PreToolUse Hook blockiert
   → User muss explizit zustimmen
```

**Synergismen in diesem Workflow:**
- ✅ CLAUDE.md liefert zentrale Standards
- ✅ Slash Command orchestriert Workflow
- ✅ Subagenten mit spezialisierten Rollen
- ✅ Skills werden automatisch aktiviert
- ✅ Hooks garantieren Code-Qualität
- ✅ SlashCommand Tool für programmatische Aufrufe
- ✅ Tool-Berechtigungen für Security

---

## 🎯 SYNERGISMEN & BEST PRACTICES

### Synergismus 1: Slash Commands + Subagenten

**Wann nutzen:**
- Komplexe Multi-Step-Workflows
- Orchestrierung mehrerer spezialisierter Agenten
- Wiederholbare Prozesse

**Best Practice:**
```markdown
Slash Command = Workflow-Orchestrator
Subagenten = Spezialisierte Worker
```

**Beispiel-Use-Cases:**
- Feature-Development-Pipeline
- Release-Prozess
- Migration-Workflows

---

### Synergismus 2: Skills + CLAUDE.md

**Wann nutzen:**
- Skills benötigen projekt-spezifisches Wissen
- Zentrale Konventionen sollen referenziert werden
- Domain-spezifische Workflows

**Best Practice:**
```markdown
CLAUDE.md = Zentrale Wissensbasis
Skills = Wiederverwendbare Workflows mit Projekt-Kontext
```

**Beispiel-Use-Cases:**
- Data Processing (Format-Specs in CLAUDE.md)
- API Design (Standards in CLAUDE.md)
- Testing (Framework-Konventionen in CLAUDE.md)

---

### Synergismus 3: Hooks + Alle Tools

**Wann nutzen:**
- Garantierte Automatisierung nötig
- Code-Qualitätssicherung
- Security-Enforcement
- Post-Processing

**Best Practice:**
```markdown
Hooks = Automatische Qualitätssicherung
PreToolUse = Prevention (Security)
PostToolUse = Reaction (Formatting, Testing)
```

**Beispiel-Use-Cases:**
- Auto-Formatting aller Files
- Test-Execution nach Code-Änderung
- Security-Checks vor sensiblen Ops
- Logging aller Tool-Usage

---

### Synergismus 4: SlashCommand Tool + CLAUDE.md

**Wann nutzen:**
- Claude soll automatisch Workflows erkennen
- Kontext-basierte Command-Auswahl
- Self-Service-Automation

**Best Practice:**
```markdown
CLAUDE.md definiert: "Wann welcher Command"
Claude entscheidet automatisch via SlashCommand Tool
```

**Beispiel in CLAUDE.md:**
```markdown
## Automated Workflows

- **After implementing features**: Rufe `/write-tests` auf
- **Before committing**: Rufe `/code-review` auf
- **For API changes**: Rufe `/update-openapi-spec` auf
```

---

### Synergismus 5: Subagenten Tool-Isolation + Main Agent Orchestration

**Wann nutzen:**
- Security-kritische Operationen
- Separation of Concerns
- Context-Pollution vermeiden

**Best Practice:**
```markdown
Main Agent = Orchestrator (hat alle Tools)
Subagenten = Specialists (eingeschränkte Tools)
  - Read-Only Analyzer: nur Read, Grep, Glob
  - Code Writer: Read, Write, Bash
  - Test Runner: Bash, Read
```

**Beispiel-Workflow:**
```
Main Agent
  → Analyst Subagent (Read-only) analysiert Problem
  → Writer Subagent (Read+Write) implementiert
  → Tester Subagent (Bash+Read) testet
  → Main Agent entscheidet über Deployment
```

---

## 📊 DECISION MATRIX: Wann was nutzen?

| Use Case | Tool | Grund |
|----------|------|-------|
| **Wiederholbare User-Workflows** | Slash Commands | Explizit, vorhersagbar, einfach |
| **Automatische Domain-Expertise** | Skills | Model-invoked, kontextabhängig |
| **Komplexe Multi-Step-Tasks** | Slash Command + Subagenten | Orchestrierung + Spezialisierung |
| **Garantierte Automatisierung** | Hooks | Nicht LLM-abhängig, immer ausgeführt |
| **Projekt-Kontext** | CLAUDE.md | Zentrale Wissensbasis |
| **Context-Isolation** | Subagenten | Separate Context Windows |
| **Security-Enforcement** | PreToolUse Hooks | Einzige Möglichkeit zu blockieren |
| **Code-Qualität** | PostToolUse Hooks | Auto-Formatting, Linting |
| **Behavior-Änderung** | Output Styles | System Prompt Modifikation |

---

## 🔍 DEBUGGING & TROUBLESHOOTING

### Slash Command wird nicht gefunden

**Problem:** `/my-command` wird nicht erkannt

**Lösungen:**
1. ✅ Prüfe Dateiname: `.claude/commands/my-command.md`
2. ✅ Prüfe YAML Frontmatter: `name` und `description` gesetzt?
3. ✅ Prüfe Working Directory: `pwd` im richtigen Projekt?
4. ✅ Global vs. Projekt: Konflikt zwischen `~/.claude/commands/` und `.claude/commands/`?

---

### Skill wird nicht aktiviert

**Problem:** Skill existiert, wird aber nicht verwendet

**Lösungen:**
1. ✅ **Description zu vage**: Muss spezifische Trigger-Wörter enthalten
   ```markdown
   ❌ description: "Data analysis"
   ✅ description: "Analyze sales data in CSV and Excel files. Use for revenue reports, pipeline analysis, quarterly metrics."
   ```
2. ✅ **SKILL.md fehlt**: Muss `SKILL.md` heißen (case-sensitive)
3. ✅ **Zu generisch**: Skill-Name und Description müssen eindeutig sein
4. ✅ **Debugging**: Claude erklärt im Response, welche Skills verwendet wurden

---

### SlashCommand Tool funktioniert nicht

**Problem:** Claude ruft Slash Command nicht programmatisch auf

**Lösungen:**
1. ✅ **Description fehlt**: MUSS `description` field im Frontmatter haben
2. ✅ **Built-in Command**: SlashCommand Tool unterstützt nur custom commands
3. ✅ **Nicht referenziert**: CLAUDE.md sollte Command erwähnen
4. ✅ **Version zu alt**: Claude Code >= 1.0.124
5. ✅ **Debugging**: `claude --debug` zeigt verfügbare Commands

---

### Hook wird nicht ausgeführt

**Problem:** PostToolUse Hook läuft nicht

**Lösungen:**
1. ✅ **Pattern falsch**: Glob-Pattern korrekt? `**/*.py` nicht `*.py`
2. ✅ **Tool nicht installiert**: `which black` prüft Verfügbarkeit
3. ✅ **Exit Code**: Hook-Command muss Exit Code 0 zurückgeben
4. ✅ **Permissions**: Hook-Script ausführbar? `chmod +x script.sh`
5. ✅ **Logs**: Prüfe Hook-Execution in Logs

---

### Subagent hat falsche Tools

**Problem:** Subagent kann nicht schreiben, obwohl nötig

**Lösung:**
```markdown
✅ Prüfe tools Array im Frontmatter:
---
name: code-writer
tools: ["Read", "Write", "Bash", "Grep", "Glob"]
---

❌ Häufiger Fehler: tools fehlt oder falsch geschrieben
```

---

### CLAUDE.md wird ignoriert

**Problem:** Claude scheint CLAUDE.md nicht zu lesen

**Lösungen:**
1. ✅ **Pfad prüfen**: `.claude/CLAUDE.md` oder `CLAUDE.md` im Root
2. ✅ **Working Directory**: Startest du Claude im richtigen Verzeichnis?
3. ✅ **Encoding**: Muss UTF-8 sein
4. ✅ **References**: `@file.md` Syntax korrekt?

---

### Pattern 7.5: Skills + MCP für End-to-End Workflows

**🆕 Oktober 2025 - Skills & MCP Kombination**

**Use Case:** Quarterly Business Review vollautomatisiert mit Skill-Wissen + MCP-Daten

**Skill: `quarterly-business-review`**
```markdown
---
name: quarterly-business-review
description: Creates QBRs following company template with standard KPIs
---

# QBR Skill

## Instructions
1. Use company template structure (Exec Summary, KPIs, Wins, Challenges, Plan)
2. Standard KPIs: Revenue, NRR, CAC, LTV, Churn
3. Apply brand guidelines from assets/brand-guide.pdf
4. Format as PPTX for executive presentation
```

**MCP Configuration:**
```json
{
  "mcpServers": {
    "google-drive": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-google-drive"]
    },
    "salesforce": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-salesforce"]
    },
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"]
    }
  }
}
```

**Workflow:**
```
User: "Create Q4 2025 QBR"

1. Claude matcht Request → QBR Skill aktiviert
2. Skill definiert: WIE (Struktur, Format, KPIs)
3. MCP Google Drive: Lädt Q3 QBR als Referenz
4. MCP Salesforce: Holt aktuelle Sales-Daten (Revenue, Deals, Pipeline)
5. Skill: Formatiert nach Template, wendet Brand an
6. Skill: Erstellt Charts & Visualisierungen
7. MCP Google Drive: Speichert in /QBRs/2025/Q4-QBR.pptx
8. MCP Slack: Postet Link in #executives Channel
```

**Weitere Beispiele:**

**Legal Contract Review:**
```
Skill: "legal-contract-review" (Kennt Standard-Klauseln, Risiken)
+ MCP Box: Contract Repository
+ MCP Slack: Legal Team Notifications

User uploads contract.pdf
→ Skill analysiert gegen Standards
→ Box lädt ähnliche Verträge als Referenz
→ Skill findet Risiko-Klauseln
→ Slack notifiziert Legal Team bei Problemen
```

**Code Modernization:**
```
Skill: "js-to-typescript" (Migration Patterns, Best Practices)
+ MCP Filesystem: Read/Write Code
+ MCP GitHub: Issues, PRs, Commits

User: "Modernize src/auth.js"
→ Skill kennt Migration-Strategie
→ Filesystem liest alte Dateien
→ Skill transformiert zu TypeScript
→ Filesystem schreibt neue Dateien
→ GitHub erstellt PR mit Changes
```

**Wann Skills + MCP kombinieren:**
- ✅ Workflow-Wissen + externe Daten benötigt
- ✅ Wiederholbare Prozesse auf dynamische Daten
- ✅ Team-Standards mit Cloud-Integration
- ✅ End-to-End Automation erwünscht

**Key Insight:**
- **Skills**: Define "HOW" (Prozess, Format, Standards)
- **MCP**: Provide "WHERE" (Daten, Tools, Integration)
- **Claude**: Orchestrates BOTH automatically

---

## 🚀 ADVANCED PATTERNS

### Pattern 8: Event-Driven Architecture mit Hooks

**Use Case:** Automatische Notifications und Logging

**Configuration:**
```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/src/**)": "echo '[CODE CHANGE] $FILE' | tee -a .claude/audit.log && notify-send 'Claude edited $FILE'"
    },
    "Stop": [
      {
        "command": "git diff --stat | notify-send 'Claude finished. Changes:' -i dialog-information"
      }
    ],
    "Notification": {
      "*": "echo '$MESSAGE' >> .claude/notifications.log"
    }
  }
}
```

**Workflow:**
```
Claude ändert Datei
  → PostToolUse: Audit-Log + Desktop-Notification

Claude beendet Task
  → Stop: Git-Diff als Notification

Claude sendet Alert
  → Notification: Logge in notifications.log
```

---

### Pattern 9: Conditional Hooks basierend auf Environment

**Use Case:** Unterschiedliches Verhalten für Dev/Prod

**Configuration:**
```json
{
  "hooks": {
    "PreToolUse": {
      "Bash(npm run deploy*)": "[ \"$NODE_ENV\" = \"production\" ] && echo 'Production deploy blocked!' && exit 1 || exit 0"
    },
    "SessionStart": [
      {
        "command": "if [ \"$CLAUDE_CODE_REMOTE\" = \"true\" ]; then npm install; fi"
      }
    ]
  }
}
```

---

### Pattern 10: Self-Documenting Workflows

**Use Case:** Skills + Commands dokumentieren sich selbst

**Skill:**
```markdown
---
name: API Endpoint Generator
description: Generate REST API endpoints with OpenAPI docs. Use for new APIs.
---

# API Endpoint Generator

## Workflow
1. Read conventions from @CLAUDE.md
2. Generate endpoint code
3. Generate OpenAPI spec
4. **Auto-document**: Run /update-api-docs command
5. **Auto-test**: Generate test file

## Post-Processing
After generation, automatically:
- Update API documentation via /update-api-docs
- Generate Postman collection
- Update CHANGELOG.md
```

**Integration:**
```
Skill generiert API
  → Skill ruft via SlashCommand Tool: /update-api-docs
  → Slash Command aktualisiert Docs
  → PostToolUse Hook: API-Tests laufen
  → Stop Hook: CHANGELOG.md Update
```

---

## 📖 BEISPIEL-REPOSITORIES

### Starter Template

```
my-project/
├── .claude/
│   ├── settings.json           # Hooks, Permissions, Env Vars
│   ├── CLAUDE.md               # Projekt-Kontext
│   ├── commands/
│   │   ├── feature-workflow.md
│   │   ├── code-review.md
│   │   └── deploy.md
│   ├── agents/
│   │   ├── planner.md
│   │   ├── code-writer.md
│   │   ├── test-writer.md
│   │   └── security-analyzer.md
│   └── skills/
│       ├── api-design/
│       │   └── SKILL.md
│       └── data-processing/
│           └── SKILL.md
├── CLAUDE.md                   # Alternative Position
└── [projekt-dateien]
```

---

## ✅ CHECKLISTE: Optimale Integration

**Projekt-Setup:**
- [ ] CLAUDE.md mit Projekt-Kontext erstellt
- [ ] Wichtigste Workflows als Slash Commands definiert
- [ ] Description field in allen Commands/Skills gesetzt
- [ ] Subagenten für wiederkehrende Aufgaben erstellt
- [ ] PostToolUse Hooks für Code-Qualität konfiguriert
- [ ] PreToolUse Hooks für Security-kritische Ops
- [ ] Skills für Domain-Expertise hinzugefügt
- [ ] CLAUDE.md referenziert Commands und Skills

**Workflow-Optimierung:**
- [ ] Slash Commands orchestrieren Subagenten
- [ ] Skills nutzen @CLAUDE.md für Kontext
- [ ] Hooks automatisieren repetitive Tasks
- [ ] SlashCommand Tool wird via CLAUDE.md aktiviert
- [ ] Subagenten haben passende Tool-Berechtigungen
- [ ] Logging und Notifications via Hooks

**Debugging:**
- [ ] `claude --debug` für SlashCommand Tool
- [ ] Hook-Logs prüfen bei Problemen
- [ ] Skill-Discovery via Response-Erklärungen
- [ ] Git-Status für CLAUDE.md Location

---

## 🔗 RESSOURCEN

**Offizielle Dokumentation:**
- Slash Commands: https://docs.claude.com/en/docs/claude-code/slash-commands
- Skills: https://docs.claude.com/en/docs/claude-code/skills
- Hooks: https://docs.claude.com/en/docs/claude-code/hooks
- Subagenten: https://docs.claude.com/en/docs/claude-code/sub-agents

**Community Resources:**
- Awesome Claude Code: https://github.com/hesreallyhim/awesome-claude-code
- Claude Command Suite: https://github.com/qdhenry/Claude-Command-Suite
- Subagents Collection: https://github.com/davepoon/claude-code-subagents-collection

**Blog Posts:**
- Claude Code Best Practices: https://www.anthropic.com/engineering/claude-code-best-practices
- Hooks Guide: https://blog.gitbutler.com/automate-your-ai-workflows-with-claude-code-hooks

---

**🎉 Tool-Interaktionen Dokumentation - Ready to Use!**

[Zurück zur Hauptdokumentation](README.md) | [Claude Code](CLAUDE_CODE.md) | [Workflows](WORKFLOWS.md)
