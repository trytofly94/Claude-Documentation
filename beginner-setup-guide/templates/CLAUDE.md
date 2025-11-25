# [Projektname]

**Zweck:** Diese Datei hilft Claude Code dein Projekt zu verstehen.
**Halte es minimal** - nur das Wichtigste!

---

## 🎯 Projekt-Übersicht

[2-3 Sätze was das Projekt macht]

Beispiel:
> Ein Web-Scraper der Produkt-Preise sammelt.
> Nutzt BeautifulSoup für Scraping, speichert in SQLite.

---

## 🛠️ Tech Stack

**Sprache:** [z.B. Python 3.11]
**Framework:** [z.B. Flask / Django / Keine]
**Datenbank:** [z.B. SQLite / PostgreSQL / Keine]
**Dependencies:** [Wichtigste Packages]

Beispiel:
- Python 3.11
- requests (HTTP Requests)
- beautifulsoup4 (HTML Parsing)
- sqlite3 (Datenbank)

---

## 📁 Wichtige Dateien

```
projekt/
├── main.py          # Entry Point
├── scraper.py       # Scraping Logic
├── database.py      # DB Operations
├── utils.py         # Helper Functions
└── tests/           # Unit Tests
    ├── test_scraper.py
    └── test_database.py
```

**Was macht was?**
- `main.py`: Startet das Programm, CLI Interface
- `scraper.py`: Enthält alle Scraping-Funktionen
- `database.py`: Datenbank CRUD Operations
- `utils.py`: Kleine Helper (String Parsing, etc.)
- `tests/`: Unit Tests für alle Funktionen

---

## 💻 Code-Stil

### Basics
- **Style:** PEP 8 (Python Standard)
- **Docstrings:** Kurz und informativ
- **Naming:** snake_case für Funktionen, PascalCase für Klassen

### Was ist wichtig?
- ✅ Lesbar > Clever
- ✅ Einfach > Komplex
- ✅ Kommentiere WARUM, nicht WAS

### Beispiel
```python
def get_price(url):
    """Scrape price from product URL."""
    # Nutze requests statt urllib (einfacher)
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')

    # Price ist in <span class="price">
    price = soup.find('span', class_='price').text
    return float(price.replace('€', '').strip())
```

---

## 🚀 Wie läuft das Projekt?

```bash
# Setup
pip install -r requirements.txt

# Starten
python main.py

# Testen (falls vorhanden)
pytest
```

---

## ⚠️ Wichtige Hinweise

### Bekannte Probleme
- [Falls vorhanden: Beschreibe Quirks/Bugs]

Beispiel:
- Amazon blockt manchmal Requests → Retry mit Delay verwenden
- SQLite hat Lock wenn 2 Prozesse gleichzeitig schreiben

### Architektur-Entscheidungen
- [Warum wurde etwas SO gemacht?]

Beispiel:
- SQLite statt PostgreSQL: Projekt ist klein, kein Server nötig
- Kein async: Nicht nötig für wenige Requests

---

## 🎯 Was Claude beachten soll

### Bei Code-Änderungen
- ✅ Halte es einfach
- ✅ Befolge PEP 8
- ✅ Teste ob es funktioniert
- ❌ Keine neuen Dependencies ohne Nachfrage
- ❌ Kein Over-Engineering

### Bei Problemen
- Schau erst in session-notes.md (vielleicht wurde Problem schon gelöst)
- Frage nach wenn unklar
- Dokumentiere Lösung in session-notes.md

---

## 📝 Template-Hinweis

✏️ **Dieses Template anpassen:**
1. Entferne diese Template-Hinweise
2. Füll die Sections mit deinen Projekt-Infos
3. Lösche was du nicht brauchst
4. Halte es kurz (max 100 Zeilen)

**Denk dran:** Das ist für Claude, nicht für Menschen.
Halte es minimal und relevant! 🎯
