# CLAUDE CODE - TOOL SELECTION GUIDE

**Stand:** 4. November 2025
**Version:** 1.0

Teil der [Claude Ecosystem Dokumentation](README.md)

---

## 🎯 ÜBERBLICK

### Warum dieser Guide?

Mit der wachsenden Zahl an Features in Claude Code stehen Entwickler vor der Frage: **Welches Tool ist das richtige für meine Aufgabe?**

Du hast die Wahl zwischen:
- **Skills** - Automatisch aktivierte Expertisen
- **Slash Commands** - Manuelle Prompt-Templates
- **Subagenten** - Spezialisierte Mini-Agenten
- **MCP Server** - Externe Integrationen
- **Hooks** - Event-driven Automation

Alle Tools haben Überschneidungen in ihren Fähigkeiten, aber unterschiedliche Stärken und ideale Einsatzgebiete.

### Dieser Guide hilft dir:

- ✅ Die richtige Tool-Wahl für deine Aufgabe zu treffen
- ✅ Overengineering zu vermeiden
- ✅ Tools effektiv zu kombinieren
- ✅ Von einfachen zu komplexen Lösungen zu skalieren
- ✅ Anti-Patterns zu erkennen und zu vermeiden

### Die zentrale Regel: "Prompt First"

> **Fang immer mit dem einfachsten Tool an: einem Slash Command (oder direktem Prompt)**

Erst wenn du erkennst, dass du:
- 🔄 **Parallelisierung** brauchst → **Subagent**
- 🤖 **Automatische Auslösung** willst → **Skill**
- 🔌 **Externe Daten** brauchst → **MCP Server**
- ⚡ **Garantierte Automatisierung** brauchst → **Hook**

...solltest du komplexere Tools nutzen.

**Wichtig:** Dieser Guide fokussiert sich auf **WANN** welches Tool nutzen. Für die technischen Details **WIE** Tools implementiert und kombiniert werden, siehe [TOOL_INTERACTIONS.md](TOOL_INTERACTIONS.md).

---

## 📚 DIE VIER GRUNDBAUSTEINE

Bevor wir in die Tool-Auswahl einsteigen, ist es wichtig die **vier Grundbausteine** des Agentic Coding zu verstehen:

### 1. Context (Kontext)

**Was weiß Claude über dein Projekt?**

- **Dateien:** Code, Dokumentation, Tests
- **CLAUDE.md:** Projekt-Memory mit Architektur & Standards
- **MCP-Daten:** Externe Systeme (Jira, GitHub, Datenbanken)
- **Conversation History:** Vorherige Nachrichten im Chat

**⚠️ Problem: Context Window Limits!**

Jedes Modell hat ein maximales Context Window:
- **Claude Sonnet 4.5:** 200K tokens (Standard)
- **Claude Haiku 4.5:** 200K tokens
- Pro Token: ~4 Zeichen Code oder ~0.75 Wörter

Zu viel Context = Performance-Probleme und höhere Kosten!

**Best Practice:** Verwende Tools, die Context sparsam nutzen (Skills mit Progressive Disclosure).

---

### 2. Model (Modell)

**Welches Claude-Modell nutzt du?**

- **Claude Sonnet 4.5** (Standard)
  - 77.2% SWE-bench Verified
  - Beste Code-Qualität
  - $3/$15 per million tokens

- **Claude Haiku 4.5** (Schnell/Günstig)
  - 73.3% SWE-bench Verified
  - 4-5x schneller als Sonnet
  - $1/$5 per million tokens

**Wichtig:** Model-Wahl beeinflusst Performance und Kosten. Für einfache Tasks (Code-Reviews, Tests) kann Haiku ausreichen.

---

### 3. Prompt (Eingabe)

**Der fundamentale Baustein!**

> Ohne guten Prompt helfen keine Tools!

Ein guter Prompt:
- ✅ Ist spezifisch und klar
- ✅ Enthält relevanten Context
- ✅ Definiert das gewünschte Ergebnis
- ✅ Gibt Beispiele wenn sinnvoll

**Custom Prompts = Slash Commands**

Slash Commands sind nichts anderes als wiederverwendbare Prompt-Templates!

---

### 4. Tools (Werkzeuge)

**Erweitere Claude's Fähigkeiten**

**Built-in Tools:**
- Read, Write, Edit (Dateien)
- Bash (Shell-Commands)
- Grep, Glob (Suche)
- WebFetch, WebSearch (Web-Zugriff)

**Erweiterte Tools:**
- Skills, Slash Commands, Subagenten (diese Dokumentation)
- MCP Server (externe Integrationen)
- Hooks (Event-driven Automation)

**⚠️ Achtung: Tool-Overload = Context-Pollution!**

Zu viele Tools (besonders MCP Server) können das Context Window überlasten. Nutze sie gezielt!

---

## 🔧 TOOL-ÜBERSICHT (KOMPAKT)

Hier eine schnelle Übersicht aller verfügbaren Tools:

### Slash Commands

**Was:** Wiederverwendbare Prompt-Templates (Markdown-Dateien)

**Wann:** Für manuelle, wiederholbare Workflows

**Invocation:** User (manuell via `/command-name`)

**Speicherort:** `.claude/commands/` (Projekt) oder `~/.claude/commands/` (Global)

**Beispiel:** `/commit-message`, `/create-component`, `/deploy`

---

### Skills

**Was:** Automatisch aktivierte Expertisen (Progressive Disclosure)

**Wann:** Für wiederkehrende Tasks mit mehreren Schritten, die Claude selbst erkennen soll

**Invocation:** Claude (automatisch basierend auf Description)

**Speicherort:** `.claude/skills/skill-name/SKILL.md`

**Beispiel:** PDF Analyzer, Brand Guidelines Checker, Git Worktree Manager

---

### Subagenten

**Was:** Spezialisierte Mini-Agenten mit eigenen Tools und Prompts

**Wann:** Für parallele oder isolierte Workflows

**Invocation:** Claude oder User (via Slash Command)

**Speicherort:** `.claude/subagents/agent-name.md`

**Beispiel:** Security Scanner, Test Fixer, Parallel Feature Development

---

### MCP Server

**Was:** Externe Integrationen (Datenquellen, APIs)

**Wann:** Für Zugriff auf externe Systeme und Daten

**Invocation:** Claude (automatisch bei Bedarf)

**Konfiguration:** `claude_desktop_config.json` oder `.claude/settings.json`

**Beispiel:** Jira, GitHub, Google Drive, Slack, Salesforce, PostgreSQL

---

### Hooks

**Was:** Event-driven Automation (Shell-Scripts)

**Wann:** Für garantierte Automatisierung (nicht LLM-abhängig)

**Invocation:** System (bei Events wie PreToolUse, PostToolUse)

**Konfiguration:** `.claude/settings.json` → `hooks`

**Beispiel:** Auto-Formatting, Security-Checks, Pre-Commit Hooks

---

**Für technische Details zur Implementierung:** Siehe [TOOL_INTERACTIONS.md](TOOL_INTERACTIONS.md)

---

## 🌳 ENTSCHEIDUNGSBAUM

### Visueller Flowchart für Tool-Auswahl

```mermaid
graph TD
    A[Neue Aufgabe] --> B{Externe Integration nötig?}
    B -->|Ja| C[MCP Server]
    B -->|Nein| D{Muss es parallel laufen?}
    D -->|Ja| E[Subagent]
    D -->|Nein| F{Wiederkehrende Task<br/>mit mehreren Schritten?}
    F -->|Ja| G{Soll Claude automatisch<br/>entscheiden wann?}
    G -->|Ja| H[Skill]
    G -->|Nein| I[Slash Command]
    F -->|Nein| I

    C --> J[Beispiel: Jira, GitHub, DB,<br/>Google Drive, Salesforce]
    E --> K[Beispiel: Parallele Tests,<br/>Multi-Repo Tasks,<br/>Security Scans]
    H --> L[Beispiel: Style Guide,<br/>API Design, QBR,<br/>PDF Analysis]
    I --> M[Beispiel: Git Commit,<br/>UI Component, Deploy,<br/>Code Review]

    style C fill:#ff9999
    style E fill:#99ccff
    style H fill:#99ff99
    style I fill:#ffff99
```

### Erklärung der Entscheidungslogik

#### 1. Externe Integration nötig?

**Frage dich:** Brauchst du Daten oder Funktionen von außerhalb deines lokalen Projekts?

**Beispiele:**
- ✅ Jira Issues abrufen
- ✅ Salesforce Daten analysieren
- ✅ Google Drive Dokumente bearbeiten
- ✅ Datenbank-Queries ausführen
- ✅ Slack Nachrichten senden

**→ MCP Server**

**Wichtig:** Für **lokale Dateien** brauchst du **KEINEN** MCP Server! Nutze die Built-in Tools (Read, Write, Grep, Glob).

---

#### 2. Muss es parallel laufen?

**Frage dich:** Muss die Task in mehreren isolierten Kontexten gleichzeitig ausgeführt werden?

**Keywords:** "parallel", "gleichzeitig", "mehrere Repos", "batch processing"

**Beispiele:**
- ✅ 10 failing Tests gleichzeitig fixen
- ✅ Security-Scan über mehrere Repositories
- ✅ Parallele Feature-Entwicklung in Git Worktrees
- ✅ Bulk-Operations über viele Dateien

**→ Subagent**

**Vorteil:** Subagenten arbeiten isoliert und können parallel laufen. Jeder Subagent hat seinen eigenen Context.

**Nachteil:** Subagenten verlieren den Haupt-Context (Main Agent). Nicht geeignet wenn Context-Sharing nötig ist.

---

#### 3. Wiederkehrend + Mehrstufig?

**Frage dich:**
- Ist es eine Task mit **mehreren logischen Schritten**?
- Wird sie **häufig wiederholt**?

**Beispiele:**
- ✅ Component erstellen (Datei + Test + Storybook + Export)
- ✅ API Endpoint implementieren (Route + Handler + Validation + Test)
- ✅ Deployment-Prozess (Build + Test + Deploy + Verify)
- ✅ Code Review nach Team-Standards

**→ Skill ODER Slash Command** (Entscheidung in Schritt 4)

---

#### 4. Manuelle vs. Automatische Auslösung?

**Die finale Entscheidung:**

**→ Skill** wenn:
- ✅ Claude soll **selbst entscheiden** wann relevant
- ✅ Domain-Expertise kodifizieren (Legal, SEO, Brand)
- ✅ Team-Standards durchsetzen
- ✅ User erwähnt relevante Keywords → Automatische Aktivierung

**→ Slash Command** wenn:
- ✅ Du willst **manuell triggern**
- ✅ Explizite Kontrolle gewünscht
- ✅ Task ist zu spezifisch für Auto-Activation
- ✅ Primitiv für Skills/Subagenten

---

#### 5. Garantierte Automatisierung nötig?

**Sonderfall: Hooks**

Wenn du **garantierte Automatisierung** brauchst (nicht LLM-abhängig):

**→ Hook**

**Beispiele:**
- ✅ Auto-Formatting nach jedem Write
- ✅ Production Writes blockieren (PreToolUse)
- ✅ Security-Checks
- ✅ Linting

**Wichtig:** Hooks sind Shell-Scripts, keine LLM-gesteuerte Logik!

---

### Wenn nichts davon zutrifft:

**→ Einfacher Prompt oder Slash Command**

Für einmalige, einfache Tasks brauchst du keine speziellen Tools.

---

## 📊 FEATURE-VERGLEICH

Detaillierter Vergleich aller Tools nach wichtigen Kriterien:

| Feature | Skills | Slash Commands | Subagenten | MCP Server | Hooks |
|---------|--------|----------------|------------|------------|-------|
| **Invocation** | Agent (automatisch) | User (manuell) | Agent oder User | Agent (automatisch) | System (Event) |
| **Context-Effizienz** | ✅ Ja (Progressive Disclosure) | ✅ Ja | ✅ Ja (isoliert) | ❌ Nein (Context-Window-Explosion) | ✅ N/A |
| **Context-Persistent** | ✅ Ja | ✅ Ja | ❌ Nein (Context verloren) | ✅ Ja | ✅ N/A |
| **Modularität** | ✅✅ Sehr hoch | ⚠️ Mittel | ⚠️ Mittel | ✅✅ Sehr hoch | ⚠️ Niedrig |
| **Parallelisierbar** | ❌ Nein | ❌ Nein | ✅✅ Ja | ❌ Nein | ✅ N/A |
| **Kompositionsfähigkeit** | ✅✅ Sehr hoch | ✅✅ Sehr hoch | ⚠️ Begrenzt | ✅ Mittel | ⚠️ Niedrig |
| **Komplexität** | Hoch | Niedrig | Mittel | Mittel | Niedrig |
| **Setup-Aufwand** | Hoch | Niedrig | Mittel | Hoch | Niedrig |
| **Wiederverwendbarkeit** | ✅✅ Sehr hoch | ✅✅ Sehr hoch | ✅ Hoch | ✅✅ Sehr hoch | ✅ Hoch |
| **LLM-abhängig** | ✅ Ja | ✅ Ja | ✅ Ja | ✅ Ja | ❌ Nein (garantiert) |
| **Externe Daten** | ⚠️ Via MCP | ⚠️ Via MCP | ⚠️ Via MCP | ✅✅ Native | ❌ Nein |
| **Tool-Isolation** | ❌ Nein | ❌ Nein | ✅✅ Ja | ❌ Nein | ❌ Nein |

