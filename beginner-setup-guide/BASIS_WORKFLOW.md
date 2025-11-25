# 🔄 Basis Workflow - Die 4 Phasen

**Dauer:** 10 Minuten Lesezeit
**Zweck:** Lerne wie du mit Claude Code effektiv arbeitest

---

## 🎯 Die Grundidee

Claude arbeitet am besten wenn du ihm sagst:
1. **Was** er tun soll (klar und konkret)
2. **Wie viel** er tun soll (nur das Nötige)
3. **Wann** er nachfragen soll (bei Unsicherheit)

**Prinzip:** Schritt für Schritt, nicht alles auf einmal.

---

## 📚 Die 4 Phasen

Jede Aufgabe durchläuft diese Phasen:

### **1. Explore (Verstehen)** 🔍

**Zweck:** Claude soll verstehen WAS da ist, BEVOR er ändert.

**Beispiel:**
```
User: "Lies bitte script.py und erkläre mir was es macht.
      Schreibe noch keinen Code!"
```

**Claude macht:**
- Liest die Datei
- Analysiert den Code
- Erklärt die Funktionalität
- **Schreibt KEINEN Code**

**Warum wichtig?**
- Claude verschwendet keinen Context mit falschem Code
- Du verstehst dein Projekt besser
- Bessere Planung ist möglich

---

### **2. Plan (Planen)** 📋

**Zweck:** Plan erstellen BEVOR Code geschrieben wird.

**Beispiel:**
```
User: "Erstelle einen Plan wie wir eine Login-Funktion hinzufügen.
      Noch nichts implementieren!"
```

**Claude macht:**
- Erstellt detaillierten Plan
- Listet nötige Schritte auf
- Zeigt dir den Plan
- Wartet auf deine Freigabe

**Beispiel-Plan:**
```markdown
## Plan: Login-Funktion

### Schritt 1: Login-Datei erstellen
- Neue Datei: auth/login.py

### Schritt 2: Login-Funktion
- Email/Password Inputs validieren
- Password gegen Datenbank prüfen
- Session-Token generieren

### Schritt 3: Integration
- Login-Route in main.py registrieren

### Schritt 4: Backup
- Git Commit mit Beschreibung

Soll ich so vorgehen?
```

**Du sagst:** "Ja, mach weiter" oder "Ändere Schritt 2..."

**Warum wichtig?**
- Keine Überraschungen
- Du behältst Kontrolle
- Änderungen vor Implementation einfacher

---

### **3. Code (Umsetzen)** ⚙️

**Zweck:** Plan Schritt für Schritt umsetzen.

**Beispiel:**
```
User: "Implementiere jetzt den Plan."
```

**Claude macht:**
- Arbeitet Plan Schritt für Schritt ab
- Zeigt dir nach jedem Schritt den Status
- Fragt bei Problemen nach

**Beispiel-Ablauf:**
```
Claude: "✅ Schritt 1 erledigt: login.py erstellt"

Claude: "✅ Schritt 2 erledigt: Login-Funktion implementiert"

Claude: "✅ Schritt 3 erledigt: Route registriert"

Claude: "Alle Schritte abgeschlossen! Soll ich committen?"
```

**Warum wichtig?**
- Transparenz - du siehst was passiert
- Bei Problemen kann unterbrochen werden
- Schrittweise Verification möglich

---

### **4. Commit (Sichern)** 💾

**Zweck:** Änderungen in Git sichern.

**Beispiel:**
```
User: "Ja, committe das bitte."
```

**Claude macht:**
- `git status` prüfen
- `git diff` zeigen
- Passende Dateien stagen
- Gute Commit Message erstellen
- Committen

**Beispiel-Commit:**
```bash
git commit -m "feat: Add user login with password authentication

- Created auth/login.py with login function
- Email and password validation
- Session token generation
- Integrated login route in main.py"
```

**Zusätzlich:** Claude updated `session-notes.md`
```markdown
## 2025-11-25: Login-Funktion hinzugefügt

### Durchgeführt
- Login mit Email/Password
- Bcrypt Password Hashing
- Session Token (24h Gültigkeit)

### Entscheidungen
- Bcrypt weil sicherer als SHA256
```

**Warum wichtig?**
- Backup falls etwas schief geht
- History deiner Änderungen
- Dokumentation was wann gemacht wurde

---

## 🎓 Praktisches Beispiel

### Aufgabe: "Verbessere die calculate() Funktion"

### Session-Verlauf:

**Phase 1: Explore**
```
User: "Lies script.py und erkläre mir die calculate() Funktion"

Claude: "Die Funktion macht aktuell:
- Addition von zwei Zahlen
- Gibt Ergebnis zurück
- PROBLEM: Keine Fehlerbehandlung wenn Input kein Number"
```

**Phase 2: Plan**
```
User: "Erstelle Plan wie wir das verbessern"

Claude: "Plan:
1. Input-Validierung hinzufügen (prüfe ob Number)
2. Fehlerbehandlung (ValueError wenn kein Number)
3. Docstring hinzufügen
4. Git Commit

OK?"

User: "Ja"
```

**Phase 3: Code**
```
User: "Implementiere den Plan"

Claude: "✅ Input-Validierung hinzugefügt"
Claude: "✅ ValueError bei ungültigem Input"
Claude: "✅ Docstring geschrieben"
Claude: "Fertig! Soll ich committen?"
```

