Führe einen comprehensive Code Review durch für: $ARGUMENTS

## Phase 1: Initial Analysis

1. **Code lesen & verstehen**
   - Was macht dieser Code?
   - Welchen Zweck erfüllt er?
   - Ist die Intention klar?

2. **Kontext verstehen**
   - Lies CLAUDE.md für Projekt-Standards
   - Welche Coding Conventions gelten?
   - Welche Architektur-Pattern werden genutzt?

## Phase 2: Code Quality Review

### 1. Readability (Lesbarkeit)

Prüfe:
- [ ] **Naming** - Sind Variablen/Funktionen verständlich benannt?
- [ ] **Struktur** - Ist der Code logisch strukturiert?
- [ ] **Kommentare** - Sind komplexe Teile kommentiert?
- [ ] **Länge** - Sind Funktionen/Klassen zu lang? (> 50 Lines?)
- [ ] **Magic Numbers** - Keine Hardcoded Values ohne Erklärung

**Feedback geben:**
```
✅ Gut: Function names sind descriptive
⚠️  Warnung: Variable 'x' ist nicht aussagekräftig
❌ Problem: Funktion ist 200 Lines lang, sollte aufgeteilt werden
```

### 2. Maintainability (Wartbarkeit)

Prüfe:
- [ ] **DRY Principle** - Keine Code-Duplikation?
- [ ] **Single Responsibility** - Macht jede Funktion nur eine Sache?
- [ ] **Dependencies** - Sind Abhängigkeiten minimal?
- [ ] **Documentation** - Ist Code dokumentiert (Docstrings)?
- [ ] **Complexity** - Ist Code unnötig komplex?

### 3. Performance

Prüfe:
- [ ] **Algorithmic Complexity** - Gibt es bessere Algorithmen?
- [ ] **N+1 Queries** - Bei Datenbank-Operationen
- [ ] **Memory Usage** - Werden große Datenstrukturen effizient genutzt?
- [ ] **Caching** - Könnten Ergebnisse gecached werden?

### 4. Security

⚠️ **KRITISCH** - Folgendes überprüfen:

- [ ] **Input Validation** - Alle User Inputs validiert?
- [ ] **SQL Injection** - Prepared Statements / ORM genutzt?
- [ ] **XSS** - Output richtig escaped?
- [ ] **Authentication** - Richtig implementiert?
- [ ] **Authorization** - Permission Checks vorhanden?
- [ ] **Secrets** - Keine API Keys/Passwords im Code?
- [ ] **Error Messages** - Keine sensitiven Infos in Errors?

**Security Issues sind SHOWSTOPPERS!**

### 5. Error Handling

Prüfe:
- [ ] **Try-Catch** - Exceptions gefangen?
- [ ] **Validation** - Input wird validiert bevor genutzt?
- [ ] **Edge Cases** - Was passiert bei null/undefined/empty?
- [ ] **Logging** - Errors werden geloggt?
- [ ] **User Feedback** - Verständliche Error Messages?

### 6. Testing

Prüfe:
- [ ] **Tests vorhanden** - Gibt es Tests für diesen Code?
- [ ] **Coverage** - Sind alle Paths getestet?
- [ ] **Edge Cases** - Sind Edge Cases getestet?
- [ ] **Mocking** - Sind externe Dependencies gemockt?

## Phase 3: Best Practices Check

### Language-Specific

**Python:**
- [ ] PEP 8 Konformität
- [ ] Type Hints vorhanden
- [ ] Docstrings (Google/NumPy Style)
- [ ] List Comprehensions statt Loops (wo sinnvoll)
- [ ] Context Managers für Resources

**PHP:**
- [ ] PSR Standards
- [ ] Type Declarations
- [ ] DocBlocks
- [ ] Prepared Statements
- [ ] Error Handling

**JavaScript:**
- [ ] ES6+ Features genutzt
- [ ] const/let statt var
- [ ] Arrow Functions
- [ ] Async/Await statt Callbacks
- [ ] JSDoc Comments

**WordPress:**
- [ ] WordPress Coding Standards
- [ ] Escape Output (esc_html, esc_attr)
- [ ] Sanitize Input
- [ ] Nonces für Forms
- [ ] Hooks & Filters korrekt genutzt

## Phase 4: Suggestions

Für jedes identifizierte Problem:

1. **Beschreibe das Problem**
2. **Erkläre warum es ein Problem ist**
3. **Schlage konkrete Lösung vor**
4. **Zeige Code-Beispiel** (Before/After)

**Format:**
```
🔴 CRITICAL (muss gefixt werden):
   - [Problem]
   - [Warum]
   - [Lösung]

🟡 WARNING (sollte gefixt werden):
   - [Problem]
   - [Warum]
   - [Lösung]

🟢 SUGGESTION (Nice to have):
   - [Verbesserungsvorschlag]
```

## Phase 5: Refactoring Vorschläge

Falls Code refactored werden sollte:

1. **Zeige Original Code**
2. **Zeige Refactored Version**
3. **Erkläre Verbesserungen**
4. **Zeige Tests bleiben grün**

## Final Report

Erstelle Zusammenfassung:

```markdown
# Code Review: $ARGUMENTS

## Overview
[Kurze Beschreibung was der Code macht]

## Issues Found

### 🔴 Critical Issues (X)
- [Issue 1]
- [Issue 2]

### 🟡 Warnings (X)
- [Warning 1]
- [Warning 2]

### 🟢 Suggestions (X)
- [Suggestion 1]

## Metrics
- Lines of Code: XXX
- Functions: XX
- Complexity: [Low/Medium/High]
- Test Coverage: XX%

## Verdict
[ ] ✅ APPROVED - Ready to merge
[ ] ⚠️  APPROVED WITH COMMENTS - Minor issues
[ ] ❌ CHANGES REQUIRED - Must fix critical issues

## Next Steps
1. [Action Item 1]
2. [Action Item 2]
```

Nach dem Review fragen:
"Möchtest du dass ich die identifizierten Issues direkt fixe?"