### Legende

- ✅✅ = Exzellent
- ✅ = Gut/Ja
- ⚠️ = Eingeschränkt/Mit Vorsicht
- ❌ = Nein/Nicht geeignet
- N/A = Nicht anwendbar

### Detaillierte Erklärungen

#### Context-Effizienz

**Skills: ✅ Progressive Disclosure**
- Stufe 1: Metadata (Name + Description) für ALLE Skills
- Stufe 2: Full Instructions nur für relevante Skills
- Stufe 3: Resources (@assets) nur bei Bedarf
- **Ergebnis:** Context-effizient auch bei vielen Skills

**MCP Server: ❌ Context-Window-Explosion**
- ALLE MCP Tools und Prompts sofort im Context Window
- Bei vielen MCP Servern: Massives Context-Problem
- **Empfehlung:** Max. 5 MCP Server gleichzeitig

**Slash Commands: ✅ Effizient**
- Nur geladen wenn aufgerufen
- Kein Context-Overhead

**Subagenten: ✅ Isoliert**
- Eigener Context pro Subagent
- Kein Haupt-Context-Pollution

---

#### Context-Persistent

**Was bedeutet das?**
Bleibt der Context zwischen Aufrufen erhalten?

**Skills/Commands/MCP: ✅ Ja**
- Haupt-Context bleibt intakt
- Können auf Conversation History zugreifen

**Subagenten: ❌ Nein**
- Verlieren Haupt-Context nach Delegation
- Müssen relevante Infos explizit übergeben bekommen
- Return nur Results, nicht den vollen Context

---

#### Parallelisierbarkeit

**Nur Subagenten: ✅✅**
- Können parallel laufen
- Ideal für Batch-Processing

**Alle anderen: ❌**
- Laufen sequenziell im Haupt-Context

---

#### Kompositionsfähigkeit

**Skills & Slash Commands: ✅✅ Sehr hoch**
- Können alles aufrufen (Skills, Commands, Subagenten, MCP)
- Höchste Ebene der Kompositionshierarchie

**MCP Server: ✅ Mittel**
- Sollten NICHT Skills aufrufen (niedrigere Ebene)
- Können von allen anderen genutzt werden

**Subagenten: ⚠️ Begrenzt**
- Können KEINE anderen Subagenten aufrufen (technische Limitation)
- Können Skills, Commands, MCP nutzen

**Hooks: ⚠️ Niedrig**
- Shell-Scripts, keine LLM-Logik
- Können externe Scripts aufrufen

---

#### LLM-abhängig

**Hooks: ❌ Nein (garantiert)**
- Einzige Tools, die **garantiert** ausgeführt werden
- Nicht von LLM-Entscheidungen abhängig
- Ideal für kritische Automatisierung (Security, Formatting)

**Alle anderen: ✅ Ja**
- Claude entscheidet wann und wie sie genutzt werden
- Kann fehlschlagen wenn Prompt unklar

---

## 🎯 USE CASE MATRIX

Wann welches Tool nutzen? Hier sind die wichtigsten Use Cases mit konkreten Beispielen:

---

## SKILLS - Automatisches Verhalten

### Wann nutzen

✅ **Claude soll selbst erkennen** wann relevant
✅ **Wiederkehrende Multi-Step-Workflows**
✅ **Domain-Expertise kodifizieren** (Legal, SEO, Brand Guidelines)
✅ **Team-Standards durchsetzen** (Code Style, Commit Messages, API Design)
✅ **Automatische Reaktion auf Keywords** im User-Prompt

### Wann NICHT nutzen

❌ **Einmalige Tasks** (zu viel Overhead)
❌ **Wenn du explizite Kontrolle brauchst** (nutze Slash Command)
❌ **Wenn Context-Window knapp ist** (Skills laden Metadata)
❌ **Zu einfache Tasks** (1-Schritt-Operations)

---

### Praxisbeispiel 1: PDF-Text automatisch extrahieren

**Szenario:** Du arbeitest oft mit PDFs und willst dass Claude automatisch Text extrahiert wenn du PDFs erwähnst.

**Lösung: Skill**

```markdown
---
name: PDF Analyzer
description: Extract and analyze text from PDF files. Use when user uploads or references PDFs.
---

# PDF Analyzer Skill

## Instructions

When user mentions or references a PDF file:

1. Detect PDF files in context (uploaded, path mentioned)
2. Extract text using `pdftotext` command
3. Structure content into logical sections
4. Provide analysis based on user request

## Commands

```bash
pdftotext input.pdf output.txt
# or for better formatting:
pdftotext -layout input.pdf output.txt
```

## Example Usage

User: "Analyze the contract.pdf in the documents folder"
→ Skill activates automatically
→ Extracts text from contract.pdf
→ Provides analysis
```

**Workflow:**
1. User: "Schau dir mal budget-report.pdf an"
2. Skill aktiviert automatisch (Keywords: "pdf")
3. Automatische Extraktion mit pdftotext
4. Claude analysiert Inhalt

**Warum Skill und nicht Command?**
- ✅ Automatische Aktivierung (kein manuelles `/pdf` nötig)
- ✅ Wiederkehrend (du arbeitest oft mit PDFs)
- ✅ Multi-Step (Detect → Extract → Structure → Analyze)

---

### Praxisbeispiel 2: Style-Guide-Verletzungen erkennen

**Szenario:** Dein Team hat Brand Guidelines die bei jeder Präsentation/Dokument geprüft werden sollen.

**Lösung: Skill mit @assets**

```markdown
---
name: Brand Compliance Checker
description: Check for brand guideline violations in documents and designs. Use when reviewing content, presentations, or marketing materials.
---

# Brand Compliance Skill

## Instructions

When user creates or reviews content that could violate brand guidelines:

1. Load brand guidelines from @assets/brand-guide.pdf
2. Check for violations:
   - Logo usage (size, placement, variants)
   - Color codes (hex values must match exactly)
   - Font families and sizes
   - Tone of voice in copy
3. Flag violations with severity (Critical/Warning/Info)
4. Suggest corrections

## Brand Assets

@assets/brand-guide.pdf
@assets/approved-logos/
@assets/color-palette.json

## Example Check

```json
{
  "violations": [
    {
      "type": "logo",
      "severity": "critical",
      "description": "Logo used in old variant",
      "correction": "Use logo-2024.svg from approved-logos/"
    },
    {
      "type": "color",
      "severity": "warning",
      "description": "Blue shade #1E90FF not in palette",
      "correction": "Use brand blue #1A73E8 instead"
    }
  ]
}
```
```

**Workflow:**
1. User: "Erstelle Präsentation für Q4 Review"
2. Skill aktiviert automatisch (Keywords: "Präsentation")
3. Lädt Brand Guidelines aus @assets/
4. Claude erstellt Präsentation
5. Skill prüft automatisch gegen Guidelines
6. Report mit Violations

**Warum Skill?**
- ✅ Team-Standard (jeder soll Guidelines einhalten)
- ✅ Automatische Prüfung (kein manuelles `/check-brand` nötig)
- ✅ Nutzt @assets für Referenz-Dokumente

---

### Praxisbeispiel 3: Git Work Trees verwalten

**Szenario:** Dein Team nutzt Git Worktrees für parallele Feature-Entwicklung. Es gibt mehrere Operations (create, remove, list, merge).

**Lösung: Skill orchestriert Slash Commands**

```markdown
---
name: Git Worktree Manager
description: Manage git worktrees (create, remove, list, merge). Use when user needs parallel feature development or wants to work on multiple branches simultaneously.
---

# Worktree Manager Skill

## Available Commands

- `/create-worktree <feature-name>` - Create new worktree
- `/remove-worktree <feature-name>` - Remove worktree
- `/list-worktrees` - List all worktrees
- `/merge-worktree <feature-name>` - Merge worktree back to main

## Instructions

Based on user request, invoke appropriate slash command:

1. **Create**: "Setup worktree für feature X"
   → Invoke `/create-worktree X`

2. **List**: "Zeig mir alle worktrees"
   → Invoke `/list-worktrees`

3. **Remove**: "Lösche worktree für X"
   → Invoke `/remove-worktree X`

4. **Merge**: "Merge worktree X zurück"
   → Invoke `/merge-worktree X`

## Workflow Example

User: "Ich brauche parallele Worktrees für login-feature und dashboard-redesign"
→ Skill erkennt Worktree-Request
→ Ruft `/create-worktree login-feature` auf
→ Ruft `/create-worktree dashboard-redesign` auf
→ Bestätigt beide Worktrees erstellt
```

**Workflow:**
1. User: "Setup worktree für authentication"
2. Skill aktiviert (Keywords: "worktree")
3. Skill ruft `/create-worktree authentication` auf
4. Worktree erstellt, Branch angelegt

**Warum Skill und nicht nur Commands?**
- ✅ Natürliche Sprache (User muss nicht `/create-worktree` kennen)
- ✅ Intelligente Orchestrierung (Skill wählt richtigen Command)
- ✅ Multi-Step möglich (z.B. create + setup dependencies)

---

### Praxisbeispiel 4: API Design nach Team-Standards

**Szenario:** Dein Team hat strikte REST API Design Guidelines die bei jedem neuen Endpoint gelten.

**Lösung: Skill mit CLAUDE.md Integration**

```markdown
---
name: API Design Reviewer
description: Review and enforce REST API design standards. Use when creating or reviewing API endpoints.
---

# API Design Reviewer Skill

## Instructions

When user creates new API endpoints:

1. Read @CLAUDE.md for project API standards
2. Review endpoint design against standards:
   - URL structure (RESTful naming)
   - HTTP methods (correct usage)
   - Response formats (consistent JSON structure)
   - Error handling (standard error codes)
   - Authentication (required headers)
   - Rate limiting (where applicable)
3. Flag violations
4. Suggest improvements

## Standards to Check

From @CLAUDE.md:
- `/api/v1/{resource}` naming
- POST for creation, PUT for full update, PATCH for partial
- Always return 201 with Location header on POST
- Errors in format: `{"error": {"code": "...", "message": "..."}}`
- Pagination with `?page=1&limit=20`

## Example Review

**Endpoint:** `POST /users/create`

**Violations:**
❌ URL should be `POST /api/v1/users` (no /create suffix)
❌ Missing 201 status code in implementation
❌ Missing Location header

**Corrected:**
```typescript
// POST /api/v1/users
app.post('/api/v1/users', async (req, res) => {
  const user = await createUser(req.body);
  res.status(201)
     .header('Location', `/api/v1/users/${user.id}`)
     .json(user);
});
```
```

**Warum Skill?**
- ✅ Team-Standard (jeder neue Endpoint sollte geprüft werden)
- ✅ Automatisch (Claude prüft selbst während Entwicklung)
- ✅ Nutzt @CLAUDE.md für Projekt-Standards

---

## SLASH COMMANDS - Manuelle, Wiederverwendbare Prompts

### Wann nutzen

✅ **Wiederholbare Workflows** die du **manuell triggern** willst
✅ **Als Primitiv für Skills/Subagenten** (Building Blocks)
✅ **Orchestrierung mehrerer Schritte** mit klarer Sequenz
✅ **Immer als erster Schritt** ("Prompt First"!)
✅ **Wenn du explizite Kontrolle** brauchst

### Wann NICHT nutzen

❌ **Wenn Claude automatisch entscheiden soll** → Skill
❌ **Für externe Daten** → MCP Server
❌ **Für Parallelisierung** → Subagent
❌ **Für garantierte Automatisierung** → Hook

---

### Praxisbeispiel 1: Git Commit Messages generieren

**Szenario:** Du willst Conventional Commit Messages für staged changes generieren.

**Lösung: Slash Command**

```markdown
---
name: commit-message
description: Generate conventional commit message for staged changes
---

# Commit Message Generator

Generate a conventional commit message following our team standards.

## Steps

1. Run `git diff --staged` to see changes
2. Analyze type of changes:
   - New features → `feat:`
   - Bug fixes → `fix:`
   - Documentation → `docs:`
   - Refactoring → `refactor:`
   - Tests → `test:`
   - Build/CI → `chore:`
3. Identify scope (component/module affected)
4. Write concise subject (max 50 chars)
5. Add body with "why" (if needed)

## Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Example

```
feat(auth): add OAuth2 login flow

