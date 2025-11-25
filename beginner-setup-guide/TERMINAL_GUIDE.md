# 💻 Terminal Guide für Anfänger - Windows & Mac

**Stand:** 25. November 2025
**Für:** Absolute Anfänger die noch nie mit Terminal gearbeitet haben
**Dauer:** 5 Minuten

---

## 🎯 Was ist das Terminal?

Das **Terminal** (auch genannt: Kommandozeile, Console, CMD) ist ein Fenster wo du Text-Befehle eingeben kannst statt mit der Maus zu klicken.

**Warum brauche ich das?**
- Claude Code läuft im Terminal
- Du startest Claude mit Text-Befehlen
- Professionelle Entwickler arbeiten so

**Keine Angst!** Es ist einfacher als es aussieht. 🙂

---

## 🪟 Windows - Terminal öffnen

### **Option 1: PowerShell (empfohlen)**

**Methode A - Über Suche:**
1. Drücke `Windows-Taste` auf der Tastatur
2. Tippe: `PowerShell`
3. Klicke auf "Windows PowerShell"
4. Ein blaues Fenster öffnet sich ✅

**Methode B - Über Rechtsklick:**
1. Halte `Shift` gedrückt
2. Rechtsklick auf einen leeren Bereich im Ordner
3. Klicke "PowerShell-Fenster hier öffnen"
4. Ein blaues Fenster öffnet sich ✅

### **Option 2: CMD (Command Prompt)**

**Methode:**
1. Drücke `Windows-Taste`
2. Tippe: `cmd`
3. Klicke auf "Eingabeaufforderung"
4. Ein schwarzes Fenster öffnet sich ✅

**💡 Empfehlung:** PowerShell ist moderner, aber beide funktionieren!

---

## 🍎 Mac - Terminal öffnen

### **Option 1: Über Spotlight (schnellste)**

1. Drücke `Cmd + Leertaste` (gleichzeitig)
2. Tippe: `Terminal`
3. Drücke `Enter`
4. Ein weißes Fenster öffnet sich ✅

### **Option 2: Über Programme**

1. Öffne **Finder**
2. Gehe zu **Programme** (Applications)
3. Öffne Ordner **Dienstprogramme** (Utilities)
4. Doppelklick auf **Terminal**
5. Ein weißes Fenster öffnet sich ✅

**💡 Tipp:** Ziehe Terminal ins Dock für schnellen Zugriff!

---

## 📂 Zum Projekt-Ordner navigieren (cd Befehl)

### **Was ist der cd Befehl?**

`cd` = "change directory" = Wechsle zum Ordner

**Beispiel:**
```
Du bist hier:     C:\Users\DeinName\
Du willst hier:   C:\Users\DeinName\Projekte\MeinProjekt\
Befehl:           cd Projekte\MeinProjekt
```

---

### **Windows - Zum Projekt navigieren**

**Beispiel:** Dein Projekt liegt auf `C:\Projekte\MeinWebsite\`

**Schritt 1: Laufwerk wechseln (falls nötig)**
```powershell
# Wenn dein Projekt auf anderem Laufwerk (z.B. D:)
D:

# Enter drücken
```

**Schritt 2: Zum Ordner wechseln**
```powershell
cd C:\Projekte\MeinWebsite

# Enter drücken
```

**Schritt 3: Prüfen ob richtig**
```powershell
dir

# Zeigt Dateien im Ordner - siehst du deine Projekt-Files? ✅
```

#### **💡 Trick: Ordner-Pfad kopieren**

**Einfacher Weg:**
1. Öffne den Ordner im Explorer
2. Klicke in die Adresszeile oben
3. Kopiere den Pfad (`Strg+C`)
4. Im Terminal tippe: `cd` (mit Leerzeichen danach)
5. Füge Pfad ein (`Strg+V`)
6. Enter drücken ✅

**Oder:**
1. Halte `Shift` gedrückt
2. Rechtsklick im Projekt-Ordner
3. "PowerShell-Fenster hier öffnen"
4. Du bist automatisch im richtigen Ordner! 🎉

---

### **Mac - Zum Projekt navigieren**

**Beispiel:** Dein Projekt liegt in `/Users/DeinName/Projekte/MeinWebsite/`

**Schritt 1: Zum Ordner wechseln**
```bash
cd /Users/DeinName/Projekte/MeinWebsite

# Enter drücken
```

**Schritt 2: Prüfen ob richtig**
```bash
ls

