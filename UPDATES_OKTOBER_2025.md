# WICHTIGE UPDATES & ERGÄNZUNGEN
## Claude Code, Desktop & MCP Ecosystem - Oktober 2025

**Stand:** 22. Oktober 2025
**Quelle:** Offizielle Anthropic-Dokumentation und Ankündigungen

---

## 🆕 CLAUDE CODE 2.0 (SEPTEMBER 2025)

### Wichtigster Release seit Launch

Claude Code 2.0 wurde am 29. September 2025 veröffentlicht und bringt die größten Updates seit dem Launch. Powered by **Claude Sonnet 4.5**, kann Claude Code jetzt **30+ Stunden autonomes Coding** durchführen.

---

### 1. VS CODE EXTENSION (BETA)

**Neu verfügbar:** Native VS Code Extension seit September 2025

**Features:**
- **Sidebar Panel**: Claude Code direkt in VS Code Sidebar integriert
- **Real-time Inline Diffs**: Code-Änderungen in Echtzeit sehen
- **Inline Diff View**: Änderungen direkt im Editor reviewen
- **Plan Mode**: Claude plant Tasks bevor Ausführung
- **Auto-Accept Feature**: Automatisches Akzeptieren von Edits
- **Grafisches Interface**: Für Entwickler die GUI über Terminal bevorzugen

**Kompatibilität:**
- Visual Studio Code
- Cursor
- Windsurf
- VSCodium

**Installation:**
```bash
# Via VS Code Extension Marketplace
# Suche nach "Claude Code" von Anthropic
```

**Unterschied zum Legacy CLI-Integration:**
- **Extension**: Native Integration, Sidebar, grafisches Interface
- **Legacy CLI**: Terminal-basiert, für Terminal-Präferenz-Nutzer

**Wichtig:** Die Extension fungiert primär als Launcher - die volle Power von Claude Code bleibt erhalten.

---

### 2. CHECKPOINTS SYSTEM (TOP-REQUESTED FEATURE!)

**Was sind Checkpoints?**
Automatisches Speichern von Code-State UND Konversations-Context vor jeder Änderung.

**Key Features:**
- ✅ **Automatisch**: Neuer Checkpoint bei jedem User-Prompt
- ✅ **30-Tage Retention**: Checkpoints bleiben 30 Tage erhalten
- ✅ **Session-Persistence**: Über resumed Conversations hinweg verfügbar
- ✅ **Konfigurierbar**: Cleanup-Perioden anpassbar

**Wie nutzen:**
```bash
# Methode 1: ESC zweimal drücken
ESC ESC

# Methode 2: /rewind Command
/rewind
```

**Drei Restore-Modi:**

1. **Chat only (Conversation only)**
   - Rewind chat history
   - Code-Änderungen bleiben erhalten
   - Use Case: Falscher Prompt, Code ist ok

2. **Code only**
   - Revert file modifications
   - Konversation bleibt erhalten
   - Use Case: Code-Änderung war falsch, Kontext behalten

3. **Both (Complete Restoration)**
   - Komplette Wiederherstellung zu vorherigem State
   - Code UND Konversation zurücksetzen
   - Use Case: Alles zurücksetzen

**Wichtige Constraints:**
- ❌ Gilt NUR für Claude's Edits
- ❌ NICHT für User's direkte Edits
- ❌ NICHT für Bash Commands
- ⚠️ **Empfehlung**: Zusätzlich Git verwenden
- ⚠️ **Kein Ersatz** für persistente Version Control
- ✅ **Zweck**: Session-level Recovery und "Entgiften" von falsch gelaufenen Konversationen

**Workflow-Beispiel:**
```bash
claude
> "Refactor the authentication system"
# Claude macht Änderungen
> ESC ESC  # Falls Fehler
> "Try a different approach for JWT validation"
# Claude startet von sauberem State
```

**Kombination mit anderen Features:**
- **+ Subagents**: Parallele Entwicklung mit Checkpoints als Safety Net
- **+ Hooks**: Auto-Tests nach Changes, bei Fail → Checkpoint zurück
- **+ Background Tasks**: Long-running Processes, Checkpoints bei wichtigen Schritten

