# 🚀 Claude Code für Anfänger - Basis Setup

**Stand:** 25. November 2025
**Zielgruppe:** Entwickler die einfach starten wollen - ohne Überforderung
**Philosophie:** Fokussiert bleiben, Schritt für Schritt lernen

---

## 🎯 Was ist das hier?

Ein **minimales, fokussiertes Setup** für Claude Code. Keine Überforderung, keine 100 Features auf einmal. Nur das Wesentliche:

✅ Claude Code richtig installieren
✅ Mit einem einfachen Workflow arbeiten
✅ Projekte sauber dokumentieren
✅ Git für Backups nutzen
✅ **Später:** Advanced Features freischalten wenn bereit

---

## 🏁 Schnellstart (15 Minuten)

### Schritt 1: Installation
```bash
# Claude Code installieren
npm install -g @anthropic-ai/claude-code

# In dein Projekt wechseln
cd /pfad/zu/deinem/projekt
```

👉 **Mehr Details:** [INSTALLATION.md](INSTALLATION.md)

### Schritt 2: Basis-Templates kopieren
```bash
# Projekt-Templates kopieren
cp beginner-setup-guide/templates/README.md ./README.md
cp beginner-setup-guide/templates/session-notes.md ./session-notes.md
cp beginner-setup-guide/templates/CLAUDE.md ./CLAUDE.md

# System-Verhalten einrichten
mkdir -p ~/.claude
cp beginner-setup-guide/system/CLAUDE.md ~/.claude/CLAUDE.md
```

### Schritt 3: Templates anpassen
```bash
# README.md öffnen und Projekt-Info eintragen
# CLAUDE.md öffnen und Tech Stack anpassen
```

### Schritt 4: Claude starten
```bash
claude
```

**Das war's! Du kannst loslegen.** 🎉

---

## 📚 Die 4 Basis-Phasen

Claude arbeitet am besten mit diesem einfachen Workflow:

### **1. Explore (Verstehen)** 🔍
```
"Lies bitte die Datei script.py und erkläre mir was sie macht.
Schreibe noch keinen Code."
```

### **2. Plan (Planen)** 📋
```
"Erstelle einen Plan wie wir Feature X hinzufügen können.
Noch nichts implementieren!"
```

### **3. Code (Umsetzen)** ⚙️
```
"Implementiere jetzt den Plan Schritt für Schritt."
```

### **4. Commit (Sichern)** 💾
```
"Erstelle ein Git Backup mit einer guten Beschreibung."
```

👉 **Mehr Details:** [BASIS_WORKFLOW.md](BASIS_WORKFLOW.md)

---

## 📁 Projekt-Struktur (Basis)

Nach dem Setup hat dein Projekt:

```
mein-projekt/
├── README.md              # Projekt-Beschreibung + TODO-Liste
├── session-notes.md       # Was wurde gemacht? Entscheidungen? Probleme?
├── CLAUDE.md              # Minimal-Info für Claude (Tech Stack, etc.)
├── .git/                  # Git für Backups (automatisch)
└── dein-code/             # Dein eigentlicher Code
```

**Das reicht!** Keine 50 Config-Files, keine komplexen Hooks. Einfach arbeiten.

---

## 🎓 Wie arbeite ich mit diesem System?

### Typische Session:

```bash
# 1. Claude starten
claude

# 2. Aufgabe beschreiben
"Ich möchte in script.py die Funktion calculate() verbessern"

# 3. Claude führt die 4 Phasen durch:
#    - Explore: Liest script.py
#    - Plan: Erstellt Plan
#    - Code: Implementiert
#    - Commit: Erstellt Git Backup

# 4. Session-Notes werden aktualisiert
# 5. Fertig!
```

### Claude's Verhalten (wichtig!)

Claude wird **NUR** das tun was du sagst:
- ✅ Konkrete Aufgabe erledigen
- ✅ Kurze Doku in session-notes.md schreiben
- ✅ Bei großen Änderungen: Git Backup
- ✅ Verbesserungen **vorschlagen** ist OK
- ❌ **NICHT** ungefragt Features implementieren
- ❌ **NICHT** .env/.gitignore/Tests erstellen ohne Aufforderung
- ❌ **NICHT** ganze Projekt-Strukturen scaffolden

**Wenn du mehr willst, sagst du es explizit!**

---

## 🎯 Was ist mit Tests, Hooks, Automation?

Die gibt es alle - aber **später**, wenn du bereit bist!

### Advanced Features freischalten:

Wenn du mit der Basis zufrieden bist und mehr willst:

👉 **[advanced-features/README.md](../advanced-features/README.md)**

Dort findest du:
- ⚡ Slash Commands (Automatisierung)
- 🪝 Hooks (Event-basiert)
- 🧪 Test-Driven Development
- 🔄 Erweiterte Workflows
- 📦 Komplexe Templates

**Aber erst wenn du soweit bist!** Kein Stress.

---

## 💡 Häufige Fragen

### "Muss ich Git können?"
**Basis-Level reicht:** `git add`, `git commit`, `git push`
Claude hilft dir dabei! In [BASIS_WORKFLOW.md](BASIS_WORKFLOW.md) steht alles.

### "Was wenn Claude zu viel macht?"
Schau in `~/.claude/CLAUDE.md` - da stehen die Limits.
Wenn Claude trotzdem zu proaktiv ist: "Bitte nur das machen was ich sage!"

### "Kann ich die Advanced Features später nutzen?"
**Ja!** Das ist genau der Punkt. Fang einfach an, lerne die Basis, upgrade später.

### "Was wenn ich noch Fragen habe?"
- 📖 [BASIS_WORKFLOW.md](BASIS_WORKFLOW.md) durchlesen
- 💬 Claude einfach fragen: "Wie funktioniert X?"
- 🆘 Bei Problemen: [INSTALLATION.md](INSTALLATION.md) Troubleshooting

---

## 🎯 Nächste Schritte

1. ✅ [INSTALLATION.md](INSTALLATION.md) durcharbeiten (10 Min)
2. ✅ Templates ins Projekt kopieren (2 Min)
3. ✅ [BASIS_WORKFLOW.md](BASIS_WORKFLOW.md) lesen (10 Min)
4. ✅ Erste Session mit Claude! 🚀
5. ⏸️ **Später:** [Advanced Features](../advanced-features/README.md) anschauen

---

## 📜 Philosophie dieses Systems

### **Fokussiert statt überwältigt**
Nicht alle Features auf einmal. Schritt für Schritt.

### **Explizit statt magisch**
Claude macht nur was du sagst. Keine Überraschungen.

### **Wachsen wenn bereit**
Advanced Features sind da - aber nur wenn du sie willst.

### **Praktisch statt theoretisch**
Direkt loslegen. Learning by doing.

---

**Viel Erfolg! 🚀**

*PS: Wenn du die Basis gemeistert hast, schau dir [advanced-features/](../advanced-features/) an. Da wird's dann richtig cool!* 😎