Implements OAuth2 authentication with Google and GitHub providers.
Includes token refresh mechanism and secure cookie storage.

Closes #123
```

## Output

Present the generated commit message and ask if user wants to commit now.
```

**Workflow:**
1. User macht Code-Änderungen
2. User: `/commit-message`
3. Command generiert Message nach Standards
4. User commitet (oder Claude fragt nach)

**Warum Command und nicht Skill?**
- ✅ Manuelle Kontrolle (nicht bei jedem Commit automatisch)
- ✅ Expliziter Trigger (User entscheidet wann)
- ✅ Einfacher Workflow (1-Schritt)

---

### Praxisbeispiel 2: React-Komponente erstellen

**Szenario:** Du erstellst oft neue React Components mit TypeScript + Tests + Storybook.

**Lösung: Slash Command mit Argumenten**

```markdown
---
name: create-component
description: Create React component with TypeScript, tests, and Storybook
---

# React Component Creator

Create a new React component: **$ARGUMENTS**

## Steps

1. Read @CLAUDE.md for project structure
2. Create component file: `src/components/$ARGUMENTS/$ARGUMENTS.tsx`
3. Create TypeScript interface for props
4. Implement component with:
   - Proper typing
   - JSDoc comments
   - Export default
5. Create test file: `src/components/$ARGUMENTS/$ARGUMENTS.test.tsx`
   - Test rendering
   - Test props
   - Test user interactions
6. Create Storybook file: `src/components/$ARGUMENTS/$ARGUMENTS.stories.tsx`
   - Default story
   - Variants for different props
7. Export from index: `src/components/index.ts`

## Component Template

```typescript
import React from 'react';

interface ${ARGUMENTS}Props {
  // Props here
}

/**
 * $ARGUMENTS component
 * @description ...
 */
export const $ARGUMENTS: React.FC<${ARGUMENTS}Props> = (props) => {
  return (
    <div className="$ARGUMENTS">
      {/* Component content */}
    </div>
  );
};

export default $ARGUMENTS;
```

## Usage Example

`/create-component Button`
→ Creates Button.tsx, Button.test.tsx, Button.stories.tsx
```

**Workflow:**
1. User: `/create-component SearchBar`
2. Command erstellt alle Files:
   - `SearchBar.tsx` (Component)
   - `SearchBar.test.tsx` (Tests)
   - `SearchBar.stories.tsx` (Storybook)
   - Export in `index.ts`

**Warum Command?**
- ✅ Manuelle Kontrolle (Component-Erstellung ist explizite Action)
- ✅ Akzeptiert Argumente ($ARGUMENTS = Component Name)
- ✅ Multi-Step aber sequenziell
- ✅ Wiederholbar

**Könnte es ein Skill sein?**
⚠️ Nein, weil:
- User will explizit Components erstellen (kein Auto-Detect)
- Zu spezifisch für automatische Aktivierung

---

### Praxisbeispiel 3: Deployment-Prozess

**Szenario:** Multi-Step Deployment mit Build, Test, Deploy, Verify.

**Lösung: Slash Command orchestriert Pipeline**

```markdown
---
name: deploy
description: Deploy application to production (build, test, deploy, verify)
---

# Production Deployment

Deploy to production with full verification pipeline.

## Pre-Flight Checks

1. Verify git status is clean
2. Verify on main branch
3. Verify all tests pass locally
4. Verify no uncommitted changes

## Deployment Steps

1. **Build:**
   ```bash
   npm run build:production
   ```

2. **Test:**
   ```bash
   npm run test:all
   npm run test:e2e
   ```

3. **Deploy:**
   ```bash
   # Tag release
   git tag -a v$(date +%Y%m%d-%H%M) -m "Production deployment"
   git push origin --tags

   # Deploy
   npm run deploy:production
   ```

4. **Verify:**
   ```bash
   # Health check
   curl https://api.production.com/health

   # Smoke tests
   npm run test:smoke:production
   ```

5. **Notify:**
   - Log deployment to monitoring
   - Post to Slack #deployments channel
   - Update deployment dashboard

## Rollback Plan

If verification fails:
```bash
npm run rollback:production
```

## Output

Provide deployment summary:
- Version deployed
- Timestamp
- Health check results
- Smoke test results
```

**Workflow:**
1. User: `/deploy`
2. Command führt Pipeline aus:
   - Build ✅
   - Tests ✅
   - Deploy ✅
   - Verify ✅
3. Success oder Rollback

**Warum Command?**
- ✅ Explizite Kontrolle (Production Deployment ist kritisch!)
- ✅ Multi-Step aber sequenziell
- ✅ Klare Rollback-Strategie
- ✅ Nicht automatisierbar (zu riskant)

---

### Praxisbeispiel 4: Code Review nach Checkliste

**Szenario:** Du willst Code-Reviews nach Team-Checkliste durchführen.

**Lösung: Slash Command mit CLAUDE.md**

```markdown
---
name: code-review
description: Perform code review using team checklist from CLAUDE.md
---

# Code Review

Perform comprehensive code review using team standards.

## Review Checklist

From @CLAUDE.md:

### Code Quality
- [ ] No commented-out code
- [ ] No console.log/print statements
- [ ] Meaningful variable names
- [ ] Functions < 50 lines
- [ ] Files < 1000 lines

### Testing
- [ ] Unit tests for new functions
- [ ] Integration tests for API endpoints
- [ ] Edge cases covered
- [ ] Mocks used appropriately

### Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] SQL injection prevention
- [ ] XSS prevention

### Performance
- [ ] No N+1 queries
- [ ] Large lists paginated
- [ ] Database indices on foreign keys
- [ ] Caching where appropriate

### Documentation
- [ ] Public functions have JSDoc/docstrings
- [ ] README updated if needed
- [ ] CHANGELOG entry added

## Process

1. Read git diff or specified files
2. Go through checklist systematically
3. Flag violations with severity
4. Suggest concrete improvements
5. Provide overall score (1-10)

## Output Format

```markdown
# Code Review Results

## Summary
- Files reviewed: 5
- Violations: 3 critical, 7 warnings
- Score: 6/10

## Critical Issues
1. **Security:** Hardcoded API key in config.ts:42
2. **Testing:** No tests for new PaymentService
3. **Performance:** N+1 query in UserController.getAllWithOrders()

## Warnings
...

## Suggestions
...
```
```

**Workflow:**
1. User: `/code-review`
2. Command liest @CLAUDE.md für Team-Standards
3. Analysiert staged changes oder aktuellen Branch
4. Geht Checkliste durch
5. Report mit Violations + Score

**Warum Command?**
- ✅ Expliziter Trigger (Review auf Anfrage)
- ✅ Nutzt @CLAUDE.md für Team-Standards
- ✅ Multi-Step Analyse

**Könnte es ein Skill sein?**
⚠️ Ja, wenn du willst dass Claude automatisch bei PRs reviewed. Aber:
- Commands geben dir mehr Kontrolle
- Du entscheidest wann Review stattfindet

---

## SUBAGENTEN - Parallele & Isolierte Workflows

### Wann nutzen

✅ **Keyword: "parallel"** in der Anforderung
✅ **Isolierte Execution** ohne Context-Pollution
✅ **Security-kritische Ops** mit eingeschränkten Tools
✅ **Große Codebase-Scans** die lange dauern
✅ **Batch-Processing** über viele Dateien/Repos

### Wann NICHT nutzen

❌ **Wenn Context-Sharing nötig ist** (Subagents verlieren Main-Context)
❌ **Wenn keine Parallelisierung nötig** (unnötiger Overhead)
❌ **Für verschachtelte Subagents** (technisch nicht möglich!)
❌ **Wenn du einfache sequenzielle Logik brauchst** (nutze Command/Skill)

---

### Praxisbeispiel 1: Umfassende Security-Audits

**Szenario:** Vollständiger Security-Scan der Codebase mit Read-Only Access.

**Lösung: Subagent mit Tool-Isolation**

```markdown
---
name: security-scanner
description: Scan codebase for security vulnerabilities with read-only access
tools: ["Read", "Grep", "Glob"]  # Nur Lese-Zugriff!
model: claude-haiku-4.5  # Schneller + günstiger für Scans
---

# Security Scanner Subagent

Comprehensive security audit of codebase.

## Focus Areas

### 1. OWASP Top 10
- SQL Injection
- XSS (Cross-Site Scripting)
- CSRF (Cross-Site Request Forgery)
- Authentication/Authorization issues
- Sensitive Data Exposure
- Security Misconfiguration

### 2. Common Vulnerabilities
- Hardcoded secrets (API keys, passwords)
- Insecure dependencies
- Missing input validation
- Unsafe eval/exec usage
- Path traversal vulnerabilities

### 3. Best Practices
- HTTPS enforcement
- Secure cookies (HttpOnly, Secure, SameSite)
- Password hashing (bcrypt, not MD5)
- Rate limiting
- CORS configuration

## Scan Process

1. **Secrets Scan:**
   ```bash
   grep -r "API_KEY\|SECRET\|PASSWORD\|TOKEN" --include="*.ts" --include="*.js"
   ```

2. **SQL Injection:**
   ```bash
   grep -r "query.*\+\|execute.*\+" --include="*.ts" --include="*.js"
   ```

3. **XSS Vulnerabilities:**
   ```bash
   grep -r "innerHTML\|dangerouslySetInnerHTML" --include="*.tsx" --include="*.jsx"
   ```

4. **Dependency Check:**
   ```bash
   npm audit --json
   ```

## Report Format

```json
{
  "summary": {
    "total_files_scanned": 245,
    "critical_issues": 2,
    "high_issues": 5,
    "medium_issues": 12,
    "low_issues": 8
  },
  "critical": [
    {
      "file": "src/config.ts",
      "line": 42,
      "type": "hardcoded_secret",
      "description": "Hardcoded API key exposed",
      "remediation": "Move to environment variable"
    }
  ]
}
```
```

**Workflow:**
1. Main Agent: "Führe Security-Audit durch"
2. Delegiert an Security Scanner Subagent
3. Subagent scannt isoliert mit Read-Only Tools
4. Main Agent erhält Report zurück
5. Main Agent zeigt Zusammenfassung

**Warum Subagent?**
- ✅ **Tool-Isolation:** Nur Read, Grep, Glob (kein Write!)
- ✅ **Security:** Kann nichts kaputt machen
- ✅ **Separation of Concerns:** Fokussiert nur auf Security
- ✅ **Parallel möglich:** Mehrere Subagents für verschiedene Scan-Typen

---

### Praxisbeispiel 2: Failing Tests parallel fixen

**Szenario:** 10 Tests failen nach Refactoring. Du willst sie parallel fixen.

**Lösung: Subagent per Test**

```markdown
---
name: test-fixer
description: Fix failing test by analyzing code and test expectations
tools: ["Read", "Write", "Bash", "Grep"]
---

# Test Fixer Subagent

Fix a single failing test.

## Input

Receives from Main Agent:
- Test file path
- Test name
- Failure message

## Process

1. **Read test file**
   - Understand what test expects
   - Identify assertion that failed

2. **Read implementation**
   - Find function/component being tested
   - Analyze current behavior

3. **Identify root cause**
   - Compare expected vs. actual
   - Find bug in implementation or test

4. **Fix**
   - If bug in code: Fix implementation
   - If bug in test: Update test expectations
   - Preserve test coverage

5. **Verify**
   - Run fixed test
   - Ensure it passes
   - Ensure no other tests broke

## Output

```json
{
  "test": "UserService.createUser",
  "status": "fixed",
  "root_cause": "Missing email validation",
  "changes": [
    "src/services/UserService.ts:42 - Added email validation"
  ],
  "verification": "Test now passes"
}
```
```

**Main Agent Orchestrierung:**

```markdown
# Main Agent Logic

1. Run test suite: `npm test`
2. Parse failures (e.g., 10 failing tests)
3. For each failing test:
   - Start Test Fixer Subagent
   - Pass test info (file, name, error)
4. All Subagents run in parallel
5. Collect results
6. Aggregate fixes
7. Final verification: `npm test`
```

**Workflow:**
1. Main Agent: Runs tests → 10 failures
2. Main Agent: Startet 10 Test Fixer Subagents parallel
3. Jeder Subagent:
   - Analysiert seinen Test
   - Findet Root Cause
   - Fixt Code
   - Verifiziert Fix
4. Main Agent: Sammelt alle Fixes
5. Main Agent: Final Test Run → Alle grün ✅

**Warum Subagent?**
- ✅ **Parallelisierung:** 10 Tests gleichzeitig fixen (10x schneller!)
- ✅ **Isolation:** Jeder Subagent fokussiert auf einen Test
- ✅ **Skalierbar:** Funktioniert für 10 oder 100 Tests