---

### 3. TERMINAL INTERFACE V2.0

**Visual Refresh:**
- Moderneres, übersichtlicheres UI
- Verbesserte Status-Anzeige
- **~3x schnellere Response** (laut User-Feedback)
- Reduzierte Lag-Issues

**Searchable Prompt History (CTRL+R):**
```bash
# Im interaktiven Modus:
Ctrl+R

# Durchsuche bisherige Prompts
# Enter zum Wiederverwenden
# Editierbar vor Submit
```

**Neue Commands:**

```bash
# Usage-Statistiken anzeigen
/usage

# Model wechseln
/model

# Checkpoint wiederherstellen
/rewind

# Thinking Mode togglern (NEU!)
Tab
```

---

### 4. TAB TO TOGGLE THINKING

**Neu:** Tab-Taste für Extended Thinking

**Wie es funktioniert:**
```bash
claude
> "Complex task"
Tab  # Aktiviert Extended Thinking für diesen Prompt
```

**Wichtige Änderung:**
- ⚠️ **Alte Thinking Keywords entfernt**: "think hard" funktioniert nicht mehr
- ✅ **Neue Methode**: Explizite Tab-Interaktion
- ⚠️ **Exception**: "ultrathink" bleibt aus sentimentalen Gründen 🥹
  - `ultrathink` aktiviert weiterhin max thinking budget

**Best Practice:**
- Für einfache Tasks: Kein Tab
- Für komplexe Architektur/Reasoning: Tab drücken
- Für maximales Thinking: Prompt mit "ultrathink" prefixen

---

### 5. BACKGROUND TASKS

**Neu:** Long-running Processes im Hintergrund

**Use Cases:**
- Dev-Server laufen lassen ohne Claude Code zu blockieren
- Watch-Prozesse (file watchers)
- Build-Prozesse
- Test-Runner im Watch-Mode

**Beispiel:**
```bash
claude
> "Start the dev server in background and then refactor the API"
# Dev-Server läuft weiter
# Claude kann parallel am Code arbeiten
```

**Kombination mit Hooks:**
```json
{
  "hooks": {
    "sessionStart": [
      {
        "type": "command",
        "command": "npm run dev &",
        "background": true
      }
    ]
  }
}
```

---

### 6. CLAUDE SONNET 4.5 ALS DEFAULT

**Wichtig:** Sonnet 4.5 ist jetzt das Default-Model!

**Performance:**
- **77.2%** auf SWE-bench Verified (nicht 76%)
- **61.4%** auf OSWorld (Computer Use) - Vorher: 42.2%
- **30+ Stunden** autonomes Coding ohne Context-Loss
- **Best coding model in the world** (Stand Oktober 2025)

**Verfügbare Modelle (Update):**
```bash
# Model wechseln
/model

# Verfügbare Modelle:
- Claude Sonnet 4.5 (Default, empfohlen)
- Claude Opus 4.1 (nicht nur 4!)
- Claude Haiku 4.5 (nicht 3.5!)
```

**Pricing (unverändert):**
- $3 per million input tokens
- $15 per million output tokens

---

### 7. VS CODE EXTENSION SETUP

**Installation:**

1. **Via Marketplace:**
   - VS Code öffnen
   - Extensions (Cmd+Shift+X)
   - "Claude Code" suchen
   - Von Anthropic installieren

2. **Erste Nutzung:**
   ```bash
   # Login erforderlich (beim ersten Start)
   # Claude.ai oder Claude Console Account
   ```

3. **Sidebar:**
   - Claude Code Icon in Sidebar erscheint
   - Click um Panel zu öffnen
   - Chat-Interface wie im Terminal

**Features im Detail:**

**A) Inline Diffs:**
- Code-Änderungen als Diff im Editor
- Accept/Reject für jede Änderung
- Multi-file Changes übersichtlich

**B) Plan Mode:**
- Claude zeigt Plan vor Execution
- User kann genehmigen oder anpassen
- Verhindert unerwünschte Änderungen

**C) Auto-Accept:**
- Optional: Automatisches Akzeptieren
- Für vertrauenswürdige Tasks
- Aktivierbar in Extension Settings

