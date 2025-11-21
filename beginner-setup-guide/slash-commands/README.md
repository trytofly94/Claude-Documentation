# ⚡ Slash Commands für Anfänger

**Stand:** 21. November 2025

## 📋 Was sind Slash Commands?

Slash Commands sind **wiederverwendbare Prompt-Templates**, die du schnell aufrufen kannst:
- Speichere häufige Workflows als `.md` Dateien
- Rufe sie auf mit `/command-name`
- Verwende `$ARGUMENTS` für Parameter

## 📦 Installation

```bash
# In deinem Projekt-Root:
mkdir -p .claude/commands

# Kopiere die Commands aus diesem Ordner:
cp slash-commands/*.md .claude/commands/
```

## 📚 Verfügbare Commands

### 🎯 Allgemeine Entwicklung

#### `/plan-feature`
Plant ein neues Feature mit Best Practices.

**Usage:**
```
/plan-feature User Authentication System
```

#### `/test-code`
Schreibt Tests für existierenden Code.

**Usage:**
```
/test-code src/auth/login.py
```

#### `/review-code`
Führt einen Code Review durch.

**Usage:**
```
/review-code src/services/payment.py
```

### 🔀 Git & Version Control

#### `/commit-changes`
Erstellt einen sauberen Git Commit mit guter Message.

**Usage:**
```
/commit-changes
```

#### `/create-pr`
Erstellt einen Pull Request mit ausführlicher Description.

**Usage:**
```
/create-pr
```

### 🐛 Debugging

#### `/debug-error`
Analysiert einen Error und schlägt Fixes vor.

**Usage:**
```
/debug-error AttributeError: 'NoneType' object has no attribute 'email'
```

#### `/wordpress-debug`
WordPress-spezifisches Debugging.

**Usage:**
```
/wordpress-debug
```

### 🔍 Code Understanding

#### `/explain-code`
Erklärt wie ein Code-Teil funktioniert.

**Usage:**
```
/explain-code src/complex_algorithm.py
```

#### `/document-code`
Fügt Dokumentation zu Code hinzu.

**Usage:**
```
/document-code src/utils/helpers.py
```

### 🚀 Performance & Security

#### `/security-review`
Prüft Code auf Security-Issues.

**Usage:**
```
/security-review src/auth/
```

#### `/optimize-performance`
Analysiert und optimiert Performance.

**Usage:**
```
/optimize-performance src/api/endpoints.py
```

## 🎓 Eigene Commands erstellen

### Template

```markdown
<!-- .claude/commands/mein-command.md -->

Beschreibe hier was Claude tun soll.

Du kannst Parameter verwenden: $ARGUMENTS

Beispiel:
- Analysiere die Datei: $ARGUMENTS
- Schreibe Tests dafür
- Erstelle Dokumentation
```

### Beispiel: Custom Python Test Command

```markdown
<!-- .claude/commands/pytest-tdd.md -->

Führe Test-Driven Development für $ARGUMENTS durch:

1. **Verstehe die Anforderung**
   - Lies die Funktion/Klasse
   - Identifiziere Testfälle

2. **Schreibe Tests ERST**
   - Edge Cases abdecken
   - Positive & Negative Tests
   - Nutze pytest Fixtures

3. **Verifiziere Tests schlagen fehl**
   - Führe pytest aus
   - Stelle sicher Tests sind rot

4. **Implementiere Code**
   - Schreibe Minimal-Code für grüne Tests

5. **Refactor**
   - Code verbessern
   - Tests sollten grün bleiben

6. **Report**
   - Zeige Test Coverage
   - Zeige Zusammenfassung
```

**Usage:**
```
/pytest-tdd src/calculator.py
```

## 💡 Best Practices

### ✅ Dos

1. **Spezifisch sein** - Je genauer der Prompt, desto besser das Ergebnis
2. **Struktur nutzen** - Numbered Lists, Bullets für Klarheit
3. **Context geben** - Referenziere CLAUDE.md Standards
4. **Wiederholbar machen** - Commands sollten konsistente Ergebnisse liefern
5. **$ARGUMENTS nutzen** - Macht Commands flexibel

### ❌ Don'ts

1. **Nicht zu generisch** - "Mach es besser" hilft nicht
2. **Nicht zu lang** - 20-30 Zeilen sind ideal
3. **Keine Secrets** - Keine API Keys in Commands
4. **Nicht hardcoden** - Nutze $ARGUMENTS statt fixer Werte

## 🔗 Weiterführend

- **[WORKFLOW_GUIDE.md](../WORKFLOW_GUIDE.md)** - Wie Workflows zusammenspielen
- **[TOOL_INTERACTIONS.md](../../TOOL_INTERACTIONS.md)** - Slash Commands + Skills + Hooks

---

**Slash Commands machen dich 10x produktiver! ⚡**