**Zeitersparnis:**
- Sequenziell: 10 Tests × 5 Min = 50 Minuten
- Parallel: ~5-7 Minuten (alle gleichzeitig)

---

### Praxisbeispiel 3: Parallele Git Work Trees

**Szenario:** 3 Features gleichzeitig in separaten Worktrees entwickeln.

**Lösung: Subagent pro Feature**

```markdown
---
name: feature-developer
description: Develop feature in isolated git worktree
tools: ["Read", "Write", "Edit", "Bash", "Grep", "Glob"]
---

# Feature Developer Subagent

Develop a complete feature in isolated worktree.

## Input

Receives from Main Agent:
- Feature name
- Feature description
- Acceptance criteria

## Process

1. **Setup** (done by Main Agent)
   - Worktree created: `../worktree-{feature-name}`
   - Branch created: `feature/{feature-name}`

2. **Implementation**
   - Read @CLAUDE.md for architecture
   - Implement feature according to criteria
   - Follow coding standards
   - Write tests

3. **Verification**
   - Run tests: `npm test`
   - Run linting: `npm run lint`
   - Build: `npm run build`

4. **Commit**
   - Generate conventional commit message
   - Commit changes

## Output

```json
{
  "feature": "user-authentication",
  "status": "completed",
  "worktree": "../worktree-user-authentication",
  "branch": "feature/user-authentication",
  "files_changed": 12,
  "tests_added": 8,
  "ready_for_review": true
}
```
```

**Main Agent Orchestrierung:**

```markdown
# Main Agent Logic

## Step 1: Setup Worktrees
For each feature:
- `/create-worktree {feature-name}`

## Step 2: Start Feature Developer Subagents
Feature 1: "User Authentication"
→ Subagent in worktree-user-authentication

Feature 2: "Dashboard Redesign"
→ Subagent in worktree-dashboard-redesign

Feature 3: "Payment Integration"
→ Subagent in worktree-payment-integration

All run in parallel!

## Step 3: Monitor Progress
- Check Subagent outputs
- Report progress to user

## Step 4: Review & Merge
When all Subagents done:
- Review each feature
- Merge back to main
- Clean up worktrees
```

**Workflow:**
1. User: "Implement these 3 features parallel"
2. Main Agent: Erstellt 3 Worktrees
3. Main Agent: Startet 3 Feature Developer Subagents
4. Alle 3 Subagents entwickeln parallel in isolierten Worktrees
5. Main Agent: Sammelt Results
6. Main Agent: Reviewed und merged alle Features

**Warum Subagent?**
- ✅ **Parallelisierung:** 3 Features gleichzeitig
- ✅ **Isolation:** Jedes Feature in eigenem Worktree + Branch
- ✅ **Context-Isolation:** Keine Konflikte zwischen Features

**Zeitersparnis:**
- Sequenziell: 3 Features × 30 Min = 90 Minuten
- Parallel: ~30-35 Minuten (alle gleichzeitig)

---

### Praxisbeispiel 4: Multi-Repository Security-Scan

**Szenario:** Dein Team hat 20 Repositories die alle gescannt werden sollen.

**Lösung: Subagent pro Repository**

```markdown
---
name: repo-security-scanner
description: Scan single repository for security issues
tools: ["Read", "Grep", "Glob", "Bash"]
model: claude-haiku-4.5  # Schneller für Batch-Processing
---

# Repository Security Scanner

Scan a single repository for security vulnerabilities.

## Input
- Repository path
- Repository name

## Scan Steps

1. **Clone/Update Repo** (if needed)
2. **Run Security Checks:**
   - Hardcoded secrets
   - Dependency vulnerabilities
   - Code patterns (SQL injection, XSS)
3. **Generate Report**

## Output

```json
{
  "repo": "api-backend",
  "status": "scanned",
  "issues": {
    "critical": 1,
    "high": 3,
    "medium": 5
  },
  "details": [...]
}
```
```

**Main Agent Orchestrierung:**

```markdown
# Batch Scan 20 Repositories

1. List all repos
2. For each repo: Start repo-security-scanner Subagent
3. All 20 Subagents run in parallel
4. Collect reports
5. Aggregate results
6. Generate dashboard
```

**Workflow:**
1. Main Agent: Liest Liste von 20 Repos
2. Main Agent: Startet 20 Subagents parallel
3. Jeder Subagent scannt ein Repo
4. Main Agent: Sammelt alle Reports
5. Main Agent: Aggregiert zu Dashboard

**Warum Subagent?**
- ✅ **Massive Parallelisierung:** 20 Repos gleichzeitig
- ✅ **Isolation:** Kein Cross-Repo-Context
- ✅ **Skalierbar:** Funktioniert für 20 oder 200 Repos

**Zeitersparnis:**
- Sequenziell: 20 Repos × 10 Min = 200 Minuten (3+ Stunden!)
- Parallel: ~10-15 Minuten

---

## MCP SERVER - Externe Integrationen

### Wann nutzen

✅ **Daten von externen Systemen** (Jira, Salesforce, Slack)
✅ **Datenbank-Zugriff** (PostgreSQL, MySQL, MongoDB)
✅ **Cloud Storage** (Google Drive, Box, Dropbox)
✅ **APIs mit Authentication** (GitHub, GitLab, Linear)
✅ **Proprietäre Systeme** (internes CRM, ERP)

### Wann NICHT nutzen

❌ **Für lokale Dateien** (nutze Built-in Tools: Read, Write)
❌ **Wenn kein externes System involviert ist**
❌ **Bei zu vielen MCP Servern** (Context-Window-Explosion!)
❌ **Für einfache HTTP Requests** (nutze Bash + curl)

---

### Praxisbeispiel 1: Jira-Integration

**Szenario:** Du willst dass Claude Issues aus Jira lesen und aktualisieren kann.

**Lösung: MCP Server**

**Konfiguration:**

```json
{
  "mcpServers": {
    "jira": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-jira"],
      "env": {
        "JIRA_URL": "https://yourcompany.atlassian.net",
        "JIRA_TOKEN": "your-api-token",
        "JIRA_USER": "your-email@company.com"
      }
    }
  }
}
```

**Use Cases:**

```markdown
# 1. Issue Lookup
User: "Zeig mir alle offenen Bugs in Sprint 23"
→ Claude nutzt Jira MCP automatisch
→ Query: project = PROJ AND sprint = 23 AND type = Bug AND status != Closed
→ Zeigt Liste mit Bugs

# 2. Issue Creation
User: "Erstelle Bug-Ticket für Login-Problem"
→ Claude erstellt Jira Issue:
  - Type: Bug
  - Summary: Login fails with SSO
  - Description: [Details from conversation]
  - Assignee: [from team roster]

# 3. Status Update
User: "Setze Issue PROJ-123 auf Done"
→ Claude updated Jira Issue
→ Adds transition comment
→ Bestätigt Update

# 4. Sprint Planning
User: "Welche Issues sind für nächsten Sprint geplant?"
→ Query: sprint = 24 AND status = "To Do"
→ Zeigt Liste mit Story Points
```

**Warum MCP Server?**
- ✅ **Externe Integration:** Jira ist externes System
- ✅ **Authentication:** API Token nötig
- ✅ **Native MCP Server verfügbar**
- ✅ **Real-time Daten:** Immer aktuell

---

### Praxisbeispiel 2: Google Drive + QBR Skill

**Szenario:** Erstelle Quarterly Business Review (QBR) basierend auf Template in Google Drive und Sales-Daten aus Salesforce.

**Lösung: Skill + 2 MCP Server**

**Konfiguration:**

```json
{
  "mcpServers": {
    "google-drive": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-google-drive"],
      "env": {
        "GOOGLE_CLIENT_ID": "...",
        "GOOGLE_CLIENT_SECRET": "..."
      }
    },
    "salesforce": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-salesforce"],
      "env": {
        "SALESFORCE_USERNAME": "...",
        "SALESFORCE_PASSWORD": "...",
        "SALESFORCE_TOKEN": "..."
      }
    }
  }
}
```

**Skill:**

```markdown
---
name: QBR Creator
description: Create Quarterly Business Review presentation from template. Use when user requests QBR, quarterly review, or business review presentation.
---

# QBR Creator Skill

Create comprehensive QBR presentation using template and live data.

## Process

1. **Load Template**
   - Google Drive MCP: Fetch "QBR_Template_2024.pptx"
   - Parse template structure

2. **Gather Data**
   - Salesforce MCP: Query sales data for quarter
     - Pipeline value
     - Closed deals
     - Win rate
     - Top customers
   - Salesforce MCP: Query customer health scores

3. **Generate Content**
   - Executive Summary slide
   - Sales Performance slide (charts from Salesforce data)
   - Customer Highlights slide
   - Challenges & Learnings slide
   - Next Quarter Goals slide

4. **Create Presentation**
   - Fill template with data
   - Generate charts
   - Format consistently

5. **Save**
   - Google Drive MCP: Save as "QBR_Q4_2025.pptx"
   - Share link with stakeholders

## Example Usage

User: "Erstelle Q4 QBR"
→ Skill aktiviert
→ Lädt Template aus Google Drive
→ Holt Sales-Daten aus Salesforce
→ Generiert Präsentation
→ Speichert in Google Drive
```

**Workflow:**
1. User: "Erstelle Q4 QBR"
2. QBR Skill aktiviert (Keywords: "QBR", "quarterly review")
3. Google Drive MCP: Lädt Template
4. Salesforce MCP: Holt Sales-Daten für Q4
5. Skill: Generiert Slides mit Daten + Charts
6. Google Drive MCP: Speichert neue PPTX
7. User erhält Link

**Warum diese Komposition?**
- ✅ **Skill:** Orchestriert den Prozess (WIE)
- ✅ **Google Drive MCP:** Template laden + Speichern (WO)
- ✅ **Salesforce MCP:** Live Sales-Daten (DATEN)

**Ohne MCP würde es nicht gehen:**
- ❌ Keine Template-Integration
- ❌ Keine aktuellen Sales-Daten
- ❌ Manuelle Arbeit statt Automatisierung

---

### Praxisbeispiel 3: PostgreSQL Datenbank-Analysen

**Szenario:** Datenanalysen direkt aus der Produktions-DB.

**Lösung: MCP Server (Read-Only!)**

**Konfiguration:**

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "postgresql://readonly_user:password@prod-db.company.com:5432/main_db"
      }
    }
  }
}
```

**⚠️ WICHTIG: Read-Only User!**

Erstelle DB-User mit nur Lese-Rechten:

```sql
CREATE USER readonly_user WITH PASSWORD 'secure_password';
GRANT CONNECT ON DATABASE main_db TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
```

**Use Cases:**

```markdown
# 1. Ad-hoc Queries
User: "Wie viele User haben sich letzte Woche registriert?"
→ Claude: SELECT COUNT(*) FROM users WHERE created_at > NOW() - INTERVAL '7 days'
→ Ergebnis: 234 User

# 2. Performance Analysis
User: "Welche Queries laufen am längsten?"
→ Claude: SELECT query, mean_exec_time FROM pg_stat_statements ORDER BY mean_exec_time DESC LIMIT 10
→ Zeigt Top 10 langsame Queries

# 3. Data Trends
User: "Zeig mir User-Wachstum pro Monat"
→ Claude: SELECT DATE_TRUNC('month', created_at) as month, COUNT(*)
          FROM users
          GROUP BY month
          ORDER BY month
→ Generiert Chart

# 4. Complex Joins
User: "Welche Kunden haben im letzten Quartal über $10k ausgegeben?"
→ Claude:
  SELECT c.name, SUM(o.total) as revenue
  FROM customers c
  JOIN orders o ON c.id = o.customer_id
  WHERE o.created_at > NOW() - INTERVAL '3 months'
  GROUP BY c.id, c.name
  HAVING SUM(o.total) > 10000
  ORDER BY revenue DESC
→ Liste mit Top Customers
```

**Warum MCP Server?**
- ✅ **Externe Datenbank**
- ✅ **SQL Queries** (nicht über Built-in Tools möglich)
- ✅ **Authentication** (Connection String)
- ✅ **Live Data** (immer aktuell)

**Security Best Practice:**
- 🔒 **Read-Only User:** Kann nichts kaputt machen
- 🔒 **No DROP/DELETE:** Nur SELECT erlaubt
- 🔒 **Production Safety:** Zero Risk

---

### Praxisbeispiel 4: Slack-Benachrichtigungen

**Szenario:** Automatische Slack-Benachrichtigungen bei Deployments oder Errors.

**Lösung: MCP Server + Hook**

**Konfiguration:**

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-...",
        "SLACK_TEAM_ID": "T..."
      }
    }
  },
  "hooks": {
    "PostToolUse": {
      "Bash(*deploy*)": "node .claude/hooks/notify-deployment.js"
    }
  }
}
```

**Hook Script:**