**D) Real-time Feedback:**
- Live-Anzeige der Arbeit
- Welche Dateien werden geändert
- Welche Commands laufen

**Wichtige Warnung (Security):**
⚠️ Wenn Claude Code in VS Code mit auto-edit permissions läuft, kann es IDE-Config-Dateien modifizieren, die automatisch vom IDE ausgeführt werden können. Dies erhöht das Risiko im auto-edit Mode und kann Claude Code's Permission-Prompts für Bash-Execution umgehen.

**Best Practice:**
- Keine auto-edit permissions für sensible Projekte
- Permissions in .claude/settings.json granular definieren
- Deny-Liste für kritische Config-Files

---

### 8. LEGACY CLI INTEGRATION (Weiterhin verfügbar)

Für Terminal-Präferenz-Nutzer bleibt die CLI-Integration bestehen:

**Features:**
- Selection Context Sharing
- Diff Viewing im IDE statt Terminal
- File Reference Shortcuts
- Automatic Diagnostic Sharing

**Kompatibel mit:**
- Visual Studio Code
- Cursor
- Windsurf
- VSCodium

**Wann nutzen:**
- Bevorzugung von Terminal-Workflows
- Verbindung von externen Terminals
- SSH/Remote Development

---

## 🔒 SECURITY FEATURES (NEU)

### /security-review Command

**Neu verfügbar:** Automatische Security-Reviews

```bash
claude
> /security-review

# Oder spezifisch:
> /security-review src/auth/
```

**Was wird geprüft:**
- SQL Injection Vulnerabilities
- Cross-Site Scripting (XSS)
- Authentication Flaws
- Authorization Issues
- Hardcoded Secrets
- Insecure Dependencies

**Output:**
- Inline Comments in Code
- Severity Levels (Critical, High, Medium, Low)
- Fix Recommendations
- Security Best Practices

### GitHub Actions Integration

**Automatische PR-Reviews:**

```yaml
# .github/workflows/claude-security.yml
name: Claude Security Review

on:
  pull_request:
    branches: [ main, develop ]

jobs:
  security-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Claude Security Review
        uses: anthropic/claude-security-action@v1
        with:
          api-key: ${{ secrets.CLAUDE_API_KEY }}
```

**Features:**
- Automatische Review vor Production
- Inline PR Comments
- Fix Recommendations
- Blocks Merge bei Critical Issues (optional)

---

## 🎨 "IMAGINE WITH CLAUDE" (RESEARCH PREVIEW)

**Neu für Max Users:** Real-time Software Generation

**Was ist es:**
- Research Preview neben Sonnet 4.5
- Generiert Software in Echtzeit
- Visuelles Interface
- Für Max-Plan Subscribers

**Use Cases:**
- Rapid Prototyping
- UI/UX Exploration
- Interactive Design Sessions
- Live Client Demos

**Verfügbarkeit:**
- Nur Claude Max Plan
- Waitlist war im letzten Monat (September 2025)
- Rollout läuft

**Hinweis:** Details limitiert, da Research Preview

---

## 📊 API UPDATES (CLAUDE DEVELOPER PLATFORM)

### Context Editing Feature

**Neu:** Automatisches Bereinigen veralteter Informationen

**Wie es funktioniert:**
- Context Window Management
- Auto-Cleanup von outdated Info
- Behält relevanten Context
- Ermöglicht längere Tasks

**API-Usage:**
```python
# Context Editing aktivieren
response = client.messages.create(
    model="claude-sonnet-4-5",
    messages=[...],
    context_editing=True  # NEU
)
```

### Memory Tool

**Neu:** Persistentes Memory über Context-Window hinaus

**Features:**
- Speichert Informationen langfristig
- Über multiple Sessions hinweg
- Strukturiertes Knowledge Management
- API-gesteuert

**Use Cases:**
- Long-running Projects
- Persistent User Preferences
- Historical Context für Agents

**API-Usage:**
```python
# Memory Tool nutzen
response = client.messages.create(
    model="claude-sonnet-4-5",
    messages=[...],
    tools=[
        {
            "type": "memory",
            "name": "project_memory"
        }
    ]
)
```

