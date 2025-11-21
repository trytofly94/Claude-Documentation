WordPress Debugging Helper

**Problem/Error:** $ARGUMENTS

## Phase 1: Information Gathering

1. **Error Details sammeln**
   - Was ist die genaue Error Message?
   - Wann tritt der Fehler auf?
   - Welche Steps reproduzieren den Fehler?
   - Frontend oder Backend?

2. **Environment prüfen**
   ```bash
   # WordPress Version
   # PHP Version
   # Theme & Plugins
   ```

   Zeige mir:
   - WordPress Version (wp-admin → Dashboard → Updates)
   - PHP Version (phpinfo() oder wp-admin → Site Health)
   - Aktives Theme
   - Aktive Plugins

3. **Debug Mode Status**
   Prüfe `wp-config.php`:
   ```php
   define('WP_DEBUG', true);
   define('WP_DEBUG_LOG', true);
   define('WP_DEBUG_DISPLAY', false);
   define('SCRIPT_DEBUG', true);
   ```

## Phase 2: Debug Log analysieren

1. **Log File finden**
   ```bash
   # Debug Log Location:
   # wp-content/debug.log
   ```

2. **Letzte Errors lesen**
   ```bash
   tail -50 wp-content/debug.log
   ```

3. **Error Pattern identifizieren**
   - Sind es PHP Errors?
   - Sind es WordPress Errors?
   - Plugin/Theme Errors?
   - Datenbank Errors?

## Phase 3: Common WordPress Issues Checken

### Issue 1: White Screen of Death (WSOD)

Wenn nichts angezeigt wird:

1. **PHP Errors prüfen**
   - Schalte WP_DEBUG ein
   - Prüfe PHP Error Log

2. **Theme testen**
   ```bash
   # Theme zu default ändern (via DB):
   # wp_options → template → twentytwentyfour
   ```

3. **Plugins deaktivieren**
   ```bash
   # Via wp-cli:
   wp plugin deactivate --all

   # Oder manual:
   # wp-content/plugins/ → umbenennen zu plugins-disabled/
   ```

### Issue 2: 500 Internal Server Error

1. **Prüfe .htaccess**
   ```bash
   # Temporär umbenennen:
   mv .htaccess .htaccess.backup

   # WP neu generieren lassen:
   # Settings → Permalinks → Save
   ```

2. **PHP Memory Limit**
   ```php
   // wp-config.php
   define('WP_MEMORY_LIMIT', '256M');
   define('WP_MAX_MEMORY_LIMIT', '512M');
   ```

3. **File Permissions**
   ```bash
   # Korrekte Permissions:
   find . -type d -exec chmod 755 {} \;  # Directories
   find . -type f -exec chmod 644 {} \;  # Files
   ```

### Issue 3: Database Connection Error

1. **wp-config.php prüfen**
   ```php
   define('DB_NAME', 'database_name');
   define('DB_USER', 'username');
   define('DB_PASSWORD', 'password');
   define('DB_HOST', 'localhost'); // oder 127.0.0.1
   ```

2. **Database erreichbar?**
   ```bash
   mysql -u username -p database_name
   ```

3. **DB Repair** (falls corrupt)
   ```php
   // wp-config.php
   define('WP_ALLOW_REPAIR', true);

   // Dann besuchen:
   // /wp-admin/maint/repair.php
   ```

### Issue 4: Plugin Conflicts

1. **Binary Search Method**
   ```
   1. Deaktiviere alle Plugins
   2. Error weg? → Plugin Problem
   3. Aktiviere Hälfte der Plugins
   4. Error wieder da? → In dieser Hälfte
   5. Repeat bis Plugin gefunden
   ```

2. **Plugin Code prüfen**
   - Häufige Issues:
     - Hooks falsch registriert
     - Outdated Code (PHP deprecated functions)
     - Conflicts mit anderen Plugins

### Issue 5: Theme Issues

1. **Child Theme prüfen**
   - Gibt es functions.php Errors?
   - Sind alle parent theme files korrekt referenziert?

2. **Template Hierarchy**
   - Wird das richtige Template geladen?
   - Custom templates vorhanden?

3. **Enqueued Scripts/Styles**
   ```php
   // Korrekt:
   wp_enqueue_style('my-style', get_stylesheet_uri());

   // Nicht:
   <link rel="stylesheet" href="style.css">
   ```

### Issue 6: Performance Issues

1. **Plugins prüfen**
   - Query Monitor Plugin installieren
   - Slow Queries identifizieren
   - Problematische Plugins deaktivieren

2. **Caching**
   - Cache Plugin installiert?
   - Object Caching?
   - Page Caching?

3. **Datenbank optimieren**
   ```bash
   wp db optimize
   ```

## Phase 4: Security Issues

### Security Checklist

1. **Updates**
   - [ ] WordPress Core aktuell?
   - [ ] Alle Plugins aktuell?
   - [ ] Theme aktuell?
   - [ ] PHP Version aktuell?

2. **File Permissions**
   - [ ] wp-config.php: 600 oder 640
   - [ ] .htaccess: 644
   - [ ] wp-content/: 755
   - [ ] Kein 777 anywhere!

3. **Security Hardening**
   ```php
   // wp-config.php

   // Disable File Editor
   define('DISALLOW_FILE_EDIT', true);

   // Security Keys (neu generieren)
   // https://api.wordpress.org/secret-key/1.1/salt/
   ```

4. **Malware Scan**
   - Wordfence Plugin
   - Sucuri Scanner
   - Manual File Check für backdoors

## Phase 5: Fix Implementation

Basierend auf der Analyse:

1. **Root Cause identifiziert?**
   - Beschreibe das Problem
   - Erkläre die Ursache

2. **Fix vorschlagen**
   - Zeige konkrete Lösung
   - Code-Beispiele
   - Step-by-Step Anleitung

3. **Backup erstellen**
   ```bash
   # Immer vor Fixes:

   # Database Backup
   wp db export backup.sql

   # Files Backup
   tar -czf backup.tar.gz wp-content/
   ```

4. **Fix implementieren**
   - Führe den Fix durch
   - Teste ob Error behoben

5. **Verifizieren**
   - Error weg?
   - Funktionalität intakt?
   - Performance OK?

## Phase 6: Prevention

Empfehlungen um Future Issues zu vermeiden:

1. **Monitoring Setup**
   - Uptime Monitoring
   - Error Log Monitoring
   - Performance Monitoring

2. **Backup Strategy**
   - Tägliche automatische Backups
   - Offsite Backups
   - Test Restores

3. **Staging Environment**
   - Test Updates auf Staging
   - Test Plugins auf Staging
   - Erst dann auf Production

4. **Documentation**
   - Dokumentiere alle Custom Code
   - Dokumentiere Plugin Config
   - Dokumentiere Known Issues

## Final Report

```markdown
# WordPress Debug Report

## Issue
[Beschreibung des Problems]

## Root Cause
[Was war die Ursache?]

## Fix Applied
[Was wurde gefixt?]
```php
// Code-Beispiel des Fixes
```

## Verification
- [x] Error behoben
- [x] Funktionalität getestet
- [x] Performance OK
- [x] Security Check

## Prevention
Empfehlungen:
1. [Empfehlung 1]
2. [Empfehlung 2]
```

Frage dann:
"Ist das Problem damit behoben? Brauchst du weitere Unterstützung?"