```javascript
// .claude/hooks/notify-deployment.js
const { sendSlackMessage } = require('./slack-utils');

// Wird nach jedem deployment-bezogenen Bash Command ausgeführt
async function notifyDeployment() {
  await sendSlackMessage({
    channel: '#deployments',
    text: `🚀 Deployment completed by Claude`,
    blocks: [
      {
        type: 'section',
        text: {
          type: 'mrkdwn',
          text: '*Deployment Summary*\n• Status: ✅ Success\n• Time: 2 minutes\n• Environment: Production'
        }
      }
    ]
  });
}

notifyDeployment();
```

**Use Cases:**

```markdown
# 1. Deployment Notification
User: "/deploy"
→ Deployment läuft
→ Hook triggered nach Bash Command
→ Slack Nachricht in #deployments

# 2. Error Alerts
User: "Run tests"
→ Tests failen
→ Hook detected failure
→ Slack Nachricht in #alerts mit Error Details

# 3. Daily Standup
User: "Post standup update"
→ Claude sammelt git commits vom Tag
→ Slack MCP: Postet in #standup Channel
```

**Warum diese Komposition?**
- ✅ **MCP Server:** Slack-Integration (API Access)
- ✅ **Hook:** Garantierte Automatisierung nach Events
- ✅ **Kombination:** Hook nutzt MCP für Slack-Posting

---

## HOOKS - Event-Driven Automation

### Wann nutzen

✅ **Garantierte Automatisierung** (nicht LLM-abhängig!)
✅ **Code-Qualitätssicherung** (Formatting, Linting)
✅ **Security-Enforcement** (Production Writes blockieren)
✅ **PreToolUse:** Einzige Möglichkeit Tools zu blockieren!
✅ **PostToolUse:** Automatisches Post-Processing

### Wann NICHT nutzen

❌ **Für komplexe Logik** (Hooks sind Shell-Commands)
❌ **Wenn LLM-Entscheidung gewünscht** (nutze Skill)
❌ **Für asynchrone Ops** (Hooks blockieren Workflow)

---

### Praxisbeispiel 1: Auto-Formatting

**Szenario:** Automatisches Formatting nach jedem Write.

**Lösung: PostToolUse Hook**

**Konfiguration:**

```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/*.py)": "black $FILE && ruff check $FILE",
      "Write(**/*.ts)": "prettier --write $FILE && eslint --fix $FILE",
      "Write(**/*.tsx)": "prettier --write $FILE && eslint --fix $FILE",
      "Write(**/*.go)": "gofmt -w $FILE",
      "Write(**/*.rs)": "rustfmt $FILE"
    }
  }
}
```

**Workflow:**
1. Claude: `Write src/components/Button.tsx`
2. File geschrieben
3. Hook triggered automatisch:
   - `prettier --write Button.tsx` → Formatiert
   - `eslint --fix Button.tsx` → Fixt Lint-Errors
4. File ist jetzt formatiert + gelintet

**Warum Hook?**
- ✅ **Garantiert:** Wird IMMER ausgeführt (nicht LLM-abhängig)
- ✅ **Automatisch:** Kein manueller Schritt
- ✅ **Zero Overhead:** Entwickler muss nicht dran denken
- ✅ **Team-Standard:** Jeder Code ist konsistent formatiert

---

### Praxisbeispiel 2: Security - Production Writes blockieren

**Szenario:** Verhindern dass Claude direkt in Production schreibt.

**Lösung: PreToolUse Hook (blockiert Tool!)**

**Konfiguration:**

```json
{
  "hooks": {
    "PreToolUse": {
      "Write(**/production/**)": "echo '❌ ERROR: Direct writes to production/ are forbidden!' && exit 1",
      "Write(**/prod/**)": "echo '❌ ERROR: Direct writes to prod/ are forbidden!' && exit 1",
      "Bash(**/production/**)": "echo '⚠️  WARNING: Bash commands in production/ require manual approval' && exit 1"
    }
  }
}
```

**Workflow:**

**Blockierter Fall:**
1. Claude: `Write production/config.json`
2. PreToolUse Hook triggered
3. Script: `exit 1` → Blockiert Tool!
4. Claude erhält Error: "Direct writes to production/ are forbidden!"
5. Write wird NICHT ausgeführt ❌

**Erlaubter Fall:**
1. Claude: `Write src/components/Button.tsx`
2. Kein Hook matched → Write läuft normal ✅

**Warum Hook (PreToolUse)?**
- ✅ **Security:** Verhindert versehentliche Production Changes
- ✅ **PreToolUse:** Einzige Möglichkeit Tools zu blockieren!
- ✅ **Garantiert:** Funktioniert auch wenn Claude "falsch denkt"
- ✅ **Zero Risk:** Production ist geschützt

---

### Praxisbeispiel 3: Test-Enforcement

**Szenario:** Jede neue Funktion muss getestet sein.

**Lösung: PostToolUse Hook mit Validation**

**Konfiguration:**

```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/src/**/*.ts)": "node .claude/hooks/enforce-tests.js $FILE"
    }
  }
}
```

**Hook Script:**

```javascript
// .claude/hooks/enforce-tests.js
const fs = require('fs');
const path = require('path');

const filePath = process.argv[2]; // $FILE von Hook
const fileContent = fs.readFileSync(filePath, 'utf-8');

// Check: Hat File neue Funktionen?
const hasNewFunctions = /export (function|const \w+ =)/.test(fileContent);

if (hasNewFunctions) {
  // Check: Existiert Test-File?
  const testPath = filePath.replace(/\.ts$/, '.test.ts');

  if (!fs.existsSync(testPath)) {
    console.error(`❌ ERROR: ${path.basename(filePath)} has new functions but no test file!`);
    console.error(`Expected test file: ${testPath}`);
    process.exit(1); // Block!
  }

  // Check: Hat Test-File Tests für neue Funktionen?
  const testContent = fs.readFileSync(testPath, 'utf-8');
  // Simple check: Hat mindestens 1 test() oder it() call
  if (!/test\(|it\(/.test(testContent)) {
    console.error(`❌ ERROR: ${testPath} exists but has no tests!`);
    process.exit(1);
  }

  console.log(`✅ Tests found for ${path.basename(filePath)}`);
}
```

**Workflow:**

**Mit Tests:**
1. Claude: `Write src/utils/formatDate.ts` (neue Funktion)
2. PostToolUse Hook triggered
3. Script prüft: formatDate.test.ts existiert? ✅
4. Script prüft: Tests vorhanden? ✅
5. ✅ Success

**Ohne Tests:**
1. Claude: `Write src/utils/formatDate.ts` (neue Funktion)
2. PostToolUse Hook triggered
3. Script prüft: formatDate.test.ts existiert? ❌
4. Script: `exit 1` → Fehler!
5. Claude erhält Error: "formatDate.ts has new functions but no test file!"
6. Claude muss Tests nachliefern

**Warum Hook?**
- ✅ **Garantiert:** Tests werden erzwungen
- ✅ **Team-Standard:** 100% Test-Coverage
- ✅ **Automatisch:** Kein manuelles Review nötig

---

### Praxisbeispiel 4: Git Commit Hooks

**Szenario:** Conventional Commit Messages erzwingen.

**Lösung: PreToolUse Hook für Git**

**Konfiguration:**

```json
{
  "hooks": {
    "PreToolUse": {
      "Bash(git commit*)": "node .claude/hooks/validate-commit-msg.js \"$COMMAND\""
    }
  }
}
```

**Hook Script:**

```javascript
// .claude/hooks/validate-commit-msg.js
const command = process.argv[2]; // "git commit -m 'message'"

// Extract commit message from command
const match = command.match(/git commit.*-m ["'](.+)["']/);
if (!match) {
  console.error('❌ Could not parse commit message');
  process.exit(1);
}

const commitMsg = match[1];

// Conventional Commit Format: type(scope): subject
const conventionalPattern = /^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .{3,50}$/;

if (!conventionalPattern.test(commitMsg)) {
  console.error('❌ ERROR: Commit message does not follow Conventional Commits!');
  console.error('');
  console.error('Format: <type>(<scope>): <subject>');
  console.error('');
  console.error('Valid types: feat, fix, docs, style, refactor, test, chore');
  console.error('Example: feat(auth): add OAuth2 login');
  console.error('');
  console.error(`Your message: "${commitMsg}"`);
  process.exit(1);
}

console.log('✅ Commit message valid');
```

**Workflow:**

**Valid Commit:**
1. Claude: `git commit -m "feat(auth): add OAuth2 login"`
2. PreToolUse Hook triggered
3. Script validiert: Conventional Format? ✅
4. Commit läuft durch

**Invalid Commit:**
1. Claude: `git commit -m "added login feature"`
2. PreToolUse Hook triggered
3. Script validiert: Conventional Format? ❌
4. Script: `exit 1` → Blockiert!
5. Claude erhält Error mit Format-Hilfe
6. Claude muss Commit Message korrigieren

**Warum Hook?**
- ✅ **Garantiert:** Alle Commits folgen Standard
- ✅ **PreToolUse:** Verhindert invalide Commits
- ✅ **Team-Standard:** Saubere Git History

---

## 🔄 KOMPOSITIONSHIERARCHIE

Verstehe welche Tools andere Tools aufrufen können:

### Hierarchie-Diagramm

```mermaid
graph TB
    subgraph "Höchste Ebene - Maximale Kompositionsfähigkeit"
        A[Skills]
        B[Slash Commands]
    end

    subgraph "Mittlere Ebene"
        C[MCP Server]
        D[Subagenten]
    end

    subgraph "Niedrigste Ebene"
        E[Hooks]
        F[Built-in Tools]
    end

    A -->|kann nutzen| B
    A -->|kann nutzen| C
    A -->|kann nutzen| D
    A -->|kann nutzen| F

    B -->|kann aufrufen| A
    B -->|kann nutzen| C
    B -->|kann nutzen| D
    B -->|kann nutzen| F

    D -->|kann nutzen| A
    D -->|kann nutzen| B
    D -->|kann nutzen| C
    D -->|kann nutzen| F
    D -.->|NICHT möglich| D

    C -->|kann nutzen| F
    C -.->|sollte nicht| A

    E -->|kann aufrufen| F
    E -.->|kein LLM-Zugriff| A
    E -.->|kein LLM-Zugriff| B

    style A fill:#99ff99
    style B fill:#ffff99
    style C fill:#ff9999
    style D fill:#99ccff
    style E fill:#ff99ff
    style F fill:#cccccc
```

### Detaillierte Regeln

#### 1. Skills (Höchste Ebene)

**Können nutzen:**
- ✅ Andere Skills aufrufen
- ✅ Slash Commands aufrufen (via SlashCommand Tool)
- ✅ Subagenten starten
- ✅ MCP Server nutzen
- ✅ Built-in Tools nutzen

**Beispiel: Git Worktree Manager Skill**

```markdown
# Skill orchestriert Commands
- `/create-worktree` (Slash Command)
- `/list-worktrees` (Slash Command)
- `/merge-worktree` (Slash Command)
```

**Komplexes Beispiel: QBR Skill**

```markdown
# Skill nutzt alles:
1. Google Drive MCP (Template laden)
2. Salesforce MCP (Sales-Daten)
3. Andere Skills (Chart Generator Skill)
4. Built-in Tools (Write für Output)
```

---

#### 2. Slash Commands (Höchste Ebene)

**Können nutzen:**
- ✅ Skills aktivieren (automatisch via Description)
- ✅ Andere Slash Commands aufrufen
- ✅ Subagenten starten
- ✅ MCP Server nutzen
- ✅ Built-in Tools nutzen

**Beispiel: Deployment Command**

```markdown
# /deploy Command orchestriert:
1. /build (anderer Command)
2. /test (anderer Command)
3. Security Scanner Skill (aktiviert automatisch)
4. Slack MCP (Notification)
```

**Wichtig:** Commands sind Primitives - oft die Building Blocks für Skills!

---

#### 3. Subagenten (Mittlere Ebene)

**Können nutzen:**
- ✅ Skills nutzen (haben Zugriff)
- ✅ Slash Commands aufrufen
- ✅ MCP Server nutzen
- ✅ Built-in Tools nutzen (eingeschränkt via `tools` config)

**NICHT möglich:**
- ❌ Andere Subagenten aufrufen (technische Limitation!)

**Beispiel: Feature Developer Subagent**

```markdown
---
tools: ["Read", "Write", "Bash"]
---

# Kann nutzen:
- Read/Write/Bash (whitelisted)
- Skills (automatisch verfügbar)
- /create-component (Slash Command)
- MCP Server

# Kann NICHT:
- Andere Subagenten starten
- Tools außerhalb Whitelist (z.B. kein Grep wenn nicht in tools)
```

---

#### 4. MCP Server (Mittlere Ebene)

**Können nutzen:**
- ✅ Built-in Tools (theoretisch, aber selten nötig)

