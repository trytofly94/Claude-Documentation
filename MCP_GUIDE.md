# MODEL CONTEXT PROTOCOL (MCP) - Vollständiger Guide

**Stand:** 22. Oktober 2025
**Version:** 3.0

Teil der [Claude Ecosystem Dokumentation](README.md)

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

