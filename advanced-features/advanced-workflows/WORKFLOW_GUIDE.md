# 🔄 Claude Code Workflow Guide für Anfänger

**Stand:** 21. November 2025
**Fokus:** Praktische Workflows für den täglichen Einsatz

---

## 📋 Inhaltsverzeichnis

1. [Der Basis-Workflow: Explore → Plan → Code → Commit](#1-der-basis-workflow)
2. [Test-Driven Development (TDD)](#2-test-driven-development)
3. [Visual Iteration Workflow](#3-visual-iteration-workflow)
4. [Context Management](#4-context-management)
5. [Checklists für komplexe Tasks](#5-checklists-für-komplexe-tasks)
6. [Multi-Claude Patterns](#6-multi-claude-patterns)
7. [Typische Anfänger-Workflows](#7-typische-anfänger-workflows)

---

## 1. Der Basis-Workflow

### 🎯 Der "Explore → Plan → Code → Commit" Workflow

Dies ist der **Kern-Workflow** für fast alle Aufgaben. Anthropic empfiehlt diesen Ansatz für maximale Qualität.

#### **Phase 1: Explore (Verstehen)**

**Ziel:** Claude soll den Context verstehen, OHNE Code zu schreiben

```bash
# In Claude Session:
"Lies bitte alle Python-Dateien im src/ Ordner und erkläre mir die Architektur.
Schreibe noch keinen Code, analysiere nur."
```

**💡 Warum wichtig?**
- Claude verschwendet keinen Context auf falschen Code
- Du verstehst dein Projekt besser
- Bessere Planung möglich

**Beispiel-Prompts:**
```
"Welche Dateien sind für die User-Authentifizierung zuständig?"
"Wie funktioniert das Routing in diesem PHP-Projekt?"
"Zeige mir die WordPress Theme-Struktur"
```

#### **Phase 2: Plan (Planen)**

**Ziel:** Detaillierter Plan BEVOR Code geschrieben wird

```bash
# Plan Mode aktivieren (optional)
/plan

# Oder direkt:
"Erstelle einen detaillierten Plan, wie wir eine Login-Funktion
mit Best Practices implementieren können. Noch keinen Code schreiben!"
```

**Was ein guter Plan enthält:**
- ✅ Welche Dateien erstellt/geändert werden
- ✅ Welche Tests geschrieben werden
- ✅ Abhängigkeiten/Packages
- ✅ Sicherheitsaspekte
- ✅ Schritt-für-Schritt Vorgehen

**💡 Tipp:** Nutze `think` für extended thinking:
```
"Denke gründlich nach und erstelle einen Plan für..."
```

#### **Phase 3: Code (Implementieren)**

**Ziel:** Plan umsetzen mit Verifikation

```bash
"Implementiere jetzt den Plan Schritt für Schritt.
Nach jedem Schritt:
1. Code schreiben
2. Tests schreiben/anpassen
3. Testen ob es funktioniert
4. Mir Bescheid geben"
```

**Best Practices beim Coden:**
- ✅ **Kleine Schritte** - nicht alles auf einmal
- ✅ **Tests parallel** - TDD wenn möglich
- ✅ **Verifizieren** - Claude soll Code testen
- ✅ **Verstehen** - Lass dir erklären was Claude macht

**Beispiel-Ablauf:**
```
1. "Erstelle die User Model Klasse mit Docstrings"
   → Review
2. "Schreibe Tests für die User Model Klasse"
   → Tests laufen
3. "Implementiere die Login-Logik"
   → Review
4. "Tests für Login-Logik"
   → Alle Tests grün
```

#### **Phase 4: Commit (Versionieren)**

**Ziel:** Saubere Git History mit guten Commit Messages

```bash
# Claude kann Commits erstellen:
"Erstelle einen Git Commit mit aussagekräftiger Message
für die Login-Implementierung"

# Claude macht:
# 1. git status (prüfen)
# 2. git diff (Changes reviewen)
# 3. git add (relevante Files)
# 4. git commit -m "feat: Add user login with bcrypt password hashing"
```

**💡 Commit Best Practices:**
- Ein Feature = Ein Commit
- Beschreibende Messages (nicht "fixed stuff")
- Tests laufen vor Commit

---

## 2. Test-Driven Development

### 🧪 TDD für Anfänger

TDD = **Erst Tests, dann Code**. Klingt rückwärts, ist aber extrem effektiv!

#### **Der TDD Workflow**

```
1. Test schreiben (der erstmal fehlschlägt)
2. Code implementieren (bis Test grün wird)
3. Refactoring (Code verbessern)
4. Repeat
```

#### **Praktisches Beispiel: Python Funktion**

**Step 1: Test schreiben**
```bash
# Prompt:
"Schreibe pytest Tests für eine Funktion calculate_discount(price, percentage),
die folgendes können soll:
- 10% Rabatt auf 100€ = 90€
- 0% Rabatt = Original Preis
- 100% Rabatt = 0€
- Negative Werte werfen ValueError

Implementiere die Funktion noch NICHT, nur Tests!"
```

**Claude erstellt `test_discount.py`:**
```python
import pytest
from src.pricing import calculate_discount

def test_ten_percent_discount():
    assert calculate_discount(100, 10) == 90

def test_zero_discount():
    assert calculate_discount(50, 0) == 50

def test_full_discount():
    assert calculate_discount(100, 100) == 0

def test_negative_price_raises_error():
    with pytest.raises(ValueError):
        calculate_discount(-10, 10)

def test_negative_percentage_raises_error():
    with pytest.raises(ValueError):
        calculate_discount(100, -5)
```

**Step 2: Tests sollten fehlschlagen**
```bash
"Führe die Tests aus - sie sollten fehlschlagen (weil Funktion fehlt)"

# Claude macht:
# pytest test_discount.py
# → ModuleNotFoundError oder ImportError ✅ (erwartet!)
```

**Step 3: Code implementieren**
```bash
"Implementiere jetzt die calculate_discount Funktion,
sodass alle Tests grün werden"
```

**Step 4: Tests sollten grün sein**
```bash
"Führe Tests erneut aus"

# Claude macht:
# pytest test_discount.py
# → All tests passed ✅
```

**Step 5: Commit**
```bash
"Committe die Tests und die Implementierung"
```

### 💡 TDD Vorteile für Anfänger

✅ **Du verstehst was der Code tun soll** (Tests sind Spezifikation)
✅ **Weniger Bugs** (Tests fangen Fehler früh)
✅ **Refactoring sicher** (Tests zeigen ob was kaputt geht)
✅ **Dokumentation** (Tests zeigen wie Code benutzt wird)

---

## 3. Visual Iteration Workflow

### 🎨 Mit Screenshots arbeiten

Besonders nützlich für **WordPress Themes, HTML/CSS, UI-Arbeit**.

#### **Workflow:**

**1. Screenshot erstellen**
```bash
# Mach einen Screenshot deiner aktuellen Seite
# z.B. current-homepage.png
```

**2. Screenshot zu Claude**
```bash
# In Claude:
"Ich habe hier einen Screenshot meiner WordPress Homepage.
Analyse bitte das Design und schlage Verbesserungen vor."

# Bild einfügen (Drag & Drop oder Pfad angeben)
```

**3. Implementierung mit Feedback-Schleife**
```bash
# Claude schlägt vor:
"Ich würde empfehlen:
1. Header sticky machen
2. Call-to-Action Button prominenter
3. Mobile Responsiveness verbessern"

# Du sagst:
"Implementiere Punkt 1 und 2 bitte"

# Claude macht Code-Änderungen

# Du testest und machst neuen Screenshot
"Hier der neue Screenshot - ist das besser?"

# 2-3 Iterationen bis perfekt
```

#### **Beispiel: WordPress Theme Anpassung**

```bash
# Iteration 1:
"Screenshot: Header ist zu groß, Logo unsichtbar"
→ Claude: Fixes CSS
→ Screenshot zeigen

# Iteration 2:
"Screenshot: Besser! Aber Navigation zu nah am Logo"
→ Claude: Adjust spacing
→ Screenshot zeigen

# Iteration 3:
"Screenshot: Perfekt! Jetzt für Mobile optimieren"
→ Claude: Media Queries
→ Mobile Screenshot zeigen
```

### 💡 Visual Iteration Tipps

- **Annotierte Screenshots** - markiere Probleme mit Pfeilen/Kreisen
- **Vorher/Nachher** - zeige beide Screenshots
- **Spezifisch sein** - "Button sollte #FF5733 sein" statt "rötlicher"

---

## 4. Context Management

### 🧹 Context sauber halten

Claude hat einen **begrenzten Context**. Du musst ihn sauber halten!

#### **Das Problem:**

```
Session Start:
→ 10 Dateien gelesen
→ Feature A implementiert
→ Feature B implementiert
→ Feature C besprochen
→ Altes Zeug besprochen
→ Context überfüllt! ❌
→ Claude vergisst Dinge
→ Schlechtere Responses
```

#### **Die Lösung: `/clear`**

```bash
# Nach jedem größeren Task:
/clear

# Beispiel-Workflow:
1. Feature A implementieren
2. Testen, committen
3. /clear
4. Feature B implementieren (frischer Context)
```

#### **Wann `/clear` nutzen?**

✅ Nach erfolgreichem Commit
✅ Zwischen verschiedenen Features
✅ Wenn Claude "verwirrt" wirkt
✅ Nach längeren Diskussionen
✅ Spätestens nach 20-30 Messages

#### **Was bleibt nach `/clear`?**

✅ CLAUDE.md wird neu geladen
✅ .claude/ Config bleibt
✅ Files auf Disk bleiben
❌ Chat History weg (ist OK!)

### 📝 CLAUDE.md als "Gedächtnis"

Statt alles im Chat zu wiederholen → In CLAUDE.md schreiben:

```markdown
# CLAUDE.md

## Projekt-Kontext (bleibt immer verfügbar)

### Architektur-Entscheidungen
- Wir nutzen Repository Pattern für Datenbank
- API Routes haben /api/v1/ Prefix
- Auth mit JWT Tokens

### Bekannte Probleme
- Legacy Code in old_system/ nicht anfassen
- WordPress Plugin XYZ macht Probleme mit Cache

### Coding Conventions
- Type Hints in allen Funktionen
- Docstrings im Google Style
```

**💡 Vorteil:** Nach `/clear` "erinnert" sich Claude über CLAUDE.md!

---

## 5. Checklists für komplexe Tasks

### ✅ Mit Markdown-Checklists arbeiten

Für große Aufgaben: Claude erstellt eine Checklist und arbeitet sie ab.

#### **Beispiel: WordPress Migration**

```bash
# Prompt:
"Wir müssen unser WordPress auf einen neuen Server migrieren.
Erstelle eine Checklist mit allen Schritten und arbeite sie dann ab."
```

**Claude erstellt:**
```markdown
# WordPress Migration Checklist

## Vorbereitung
- [ ] Backup der Datenbank erstellen
- [ ] Backup der wp-content Files
- [ ] PHP/MySQL Versionen auf neuem Server prüfen
- [ ] DNS TTL auf 5 Minuten setzen

## Migration
- [ ] Datenbank auf neuen Server importieren
- [ ] Files via SFTP übertragen
- [ ] wp-config.php anpassen
- [ ] Database Search/Replace URLs
- [ ] Permalinks neu speichern

## Testing
- [ ] Homepage testen
- [ ] Login testen
- [ ] Plugins aktivieren
- [ ] Theme testen
- [ ] Formulare testen

## Go-Live
- [ ] DNS umstellen
- [ ] SSL Zertifikat prüfen
- [ ] Performance testen
- [ ] 24h Monitoring
```

**Claude arbeitet ab:**
```bash
# Claude macht Schritt 1:
"✅ Datenbank Backup erstellt: backup_2025-11-21.sql"

# Du bestätigst:
"OK, weiter"

# Claude macht Schritt 2:
"✅ Files gebackupt: wp-content-backup.tar.gz"

# etc...
```

### 💡 Checklist Best Practices

- **Detailliert** - jeder Schritt klar definiert
- **Testbar** - nach jedem Schritt verifizierbar
- **Sequenziell** - in logischer Reihenfolge
- **Mit Claude erstellen** - Claude kennt Best Practices

---

## 6. Multi-Claude Patterns

### 👥 Mehrere Claude Instanzen nutzen

**Für Anfänger:** Später relevant, aber gut zu wissen!

#### **Pattern 1: Writer + Reviewer**

```bash
# Terminal 1: Claude schreibt Code
claude
> "Implementiere Login-Feature"

# Terminal 2: Claude reviewt Code
claude
> "Review den Code in src/auth/login.py nach Security Best Practices"
```

#### **Pattern 2: Parallele Features**

```bash
# Terminal 1: Feature A
cd project
git worktree add ../project-feature-a feature/a
cd ../project-feature-a
claude
> "Implementiere Feature A"

# Terminal 2: Feature B
cd ../project
git worktree add ../project-feature-b feature/b
cd ../project-feature-b
claude
> "Implementiere Feature B"
```

**💡 Für Anfänger:** Eine Instanz reicht erstmal!

---

## 7. Typische Anfänger-Workflows

### 🎯 Workflow-Bibliothek für deinen Alltag

#### **Workflow: Neues Python Script erstellen**

```bash
# 1. Plan erfragen
"Ich brauche ein Python Script das [X] macht.
Erstelle einen Plan mit Best Practices."

# 2. Implementieren lassen
"Implementiere den Plan mit:
- Type Hints
- Docstrings
- Error Handling
- Main-Guard"

# 3. Tests schreiben
"Schreibe pytest Tests für alle Funktionen"

# 4. Testen
"Führe die Tests aus"

# 5. Committen
"Committe alles mit guter Message"
```

#### **Workflow: Bug fixen**

```bash
# 1. Problem beschreiben
"Ich habe einen Bug: [Beschreibung]
Hier ist der Error: [Error Message]"

# 2. Analyse
"Finde die Ursache des Problems"

# 3. Test schreiben (!)
"Schreibe einen Test der den Bug reproduziert"

# 4. Fixen
"Fixe jetzt den Bug sodass der Test grün wird"

# 5. Verifizieren
"Alle Tests laufen? Auch die alten?"

# 6. Committen
"Committe den Fix"
```

#### **Workflow: WordPress Plugin anpassen**

```bash
# 1. Plugin verstehen
"Lies das Plugin in wp-content/plugins/mein-plugin/
und erkläre mir wie es funktioniert"

# 2. Change planen
"Ich möchte Feature X hinzufügen.
Welche Files müssen geändert werden?"

# 3. Backup (!)
"Erstelle ein Backup des Plugins"

# 4. Implementieren
"Implementiere Feature X nach WordPress Best Practices"

# 5. Testen
"Zeige mir Test-Schritte zum manuellen Testen"

# 6. Committen
"Committe die Änderungen"
```

#### **Workflow: Code verstehen (Onboarding)**

```bash
# 1. Overview
"Gib mir einen Überblick über dieses Projekt"

# 2. Architektur
"Erkläre die Ordner-Struktur und Architektur"

# 3. Spezifisch nachfragen
"Wie funktioniert [spezifisches Feature]?"
"Wo ist [X] implementiert?"
"Warum wurde [Y] so gemacht?"

# 4. Dokumentieren
"Füge die Erkenntnisse zu CLAUDE.md hinzu"
```

---

## 🎓 Zusammenfassung

### **Die 3 Kern-Prinzipien:**

1. **Plan → Code → Test → Commit**
   - Nicht direkt losschreiben
   - Immer Planen
   - Immer Testen
   - Sauber Committen

2. **Context Management**
   - `/clear` regelmäßig nutzen
   - CLAUDE.md als Gedächtnis
   - Fokussiert bleiben

3. **Verstehen vor Übernehmen**
   - Claude's Code reviewen
   - Tests verstehen
   - Nie blind copy/paste

### **Nächste Schritte:**

✅ [GIT_WORKFLOW.md](./GIT_WORKFLOW.md) - Git Best Practices lernen
✅ [Slash Commands](./slash-commands/) - Workflows automatisieren
✅ [CLAUDE_MD_TEMPLATE.md](./CLAUDE_MD_TEMPLATE.md) - Projekt-Kontext erstellen

---

**Happy Coding mit Claude! 🚀**
