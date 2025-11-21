# 📝 CLAUDE.md Templates für deine Projekte

**Stand:** 21. November 2025
**Zweck:** Vorlagen für CLAUDE.md in verschiedenen Projekt-Typen

---

## 📋 Inhaltsverzeichnis

1. [Was ist CLAUDE.md?](#was-ist-claudemd)
2. [Template: Python Projekt](#template-python-projekt)
3. [Template: PHP/WordPress Projekt](#template-phpwordpress-projekt)
4. [Template: HTML/CSS/JavaScript](#template-htmlcssjavascript)
5. [Template: Full-Stack Projekt](#template-full-stack-projekt)
6. [Best Practices](#best-practices)

---

## Was ist CLAUDE.md?

### 🎯 Zweck

`CLAUDE.md` ist eine **Projekt-Dokumentation für Claude Code**:
- Claude liest sie automatisch bei jedem Start
- Bleibt verfügbar auch nach `/clear`
- Funktioniert wie "Projekt-Gedächtnis"
- Hilft Claude dein Projekt zu verstehen

### 📍 Wo platzieren?

```bash
# Projekt-Root (am wichtigsten)
/mein-projekt/CLAUDE.md

# Optional: Globale Defaults
~/.claude/CLAUDE.md

# Optional: Monorepo Subfolders
/mein-projekt/backend/CLAUDE.md
/mein-projekt/frontend/CLAUDE.md
```

### 💡 Was gehört rein?

✅ **Tech Stack** - Welche Technologien/Frameworks?
✅ **Coding Standards** - Style Guides, Conventions
✅ **Testing** - Wie werden Tests ausgeführt?
✅ **Git Workflow** - Branch Strategy, Commit Conventions
✅ **Projekt-Kontext** - Architektur, wichtige Entscheidungen
✅ **Commands** - Wichtige Bash Commands
✅ **Bekannte Probleme** - Quirks, Workarounds

❌ **Nicht rein:**
- Secrets/API Keys
- Lange Code-Beispiele (nur Referenzen)
- Sich ständig ändernde Infos

---

## Template: Python Projekt

### 📄 Kopiervorlage für Python

```markdown
# [Projektname]

## Projekt-Übersicht

Ein [Beschreibung] Projekt, das [Zweck].

**Repository:** https://github.com/username/project
**Dokumentation:** [Falls vorhanden]

## Tech Stack

- **Python:** 3.11+
- **Framework:** [Flask / Django / FastAPI / None]
- **Datenbank:** [PostgreSQL / MySQL / SQLite / None]
- **Testing:** pytest
- **Dependency Management:** pip + requirements.txt (oder poetry/pipenv)
- **Code Quality:** black, flake8, mypy

## Projekt-Struktur

```
project/
├── src/                  # Source Code
│   ├── __init__.py
│   ├── main.py          # Entry Point
│   ├── models/          # Data Models
│   ├── services/        # Business Logic
│   └── utils/           # Utilities
├── tests/               # Test Files
│   ├── unit/
│   ├── integration/
│   └── fixtures/
├── docs/                # Dokumentation
├── requirements.txt     # Dependencies
└── README.md
```

## Setup & Installation

```bash
# Virtual Environment erstellen
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
venv\\Scripts\\activate     # Windows

# Dependencies installieren
pip install -r requirements.txt

# Development Dependencies
pip install -r requirements-dev.txt

# Datenbank Setup (falls relevant)
python manage.py migrate

# Server starten
python src/main.py
```

## Coding Standards

### Style Guide
- **PEP 8** für Code-Formatierung
- **Google Style** für Docstrings
- **Type Hints** für alle Funktionen/Methoden
- **Black** für automatische Formatierung

### Naming Conventions
- `snake_case` für Funktionen und Variablen
- `PascalCase` für Klassen
- `SCREAMING_SNAKE_CASE` für Konstanten

### Beispiel
```python
from typing import Optional

class UserService:
    """Service for managing user operations."""

    def create_user(self, email: str, password: str) -> Optional[User]:
        """Create a new user account.

        Args:
            email: User's email address
            password: Raw password (will be hashed)

        Returns:
            Created User object or None if failed

        Raises:
            ValueError: If email is invalid
        """
        pass
```

## Testing

### Test ausführen
```bash
# Alle Tests
pytest

# Mit Coverage
pytest --cov=src --cov-report=html

# Spezifische Test-Datei
pytest tests/test_user.py

# Spezifischer Test
pytest tests/test_user.py::test_create_user

# Verbose Output
pytest -v
```

### Test-Standards
- **Jede Funktion** braucht mindestens einen Test
- **Test-Datei Naming:** `test_*.py`
- **Test-Funktion Naming:** `test_*`
- **Fixtures** in `conftest.py`
- **Mocks** mit pytest-mock
- **Minimum Coverage:** 80%

### Test-Struktur
```python
def test_create_user_success():
    """Test successful user creation."""
    # Arrange
    service = UserService()
    email = "test@example.com"

    # Act
    user = service.create_user(email, "password123")

    # Assert
    assert user is not None
    assert user.email == email
```

## Git Workflow

### Branch Strategy
- `main` - Production-ready code
- `develop` - Integration branch (optional)
- `feature/*` - New features
- `bugfix/*` - Bug fixes
- `hotfix/*` - Critical production fixes

### Commit Conventions
Wir nutzen **Conventional Commits**:
```
feat: Add user registration
fix: Prevent SQL injection in login
docs: Update API documentation
test: Add tests for auth module
refactor: Extract validation to separate class
```

### Vor jedem Commit
```bash
# Tests laufen
pytest

# Code formatieren
black src/ tests/

# Linting
flake8 src/

# Type checking
mypy src/
```

## Environment Variables

```bash
# .env file (nicht committen!)
DATABASE_URL=postgresql://user:pass@localhost/db
SECRET_KEY=your-secret-key-here
DEBUG=True
```

Nutze `python-dotenv` zum Laden:
```python
from dotenv import load_dotenv
load_dotenv()
```

## Common Commands

```bash
# Development Server
python src/main.py

# Database Migrations (Django/SQLAlchemy)
python manage.py makemigrations
python manage.py migrate

# Shell (Django)
python manage.py shell

# Formatting
black src/ tests/

# Linting
flake8 src/

# Type Checking
mypy src/
```

## Wichtige Hinweise

### Sicherheit
- **NIEMALS** Secrets in Code
- **Immer** Passwörter hashen (bcrypt)
- **Immer** Input validieren
- **Immer** SQL Injection vermeiden (ORM nutzen)

### Performance
- Datenbank Queries optimieren (N+1 vermeiden)
- Caching nutzen wo sinnvoll
- Async I/O für externe Requests

### Bekannte Probleme
- [Falls vorhanden: Known Issues beschreiben]

## Dependencies

**Core:**
- fastapi / flask / django
- sqlalchemy / django-orm
- pydantic (Validation)

**Dev:**
- pytest
- black
- flake8
- mypy
- pytest-cov

## Hilfreiche Links

- [Python Docs](https://docs.python.org/3/)
- [Framework Docs]
- [Projekt Wiki / Confluence]
```

---

## Template: PHP/WordPress Projekt

### 📄 Kopiervorlage für PHP/WordPress

```markdown
# [Projektname] - WordPress Projekt

## Projekt-Übersicht

Ein WordPress [Theme / Plugin / Custom Site] für [Zweck].

**Live URL:** [falls vorhanden]
**WordPress Version:** 6.4+
**PHP Version:** 8.1+

## Tech Stack

- **CMS:** WordPress 6.4+
- **PHP:** 8.1+
- **Database:** MySQL 8.0+
- **Theme:** [Theme Name / Custom]
- **Build Tools:** [Webpack / Gulp / Vite / None]
- **Testing:** PHPUnit, WP Browser (optional)

## Projekt-Struktur

```
wordpress-project/
├── wp-content/
│   ├── themes/
│   │   └── mein-theme/
│   │       ├── functions.php
│   │       ├── style.css
│   │       ├── header.php
│   │       ├── footer.php
│   │       ├── templates/
│   │       └── assets/
│   ├── plugins/
│   │   └── mein-plugin/
│   └── uploads/
├── wp-config.php
└── .htaccess
```

## Setup & Installation

```bash
# WordPress installieren (falls noch nicht)
# Download von wordpress.org

# Datenbank erstellen
mysql -u root -p
CREATE DATABASE wordpress_db;

# wp-config.php konfigurieren
cp wp-config-sample.php wp-config.php
# DB Credentials eintragen

# WordPress Installation im Browser:
# http://localhost/wp-admin/install.php

# Theme aktivieren
# WP Admin → Appearance → Themes → Activate

# Plugins installieren
# WP Admin → Plugins → Add New
```

## WordPress Coding Standards

### PHP Standards
- **PSR-12** Code Style
- **WordPress Coding Standards** für WP-spezifischen Code
- **Escape Output** - Immer `esc_html()`, `esc_attr()`, etc.
- **Sanitize Input** - Immer `sanitize_text_field()`, etc.
- **Nonces** für Forms
- **Prepared Statements** für DB Queries

### Theme Development
```php
// functions.php Struktur
<?php
// Theme Setup
function mein_theme_setup() {
    // Theme Support
    add_theme_support('title-tag');
    add_theme_support('post-thumbnails');

    // Menus registrieren
    register_nav_menus([
        'primary' => __('Primary Menu', 'mein-theme'),
    ]);
}
add_action('after_setup_theme', 'mein_theme_setup');

// Enqueue Scripts & Styles
function mein_theme_scripts() {
    wp_enqueue_style('main-style', get_stylesheet_uri());
    wp_enqueue_script('main-js', get_template_directory_uri() . '/js/main.js', [], '1.0', true);
}
add_action('wp_enqueue_scripts', 'mein_theme_scripts');
```

### Security Best Practices
```php
// Output escaping
echo esc_html($user_input);
echo esc_url($url);
echo esc_attr($attribute);

// Input sanitization
$clean = sanitize_text_field($_POST['input']);
$email = sanitize_email($_POST['email']);
$url = esc_url_raw($_POST['url']);

// Nonce validation
if (!wp_verify_nonce($_POST['nonce'], 'my_action')) {
    wp_die('Security check failed');
}

// Prepared statements
global $wpdb;
$results = $wpdb->get_results(
    $wpdb->prepare(
        "SELECT * FROM {$wpdb->posts} WHERE post_type = %s",
        'page'
    )
);
```

## Testing

```bash
# PHPUnit Tests (falls eingerichtet)
phpunit

# WordPress Browser Tests
vendor/bin/codecept run acceptance
```

## Git Workflow

### Was committen?
✅ Theme/Plugin Code
✅ Custom Uploads (Icons, etc.)
✅ .gitignore

### Was NICHT committen?
❌ WordPress Core Files
❌ wp-config.php
❌ User Uploads
❌ Cache/Temp Files

### .gitignore
```
# WordPress
/wp-admin/
/wp-includes/
/wp-content/uploads/
/wp-content/cache/
wp-config.php

# Theme/Plugin
node_modules/
.sass-cache/
*.map
```

### Commit Conventions
```
feat: Add custom post type for portfolio
fix: Resolve mobile menu toggle issue
style: Update header styling
refactor: Extract widget logic to separate file
```

## Common WordPress Commands

```bash
# WP-CLI (wenn installiert)
wp plugin list
wp theme activate mein-theme
wp db export backup.sql
wp cache flush
wp user create username email@example.com --role=administrator

# Database Backup
mysqldump -u root -p wordpress_db > backup.sql

# Database Restore
mysql -u root -p wordpress_db < backup.sql
```

## Debugging

```php
// In wp-config.php für Development:
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
define('SCRIPT_DEBUG', true);

// Logs finden in:
// wp-content/debug.log
```

## Hooks & Filters

### Wichtige Action Hooks
- `init` - Initialisierung
- `wp_enqueue_scripts` - Scripts/Styles laden
- `after_setup_theme` - Theme Setup
- `save_post` - Nach Post Save

### Wichtige Filter Hooks
- `the_content` - Post Content filtern
- `the_title` - Title filtern
- `excerpt_length` - Excerpt Länge
- `wp_nav_menu_items` - Menu Items anpassen

## Plugins (Abhängigkeiten)

**Erforderlich:**
- [Plugin Name] - Zweck

**Empfohlen:**
- Advanced Custom Fields (ACF)
- Yoast SEO
- WP Rocket (Caching)

## Bekannte Probleme

- [Problem 1]: [Workaround]
- [Problem 2]: [Lösung]

## Hilfreiche Links

- [WordPress Codex](https://codex.wordpress.org/)
- [WP Developer Docs](https://developer.wordpress.org/)
- [WP Coding Standards](https://developer.wordpress.org/coding-standards/)
```

---

## Template: HTML/CSS/JavaScript

### 📄 Kopiervorlage für Frontend Projekte

```markdown
# [Projektname] - Frontend Projekt

## Projekt-Übersicht

Ein [Website / Web App / Landing Page] für [Zweck].

**Live URL:** [falls deployed]
**Design:** [Figma Link / Design System]

## Tech Stack

- **HTML5**
- **CSS3** ([Vanilla / Sass / Tailwind / Bootstrap])
- **JavaScript:** [Vanilla / ES6+ / TypeScript]
- **Build Tool:** [Vite / Webpack / Parcel / None]
- **Package Manager:** npm / yarn
- **Version Control:** Git + GitHub

## Projekt-Struktur

```
project/
├── src/
│   ├── index.html
│   ├── css/
│   │   ├── main.css
│   │   ├── components/
│   │   └── utils/
│   ├── js/
│   │   ├── main.js
│   │   ├── modules/
│   │   └── utils/
│   ├── assets/
│   │   ├── images/
│   │   ├── fonts/
│   │   └── icons/
│   └── pages/          # Multi-page site
├── dist/               # Build Output
├── package.json
└── README.md
```

## Setup & Installation

```bash
# Dependencies installieren
npm install

# Development Server starten
npm run dev

# Build für Production
npm run build

# Preview Production Build
npm run preview
```

## Coding Standards

### HTML
- **Semantic HTML5** - `<header>`, `<nav>`, `<main>`, `<article>`, etc.
- **Accessibility** - ARIA labels, alt texts, proper heading hierarchy
- **Valid HTML** - W3C Validator
- **BEM Methodology** für CSS Classes

```html
<!-- Beispiel -->
<article class="card">
    <header class="card__header">
        <h2 class="card__title">Title</h2>
    </header>
    <div class="card__body">
        <p class="card__text">Content</p>
    </div>
    <footer class="card__footer">
        <button class="card__button">Action</button>
    </footer>
</article>
```

### CSS
- **Mobile First** - Start mit Mobile, dann Media Queries
- **BEM Naming** - Block__Element--Modifier
- **CSS Variables** für Theming
- **Consistent Spacing** - 4px / 8px Grid System
- **No !important** (außer absolute Notfälle)

```css
/* CSS Variables */
:root {
    --color-primary: #3B82F6;
    --color-secondary: #10B981;
    --spacing-unit: 8px;
    --font-size-base: 16px;
}

/* BEM Example */
.button {
    /* Block */
}

.button__icon {
    /* Element */
}

.button--primary {
    /* Modifier */
}

/* Mobile First */
.container {
    padding: 16px;
}

@media (min-width: 768px) {
    .container {
        padding: 32px;
    }
}
```

### JavaScript
- **ES6+ Syntax** - const/let, arrow functions, destructuring
- **Modules** - Import/Export
- **Naming:** camelCase für Variablen, PascalCase für Klassen
- **JSDoc** für Dokumentation
- **Error Handling** mit try/catch

```javascript
/**
 * Fetch user data from API
 * @param {string} userId - The user ID
 * @returns {Promise<Object>} User object
 */
async function fetchUser(userId) {
    try {
        const response = await fetch(`/api/users/${userId}`);
        if (!response.ok) throw new Error('Failed to fetch');
        return await response.json();
    } catch (error) {
        console.error('Error fetching user:', error);
        throw error;
    }
}
```

## Browser Support

- **Chrome:** Latest 2 versions
- **Firefox:** Latest 2 versions
- **Safari:** Latest 2 versions
- **Edge:** Latest 2 versions
- **Mobile:** iOS 13+, Android 8+

## Performance

### Optimizations
- ✅ Minify CSS/JS
- ✅ Optimize Images (WebP, proper sizing)
- ✅ Lazy Loading für Images
- ✅ Critical CSS inline
- ✅ Defer non-critical JS
- ✅ Use CDN für Assets

### Performance Budget
- **First Contentful Paint:** < 1.5s
- **Largest Contentful Paint:** < 2.5s
- **Total Bundle Size:** < 200KB (gzipped)

## Accessibility (a11y)

### Checklist
- ✅ Semantic HTML
- ✅ ARIA labels wo nötig
- ✅ Keyboard Navigation funktioniert
- ✅ Focus States sichtbar
- ✅ Color Contrast WCAG AA (mindestens)
- ✅ Alt Text für alle Images
- ✅ Screen Reader tested

## Testing

```bash
# Linting
npm run lint

# Format checking
npm run format:check

# Unit Tests (falls Jest konfiguriert)
npm test

# E2E Tests (falls Playwright/Cypress)
npm run test:e2e
```

## Deployment

```bash
# Build für Production
npm run build

# Deploy (Beispiel mit GitHub Pages)
npm run deploy

# Oder manuell:
# dist/ Ordner zu Webserver hochladen
```

## Common Commands

```bash
# Dev Server
npm run dev

# Build
npm run build

# Preview
npm run preview

# Lint
npm run lint

# Format
npm run format
```

## Git Workflow

### Commit Conventions
```
feat: Add contact form
fix: Resolve mobile menu issue
style: Update button hover states
refactor: Extract form validation logic
perf: Optimize image loading
```

## Dependencies

```json
{
  "devDependencies": {
    "vite": "^4.0.0",
    "sass": "^1.57.0",
    "prettier": "^2.8.0",
    "eslint": "^8.30.0"
  },
  "dependencies": {
    // Production dependencies
  }
}
```

## Hilfreiche Links

- [MDN Web Docs](https://developer.mozilla.org/)
- [Can I Use](https://caniuse.com/)
- [WebAIM WCAG Checklist](https://webaim.org/standards/wcag/checklist)
```

---

## Template: Full-Stack Projekt

### 📄 Kopiervorlage für Full-Stack

```markdown
# [Projektname] - Full-Stack Application

## Projekt-Übersicht

Ein Full-Stack [Web App / API / Platform] für [Zweck].

## Tech Stack

### Frontend
- **Framework:** React / Vue / Svelte
- **Language:** TypeScript
- **Styling:** Tailwind CSS / Styled Components
- **State:** Redux / Zustand / Context API
- **Build:** Vite

### Backend
- **Language:** Python / Node.js / PHP
- **Framework:** FastAPI / Express / Laravel
- **Database:** PostgreSQL
- **ORM:** SQLAlchemy / Prisma / Eloquent
- **API:** REST / GraphQL
- **Auth:** JWT / OAuth2

### DevOps
- **Containerization:** Docker
- **CI/CD:** GitHub Actions
- **Hosting:** [AWS / Vercel / Heroku]

## Projekt-Struktur

```
project/
├── frontend/
│   ├── src/
│   ├── public/
│   └── package.json
├── backend/
│   ├── src/
│   ├── tests/
│   └── requirements.txt
├── docker-compose.yml
└── README.md
```

## Setup & Installation

```bash
# Backend
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver

# Frontend
cd frontend
npm install
npm run dev
```

## API Documentation

**Base URL:** `http://localhost:8000/api/v1`

### Endpoints
```
GET    /api/v1/users          # List users
POST   /api/v1/users          # Create user
GET    /api/v1/users/:id      # Get user
PUT    /api/v1/users/:id      # Update user
DELETE /api/v1/users/:id      # Delete user
```

## Environment Variables

```bash
# Backend .env
DATABASE_URL=postgresql://user:pass@localhost/db
SECRET_KEY=xxx
JWT_SECRET=xxx

# Frontend .env
VITE_API_URL=http://localhost:8000
```

## Testing

```bash
# Backend Tests
cd backend
pytest

# Frontend Tests
cd frontend
npm test

# E2E Tests
npm run test:e2e
```

## Deployment

```bash
# Docker
docker-compose up --build

# Production
docker-compose -f docker-compose.prod.yml up -d
```

[... weitere Sections nach Bedarf ...]
```

---

## Best Practices

### ✅ Dos

1. **Konkret sein** - Spezifische Commands, nicht allgemein
2. **Aktuell halten** - Bei größeren Änderungen updaten
3. **Kurz halten** - Nur wichtige Infos, nicht Roman
4. **Strukturiert** - Klare Sections mit Headers
5. **Codebeispiele** - Zeigen wie Code aussehen soll

### ❌ Don'ts

1. **Keine Secrets** - API Keys gehören in .env
2. **Nicht zu generisch** - "Schreibe guten Code" hilft nicht
3. **Nicht zu lang** - Claude hat Context Limit
4. **Nicht veralten lassen** - Veraltete Infos sind schädlich

### 🔄 Wann updaten?

- ✅ Tech Stack ändert sich
- ✅ Coding Standards ändern sich
- ✅ Neue wichtige Commands hinzukommen
- ✅ Architektur-Entscheidungen getroffen werden
- ✅ Bekannte Probleme auftauchen

---

## 🚀 Nächste Schritte

1. **Wähle passendes Template** für deinen Projekt-Typ
2. **Kopiere & anpassen** an dein Projekt
3. **Als CLAUDE.md speichern** im Projekt-Root
4. **Claude testen** - "Erkläre mir die Projekt-Struktur"
5. **Iterativ verbessern** - Bei Bedarf erweitern

---

**Mit einer guten CLAUDE.md arbeitet Claude viel effektiver! 📝**