---

## 🛠️ SKILLS UPDATES

### /v1/skills API Endpoint (NEU!)

**Programmatische Skill-Verwaltung:**

```python
import anthropic

client = anthropic.Anthropic(api_key="your-key")

# Skill erstellen
skill = client.skills.create(
    name="Custom Analysis",
    description="Domain-specific analysis skill",
    content=skill_content
)

# Skill auflisten
skills = client.skills.list()

# Skill updaten
client.skills.update(
    skill_id="skill_123",
    version="v2"
)

# Skill löschen
client.skills.delete(skill_id="skill_123")
```

**Versionierung:**
- Skills können versioniert werden
- Rollback zu vorherigen Versionen
- A/B Testing von Skill-Versionen

### Skill-Creator Skill

**Interaktive Skill-Erstellung:**

```bash
claude
> "Create a skill for Stripe API integration"

# Claude (mit skill-creator):
# - Stellt Fragen zum Workflow
# - Generiert Folder-Struktur
# - Formatiert SKILL.md
# - Bündelt notwendige Resources
```

### Box Integration Skills (NEU)

**Offizielle Box-Skills:**
- Read/Write Box Content
- Transform Files zu PPTX/XLSX/DOCX
- Organisation Standards einhalten
- Spart Stunden manueller Arbeit

**Installation:**
```bash
# Via Claude Code
claude mcp add --transport http box https://mcp.box.com/mcp

# Oder in claude_desktop_config.json
{
  "mcpServers": {
    "box": {
      "command": "npx",
      "args": ["-y", "@box/mcp-server"],
      "env": {
        "BOX_ACCESS_TOKEN": "${BOX_TOKEN}"
      }
    }
  }
}
```

### Enterprise Skill Deployment

**In Arbeit:**
- Simplified Skill Creation Workflows
- Enterprise-wide Deployment Capabilities
- Zentrale Distribution über Teams
- Admin-Verwaltung von Skills

**Aktueller Stand:** Skills sind individuell pro Nutzer, NICHT org-weit

---

## 🧠 CLAUDE AGENT SDK UPDATES

### Rebranding & Expansion

**Wichtig:** "Claude Code SDK" ist jetzt "Claude Agent SDK"

**Grund:**
- Klarere Positionierung
- Nicht nur für Coding
- General-purpose Agent Building Tool
- Für diverse Tasks beyond Coding

### Neue Capabilities

**Subagents Support:**
```typescript
import { Agent, Subagent } from '@anthropic-ai/claude-agent-sdk';

const mainAgent = new Agent({
  model: 'claude-sonnet-4-5'
});

// Subagent definieren
const codeReviewer = new Subagent({
  name: 'code-reviewer',
  description: 'Reviews code for quality and security',
  tools: ['Read', 'Grep'],
  model: 'sonnet'
});

// Subagent nutzen
mainAgent.delegate(codeReviewer, {
  task: 'Review the authentication module'
});
```

**Hooks Support:**
```typescript
const agent = new Agent({
  hooks: {
    afterWrite: {
      '**/*.py': 'black $FILE',
      '**/*.ts': 'prettier --write $FILE'
    },
    beforeBash: {
      'rm -rf*': 'exit 1'  // Blockiere gefährliche Commands
    }
  }
});
```

### Use Cases (Erfolgreiche Implementations)

**Bereits gebaut:**
- Financial Compliance Agents
- Cybersecurity Agents
- Code Debugging Agents
- Custom Workflow Agents

**Key Insight:** Same Infrastructure wie Claude Code, aber für beliebige Tasks

---

## 🌐 CLAUDE FOR CHROME EXTENSION

**Jetzt verfügbar für Max Users** (war Waitlist im September)

**Features:**
- Computer Use Capabilities
- Browser Navigation
- Spreadsheet Filling
- Task Completion in Browser

**Demo-Capabilities:**
- Navigieren auf Websites
- Formulare ausfüllen
- Daten in Spreadsheets eintragen
- Multi-Step Workflows

