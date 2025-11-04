# 📚 CLAUDE ECOSYSTEM DOKUMENTATION

**Stand:** 4. November 2025
**Version:** 3.4 - Tool Selection Guide

---

## 🎯 Überblick

Vollständige Dokumentation des Claude Ecosystems mit Claude Code, Claude Desktop und Model Context Protocol (MCP).

**Zielgruppe:** Entwickler mit Anthropic Pro/Max-Abo
**Plattform:** macOS, Windows, Linux

---

## 📄 Dokumentations-Struktur

Die Dokumentation ist in handliche Einzeldateien aufgeteilt:

### 1. 🖥️ [CLAUDE_CODE.md](CLAUDE_CODE.md)
**Claude Code CLI & VS Code Extension**

- ✅ Installation & Kernfunktionen
- ✅ `.claude` Ordner Konfiguration
- ✅ Agentic Coding Workflows
- ✅ **Claude Code 2.0 Features** (VS Code Extension, Checkpoints, Background Tasks)
- ✅ **Legacy CLI Integration**
- ✅ Security Features (`/security-review`)
- ✅ **API Features** (Context Editing, Memory Tool)
- ✅ Output Styles & Customization
- ✅ CLI-Tools Integration
- 🆕 **Claude Code Web Version** (Browser-basiert, GitHub Integration)
- 🆕 **GitHub Integration** (@claude Tagging)
- 🆕 **Erweiterte Konfiguration** (CLAUDE.md Imports)

**Wichtigste Updates:**
- 🆕 **Claude Code Web Version** (Oktober 2025) - Cloud-basierte Plattform
- 🆕 **Neue Commands** (/export, /permissions, /statusline)
- 🆕 **Keyboard Shortcuts** (Ctrl+B, Ctrl+Z, Ctrl+U, Ctrl+_)
- 🆕 **Environment Variables** (USE_BUILTIN_RIPGREP, etc.)
- 🆕 Claude Sonnet 4.5 als Default (77.2% SWE-bench)
- 🆕 VS Code Extension (Beta)
- 🆕 Checkpoints System (ESC ESC zum Rewind)
- 🆕 Background Tasks für paralleles Arbeiten
- 🆕 Context Editing & Memory Tool

---

### 2. 🎨 [CLAUDE_DESKTOP.md](CLAUDE_DESKTOP.md)
**Claude Desktop App & Features**

- ✅ Kernfunktionen & MCP-Integration
- ✅ Projects System
- ✅ **Skills** (Pre-built, Custom, API, Box Integration)
- ✅ **"Imagine with Claude"** Research Preview
- ✅ Claude for Chrome Extension
- ✅ Artifacts & Publishing
- ✅ Google Docs Integration

**Wichtigste Updates:**
- 🆕 Skills API (`/v1/skills`) für programmatische Verwaltung
- 🆕 Skill-Creator Skill (interaktive Skill-Erstellung)
- 🆕 Box Integration Skills
- 🆕 Enterprise Skill Deployment (in Arbeit)
- 🆕 "Imagine with Claude" (Real-time Software Generation)

---

### 3. 🔌 [MCP_GUIDE.md](MCP_GUIDE.md)
**Model Context Protocol**

- ✅ Grundkonzept & Architektur
- ✅ Verfügbare MCP-Server
- ✅ Konfiguration (Claude Code & Desktop)
- ✅ Filesystem Server (detailliert)
- ✅ Troubleshooting

**Wichtigste Updates:**
- 🆕 Box MCP-Server
- 🆕 Erweiterte Konfigurationsoptionen

---

### 4. ⚡ [WORKFLOWS.md](WORKFLOWS.md)
**Interaktionen & Praktische Workflows**

- ✅ Claude Desktop + MCP Workflows
- ✅ Claude Code + VS Code Extension
- ✅ Kombinierte Nutzung
- ✅ Best Practices
- ✅ Troubleshooting & FAQ
- ✅ Konfigurationsvorlagen

---

### 5. 🔄 [TOOL_INTERACTIONS.md](TOOL_INTERACTIONS.md)
**Tool-Interaktionen & Synergismen**

