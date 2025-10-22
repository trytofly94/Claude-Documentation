# 📚 CLAUDE ECOSYSTEM DOKUMENTATION

**Stand:** 22. Oktober 2025
**Version:** 3.0 - Modulare Struktur mit allen Oktober 2025 Updates

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

**Wichtigste Updates:**
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

## 🆕 Wichtigste Updates Oktober 2025

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

### API & Skills Updates

📦 **Skills API** (`/v1/skills`)
- Programmatische Skill-Verwaltung
- Versionierung & Rollback
- Skill-Creator für interaktive Erstellung
- Box Integration Skills

🧠 **Developer Platform**
- Context Editing für längere Tasks
- Memory Tool für persistentes Memory
- Erweiterte API-Funktionen

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

### Version 3.1 (22. Oktober 2025) - Aktuelle Web-Recherche
- 🔍 **Alle Punkte mit aktueller Dokumentation verifiziert**
- ⚠️ **"Imagine with Claude"** - Korrigiert als temporäres Feature (war nur Sept 29 - Okt 11, 2025)
- 🧪 **Context Editing** - Beta-Status und korrekte Beta-Header dokumentiert (`context-management-2025-06-27`)
- 💾 **Memory Tool** - Als file-based, client-side System korrekt beschrieben
- 🎯 **Skills API** - Beta-Header hinzugefügt (`anthropic-beta: skills-2025-10-02`), Launch-Datum 16. Okt 2025
- 📦 **Box Integration** - Von Skills zu MCP verschoben (ist MCP-Server, kein Skill)
- ✅ Performance-Metriken für Context Editing + Memory Tool ergänzt
- ✅ Offizielle Dokumentations-Links hinzugefügt

### Version 3.0 (22. Oktober 2025)
- ♻️ Dokument in modulare Struktur aufgeteilt
- ✅ Alle Oktober 2025 Updates integriert
- ✅ Legacy CLI Integration dokumentiert
- ✅ API Features (Context Editing, Memory Tool) hinzugefügt
- ✅ Skills API & Box Integration dokumentiert
- ✅ "Imagine with Claude" beschrieben
- ✅ Skill-Creator & Enterprise Deployment hinzugefügt

### Version 2.0 (22. Oktober 2025)
- ✅ Claude Code 2.0 Features komplett
- ✅ Claude Sonnet 4.5 Updates
- ✅ Security Features dokumentiert

### Version 1.0 (Initial)
- ✅ Basis-Recherche abgeschlossen
- ✅ Alle 6 Schritte dokumentiert

---

## ✉️ Fragen & Feedback

Bei Fragen:
- **Inhalt:** Siehe entsprechende Einzeldateien für Details
- **Features:** Siehe offizielle Docs (Links oben)
- **Technische Issues:** Anthropic Support kontaktieren

---

**🎉 Claude Ecosystem Dokumentation - Ready to Use!**

Start: [CLAUDE_CODE.md](CLAUDE_CODE.md) | [CLAUDE_DESKTOP.md](CLAUDE_DESKTOP.md) | [MCP_GUIDE.md](MCP_GUIDE.md) | [WORKFLOWS.md](WORKFLOWS.md)