**Performance:**
- Powered by Sonnet 4.5
- 61.4% auf OSWorld (Real-World Computer Tasks)
- 19 Prozentpunkte Verbesserung vs. Sonnet 4

**Zugang:**
- Claude Max Plan erforderlich
- Automatic Rollout an Waitlist-User

---

## 📜 CONSUMER TERMS & PRIVACY UPDATE (OKTOBER 2025)

### Wichtige Policy-Änderungen

**Rollout:** Ab Oktober 2025

**Deadline für bestehende User:** 8. Oktober 2025 (**bereits abgelaufen**)

### Opt-In Model Training

**Neu:**
- User können wählen: Data für Model Training erlauben
- **Gilt für:** Free, Pro, Max Accounts
- **Gilt auch für:** Claude Code Sessions!

**Wenn Opt-In:**
- ✅ Daten werden für Model Training verwendet
- ✅ **5-Jahres Data Retention** (statt 30 Tage)
- ✅ Gilt nur für neue oder resumed Chats/Sessions
- ✅ Alte Chats ohne weitere Aktivität: NICHT betroffen

**Wenn Opt-Out:**
- ❌ Keine Daten für Training
- ✅ Standard 30-Tage Retention bleibt
- ✅ Weiterhin voller Service

### Control & Transparency

**User hat Kontrolle:**
- Jederzeit änderbar in Privacy Settings
- Einzelne Chats löschbar → aus Training excluded
- Account löschen → alle Daten aus Training
- Nur neue/resumed Sessions betroffen

**Zweck der Extended Retention:**
- Verbesserte Classifier für Misuse-Detection
- Safety Systems lernen aus längeren Zeiträumen
- Bessere Erkennung von Abuse/Spam/Misuse

### Wie Settings ändern

**Neue User:** Während Signup-Prozess

**Bestehende User:** 
- In-App Notification erhalten
- Privacy Settings → Model Training
- Sofort wirksam nach Änderung

**Wichtig:** Team/Enterprise Accounts nicht betroffen (separate Policies)

---

## 🆕 WEITERE KLEINERE UPDATES

### Verfügbare Modelle (Aktualisiert)

**In Claude Code / API:**
- Claude Sonnet 4.5 (Default)
- Claude Opus 4.1 (Update: nicht nur 4)
- Claude Haiku 4.5 (Update: nicht 3.5)

**In Claude Apps:**
- Alle obigen + Extended Thinking optional

### Claude in GitHub Copilot

**Neu:** Sonnet 4.5 in GitHub Copilot Public Test

**Verfügbarkeit:**
- Pro und höhere Plans
- Chat, Edit, Agent Modes
- Alle unterstützten IDEs

**Aktivierung:**
- **Business/Enterprise**: Admin opt-in in Copilot Settings
- **Individual Plans**: In Model Picker auswählen + one-time prompt

### "Code with Claude" Conference

**Ankündigung:** Erste Developer Conference

**Details:**
- **Datum:** 22. Mai 2025
- **Ort:** San Francisco, The Midway
- **Format:** Hands-on Event
- **Themen:** 
  - Real-world Implementations
  - Anthropic API
  - CLI Tools
  - Model Context Protocol (MCP)
  - Interactive Workshops
  - Product Roadmap
  - Networking

---

## 📚 DOKUMENTATION & RESOURCES

### Wichtige Links (Aktualisiert)

**Claude Code:**
- Docs: https://docs.claude.com/en/docs/claude-code
- Release Notes: https://docs.claude.com/en/release-notes/claude-code
- VS Code Extension: VS Code Marketplace
- Checkpointing Guide: https://docs.claude.com/en/docs/claude-code/checkpointing

**Claude Agent SDK:**
- Docs: https://docs.claude.com/en/docs/claude-agent-sdk
- Migration Guide: claude-code → claude-agent-sdk

**Skills:**
- Skills Docs: https://docs.claude.com/en/docs/skills
- Anthropic Academy: Skills Creation
- Example Skills: GitHub anthropics/skills

**MCP:**
- MCP Website: https://modelcontextprotocol.io
- MCP Spec: https://spec.modelcontextprotocol.io
- Server Registry: GitHub modelcontextprotocol/servers

