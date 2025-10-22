# CLAUDE DESKTOP - Vollständige Dokumentation

**Stand:** 22. Oktober 2025
**Version:** 3.0

Teil der [Claude Ecosystem Dokumentation](README.md)

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

---

#### Skills API (`/v1/skills`) - Programmatische Verwaltung

**NEU: Oktober 16, 2025 - Beta**

Das Skills API ermöglicht programmatische Verwaltung von Skills über die Claude API. Announced am 16. Oktober 2025, ist es aktuell in Beta.

**Status:**
- 🧪 **Beta** - Erfordert Beta-Header
- 📅 **Announced:** 16. Oktober 2025
- 🔑 **Beta-Header:** `anthropic-beta: skills-2025-10-02`

**Verfügbarkeit:**
- Pro, Max, Team, Enterprise Plans
- Erfordert Code Execution aktiviert
- API-Key erforderlich

**Features:**
- ✅ **POST /v1/skills** - Skills erstellen und hochladen
- ✅ **GET /v1/skills** - Alle verfügbaren Skills auflisten
- ✅ **Multipart Upload** - Files und Metadata hochladen
- ✅ **Versionierung** - Pin specific versions oder nutze "latest"
- ✅ **Messages API Integration** - Bis zu 8 Skills per Request

**API-Beispiele:**

```bash
# Skill erstellen via cURL
curl -X POST "https://api.anthropic.com/v1/skills" \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "anthropic-beta: skills-2025-10-02" \
  -F "display_title=My Excel Skill" \
  -F "files[]=@excel-skill/SKILL.md;filename=excel-skill/SKILL.md" \
  -F "files[]=@excel-skill/process_excel.py;filename=excel-skill/process_excel.py"
```

```python
import anthropic

client = anthropic.Anthropic(api_key="your-key")

# Skills in Messages API nutzen
response = client.messages.create(
    model="claude-sonnet-4-5",
    extra_headers={
        "anthropic-beta": "skills-2025-10-02"
    },
    messages=[...],
    # Container parameter für Skills
    # (Bis zu 8 Skills per Request)
)

# Skills auflisten
skills_response = client.skills.list()
# Unterstützt sowohl Anthropic-managed als auch custom skills
```

**Versionierungs-Workflow:**
```python
# Version 1 erstellen
v1 = client.skills.create(
    name="data-analyzer",
    content=v1_content
)

# Version 2 (Update)
v2 = client.skills.update(
    skill_id=v1.id,
    version="v2",
    content=v2_content
)

# A/B Testing
# 50% User bekommen v1, 50% v2
# Nach Evaluation:
if v2_performance > v1_performance:
    client.skills.set_default(skill_id=v1.id, version="v2")
else:
    client.skills.rollback(skill_id=v1.id, to_version="v1")
```

**Use Cases:**
- ✅ **CI/CD Integration** - Skills automatisch deployen
- ✅ **Team Distribution** - Skills per Script verteilen
- ✅ **Version Management** - Systematisches Versions-Tracking
- ✅ **Automated Testing** - Skills programmatisch testen

---

#### Skill-Creator Skill - Interaktive Skill-Erstellung

**NEU:** Guided Skill Creation direkt in Claude

Der Skill-Creator ist ein Meta-Skill, der dabei hilft, neue Skills interaktiv zu erstellen. Claude führt durch den Prozess und generiert die notwendige Struktur.

**Wie es funktioniert:**

```
User: "Create a skill for Stripe API integration"

Claude (mit skill-creator):
1. Stellt Fragen zum Workflow:
   - "Welche Stripe-Operationen sollen unterstützt werden?"
   - "Welche Daten werden typischerweise benötigt?"
   - "Gibt es spezielle Error-Handling-Anforderungen?"

2. Generiert Folder-Struktur:
   stripe-integration/
   ├── SKILL.md (mit allen Instructions)
   ├── reference.md (Stripe API Referenzen)
   └── examples/ (Beispiel-Workflows)

3. Formatiert SKILL.md korrekt:
   - YAML Frontmatter mit name & description
   - Strukturierte Instructions
   - Beispiele und Best Practices
   - Error-Handling Guidelines

4. Bündelt notwendige Resources:
   - API-Dokumentation
   - Code-Templates
   - Test-Cases
```

**Aktivierung:**
Der Skill-Creator Skill ist als Pre-built Skill in Claude.ai/Desktop verfügbar (für Pro+). Einfach anfragen: "Help me create a skill for [use case]"