**Sollten NICHT:**
- ⚠️ Skills aufrufen (niedrigere Ebene der Abstraktion)
- ⚠️ Slash Commands aufrufen

**Wichtig:** MCP Server sind **Datenquellen**, keine Orchestratoren!

**Richtig:**
```markdown
Skill → nutzt → MCP Server (Daten holen)
```

**Falsch:**
```markdown
MCP Server → ruft → Skill auf
```

---

#### 5. Hooks (Niedrigste Ebene)

**Können nutzen:**
- ✅ Shell-Commands ausführen
- ✅ Scripts aufrufen
- ⚠️ Built-in Tools indirekt (via Claude Response)

**NICHT möglich:**
- ❌ Skills aufrufen (keine LLM-Logik)
- ❌ Slash Commands aufrufen (keine LLM-Logik)
- ❌ MCP Server nutzen (keine LLM-Logik)

**Beispiel:**

```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/*.ts)": "prettier --write $FILE"  // Shell Command OK
    }
  }
}
```

**Wichtig:** Hooks sind **Shell-Scripts**, keine LLM-gesteuerte Logik!

---

### Praktische Kompositions-Beispiele

#### Beispiel 1: Multi-Layer QBR Pipeline

```markdown
Layer 1: Slash Command "/create-qbr Q4"
  ↓
Layer 2: QBR Creator Skill (aktiviert automatisch)
  ↓
Layer 3a: Google Drive MCP (Template laden)
Layer 3b: Salesforce MCP (Sales-Daten)
Layer 3c: Chart Generator Skill (Visualisierungen)
  ↓
Layer 4: Built-in Tools (Write für PPTX)
  ↓
Layer 5: PostToolUse Hook (Auto-Format)
```

**Alle Ebenen zusammen!**

---

#### Beispiel 2: Parallel Feature Development

```markdown
Layer 1: Slash Command "/parallel-features feature-a feature-b"
  ↓
Layer 2: Orchestrator Skill
  ↓
  ├─ Subagent A (feature-a)
  │   ↓
  │   ├─ Component Creator Skill
  │   ├─ /create-component (Command)
  │   └─ GitHub MCP (Create PR)
  │
  └─ Subagent B (feature-b)
      ↓
      ├─ API Generator Skill
      ├─ /create-endpoint (Command)
      └─ Jira MCP (Update Issue)
```

**Parallel Execution mit voller Komposition!**

---

### Context-Window-Impact Visualisierung

```mermaid
graph LR
    subgraph "Context-Effizient ✅"
        A[Skills<br/>Progressive Disclosure]
        B[Slash Commands<br/>On-Demand Load]
        C[Subagenten<br/>Isolated Context]
    end

    subgraph "Context-Intensiv ⚠️"
        D[MCP Server<br/>All Tools in Context]
    end

    subgraph "Kein Context-Impact"
        E[Hooks<br/>Shell Scripts]
    end

    A -->|Stufe 1: Metadata| F[Small Context]
    A -->|Stufe 2: Instructions| G[Medium Context]
    A -->|Stufe 3: Resources| H[Large Context]

    B -->|Nur wenn aufgerufen| F

    C -->|Eigener Context| I[Isolated]

    D -->|Alle Tools sofort| J[Large Context!]

    style A fill:#99ff99
    style B fill:#ffff99
    style C fill:#99ccff
    style D fill:#ff9999
    style E fill:#ff99ff
```

---

## 🚀 "PROMPT FIRST" WORKFLOW

### Die goldene Regel

> **Fang immer einfach an. Skaliere nur wenn nötig.**

Zu viele Entwickler machen den Fehler direkt mit komplexen Tools zu starten. Das Ergebnis:
- ❌ Overengineering
- ❌ Maintenance-Overhead
- ❌ Schwer zu debuggen
- ❌ Context-Window-Pollution

**Die richtige Reihenfolge:**
1. Direkter Prompt
2. Slash Command (wenn wiederholbar)
3. Skill ODER Subagent (wenn komplexer)
4. + MCP Server (wenn externe Daten)

---

### Migrations-Stufen im Detail

#### Stufe 1: Direkter Prompt

**Wann ausreichend:**
- ✅ Einmalige Aufgabe
- ✅ Exploratives Ausprobieren
- ✅ Unklar ob wiederholbar

**Beispiel:**

```
User: "Erstelle mir eine git commit message für die staged changes"
```

Claude macht es → Fertig!

**Wann zur nächsten Stufe?**
→ Wenn du merkst: "Das mache ich öfter als 3x"

---

#### Stufe 2: Slash Command

**Wann sinnvoll:**
- ✅ Task wird wiederholt (>3x)
- ✅ Willst manuelle Kontrolle behalten
- ✅ Klare Schrittfolge

**Migration:**

Direkter Prompt:
```
"Erstelle conventional commit message für staged changes"
```

Wird zu Slash Command:
```markdown
---
name: commit-msg
description: Generate conventional commit message
---

# Commit Message Generator

1. Run git diff --staged
2. Analyze changes
3. Generate conventional commit format
```

**Vorteile:**
- ✅ Wiederverwendbar via `/commit-msg`
- ✅ Konsistente Qualität
- ✅ Team kann gleichen Command nutzen

**Wann zur nächsten Stufe?**
→ Wenn du willst dass:
- Claude automatisch erkennt wann relevant → **Skill**
- Task parallel laufen soll → **Subagent**

---

#### Stufe 3a: Skill (Automatische Aktivierung)

**Wann sinnvoll:**
- ✅ Claude soll automatisch erkennen wann relevant
- ✅ Wiederkehrendes Muster
- ✅ Mehrere Schritte involviert
- ✅ Team-Standard

**Migration:**

Slash Command:
```markdown
---
name: commit-msg
---
Generate commit message
```

Wird zu Skill:
```markdown
---
name: Commit Message Generator
description: Generate commit messages following team conventions. Use after code changes before committing.
---

# Commit Message Generator

When user mentions committing or has staged changes:

1. Run git diff --staged
2. Generate conventional commit message
3. Follow team standards from @CLAUDE.md
```

**Vorteile:**
- ✅ Automatische Aktivierung (kein `/` nötig)
- ✅ Claude erkennt selbst wann relevant
- ✅ Natürlichere Interaction

**Beispiel:**

```
User: "Ich hab die Auth fertig, können wir committen?"
→ Skill aktiviert automatisch (Keywords: "committen")
→ Generiert Message
→ Claude fragt: "Soll ich damit committen?"
```

**Nachteil:**
- ⚠️ Weniger explizite Kontrolle
- ⚠️ Skill-Overhead (Progressive Disclosure)

---

#### Stufe 3b: Subagent (Parallelisierung)

**Wann sinnvoll:**
- ✅ Task muss parallel laufen
- ✅ Tool-Isolation gewünscht
- ✅ Batch-Processing

**Migration:**

Slash Command:
```markdown
---
name: fix-test
---
Fix single failing test
```

Wird zu Subagent:
```markdown
---
name: test-fixer
tools: ["Read", "Write", "Bash"]
---

Fix a single failing test.

Input: Test name, file, error
Output: Fixed test + verification
```

**Main Agent orchestriert:**

```markdown
# Main Agent
1. Run all tests → 10 failures
2. For each failure: Start test-fixer Subagent
3. All run in parallel
4. Collect results
```

**Vorteile:**
- ✅ Massive Parallelisierung
- ✅ Tool-Isolation (Security)
- ✅ Schneller als sequenziell

**Nachteil:**
- ⚠️ Context geht verloren
- ⚠️ Komplexer zu orchestrieren

---

#### Stufe 4: + MCP Server (Externe Daten)

**Wann sinnvoll:**
- ✅ Externe Systeme involviert
- ✅ API-Zugriff nötig
- ✅ Real-time Daten

**Migration:**

Skill:
```markdown
---
name: Commit Message Generator
---
Generate commit message
```

Wird zu Skill + MCP:
```markdown
---
name: Commit Message Generator
---

# Mit Jira-Integration

1. Generate commit message
2. Jira MCP: Get Issue details (if mentioned)
3. Add Issue ID to commit footer
4. Add Issue title to commit body

Example:
"feat(auth): add OAuth2 login

Implements OAuth2 for Google and GitHub.

Issue: PROJ-123 - Add OAuth login options"
```

**Vorteile:**
- ✅ Kontext aus Jira
- ✅ Automatische Issue-Verlinkung
- ✅ Vollständigere Commit Messages

---

### Migrations-Entscheidungsbaum

```mermaid
graph TD
    A[Direkter Prompt] -->|Wiederholbar?| B{Mehr als 3x?}
    B -->|Ja| C[Slash Command]
    B -->|Nein| A

    C -->|Automatisch?| D{Claude soll<br/>erkennen wann?}
    C -->|Parallel?| E{Muss parallel<br/>laufen?}

    D -->|Ja| F[Skill]
    D -->|Nein| C

    E -->|Ja| G[Subagent]
    E -->|Nein| C

    F -->|Externe Daten?| H{Externe<br/>Systeme?}
    H -->|Ja| I[Skill + MCP]
    H -->|Nein| F

    G -->|Externe Daten?| J{Externe<br/>Systeme?}
    J -->|Ja| K[Subagent + MCP]
    J -->|Nein| G

    style A fill:#cccccc
    style C fill:#ffff99
    style F fill:#99ff99
    style G fill:#99ccff
    style I fill:#88ff88
    style K fill:#88ccff
```

---

### Wann NICHT migrieren

#### ❌ Von Command zu Skill wenn:

1. **Du explizite Kontrolle willst**
   - Deployment zu Production
   - Kritische DB-Operations
   - Irreversible Actions

2. **Task ist zu simpel (1 Schritt)**
   - "Run tests"
   - "Format file"
   - Besser als Command mit voller Kontrolle

3. **Context-Window ist knapp**
   - Viele Skills = Metadata-Overhead
   - Commands werden nur on-demand geladen

4. **Skill würde selten aktiviert**
   - <5x pro Monat
   - Overhead lohnt sich nicht

---

#### ❌ Von Command zu Subagent wenn:

1. **Keine Parallelisierung nötig**
   - Sequenzieller Workflow ist in Ordnung
   - Command ist schnell genug

2. **Context-Sharing wichtig**
   - Subagent verliert Main-Context
   - Wenn Conversation History nötig

3. **Task ist zu einfach**
   - Subagent-Overhead für simple Tasks unnötig

---

#### ❌ Von Skill zu MCP wenn:

1. **Skill löst Problem bereits gut**
   - Keine externen Daten nötig
   - Funktioniert mit Built-in Tools

2. **Keine externen Daten involviert**
   - Lokale Dateien → Built-in Tools
   - Keine APIs nötig

3. **Context-Window bereits voll**
   - MCP Server = Context-Window-Explosion
   - Vermeiden wenn möglich

---

### Praktische Migrations-Beispiele

#### Migration 1: Logging → Command → Skill

**Stufe 1: Direkter Prompt**
```
User: "Add logging to handlePayment function"
Claude: Adds console.log statements
```

**Stufe 2: Slash Command (nach 5x)**
```markdown
---
name: add-logging
---
Add structured logging to function: $ARGUMENTS

1. Read function
2. Add logging at:
   - Entry (params)
   - Key steps
   - Exit (return value)
   - Errors (catch blocks)
3. Use Winston logger
```

**Stufe 3: Skill (Team-Standard)**
```markdown
---
name: Logging Enforcer
description: Add structured logging to functions. Use when creating or reviewing functions without logging.
---

# Logging Enforcer

When user creates/reviews function without logging:

1. Detect missing logging
2. Add Winston logger with proper levels:
   - info: Function entry/exit
   - debug: Key steps
   - error: Errors
3. Follow logging standards from @CLAUDE.md
```

**Warum Migration sinnvoll:**
- Team-Standard → Alle Funktionen sollten Logging haben
- Automatische Detection → Keine manuellen `/add-logging` Calls
- Konsistenz → Immer gleiche Logging-Struktur

---

#### Migration 2: Component → Command → Skill + MCP

**Stufe 1: Direkter Prompt**
```
User: "Create Button component"
Claude: Creates Button.tsx
```

**Stufe 2: Slash Command (nach 10x)**
```markdown
---
name: create-component
---
Create React component: $ARGUMENTS

1. Component file
2. Test file
3. Storybook file
```

**Stufe 3: Skill (Automatisch)**
```markdown
---
name: Component Creator
description: Create React components with tests and stories. Use when user mentions creating a component.
---
```

**Stufe 4: + Figma MCP (Design-Integration)**
```markdown
---
name: Component Creator
description: Create React components from Figma designs.
---

1. Figma MCP: Get design specs for component
2. Create component matching design:
   - Colors from Figma
   - Spacing from Figma
   - Typography from Figma
3. Create tests
4. Create Storybook
```