- ✅ Slash Commands, Skills, Subagenten, Hooks Integration
- ✅ Wie Tools miteinander interagieren
- ✅ SlashCommand Tool für programmatische Aufrufe
- ✅ Progressive Disclosure System (Skills)
- ✅ Event-driven Automation (Hooks)
- ✅ 10 praktische Interaktionsmuster
- ✅ Decision Matrix: Wann was nutzen
- ✅ Advanced Patterns & Best Practices
- ✅ Debugging & Troubleshooting

**Wichtigste Erkenntnisse:**
- 🔄 Slash Commands können Subagenten orchestrieren
- 🤖 Claude kann Slash Commands via SlashCommand Tool aufrufen
- 📚 Skills nutzen @CLAUDE.md für Projekt-Kontext
- ⚡ Hooks garantieren Automatisierung (nicht LLM-abhängig)
- 🔒 PreToolUse Hooks können Tools blockieren (Security!)
- 🎯 Subagenten mit Tool-Isolation für Separation of Concerns

---

### 6. 🎯 [TOOL_SELECTION_GUIDE.md](TOOL_SELECTION_GUIDE.md)
**Wann welches Tool nutzen?** (NEU!)

- ✅ **Entscheidungsbaum** für Tool-Auswahl
- ✅ **Feature-Vergleich** (Skills vs. Commands vs. Subagents vs. MCP vs. Hooks)
- ✅ **"Prompt First" Workflow** - Von einfach zu komplex skalieren
- ✅ **Migrationspfade** (Prompt → Command → Skill/Subagent → +MCP)
- ✅ **Use Case Matrix** mit 15+ Praxisbeispielen
- ✅ **Kompositionshierarchie** - Welches Tool kann was aufrufen
- ✅ **Anti-Patterns** - Wann NICHT welches Tool nutzen
- ✅ **FAQ** mit 15+ häufigen Fragen
- ✅ **Progressive Disclosure erklärt** (Skills vs. MCP Context-Impact)