**Output:**
- Vollständig formatiertes Skill-Package
- Bereit für Upload via Settings oder API
- Inkl. Dokumentation und Beispielen

**Beispiel-Dialog:**
```
User: "I need a skill for database migration workflows with Prisma"

Claude: "I'll help you create a Prisma migrations skill. Let me ask a few questions:

1. Which database are you using? (PostgreSQL, MySQL, etc.)
2. Do you need dev migrations, production migrations, or both?
3. Should the skill include rollback procedures?
4. Any specific naming conventions for migrations?"

User: "PostgreSQL, both, yes rollbacks, use descriptive names"

Claude: "Perfect! I'll create a skill with:
- Dev & production migration workflows
- Rollback procedures
- PostgreSQL-specific optimizations
- Descriptive naming guidelines

[Generiert SKILL.md mit allen Specs]

Ready to use! You can now:
1. Copy to .claude/skills/prisma-migrations/
2. Or upload via Settings > Features as ZIP
```

**Benefits:**
- 🚀 Schnellere Skill-Erstellung
- 🚀 Best Practices automatisch integriert
- 🚀 Konsistente Struktur
- 🚀 Weniger Fehler

---

#### Enterprise Skill Deployment (In Arbeit)

**Zukunft: Organisation-weite Skill-Verwaltung**

Anthropic arbeitet an Enterprise-Features für zentrale Skill-Verwaltung.

**Geplante Features:**
- ✅ **Simplified Skill Creation Workflows** - Einfachere Erstellung für Admins
- ✅ **Enterprise-wide Deployment** - Skills für gesamte Organisation deployen
- ✅ **Zentrale Distribution** - Admin deployed, alle bekommen automatisch
- ✅ **Admin-Verwaltung** - Zentrale Kontrolle über Skills
- ✅ **Permissions Management** - Wer darf welche Skills nutzen
- ✅ **Audit Logging** - Tracking von Skill-Usage
- ✅ **Compliance Controls** - Sicherstellen dass Skills Richtlinien folgen

**Aktueller Stand (Oktober 2025):**
- ⚠️ Skills sind individuell pro Nutzer, NICHT org-weit
- ⚠️ Keine zentrale Admin-Verwaltung
- ⚠️ Jeder User muss Skills selbst hochladen

**Workarounds bis Enterprise-Features verfügbar:**

**1. Skills API + Automation:**
```python
# Script für Team-Distribution
import anthropic

def deploy_skill_to_team(team_api_keys, skill_content):
    for api_key in team_api_keys:
        client = anthropic.Anthropic(api_key=api_key)
        client.skills.create(
            name="company-standard-skill",
            content=skill_content
        )
```

**2. Git-basierte Distribution (Claude Code):**
```bash
# Team-Repository mit .claude/skills/
# Alle clonen → Alle haben Skills
git clone company/claude-skills
cd claude-skills
# Skills sind in .claude/skills/ verfügbar
```

**3. Dokumentation + Self-Service:**
- Confluence-Page mit Skill-ZIP-Files
- Anleitung für Upload
- Team lädt selbst hoch

**Empfehlung:**
Für jetzt Skills API nutzen für programmatische Distribution. Sobald Enterprise-Features verfügbar sind, auf zentrale Verwaltung migrieren.

---

**Best Practices für Custom Skills:**
- ✅ Klare, spezifische Beschreibungen für Discovery
- ✅ Domain-Expertise in SKILL.md dokumentieren
- ✅ Beispiele und Best Practices inkludieren
- ✅ Skills für wiederkehrende Aufgaben erstellen
- ✅ Skills API nutzen für Team-Distribution
- ✅ Versionierung für Updates verwenden
- ✅ Box Integration für Content-Management


### F) WEITERE FEATURES & UPDATES (OKTOBER 2025)

#### "Imagine with Claude" (Temporäres Research Preview - BEENDET)

**⚠️ WICHTIG: Dieses Feature war temporär und ist derzeit nicht verfügbar**

"Imagine with Claude" war ein Research Preview Feature für Real-time Software Generation, das vom **29. September bis 11. Oktober 2025** verfügbar war.

**Zeitraum:**
- **Start:** 29. September 2025
- **Ursprüngliches Ende:** 4. Oktober 2025 (5 Tage)
- **Verlängert bis:** 11. Oktober 2025
- **Aktueller Status:** ❌ Beendet
- **Zukunft:** ❓ Unklar - Anthropic hat nicht bestätigt ob/wann es zurückkommt

