# Session Notes

**Zweck:** Dokumentiere hier was in jeder Session passiert ist.
**Wichtig:** Entscheidungen + Was nicht funktioniert hat!

---

## [Datum]: [Kurze Beschreibung der Session]

### Aufgabe
- [Was sollte gemacht werden?]

### Durchgeführt
- [Was wurde tatsächlich gemacht?]
- [Welche Files wurden geändert?]

### Entscheidungen
- [Wichtige Entscheidungen und WARUM]
- Beispiel: "Bcrypt statt SHA256 weil sicherer für Passwords"

### Probleme
- [Was hat NICHT funktioniert?]
- [Welche Fehler gab es?]
- [Wie wurden sie gelöst oder sind sie noch offen?]

### Für nächste Session
- [ ] [Offene TODOs]
- [ ] [Was muss noch gemacht werden?]

---

## Beispiel-Session:

## 2025-11-25: Login-Funktion hinzugefügt

### Aufgabe
- User Login mit Email/Password implementieren

### Durchgeführt
- `auth/login.py` erstellt
- Login-Funktion mit bcrypt Password Hashing
- Session-Token Generation (JWT)

### Entscheidungen
- **Bcrypt statt SHA256:** Sicherer, industry standard für Passwords
- **JWT Token:** 24h Gültigkeit (könnte später angepasst werden)
- **Email-Validierung:** Nur Basic Regex (kein Email-Versand noch)

### Probleme
- Erste Version hatte Bug: Token expiry war falsch gesetzt
- **Gelöst:** datetime.timedelta statt Sekunden verwenden
- **Offen:** Tests fehlen noch

### Für nächste Session
- [ ] Tests für Login schreiben
- [ ] Logout-Funktion implementieren
- [ ] Password-Reset überlegen (später?)

---

## Tipps für Session Notes

### Was gehört rein? ✅
- **Entscheidungen:** WARUM wurde etwas SO gemacht?
- **Probleme:** Was ging schief? Wie gefixt?
- **Offene Fragen:** Was ist unklar?
- **TODOs:** Was muss noch gemacht werden?

### Was NICHT rein? ❌
- Keine Code-Snippets (die sind im Code selbst)
- Keine ausführlichen Tutorials (dafür ist README)
- Keine allgemeinen Infos (dafür ist CLAUDE.md)

### Warum ist das wichtig?
Wenn du (oder eine neue KI) später an dem Projekt weiterarbeitest,
verstehst du sofort:
- Was wurde schon versucht
- Welche Entscheidungen wurden getroffen
- Was hat nicht funktioniert (spare dir die Zeit!)
- Was ist noch offen

**Dokumentiere für dein zukünftiges Ich! 🎯**