**Basis:** [Video-Tutorial](https://www.youtube.com/watch?v=kFpLzCVLA20) von Anthropic

**Wichtigste Erkenntnisse:**
- 🎯 **Faustregel:** "Prompt First" - Starte immer mit Slash Command
- 📊 **Skills:** Progressive Disclosure = context-effizient (✅)
- 🔴 **MCP:** Context-Window-Explosion bei zu vielen Servern (⚠️)
- ⚡ **Subagenten:** Parallelisierung (Keyword: "parallel")
- 🔧 **Hooks:** Garantierte Automatisierung (nicht LLM-abhängig)
- 🌳 **Hierarchie:** Skills/Commands (top) > MCP/Subagents (middle) > Hooks (bottom)

**Abgrenzung:**
- **TOOL_INTERACTIONS.md:** **WIE** Tools zusammenarbeiten (technisch)
- **TOOL_SELECTION_GUIDE.md:** **WANN** welches Tool wählen (strategisch)

---

## 🆕 Wichtigste Updates (Stand: 4. November 2025)

### 🌐 Claude Code Web Version (20. Oktober 2025)

**NEU: Cloud-basierte Coding-Plattform**
- ✅ Kein lokales Setup nötig - Vollständig im Browser
- ✅ Native GitHub Repository Integration
- ✅ Parallele Tasks über mehrere Repositories
- ✅ Secure Sandbox Environments (Trusted/Custom/No Network)
- ✅ iOS Mobile App (early stage)
- ⚠️ Research Preview für Pro & Max Users
- 📖 **Details:** [CLAUDE_CODE.md - Sektion I](CLAUDE_CODE.md#i-claude-code-web-version-oktober-2025)

**Zugang:** [claude.ai/code](https://claude.ai/code)

---

### 🤖 Claude Haiku 4.5 (15. Oktober 2025)

**Leistungsstarkes Budget-Model:**
- 🏆 **73.3%** SWE-bench Verified (fast Sonnet 4 Niveau!)
- ⚡ **4-5x schneller** als Sonnet 4.5
- 💰 **$1/$5** per million tokens (vs. $3/$15 Sonnet)
- 📊 **200K context** standard, 1M für Developer Platform
- 📝 **64K max output** (vs. 8K bei Haiku 3.5)
- 🧠 **Extended Thinking** erstmals für Haiku verfügbar
- 🎯 **Free Tier verfügbar** auf claude.ai

**Use Cases:** Schnelle Code-Reviews, Batch-Processing, Cost-sensitive Workloads

---

### ⚠️ Breaking Changes (2025)

**Custom Slash Command Namespacing (Juli 2025):**
- Subdirectories in `.claude/commands/` erstellen jetzt Namespaces
- Beispiel: `.claude/commands/frontend/foo.md` → `/frontend:foo` (nicht mehr `/foo`)
- **Migration:** Flatten Command-Struktur ODER Namespace-Prefix nutzen
- 📖 [Details in CLAUDE_CODE.md - Sektion A](CLAUDE_CODE.md#a-kernfunktionen--cli-befehle)

**ANTHROPIC_LOG statt DEBUG:**
- `DEBUG=true` ist deprecated
- Nutze `ANTHROPIC_LOG=debug` für Request-Logging
- 📖 [Details in CLAUDE_CODE.md - Sektion D](CLAUDE_CODE.md#c-projekt-struktur)

---

### Claude Code 2.0 (September 2025 Release)

**Revolutionary Features für Autonomes Coding:**

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

### Skills & API Updates (Oktober 16, 2025)

🎯 **Agent Skills Launch** - Spezialisierte Fähigkeiten für Claude
- **Was**: Ordner mit Anweisungen, Scripts & Ressourcen die Claude automatisch lädt
- **Wo**: Claude Apps, Claude Code (`~/.claude/skills/`), API
- **Composable**: Mehrere Skills arbeiten zusammen
- **Portable**: Gleiche Skills funktionieren überall
- **Progressive Disclosure**: Nur relevante Informationen werden geladen
- **Skill-Creator Skill**: Interaktive Skill-Erstellung durch Konversation

📦 **Skills API** (`/v1/skills`) - Programmatische Skill-Verwaltung
- Versionierung & Rollbacks
- Team-Distribution automatisiert
- A/B Testing möglich
- Beta: `anthropic-beta: skills-2025-10-02`

🧠 **Developer Platform** - Context Editing & Memory Tool für längere Tasks (→ [CLAUDE_CODE.md](CLAUDE_CODE.md#api-features))

**Ressourcen:**
- [Skills Blog Post](https://claude.com/blog/skills)
- [CLAUDE_DESKTOP.md - Skills-Sektion](CLAUDE_DESKTOP.md#d-skills---spezialisierte-fähigkeiten-für-claude)
- [WORKFLOWS.md - Skills-Workflows](WORKFLOWS.md#d-skills-basierte-workflows)
- [MCP_GUIDE.md - Skills vs. MCP](MCP_GUIDE.md#b1-skills-vs-mcp---wann-was-nutzen)

### Security & Tools

🔒 **Security Features**
- `/security-review` Command - Auto-Analyse für Vulnerabilities
- GitHub Actions Integration für CI/CD
- OWASP Top 10, SQL Injection, XSS Detection

🌐 **Weitere Updates**
- Claude for Chrome Extension (Max Users)
- "Imagine with Claude" Research Preview
- Consumer Terms Update (Opt-in Model Training)

---

## 🚀 Schnellstart

### Für Claude Code Nutzer

1. **Starten:** [CLAUDE_CODE.md](CLAUDE_CODE.md) → Installation & Kernfunktionen
2. **VS Code Extension:** [CLAUDE_CODE.md#vs-code-extension](CLAUDE_CODE.md)
3. **Checkpoints nutzen:** ESC ESC zum Rewind
4. **MCP integrieren:** [MCP_GUIDE.md](MCP_GUIDE.md)
5. **🆕 Tool-Auswahl:** [TOOL_SELECTION_GUIDE.md](TOOL_SELECTION_GUIDE.md) → Entscheidungsbaum
6. **Tool-Interaktionen:** [TOOL_INTERACTIONS.md](TOOL_INTERACTIONS.md) → Synergismen verstehen

### Für Claude Desktop Nutzer

1. **Starten:** [CLAUDE_DESKTOP.md](CLAUDE_DESKTOP.md) → Kernfunktionen
2. **MCP konfigurieren:** [MCP_GUIDE.md](MCP_GUIDE.md)
3. **Skills erstellen:** [CLAUDE_DESKTOP.md#skills](CLAUDE_DESKTOP.md)
4. **Projects nutzen:** [CLAUDE_DESKTOP.md#projects](CLAUDE_DESKTOP.md)

### Für Einsteiger

1. **Übersicht:** Diese README.md komplett lesen
2. **Basis:** [CLAUDE_CODE.md](CLAUDE_CODE.md) oder [CLAUDE_DESKTOP.md](CLAUDE_DESKTOP.md)
3. **Erweitern:** [MCP_GUIDE.md](MCP_GUIDE.md) für externe Integrationen
4. **Optimieren:** [WORKFLOWS.md](WORKFLOWS.md) für Best Practices
5. **🆕 Tool-Auswahl:** [TOOL_SELECTION_GUIDE.md](TOOL_SELECTION_GUIDE.md) → Wann welches Tool
6. **Vertiefen:** [TOOL_INTERACTIONS.md](TOOL_INTERACTIONS.md) → Wie Tools zusammenarbeiten

---

## 📊 Feature-Vergleich

| Feature | Claude Code | Claude Desktop | Web (claude.ai) |
|---------|-------------|----------------|-----------------|
| **Coding** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| **MCP Integration** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ❌ |
| **Checkpoints** | ⭐⭐⭐⭐⭐ | ❌ | ❌ |
| **Skills** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **VS Code Integration** | ⭐⭐⭐⭐⭐ | ❌ | ❌ |
| **Artifacts** | ❌ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Projects** | ❌ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Background Tasks** | ⭐⭐⭐⭐⭐ | ❌ | ❌ |
| **Autonomes Coding** | ⭐⭐⭐⭐⭐ (30h+) | ⭐⭐⭐ | ⭐⭐⭐ |

---

## 🎯 Empfohlene Use Cases

### Nutze Claude Code wenn:
- ✅ Intensives Coding & Refactoring
- ✅ CI/CD Integration gewünscht
- ✅ Lange autonome Coding-Sessions (30h+)
- ✅ Terminal-Workflows bevorzugt
- ✅ Git-Integration wichtig
- ✅ Background Tasks benötigt

### Nutze Claude Desktop wenn:
- ✅ Dokumentenerstellung (PPTX, XLSX, DOCX)
- ✅ MCP-Server für externe Datenquellen
- ✅ Projects für organisierte Arbeit
- ✅ Skills für wiederholbare Workflows
- ✅ GUI bevorzugt
- ✅ Google Docs Integration

### Nutze Beide:
- ⭐ Claude Code für Entwicklung
- ⭐ Claude Desktop für Dokumentation & Planning
- ⭐ MCP-Server in beiden Tools sharen

### 🆕 Nutze Skills wenn:
- ✅ Team-Workflows standardisieren (Commit Messages, Code Reviews, Testing)
- ✅ Brand Guidelines durchsetzen (Logo-Nutzung, Tone of Voice, Farbpaletten)
- ✅ Wiederholbare Prozesse haben (QBRs, Status Reports, Sprint Planning)
- ✅ Domain-Expertise kodifizieren (Legal Reviews, SEO, Compliance)
- ✅ Code-basierte Transformationen (Data Processing, Document Generation)
- ✅ Skills mit MCP kombinieren für End-to-End Automation

**Skills-Beispiele:**
- 📊 **QBR Automation**: Template + KPIs + Brand Guidelines → PPTX
- 👨‍⚖️ **Legal Contract Review**: Standard-Klauseln + Risiko-Patterns → Compliance-Check
- 🔄 **Sprint Planning**: Team Velocity + Capacity + Story Points → Planning Docs
- 🎨 **Brand Compliance**: Logo-Rules + Colors + Fonts → Auto-Formatting
- 💻 **Coding Standards**: ESLint + Naming + Documentation → Consistent Code

→ Siehe [CLAUDE_DESKTOP.md](CLAUDE_DESKTOP.md#d-skills---spezialisierte-fähigkeiten-für-claude) für Details

---

## 📚 Ressourcen

**Offizielle Links:**
- Claude Code Docs: https://docs.claude.com/en/docs/claude-code
- Release Notes: https://docs.claude.com/en/release-notes/claude-code
- MCP Website: https://modelcontextprotocol.io
- Anthropic Blog: https://anthropic.com/news
- Skills Docs: https://docs.claude.com/en/docs/skills

**Support:**
- General: https://support.claude.com
- Developer: https://docs.claude.com
- Community: GitHub Discussions

---

## 🔄 Changelog

### Version 3.4 (4. November 2025) - Tool Selection Guide

**Neue Dokumentation:**
- 🎯 **TOOL_SELECTION_GUIDE.md** - Meta-Dokumentation für strategische Tool-Auswahl
  - **Entscheidungsbaum** mit Mermaid-Visualisierung
  - **Feature-Vergleich** aller Tools (Skills, Commands, Subagents, MCP, Hooks)
  - **"Prompt First" Workflow** - Skalierung von einfach zu komplex
  - **Migrationspfade** (Prompt → Command → Skill/Subagent → +MCP)
  - **Use Case Matrix** mit 15+ detaillierten Praxisbeispielen
  - **Kompositionshierarchie** - Welches Tool kann welche Tools aufrufen
  - **Anti-Patterns** - 10 häufige Fehler dokumentiert
  - **FAQ** mit 15+ häufigen Fragen zur Tool-Auswahl
  - **Progressive Disclosure** vs. Context-Window-Explosion erklärt

**Basis:**
- Video-Tutorial: [How to choose the right approach](https://www.youtube.com/watch?v=kFpLzCVLA20)
- Ergänzt TOOL_INTERACTIONS.md (WIE) mit Meta-Ebene (WANN)

**Quelle:** GitHub Issue #7

---

### Version 3.3 (4. November 2025) - Feature-Erweiterung

**Neue Hauptsektionen in CLAUDE_CODE.md:**
- 🌐 **Sektion I:** Claude Code Web Version (Oktober 2025)
- 🔗 **Sektion J:** GitHub Integration (@claude Tagging)
- ⚙️ **Sektion K:** Erweiterte Konfiguration (CLAUDE.md Imports)

**Neue Features dokumentiert:**
- `/export` Command (Conversation Export)
- `/permissions` Command (Interaktive Permission-Verwaltung)
- `/statusline` Command (Custom Terminal Status)
- **Keyboard Shortcuts:** Ctrl+B, Ctrl+Z, Ctrl+U, Ctrl+_
- **Environment Variables:** USE_BUILTIN_RIPGREP, CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR
- **JetBrains Integration:** Basis-Infos hinzugefügt

**Updates & Korrekturen:**
- Plan Mode korrigiert (Shift+Tab **zweimal** drücken)
- Stop Hooks Details erweitert (Transcript Path, Exit Code, etc.)
- Claude Haiku 4.5 Details vervollständigt

**Breaking Changes dokumentiert:**
- Custom Slash Command Namespacing (Juli 2025)
- ANTHROPIC_LOG statt DEBUG=true

**Quelle:** GitHub Issue #1 (systematische Feature-Recherche)

---

### Version 3.2 (22. Oktober 2025)
- 🔄 **TOOL_INTERACTIONS.md** - Neue Datei für Tool-Synergismen & Interaktionsmuster

### Version 3.1 (22. Oktober 2025)
- 🔍 Dokumentation mit offiziellen Quellen verifiziert
- 📦 Box MCP-Server, Skills API, Context Editing & Memory Tool ergänzt

### Version 3.0 (22. Oktober 2025)
- ♻️ Modulare Struktur: Dokumentation in Einzeldateien aufgeteilt
- ✅ Oktober 2025 Updates vollständig integriert

---

## ✉️ Fragen & Feedback

Bei Fragen:
- **Inhalt:** Siehe entsprechende Einzeldateien für Details
- **Features:** Siehe offizielle Docs (Links oben)
- **Technische Issues:** Anthropic Support kontaktieren

---

**🎉 Claude Ecosystem Dokumentation - Ready to Use!**

Start: [CLAUDE_CODE.md](CLAUDE_CODE.md) | [CLAUDE_DESKTOP.md](CLAUDE_DESKTOP.md) | [MCP_GUIDE.md](MCP_GUIDE.md) | [WORKFLOWS.md](WORKFLOWS.md) | [TOOL_INTERACTIONS.md](TOOL_INTERACTIONS.md) | 🆕 [TOOL_SELECTION_GUIDE.md](TOOL_SELECTION_GUIDE.md)