**Warum Migration sinnvoll:**
- Figma als Single Source of Truth
- Automatische Design-Code Sync
- Konsistenz zwischen Design & Code

---

## ❌ ANTI-PATTERNS

Lerne von häufigen Fehlern:

### 1. Skills für einmalige Tasks

**❌ Schlecht:**

```markdown
---
name: Deploy Version 2.0 to Production
description: Deploy version 2.0 to production servers
---

# One-Time Deployment

Deploy v2.0 specifically...
```

**Problem:**
- Skill ist für einmalige Action
- Wird nie wieder aktiviert
- Overhead (Progressive Disclosure) umsonst

**✅ Besser:**

Slash Command oder direkter Prompt:
```
/deploy v2.0
```

**Regel:**
- Skills nur für **wiederkehrende** Tasks
- Einmalig → Command oder Prompt

---

### 2. MCP Server für lokale Dateien

**❌ Schlecht:**

```json
{
  "mcpServers": {
    "local-files": {
      "command": "mcp-server-filesystem",
      "args": ["/path/to/project"]
    }
  }
}
```

**Problem:**
- MCP verursacht Context-Window-Explosion
- Built-in Tools (Read, Write, Grep, Glob) sind viel effizienter
- Unnötiger Overhead

**✅ Besser:**

Nutze Built-in Tools:
- `Read` für Dateien lesen
- `Write` für Dateien schreiben
- `Grep` für Suche
- `Glob` für File-Matching

**Regel:**
- MCP nur für **externe** Systeme
- Lokale Dateien → Built-in Tools

---

### 3. Verschachtelte Subagenten

**❌ Schlecht:**

```markdown
# Subagent A
---
name: orchestrator
---

Start Subagent B for each task...
```

**Problem:**
- Subagenten können **keine** anderen Subagenten aufrufen
- Technische Limitation!

**✅ Besser:**

Main Agent orchestriert beide Subagents parallel:

```markdown
# Main Agent
1. Identifiziere Tasks
2. Start Subagent A für Task 1
3. Start Subagent B für Task 2
4. Beide laufen parallel
```

**Regel:**
- Nur Main Agent kann Subagenten starten
- Subagenten sind "Leaf Nodes"

---

### 4. Skills für alles

**❌ Schlecht:**

```
.claude/skills/
├── calculate-sum/
├── format-date/
├── uppercase-string/
├── remove-whitespace/
├── validate-email/
├── ... (50 weitere Mini-Skills)
```

**Problem:**
- Zu viele Skills = Context-Pollution
- Metadata für ALLE Skills wird geladen (Progressive Disclosure Stufe 1)
- Claude muss alle evaluieren → Performance-Problem

**✅ Besser:**

Skills nur für **echte Domain-Expertise**:
```
.claude/skills/
├── brand-compliance/
├── api-design-reviewer/
├── security-audit/
└── qbr-creator/
```

Einfache Funktionen → Keine Skills nötig!

**Regel:**
- Skills: <20 empfohlen
- Nur für Domain-Expertise & Team-Standards
- Nicht für triviale 1-Liner

---

### 5. Slash Command Overload

**❌ Schlecht:**

```
.claude/commands/
├── add-button.md
├── add-input.md
├── add-select.md
├── add-checkbox.md
... (100 Commands für jedes Detail)
```

**Problem:**
- Unübersichtlich
- Schwer zu finden
- Kein User kann sich 100 Commands merken

**✅ Besser:**

**Option A: Gruppierung in Skills**
```
.claude/skills/
└── component-creator/
    ├── SKILL.md (orchestriert alles)
    └── commands/
        ├── button.md
        ├── input.md
        └── select.md
```

**Option B: Namespacing**
```
.claude/commands/
├── frontend:component.md
├── frontend:page.md
├── backend:api.md
└── backend:database.md
```

User: `/frontend:component Button`

**Regel:**
- Commands: <30 empfohlen
- Nutze Namespacing für Gruppierung
- Erwäge Skills für viele ähnliche Commands

---

### 6. Hooks für komplexe Logik

**❌ Schlecht:**

```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/*.py)": "python complex_analysis.py $FILE && python generate_docs.py $FILE && python run_linter.py $FILE && python update_index.py && ..."
    }
  }
}
```

**Problem:**
- Hooks sind Shell-Commands, keine LLM-Logik
- Komplex = Schwer zu debuggen
- Fehler blockieren Workflow
- Keine intelligente Entscheidung

**✅ Besser:**

Skill mit klarer Logik:

```markdown
---
name: Python File Processor
description: Process Python files after writing (analyze, document, lint).
---

# Python File Processor

When Python file is written:

1. Analyze with pylint
2. Generate docstrings if missing
3. Update module index
4. Check complexity (only if >50 lines)
```

**Regel:**
- Hooks: Simple Shell-Commands (Formatting, Linting)
- Komplexe Logik → Skills (LLM kann intelligent entscheiden)

---

### 7. Alle Slash Commands zu Skills konvertieren

**❌ Schlecht:**

```
Massenmigration:
.claude/commands/* → .claude/skills/*
```

**Problem:**
- Nicht jeder Command profitiert von Skill-Conversion
- Overhead ohne Nutzen
- Verlust von expliziter Kontrolle

**✅ Besser:**

Nur migrieren wenn:
- ✅ Wirklich wiederkehrend (>10x)
- ✅ Claude soll automatisch entscheiden
- ✅ Mehrere Schritte involviert
- ✅ Team-Standard

**Behalte Commands für:**
- ❌ Kritische Operations (Deployment)
- ❌ Explizite Kontrolle gewünscht
- ❌ Seltene Tasks (<5x)

**Regel:**
- Skill ≠ automatisch besser als Command
- Commands haben ihren Platz!

---

### 8. Zu viele MCP Server

**❌ Schlecht:**

```json
{
  "mcpServers": {
    "jira": {...},
    "github": {...},
    "gitlab": {...},
    "salesforce": {...},
    "hubspot": {...},
    "slack": {...},
    "google-drive": {...},
    "box": {...},
    "postgres": {...},
    "mysql": {...},
    "redis": {...},
    "elasticsearch": {...}
  }
}
```

**Problem:**
- Alle MCP Tools sofort im Context Window!
- Massive Context-Window-Explosion
- Claude kann nicht effizient arbeiten

**✅ Besser:**

**Option A: Nur aktiv benötigte MCP Server** (Max. 5)
```json
{
  "mcpServers": {
    "jira": {...},
    "github": {...},
    "postgres": {...}
  }
}
```

**Option B: Profile für verschiedene Workflows**

`.claude/settings.json` (Development):
```json
{
  "mcpServers": {
    "github": {...},
    "postgres": {...}
  }
}
```

`.claude/settings.business.json` (Business):
```json
{
  "mcpServers": {
    "salesforce": {...},
    "google-drive": {...}
  }
}
```

**Regel:**
- MCP Server: <5 gleichzeitig empfohlen
- Mehr = Context-Window-Problem
- Nutze Profile für verschiedene Workflows

---

### 9. Subagenten ohne klare Tool-Isolation

**❌ Schlecht:**

```markdown
---
name: risky-agent
tools: ["Read", "Write", "Bash", "Edit"]  # Alle Tools!
---

Do various things...
```

**Problem:**
- Kein echter Vorteil von Subagent
- Sicherheitsrisiko (Bash + Write = potentiell gefährlich)
- Subagent kann alles = Keine Separation of Concerns

**✅ Besser:**

Klare Tool-Isolation:

```markdown
---
name: security-scanner
tools: ["Read", "Grep", "Glob"]  # Nur Lese-Zugriff!
---

Scan for security issues (Read-Only)
```

```markdown
---
name: test-runner
tools: ["Read", "Bash"]  # Nur Tests ausführen
---

Run tests in isolation
```

**Regel:**
- Subagenten: Minimale Tools für Aufgabe
- Security: Read-Only wenn möglich
- Separation of Concerns

---

### 10. Hooks die Workflow blockieren

**❌ Schlecht:**

```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/*.ts)": "npm run build && npm run test"  // Kann 5 Minuten dauern!
    }
  }
}
```

**Problem:**
- Hook blockiert nach JEDEM Write
- User muss 5 Min warten nach jeder Dateiänderung
- Workflow extrem langsam

**✅ Besser:**

Schnelle Hooks:
```json
{
  "hooks": {
    "PostToolUse": {
      "Write(**/*.ts)": "prettier --write $FILE && eslint --fix $FILE"  // <1 Sekunde
    }
  }
}
```

Langsame Checks → Command oder Background:
```markdown
---
name: full-check
---

Run complete build & test suite.
(User ruft auf wenn gewünscht)
```

**Regel:**
- Hooks: <5 Sekunden execution time
- Langsame Ops → Commands (User-triggered)

---

## ❓ FAQ

### Tool-Auswahl

**F: Sollte ich alle meine Slash Commands zu Skills konvertieren?**

**A:** Nein! Nur wenn:
- ✅ Claude soll automatisch entscheiden wann relevant
- ✅ Task ist wiederkehrend mit mehreren Schritten
- ✅ Team-Standard der durchgesetzt werden soll

Behalte Commands für:
- ❌ Kritische Operations (du willst Kontrolle)
- ❌ Seltene Tasks
- ❌ Wenn Context-Window knapp ist

---

**F: Wann brauche ich wirklich einen MCP Server?**

**A:** Nur wenn:
- ✅ Externe Daten/Services involviert (Jira, Salesforce, etc.)
- ✅ Authentication nötig (API Keys, OAuth)
- ✅ Real-time Daten gewünscht

NICHT für:
- ❌ Lokale Dateien (nutze Built-in Tools: Read, Write)
- ❌ Einfache HTTP Requests (nutze Bash + curl)

---

**F: Kann ich Skills verschachteln?**

**A:** Ja, Skills können andere Skills aufrufen. ABER:
- ⚠️ Testing wird komplexer
- ⚠️ Debugging schwieriger
- ⚠️ Context-Window-Overhead
- Nutze mit Vorsicht, nur wenn wirklich nötig

---

**F: Wie zuverlässig sind verkettete Skills?**

**A:** Abhängig von:
- **Klarheit der Skill-Descriptions:** Je klarer, desto zuverlässiger
- **Context-Window-Größe:** Zu viele Skills = Performance-Problem
- **Testing:** Kritische Workflows sollten getestet werden

Empfehlung:
- ✅ Einfache Verkettung (2-3 Skills): Meistens OK
- ⚠️ Komplexe Verkettung (5+ Skills): Testing erforderlich
- ❌ Zu viele Skills (<20 total): Context-Pollution

---

### Komposition

**F: Kann ein Skill einen Subagent aufrufen?**

**A:** Ja! Skills können Subagenten nutzen für Parallelisierung.

Beispiel:
```markdown
---
name: Multi-Repo Security Audit
---

# Skill orchestriert Subagenten

1. Identifiziere alle Repos
2. Pro Repo: Start Security Scanner Subagent
3. Sammle Reports
4. Aggregiere zu Dashboard
```

---

**F: Kann ein Subagent einen Skill nutzen?**

**A:** Ja, Subagenten haben Zugriff auf Skills.

Beispiel:
```markdown
---
name: feature-developer
tools: ["Read", "Write", "Bash"]
---

# Subagent kann Skills nutzen

1. Component Creator Skill (für UI)
2. API Generator Skill (für Backend)
```

---

**F: Kann ein Subagent einen anderen Subagent aufrufen?**

**A:** Nein, technische Limitation!

Nur Main Agent kann Subagenten starten. Subagenten sind "Leaf Nodes".

**Workaround:** Main Agent orchestriert beide Subagenten parallel.

---

**F: Können Slash Commands Skills aktivieren?**

**A:** Ja, indirekt!

Wenn Slash Command Beschreibung Keywords enthält die Skill matcht:

```markdown
# Command
---
name: review-security
description: Review code for security vulnerabilities
---

# Skill (aktiviert automatisch!)
---
name: Security Auditor
description: Audit code for security issues. Use when reviewing security.
---
```

Keyword "security" in Command → Skill aktiviert!

---

### Performance

**F: Zu viele Skills = Performance-Problem?**

**A:** Ja, wegen Progressive Disclosure:

**Stufe 1 (Metadata):** Wird für ALLE Skills geladen
- Name + Description für 50 Skills = Viel Context!

**Problem:** Claude muss alle 50 Skill-Descriptions evaluieren.

**Empfehlung:** <20 Skills

**Lösung wenn zu viele:**
- Skills zusammenfassen (gleiche Domain)
- Seltene Skills als Commands
- Profile für verschiedene Workflows

---

**F: Zu viele MCP Server = Problem?**

**A:** JA! Großes Problem:

**Context-Window-Explosion:**
- Alle MCP Tools sofort im Context Window
- 10 MCP Server mit je 20 Tools = 200 Tools im Context!

**Empfehlung:** <5 MCP Server gleichzeitig