**Support:**
- General Support: https://support.claude.com
- API/Developer: https://docs.claude.com
- Community: GitHub Discussions

---

## 🚨 BREAKING CHANGES & DEPRECATIONS

### Thinking Keywords

**Deprecated:** "think hard" und ähnliche Keywords

**Grund:** Zu implizit, nicht konsistent

**Neu:** Tab to Toggle Thinking (explizit)

**Exception:** "ultrathink" bleibt (sentimental reasons)

**Migration:**
```bash
# Alt (funktioniert nicht mehr):
> "think hard about this problem"

# Neu:
Tab + "analyze this problem"

# Oder für max thinking:
> "ultrathink: analyze this complex system"
```

### Claude Code SDK → Claude Agent SDK

**Rebranding:** Package-Name geändert

**Migration:**
```bash
# Alt:
npm install @anthropic-ai/claude-code

# Neu:
npm install @anthropic-ai/claude-agent-sdk
```

**Import-Änderungen:**
```typescript
// Alt:
import { ClaudeCode } from '@anthropic-ai/claude-code';

// Neu:
import { Agent } from '@anthropic-ai/claude-agent-sdk';
```

**Migration Guide:** https://docs.claude.com/en/docs/claude-agent-sdk/migration

---

## 🎯 BEST PRACTICES UPDATE

### Mit Checkpoints arbeiten

**Pattern 1: Experimental Changes**
```bash
claude
> "Let me try refactoring the auth module"
# Checkpoint erstellt automatisch
# Falls nicht zufrieden:
ESC ESC
> "Try a different approach using middleware pattern"
```

**Pattern 2: Multi-Step Tasks**
```bash
> "Step 1: Extract interfaces"
# Review Result
> "Step 2: Implement concrete classes"
# Review Result
# Falls Step 2 falsch:
/rewind
> "Step 2: Use composition instead"
```

**Pattern 3: Safeguarded Autonomy**
```bash
# In settings.json:
{
  "hooks": {
    "afterWrite": {
      "**/*.ts": "npm run typecheck && npm test"
    }
  }
}

# Dann:
> "Refactor the entire API layer"
# Claude arbeitet autonom
# Bei Test-Failure: Automatisch /rewind + fix
```

### VS Code Extension effektiv nutzen

**Best Practice 1: Plan Mode für große Changes**
```
1. Großen Task geben
2. Claude zeigt Plan
3. Plan reviewen und genehmigen
4. Claude führt aus mit Checkpoints
5. Review in Inline Diffs
```

**Best Practice 2: Auto-Accept für vertrauenswürdige Tasks**
```
- Enable Auto-Accept in Settings
- Nur für:
  - Dokumentation
  - Tests schreiben
  - Refactorings in isolierten Modulen
- Nie für:
  - Production-kritischer Code
  - Auth/Security Code
  - Database Migrations
```

**Best Practice 3: Background Tasks + Checkpoints**
```bash
> "Start dev server in background"
> "Now refactor the API with extensive changes"
# Dev Server läuft weiter
# Checkpoints bei jedem Schritt
# Bei Problemen: /rewind + Server läuft noch
```

---

## 🔮 AUSBLICK & ROADMAP

### Kommende Features (Angekündigt)

**Skills:**
- Simplified Skill Creation Workflows
- Enterprise-wide Deployment
- Zentrale Admin-Verwaltung
- Team-weite Skill-Distribution

**VS Code Extension:**
- Weitere IDE-Integrations (JetBrains erwähnt)
- Mehr Inline-Features
- Extension Commands API (von Community gewünscht)

**MCP:**
- Mehr offizielle MCP-Server
- Verbesserte Discovery
- Better Tooling für Server-Entwicklung

**Autonomie:**
- Längere autonome Sessions (>30h)
- Bessere Multi-Agent Coordination
- Advanced Memory Management

### In Arbeit

**Performance:**
- Weitere Latenz-Reduktionen
- Bessere Token-Efficiency
- Schnellere Tool-Execution

**Safety:**
- Verbesserte Classifier
- Weniger False-Positives
- Granularere Permissions

---

