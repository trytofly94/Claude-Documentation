Schreibe comprehensive Tests für: $ARGUMENTS

## Phase 1: Code verstehen

1. **Analyse**
   - Lies den Code in $ARGUMENTS
   - Verstehe was der Code tut
   - Identifiziere alle Funktionen/Methoden
   - Erkenne Dependencies

2. **Test-Strategie festlegen**
   - Welches Test-Framework nutzen wir? (pytest/unittest/phpunit/jest)
   - Wo sollen Tests hin? (tests/ Ordner)
   - Naming Convention? (test_*.py oder *.test.js)

## Phase 2: Test Cases identifizieren

Für jede Funktion/Methode identifiziere:

1. **Happy Path** (Normal Case)
   - Standard Input → Expected Output
   - Der "normale" Anwendungsfall

2. **Edge Cases**
   - Leere Inputs
   - Null/None Values
   - Minimum/Maximum Values
   - Grenzwerte

3. **Error Cases**
   - Invalid Input
   - Wrong Types
   - Exceptions die geworfen werden sollten

4. **Boundary Conditions**
   - Was passiert an den Grenzen?
   - Off-by-one Errors?

## Phase 3: Tests schreiben

Für jeden Test Case:

1. **Test-Struktur: Arrange-Act-Assert**
   ```python
   def test_function_name_scenario():
       """Test description."""
       # Arrange - Setup
       input_data = ...
       expected_output = ...

       # Act - Execute
       result = function(input_data)

       # Assert - Verify
       assert result == expected_output
   ```

2. **Naming Convention**
   - `test_<function>_<scenario>_<expected_result>`
   - Beispiel: `test_login_invalid_password_raises_error`

3. **Test Documentation**
   - Jeder Test braucht Docstring
   - Erkläre was getestet wird

## Phase 4: Mocks & Fixtures

1. **Identify Mocking Needs**
   - Externe APIs
   - Datenbank Calls
   - File I/O
   - Time-dependent Code

2. **Setup Fixtures**
   - Wiederverwendbare Test-Daten
   - Setup/Teardown Logic

## Phase 5: Test Execution

1. **Tests ausführen**
   - Führe die Tests aus
   - Zeige Output/Ergebnis

2. **Coverage prüfen**
   - Wie viel Code ist abgedeckt?
   - Welche Branches fehlen?

3. **Report**
   - Zeige Zusammenfassung
   - Test Results (Pass/Fail)
   - Coverage Percentage
   - Fehlende Test Cases

## Test Quality Checklist

Stelle sicher dass:
- [ ] Alle Public Functions getestet sind
- [ ] Edge Cases abgedeckt sind
- [ ] Error Cases getestet sind
- [ ] Tests sind unabhängig (nicht voneinander abhängig)
- [ ] Tests sind deterministisch (immer gleiches Ergebnis)
- [ ] Tests sind schnell (< 1s per Test ideal)
- [ ] Test Names sind beschreibend
- [ ] Docstrings vorhanden
- [ ] Keine Hardcoded Values (nutze Fixtures/Constants)
- [ ] Assertions sind klar und spezifisch

## Beispiel-Output Format

Am Ende zeige:
```
✅ Tests geschrieben für:
   - test_function1_happy_path
   - test_function1_empty_input
   - test_function1_invalid_type
   - test_function2_...

📊 Test Results:
   - Total: 12 tests
   - Passed: 12
   - Failed: 0
   - Coverage: 94%

🎯 Nächste Schritte:
   - [Optional] Zusätzliche Tests für ...
   - Committe Tests in Git
```
