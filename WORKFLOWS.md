# WORKFLOWS & BEST PRACTICES

**Stand:** 22. Oktober 2025
**Version:** 3.0

Teil der [Claude Ecosystem Dokumentation](README.md)

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