## 📊 ZUSAMMENFASSUNG: WAS IST NEU?

### Top 5 Updates

1. **Claude Code 2.0** mit VS Code Extension, Checkpoints, Background Tasks
2. **Claude Sonnet 4.5** als Default mit 77.2% SWE-bench und 30h+ Autonomie
3. **Security Features** mit /security-review und GitHub Actions
4. **API Updates** mit Context Editing und Memory Tool
5. **Skills API** mit /v1/skills Endpoint und programmatischer Verwaltung

### Quick Reference

```bash
# Neue Commands:
/rewind          # Checkpoint zurück
/usage           # Usage Stats
/security-review # Security Audit
Tab              # Toggle Thinking

# Model wechseln:
/model
# → Sonnet 4.5 (Default)
# → Opus 4.1
# → Haiku 4.5

# VS Code Extension:
# Installiere von Marketplace
# Nutze Sidebar Panel
# Inline Diffs für Review

# Checkpoints:
ESC ESC          # Quick rewind
/rewind          # Explicit rewind
# Drei Modi: Chat only, Code only, Both
```

---

## ✅ EMPFOHLENE AKTUALISIERUNGEN IM HAUPTDOKUMENT

Folgende Sektionen sollten im Hauptdokument **ergänzt oder aktualisiert** werden:

### SCHRITT 1 - CLAUDE CODE

**A) Kernfunktionen:**
- [ ] Claude Sonnet 4.5 als Default (nicht Sonnet 4)
- [ ] 77.2% auf SWE-bench (Update)
- [ ] 30+ Stunden autonomes Coding
- [ ] Neue Commands: /usage, /rewind, Tab for thinking

**B) .claude Ordner:**
- [x] Bereits gut dokumentiert - keine Änderungen

**Neu zu ergänzen:**

**F) CLAUDE CODE 2.0 FEATURES (NEU):**
- [ ] VS Code Extension (kompletter Abschnitt)
- [ ] Checkpoints System (kompletter Abschnitt)
- [ ] Background Tasks (kompletter Abschnitt)
- [ ] Terminal v2.0 Updates
- [ ] Tab to Toggle Thinking

**G) Security Features (NEU):**
- [ ] /security-review Command
- [ ] GitHub Actions Integration

### SCHRITT 2 - CLAUDE DESKTOP

**G) Weitere Features:**
- [ ] Claude for Chrome Extension (Update: Jetzt für Max verfügbar)
- [ ] "Imagine with Claude" Research Preview (NEU)

### SCHRITT 3 - MCP

**C) Verfügbare MCP-Server:**
- [ ] Box Integration (NEU)

### SCHRITT 5 - INTERAKTIONEN

**C) Kombinierte Nutzung:**
- [ ] VS Code Extension Workflows (NEU)
- [ ] Checkpoint-basierte Workflows (NEU)

### SCHRITT 6 - PRAKTISCHE ASPEKTE

**A) Installation & Setup:**
- [ ] VS Code Extension Setup (NEU)

**C) Troubleshooting:**
- [ ] Checkpoint-Issues (NEU)
- [ ] VS Code Extension Problems (NEU)

---

## 📝 HINWEISE ZUR INTEGRATION

**Vorgehen:**

1. **Hauptdokument strukturell beibehalten**
   - Bewährte Struktur funktioniert gut
   - Nur ergänzen, nicht umbauen

2. **Neue Sektionen einfügen wo sinnvoll**
   - Claude Code 2.0 nach aktuellem E) Integration
   - VS Code Extension als eigener Unterabschnitt

3. **Versionsnummern aktualisieren**
   - Überall "Sonnet 4" → "Sonnet 4.5"
   - Benchmarks aktualisieren

4. **Beispiele erweitern**
   - Checkpoint-Workflows
   - VS Code Extension Usage
   - Security-Review Examples

5. **Cross-References**
   - Checkpoints mit Git-Integration verlinken
   - VS Code mit Terminal-Version vergleichen
   - Security mit Permissions verknüpfen

---

**Stand der Updates:** 22. Oktober 2025
**Nächster Review:** Nach "Code with Claude" Conference (Mai 2025)