# Zeigt Dateien im Ordner - siehst du deine Projekt-Files? ✅
```

#### **💡 Trick: Drag & Drop**

**Einfachster Weg:**
1. Im Terminal tippe: `cd` (mit Leerzeichen danach)
2. Ziehe deinen Projekt-Ordner aus dem Finder ins Terminal
3. Der Pfad wird automatisch eingefügt!
4. Enter drücken ✅

#### **💡 Abkürzungen**

```bash
# Zum Home-Verzeichnis
cd ~

# Ein Ordner zurück
cd ..

# Zum vorherigen Ordner
cd -
```

---

## 🚀 Claude Code starten

### **Basis-Start (mit Permissions)**

Im richtigen Projekt-Ordner:

```bash
# Einfach claude starten
claude

# Enter drücken
```

**Was passiert:**
- Claude startet
- Fragt nach Permissions (Erlaubnis) für jede Aktion
- Du musst "Allow" drücken bei jedem Tool

**Gut für:** Lernen, Kontrolle behalten

---

### **Schnell-Start (ohne Permissions) - Für Anfänger empfohlen!**

```bash
# Claude ohne Permission-Prompts starten
claude --dangerously-skip-permissions

# Enter drücken
```

**Was ist `--dangerously-skip-permissions`?**
- Claude fragt NICHT bei jeder Aktion
- Arbeitet schneller ohne Unterbrechungen
- Name klingt gruselig, ist aber OK für eigene Projekte!

**⚠️ Wichtig:**
- Nur in DEINEN eigenen Projekten nutzen!
- Nicht bei fremdem Code
- Nicht auf Produktions-Servern

**💡 Für Anfänger empfohlen:**
- Weniger nervige Prompts
- Flüssigeres Arbeiten
- Du kannst dich aufs Lernen konzentrieren

---

## 🎓 Vollständiger Workflow - Schritt für Schritt

### **Windows Workflow**

```powershell
# 1. PowerShell öffnen
# Windows-Taste → "PowerShell" → Enter

# 2. Zu deinem Projekt navigieren
cd C:\Projekte\MeinWebsite

# 3. Prüfen ob richtig
dir
# Siehst du deine Files? ✅

# 4. Claude starten (Anfänger-Modus)
claude --dangerously-skip-permissions

# 5. Warte bis Claude geladen ist
# Du siehst: "Claude Code v..."
# Und einen Cursor: >

# 6. Erste Aufgabe geben
"Lies die Datei index.html und erkläre mir was sie macht"

# 7. Claude antwortet!
# 8. Weiter arbeiten oder beenden mit: Strg+C
```

### **Mac Workflow**

```bash
# 1. Terminal öffnen
# Cmd+Leertaste → "Terminal" → Enter

# 2. Zu deinem Projekt navigieren
cd /Users/DeinName/Projekte/MeinWebsite

# 3. Prüfen ob richtig
ls
# Siehst du deine Files? ✅

# 4. Claude starten (Anfänger-Modus)
claude --dangerously-skip-permissions

# 5. Warte bis Claude geladen ist
# Du siehst: "Claude Code v..."
# Und einen Cursor: >

# 6. Erste Aufgabe geben
"Lies die Datei index.html und erkläre mir was sie macht"

# 7. Claude antwortet!
# 8. Weiter arbeiten oder beenden mit: Cmd+C oder Strg+C
```

---

## 💡 Häufige Befehle - Cheat Sheet

### **Navigation**

| Windows | Mac/Linux | Was es macht |
|---------|-----------|--------------|
| `dir` | `ls` | Dateien im Ordner anzeigen |
| `cd Ordner` | `cd Ordner` | In Ordner wechseln |
| `cd ..` | `cd ..` | Ein Ordner zurück |
| `cd \` | `cd ~` | Zum Home/Root |
| `D:` | - | Laufwerk wechseln (nur Windows) |

### **Claude Code**

| Befehl | Was es macht |
|--------|--------------|
| `claude` | Claude normal starten (mit Permissions) |
| `claude --dangerously-skip-permissions` | Claude ohne Permission-Prompts |
| `claude --version` | Version anzeigen |
| `Strg+C` / `Cmd+C` | Claude beenden |
| `/clear` | In Claude: Context löschen |
| `/help` | In Claude: Hilfe anzeigen |

### **Nützliche Terminal-Befehle**

| Windows | Mac/Linux | Was es macht |
|---------|-----------|--------------|
| `cls` | `clear` | Terminal aufräumen |
| `exit` | `exit` | Terminal schließen |
| `pwd` | `pwd` | Zeige aktuellen Pfad |

---

## 🐛 Troubleshooting

### **Problem: "Befehl nicht gefunden" / "command not found"**

```
claude: Befehl nicht gefunden
```

**Lösung:**
1. Ist Claude installiert?
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```

2. Terminal neu starten

3. PATH prüfen:
   ```bash
   # Windows
   echo $env:PATH

   # Mac
   echo $PATH
   ```