**Vergleich:**
- Skills: Progressive Disclosure → Context-effizient ✅
- MCP: Alle Tools sofort → Context-intensiv ❌

---

**F: Sind Subagenten schneller als sequenzielle Ausführung?**

**A:** Nur bei echtem Parallelismus!

**Parallel = Schneller:**
```markdown
10 Tests sequenziell: 10 × 5 Min = 50 Min
10 Tests parallel (Subagents): ~5-7 Min
```

**Kein Vorteil wenn:**
- Nur 1 Subagent (kein Parallelismus)
- Tasks müssen sequenziell sein (Abhängigkeiten)

---

### Migration

**F: Wann sollte ich von Command zu Skill migrieren?**

**A:** Wenn:
- ✅ Task >10x wiederholt
- ✅ Claude soll automatisch erkennen
- ✅ Mehrere logische Schritte
- ✅ Team-Standard (alle sollten nutzen)

**Checkliste:**
- [ ] Wird häufig genutzt (>10x)
- [ ] Automatische Aktivierung gewünscht
- [ ] Multi-Step Workflow
- [ ] Team-Standard

Alle 4 → Skill! Sonst: Behalte Command.

---

**F: Wann sollte ich von Skill zurück zu Command migrieren?**

**A:** Wenn:
- ❌ Skill wird selten aktiviert (<5x/Monat)
- ❌ Context-Window ist knapp
- ❌ Du brauchst explizite Kontrolle
- ❌ Skill ist zu spezifisch

**Zeichen dass Skill nicht passt:**
- Skill aktiviert nicht automatisch (Description zu vage?)
- Skill aktiviert zu oft (Description zu allgemein?)
- Niemand nutzt es (zu kompliziert?)

---

**F: Kann ich Command und Skill parallel haben?**

**A:** Ja! Oft sogar empfohlen.

**Beispiel:**

Command für explizite Kontrolle:
```markdown
---
name: deploy
---
Deploy to production (manual trigger)
```

Skill für Automatisierung:
```markdown
---
name: Deployment Checker
description: Check if code is ready for deployment. Use before deploying.
---

Pre-deployment checks:
- Tests passing?
- Linting clean?
- Breaking changes documented?
```

User kann `/deploy` manuell callen, aber Skill prüft automatisch vorher!

---

### Troubleshooting

**F: Skill wird nicht aktiviert obwohl relevant?**

**A:** Check Description:

**Zu vage:**
```markdown
---
description: Help with data
---
```

**Besser (spezifisch):**
```markdown
---
description: Analyze CSV and Excel files for revenue reports, pipeline analysis, and sales forecasting.
---
```

**Trigger-Wörter hinzufügen:**
- "Analyze CSV" → Keywords: CSV, Excel, analyze
- "Create QBR" → Keywords: QBR, quarterly review, business review

**Debug-Trick:**
Frag Claude: "Welche Skills sind aktiv?" → Siehst du ob Skill erkannt wurde.

---

**F: Zu viele Skills aktivieren sich?**

**A:** Descriptions zu allgemein:

**Problem:**
```markdown
---
name: Code Helper
description: Help with code
---
```
→ Aktiviert bei JEDEM Code-Request!

**Lösung:**
```markdown
---
name: React Component Creator
description: Create React components with TypeScript, tests, and Storybook. Use when user explicitly requests a new component.
---
```

**Spezifischer = Bessere Activation**

---

**F: Subagent verliert Context?**

**A:** Das ist normal! Subagenten sind isoliert.

**Lösung:** Übergebe relevanten Context explizit:

**❌ Schlecht:**
```markdown
Main: "Fix the test"
→ Subagent: "Which test?"
```

**✅ Gut:**
```markdown
Main: "Fix test 'UserService.createUser' in src/services/UserService.test.ts
       Error: 'Expected status 201 but got 400'
       Context: We changed validation rules in last commit"
→ Subagent: Hat alle Infos!
```

---

**F: MCP Server funktioniert nicht?**

**A:** Häufige Probleme:

**1. Authentication fehlt:**
```json
{
  "env": {
    "API_KEY": "..."  // Check: Ist Key gültig?
  }
}
```

**2. Command nicht gefunden:**
```json
{
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-jira"]
}
```
→ Check: `npx @modelcontextprotocol/server-jira` im Terminal

**3. Permissions:**
- Read-Only User für DB?
- API Token hat Permissions?

**Debug:** Check Claude Logs:
- macOS: `~/Library/Logs/Claude/`
- Windows: `%APPDATA%\Claude\logs\`

---

**F: Hook wird nicht ausgeführt?**

**A:** Check Pattern-Matching:

**❌ Funktioniert nicht:**
```json
{
  "PostToolUse": {
    "Write(*.ts)": "prettier $FILE"  // Fehlt **/
  }
}
```

**✅ Funktioniert:**
```json
{
  "PostToolUse": {
    "Write(**/*.ts)": "prettier $FILE"  // ** = recursive
  }
}
```

**Debug:**
- Füge `echo` hinzu: `"echo 'Hook triggered!' && prettier $FILE"`
- Check Terminal Output

---

**F: Wie debugge ich Skill-Activation?**

**A:** Mehrere Optionen:

**1. Frag Claude direkt:**
```
User: "Welche Skills sind aktiv?"
Claude: "Currently active: [Liste von Skills]"
```

**2. Check Skill Description:**
- Sind Keywords enthalten die User verwendet?
- Ist Description spezifisch genug?

**3. Test mit explizitem Mention:**
```
User: "Use the Brand Compliance Checker to review this presentation"
→ Claude sollte Skill nutzen
```

**4. Simplified Test:**
- Erstelle minimalen Test-Skill
- Check ob dieser aktiviert wird
- Dann: Erweitere schrittweise

---

### Best Practices

**F: Wie organisiere ich viele Commands/Skills?**

**A:** Empfohlene Struktur:

```
.claude/
├── commands/
│   ├── git/
│   │   ├── commit.md
│   │   ├── worktree-create.md
│   │   └── worktree-remove.md
│   ├── frontend/
│   │   ├── component.md
│   │   └── page.md
│   └── backend/
│       ├── api.md
│       └── database.md
├── skills/
│   ├── brand-compliance/
│   ├── security-audit/
│   └── qbr-creator/
└── subagents/
    ├── security-scanner.md
    └── test-fixer.md
```

**Namespacing für Commands:**
- `/git:commit`
- `/frontend:component`
- `/backend:api`

---

**F: Wie dokumentiere ich meine Tools für das Team?**

**A:** Erstelle Team-Dokumentation:

**README.md in `.claude/`:**

```markdown
# Team Claude Configuration

## Available Slash Commands

### Git Commands
- `/git:commit` - Generate conventional commit message
- `/git:worktree` - Create new worktree

### Frontend Commands
- `/frontend:component` - Create React component
- `/frontend:page` - Create new page

## Active Skills

### Brand Compliance Checker
Automatically checks brand guidelines on presentations.
**Trigger:** Mention "presentation" or "slides"

### Security Auditor
Reviews code for security issues.
**Trigger:** Mention "security" or "audit"

## MCP Servers

- **Jira:** Access issues and create tickets
- **GitHub:** Repository operations
- **Postgres:** Read-only database access
```

---

**F: Wie teste ich Skills/Commands vor Deployment?**

**A:** Testing-Strategie:

**1. Lokales Testing:**
```markdown
# In .claude/commands/test-command.md
---
name: test
---

Test command (delete after testing)
```

**2. Incremental Rollout:**
- Nur du: `.claude/commands/` (Projekt-lokal)
- Team: `~/.claude/commands/` (Global shared)

**3. Version Control:**
```bash
git add .claude/
git commit -m "feat: Add new security-audit skill"
```

**4. Dokumentation:**
- README.md mit Beispielen
- Changelog für neue Tools

---

**F: Wie verhindere ich Konflikte zwischen Tools?**

**A:** Klare Zuständigkeiten:

**❌ Konflikt:**
```markdown
# Skill A
description: Format code

# Skill B
description: Format and lint code
```
→ Beide aktivieren bei "format"!

**✅ Klare Trennung:**
```markdown
# Skill A: Formatter
description: Auto-format code using Prettier/Black. Use after writing code.

# Skill B: Linter
description: Lint code for errors and style issues. Use before committing.
```

**Best Practice:**
- Jedes Tool hat klare Zuständigkeit
- Keywords nicht überlappen
- Test mit gleichen Prompts

---

## 🔗 RESSOURCEN

### Primärquellen

**Video-Tutorial (Basis für diesen Guide):**
- 🎥 [How to choose the right approach for your task](https://www.youtube.com/watch?v=kFpLzCVLA20)
- Von: Anthropic
- Datum: Oktober 2025

**GitHub Issue:**
- 📋 [Issue #7: Tool Selection Guide](https://github.com/trytofly94/Claude-Documentation/issues/7)

---

### Verwandte Dokumentation

**In diesem Repository:**

**[TOOL_INTERACTIONS.md](TOOL_INTERACTIONS.md)**
- Technische Details: **WIE** Tools interagieren
- SlashCommand Tool
- Progressive Disclosure
- Event-driven Automation
- 10 praktische Patterns
- Decision Matrix

**[CLAUDE_CODE.md](CLAUDE_CODE.md)**
- Skills: Komplette Dokumentation
- Slash Commands: Format & Syntax
- Subagenten: Configuration Details
- Hooks: PreToolUse & PostToolUse
- CLI Features

**[MCP_GUIDE.md](MCP_GUIDE.md)**
- MCP Server: Installation & Konfiguration
- Verfügbare Server (Jira, GitHub, Google Drive, etc.)
- Configuration Examples
- Troubleshooting

**[WORKFLOWS.md](WORKFLOWS.md)**
- Praktische Workflows
- Best Practices
- Kombinierte Nutzung
- FAQ

**[CLAUDE_DESKTOP.md](CLAUDE_DESKTOP.md)**
- Skills API
- Box Integration
- "Imagine with Claude"

---

### Offizielle Anthropic-Dokumentation

- 📖 [Claude Code Docs](https://docs.claude.com/en/docs/claude-code)
- 🔌 [MCP Website](https://modelcontextprotocol.io)
- 📰 [Anthropic Blog](https://anthropic.com/news)

---

### Community & Support

- 💬 [Claude Discord](https://discord.gg/claude) (falls verfügbar)
- 🐛 [GitHub Issues](https://github.com/trytofly94/Claude-Documentation/issues)
- 📧 Support: support@anthropic.com

---

## 🎓 Zusammenfassung

### Die wichtigsten Takeaways

#### 1. "Prompt First" Philosophie
> Fang immer einfach an: Direkter Prompt → Slash Command → Skill/Subagent → +MCP

#### 2. Tool-Wahl-Matrix
- **Slash Commands:** Manuelle, wiederholbare Workflows
- **Skills:** Automatische Aktivierung, Domain-Expertise
- **Subagenten:** Parallelisierung, Tool-Isolation
- **MCP Server:** Externe Integrationen (Jira, DB, etc.)
- **Hooks:** Garantierte Automatisierung (nicht LLM)

#### 3. Context-Window ist kritisch
- **Skills:** Context-effizient (Progressive Disclosure) ✅
- **MCP Server:** Context-intensiv (alle Tools sofort) ⚠️
- **Empfehlung:** <20 Skills, <5 MCP Server

#### 4. Kompositionshierarchie
```
Skills/Commands (top)
  ↓
MCP Server + Subagenten (middle)
  ↓
Hooks + Built-in Tools (bottom)
```

#### 5. Anti-Patterns vermeiden
- ❌ Skills für einmalige Tasks
- ❌ MCP für lokale Dateien
- ❌ Verschachtelte Subagenten
- ❌ Zu viele Skills/MCP Server

#### 6. Testing & Iteration
- Start einfach → Teste → Skaliere bei Bedarf
- Dokumentiere für Team
- Version Control für `.claude/`

---

### Nächste Schritte

1. **Verstehe deine Anforderungen**
   - Einmalig oder wiederkehrend?
   - Manuell oder automatisch?
   - Parallel nötig?
   - Externe Daten?

2. **Nutze den Entscheidungsbaum** (siehe oben)

3. **Start mit Slash Command**
   - Test die Idee
   - Iteriere

4. **Migriere wenn sinnvoll**
   - Command → Skill (wenn automatisch gewünscht)
   - Command → Subagent (wenn parallel nötig)
   - + MCP (wenn externe Daten)

5. **Dokumentiere & Teile**
   - README.md in `.claude/`
   - Onboarding für Team

---

**Viel Erfolg beim Tool-Auswahl! 🚀**

Bei Fragen: [GitHub Issues](https://github.com/trytofly94/Claude-Documentation/issues)

---

**Stand:** 4. November 2025
**Version:** 1.0
**Autoren:** trytofly94 + Claude (Sonnet 4.5)
**Lizenz:** MIT