**Was es war:**
- **Temporäres Research Preview** - Experimentelles 2-Wochen-Fenster
- **Real-time UI Generation** - Software wurde in Echtzeit generiert
- **Powered by "Heli"** - Internes Agent-System speziell für Interface-Generation
- **Visuelles Interface** - Desktop-ähnlich mit "What do you want to build?" Prompt
- **Keine Templates** - Alles wurde live von Claude Sonnet 4.5 generiert
- **Max & Pro Users** - Initial Max-only, dann auf Pro erweitert

**Use Cases (während aktiv):**
- 🚀 **Rapid Prototyping** - Schnelle Proof-of-Concepts
- 🎨 **UI/UX Exploration** - Interaktive Design-Iterationen
- 💡 **Interactive Design Sessions** - Live-Entwicklung mit Stakeholdern
- 👥 **Live Client Demos** - Real-time Visualisierung von Ideen
- 🔄 **Iterative Refinement** - Sofortiges Feedback und Anpassungen

**Beispiel (was möglich war):**
```
User: "Create a mood detection app for Samsung S23 with camera access"

Imagine with Claude:
- Generierte App-Interface piece by piece
- Kamera-Viewfinder erschien live
- Detection Overlay wurde hinzugefügt
- Mood Indicators in Real-time
- Komplett funktionale App in Minuten
```

**Technologie:**
- **Keine IDE, keine Templates** - Alles von Grund auf
- **Claude Sonnet 4.5** - Live Code-Generation
- **"Heli" Agent System** - Spezialisiertes System für UI-Generation
- **Interaktiv** - Änderungen in Real-time während Development

**Aktueller Status (Oktober 2025):**
- ❌ **Nicht mehr verfügbar** - Research Preview endete am 11. Oktober 2025
- 📊 **Feedback-Phase** - Anthropic sammelt Nutzerfeedback aus dem Experiment
- 🔮 **Mögliche Zukunft** - Könnte dauerhaftes Feature werden, aber unbestätigt

**Was Anthropic sagte:**
> "This is a temporary research preview... Anthropic hasn't said whether this will come back, become a permanent feature, or evolve into something else entirely."

**Aktuelle Alternativen:**
Für schnelles UI-Prototyping nutze:
- ✅ **Artifacts** in Claude.ai - Interaktive Code-Prototypen
- ✅ **Claude Code** mit VS Code Extension - Production-ready Development
- ✅ **Claude Sonnet 4.5** mit Extended Thinking - Komplexe UI-Generation

---

#### Claude for Chrome Extension

**Computer Use Capabilities für Max Users**

Claude for Chrome ist die Browser-Extension mit Computer Use Capabilities, jetzt verfügbar für Max Users.

**Features:**
- 🌐 **Browser Navigation** - Autonome Web-Navigation
- 📝 **Form Filling** - Automatisches Ausfüllen von Formularen
- 📊 **Spreadsheet Operations** - Daten in Sheets eintragen
- 🔄 **Multi-Step Workflows** - Komplexe Browser-Aufgaben

**Demo-Capabilities:**
- Navigieren auf Websites
- Informationen extrahieren
- Formulare intelligent ausfüllen
- Daten zwischen Tabs/Apps bewegen
- Multi-Step Workflows ausführen

**Performance:**
- **Powered by:** Claude Sonnet 4.5
- **61.4%** auf OSWorld (Real-World Computer Tasks)
- **19 Prozentpunkte Verbesserung** vs. Sonnet 4

**Verfügbarkeit:**
- ✅ Claude Max Plan erforderlich
- ✅ Automatic Rollout an Waitlist-User (abgeschlossen)
- ✅ Jetzt allgemein für Max Users verfügbar

---

#### Claude Agent SDK (Rebranding)

**Früher "Claude Code SDK"**

- Neuer Name für klarere Positionierung
- General-purpose Agent Building Tool
- Nicht nur für Coding, für diverse Tasks
- TypeScript & Python Support

---

#### Verfügbare Modelle (Update)

- **Claude Sonnet 4.5** (Default) - 77.2% SWE-bench
- **Claude Opus 4.1** (Komplexeste Tasks)
- **Claude Haiku 4.5** (Schnellstes Model)

---

#### Consumer Terms Update

**Opt-in Model Training (Free/Pro/Max Accounts)**

- Opt-in für Model Training Data
- 5-Jahres Data Retention (vs. 30 Tage bei Opt-out)
- Jederzeit änderbar in Privacy Settings
- Nur neue/resumed Chats betroffen



### G) URSPRÜNGLICHE WEITERE FEATURES

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