### **Problem: "Ich bin im falschen Ordner"**

```powershell
# Wo bin ich?
pwd

# Zeige mir alle Ordner
dir    # Windows
ls     # Mac

# Gehe ein Ordner zurück
cd ..

# Gehe zum Home
cd ~
```

### **Problem: "Terminal hängt / reagiert nicht"**

**Lösung:**
1. Drücke `Strg+C` (oder `Cmd+C` auf Mac)
2. Warte 2 Sekunden
3. Wenn immer noch hängt: Terminal schließen und neu öffnen

### **Problem: "Kann Projekt-Ordner nicht finden"**

**Windows:**
```powershell
# Liste alle Laufwerke
Get-PSDrive -PSProvider FileSystem

# Suche nach deinem Projekt
Get-ChildItem C:\ -Recurse -Directory -Filter "MeinProjekt" -ErrorAction SilentlyContinue
```

**Mac:**
```bash
# Suche nach deinem Projekt
find ~ -name "MeinProjekt" -type d
```

### **Problem: "Permission denied" / "Zugriff verweigert"**

**Windows:**
- PowerShell als Administrator starten
- Rechtsklick auf PowerShell → "Als Administrator ausführen"

**Mac:**
- Mit `sudo` vor den Befehl:
  ```bash
  sudo claude
  ```
- Gibt Passwort ein

---

## 🎯 Best Practices für Anfänger

### ✅ DO

1. **Arbeite in einem festen Projekt-Ordner**
   ```
   C:\Projekte\MeinWebsite\     # Windows
   ~/Projekte/MeinWebsite/      # Mac
   ```

2. **Nutze Tab-Completion**
   - Tippe Anfang vom Ordnernamen
   - Drücke `Tab`
   - Terminal vervollständigt automatisch!

3. **Copy & Paste im Terminal**
   - Windows: `Strg+C` zum Kopieren, `Strg+V` zum Einfügen
   - Mac: `Cmd+C` zum Kopieren, `Cmd+V` zum Einfügen

4. **Nutze Pfeil-Tasten**
   - `↑` (Pfeil hoch): Vorheriger Befehl
   - `↓` (Pfeil runter): Nächster Befehl
   - Spart viel Tippen!

### ❌ DON'T

1. **Nicht wahllos `sudo` / Admin benutzen**
   - Nur wenn wirklich nötig
   - Kann System beschädigen

2. **Nicht in System-Ordnern arbeiten**
   - Nicht in `C:\Windows\`
   - Nicht in `/System/`
   - Bleib in deinen Projekt-Ordnern!

3. **Nicht Befehle kopieren ohne zu verstehen**
   - Lies was der Befehl macht
   - Bei Unsicherheit: Frag Claude oder Google

---

## 🎓 Nächste Schritte

### Du kannst jetzt:

1. ✅ Terminal öffnen (Windows & Mac)
2. ✅ Zu deinem Projekt navigieren (`cd`)
3. ✅ Claude starten (`claude --dangerously-skip-permissions`)
4. ✅ Mit Claude arbeiten!

### Weiter geht's:

1. → [BASIS_WORKFLOW.md](BASIS_WORKFLOW.md) - Lerne die 4 Phasen
2. → [INSTALLATION.md](INSTALLATION.md) - Falls Installation fehlt
3. → Probier's aus mit einem echten Projekt!

---

## 📝 Schnell-Referenz

### **Alles auf einen Blick:**

```bash
# 1. Terminal öffnen
# Windows: Windows-Taste → "PowerShell"
# Mac: Cmd+Leertaste → "Terminal"

# 2. Zu Projekt navigieren
cd /pfad/zum/projekt

# 3. Prüfen
dir    # Windows
ls     # Mac

# 4. Claude starten
claude --dangerously-skip-permissions

# 5. Arbeiten!
"Lies README.md und erkläre mir das Projekt"

# 6. Beenden
Strg+C    # Windows
Cmd+C     # Mac
```

---

## 🆘 Noch Fragen?

### **Hilfe im Terminal:**

```bash
# Claude Hilfe
claude --help

# Befehl Hilfe (Windows)
Get-Help cd

# Befehl Hilfe (Mac/Linux)
man cd
```

### **Online Resourcen:**

- [Basis Terminal Commands erklärt](https://www.google.com/search?q=terminal+basics)
- Claude im Terminal fragen: `"Wie funktioniert der cd Befehl?"`

---

**Glückwunsch! Du kannst jetzt Terminal und Claude Code nutzen! 🎉**

*PS: Nach ein paar Tagen wirst du dich fragen warum du dachtest Terminal wäre kompliziert! 😊*