**Phase 4: Commit**
```
User: "Ja"

Claude: "✅ Git Commit erstellt: 'feat: Add input validation to calculate()'"
Claude: "✅ session-notes.md updated"

Claude: "Alles erledigt! 🎉"
```

---

## 💾 Git Basics

Du musst kein Git-Experte sein, aber Basics helfen:

### Die wichtigsten Commands

```bash
# Status anzeigen (was ist geändert?)
git status

# Änderungen anzeigen
git diff

# Alle Änderungen committe (Claude macht das meist)
git add .
git commit -m "Beschreibung"

# History anzeigen
git log --oneline

# Pushen zu GitHub (optional)
git push
```

### Claude hilft dir!

Du musst Git Commands nicht selbst ausführen:
```
User: "Zeig mir was geändert wurde"
→ Claude: Führt `git diff` aus

User: "Committe die Änderungen"
→ Claude: Macht `git add` + `git commit` + gute Message

User: "Zeig mir die History"
→ Claude: Führt `git log` aus
```

**Du bestimmst, Claude führt aus!**

---

## 🎯 Typische Workflows

### Workflow 1: Bug fixen

```
1. "Lies file.py und finde den Bug bei X"  [Explore]
2. "Erstelle Plan wie wir das fixen"       [Plan]
3. "Implementiere den Fix"                 [Code]
4. "Committe das"                          [Commit]
```

### Workflow 2: Feature hinzufügen

```
1. "Lies die relevanten Files für Feature X"  [Explore]
2. "Erstelle Plan für Feature X"              [Plan]
3. "Implementiere Schritt 1 des Plans"        [Code - Teil 1]
4. "Jetzt Schritt 2"                          [Code - Teil 2]
5. "Committe alles"                           [Commit]
```

### Workflow 3: Code verstehen

```
1. "Erkläre mir wie auth/login.py funktioniert"  [Explore]
2. "Was macht die Funktion verify_password()?"   [Explore]
3. "Gibt es potenzielle Probleme?"               [Explore]
4. "Dokumentiere das in session-notes.md"        [Dokumentation]
```

---

## 💡 Best Practices

### ✅ DO

**Sei spezifisch:**
```
❌ "Verbessere den Code"
✅ "Füge Input-Validierung zu calculate() hinzu"
```

**Schritt für Schritt:**
```
❌ "Implementiere Login, Registrierung, und Password-Reset"
✅ "Implementiere Login" → dann separat: "Jetzt Registrierung"
```

**Plan erst, dann Code:**
```
❌ "Implementiere Feature X" (direkt coden)
✅ "Erstelle Plan für Feature X" → Review → "Implementiere"
```

**Regelmäßig committen:**
```
✅ Nach jedem Feature committen
✅ Nach jedem Bug-Fix committen
❌ Erst nach 10 Änderungen committen
```

### ❌ DON'T

**Nicht zu vage:**
```
❌ "Mach es besser"
❌ "Optimiere alles"
❌ "Füge Features hinzu"
```

**Nicht zu viel auf einmal:**
```
❌ "Implementiere komplettes Auth-System + API + Frontend + Tests + Docs"
✅ "Implementiere Login-Funktion" (nur das erste)
```

**Nicht Context überladen:**
```
Nach 15-20 Prompts:
/clear
→ Dann weiter arbeiten (CLAUDE.md bleibt geladen!)
```

---

## 🆘 Häufige Fragen

### "Muss ich immer alle 4 Phasen durchlaufen?"

**Bei großen Änderungen:** Ja, alle 4 Phasen
**Bei kleinen Änderungen:** Explore kann übersprungen werden

Beispiel klein:
```
User: "Ändere Farbe in CSS von blau zu rot"
→ Explore nicht nötig, direkt implementieren
```

Beispiel groß:
```
User: "Implementiere komplettes Auth-System"
→ ALLE 4 Phasen wichtig!
```

### "Was wenn Claude zu viel macht?"

Erinnere ihn:
```
User: "Bitte nur das machen was ich sage!
      Keine zusätzlichen Features ohne meine Erlaubnis."
```

Und check `~/.claude/CLAUDE.md` - da stehen die Limits.

### "Wie oft sollte ich committen?"

**Faustregel:**
- Nach jedem Feature: ✅ Commit
- Nach jedem Bug-Fix: ✅ Commit
- Nach großen Refactorings: ✅ Commit
- Am Ende des Tages: ✅ Commit

**Besser:** Viele kleine Commits als ein riesiger!

### "Muss ich Git Commands selbst ausführen?"

**Nein!** Claude macht das für dich:
```
User: "Committe die Änderungen"
→ Claude macht git add + commit + gute Message
```

Du kannst aber auch selbst Git nutzen wenn du willst.

---

## 🎉 Zusammenfassung

### Die 4 Phasen (kurz)

1. **Explore** 🔍 - Verstehen was da ist
2. **Plan** 📋 - Planen was gemacht wird
3. **Code** ⚙️ - Implementieren Schritt für Schritt
4. **Commit** 💾 - In Git sichern

### Wichtigste Regeln

- ✅ Sei spezifisch in deinen Anfragen
- ✅ Plan erst, dann Code
- ✅ Schritt für Schritt arbeiten
- ✅ Regelmäßig committen
- ✅ Session-Notes pflegen

### Nächste Schritte

1. ✅ Workflow verstanden
2. → Erste Session mit Claude!
3. → Kleine Aufgabe ausprobieren
4. → **Später:** [Advanced Features](../advanced-features/README.md)

---

**Du bist jetzt ready! Los geht's! 🚀**
