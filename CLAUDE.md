# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **German-language documentation repository** for the Claude ecosystem, covering:
- **Claude Code** (CLI & VS Code Extension)
- **Claude Desktop** (Desktop App & Skills)
- **MCP** (Model Context Protocol)
- **Workflows** & Tool Interactions

**Target Audience:** German-speaking developers with Anthropic Pro/Max subscriptions
**Primary Language:** German (all documentation files)
**Repository Type:** Documentation/Reference (no executable code)

## Repository Structure

```
/
├── README.md                 # Main entry point - ecosystem overview
├── CLAUDE_CODE.md           # Claude Code documentation (CLI, VS Code, features)
├── CLAUDE_DESKTOP.md        # Claude Desktop documentation (Skills, Projects, Artifacts)
├── MCP_GUIDE.md             # Model Context Protocol guide
├── WORKFLOWS.md             # Practical workflows & best practices
├── TOOL_INTERACTIONS.md     # Tool synergies (Slash Commands, Skills, Subagents, Hooks)
└── archive/                 # Historical documentation versions
    ├── CLAUDE_ECOSYSTEM_V2_OKTOBER_2025.md
    ├── EXECUTIVE_SUMMARY_UPDATES.md
    └── UPDATES_OKTOBER_2025.md
```

## Documentation Philosophy

This documentation follows a **modular structure** (Version 3.x):
- Each main topic has its own standalone file
- README.md serves as the central hub with navigation
- Cross-references between files use relative markdown links
- Archive folder contains historical unified documents

## Working with This Repository

### Content Updates

When updating documentation:

1. **Identify the correct file** based on topic:
   - Claude Code features → `CLAUDE_CODE.md`
   - Claude Desktop features → `CLAUDE_DESKTOP.md`
   - MCP servers/configuration → `MCP_GUIDE.md`
   - Workflows & best practices → `WORKFLOWS.md`
   - Tool interactions & synergies → `TOOL_INTERACTIONS.md`

2. **Maintain consistency:**
   - Keep German language throughout
   - Use emoji prefixes consistently (🆕, ✅, ⚠️, 🔄, etc.)
   - Preserve existing formatting conventions
   - Update version numbers and dates when making significant changes

3. **Update cross-references:**
   - If adding new sections, update links in README.md
   - Maintain relative markdown links between files
   - Check that anchor links still work after section renames

### Version Control

**Git Configuration:**
- Remote: `https://github.com/trytofly94/Claude-Documentation`
- Main branch: `main`
- Current status: Clean working directory

**Recent commits follow pattern:**
- Merge PR → Feature description → Original PR branch
- Examples: "Neue Dokumentation: Tool-Interaktionen & Synergismen"

### Archive Policy

The `archive/` folder contains:
- Previous unified documentation versions (before modular split)
- Historical update summaries
- Executive summaries of feature releases

**Do not modify archived files** - they serve as historical reference.

## Key Documentation Sections

### CLAUDE_CODE.md
Contains detailed information about:
- Installation & CLI commands
- `.claude` folder configuration (settings, commands, skills, subagents, hooks)
- Agentic coding workflows
- Claude Code 2.0 features (VS Code Extension, Checkpoints, Background Tasks)
- Security features (`/security-review`)
- API features (Context Editing, Memory Tool)

### CLAUDE_DESKTOP.md
Covers:
- Core features & MCP integration
- Projects system
- Skills (pre-built, custom, API, Box integration)
- "Imagine with Claude" research preview
- Artifacts & publishing
- Google Docs integration

### MCP_GUIDE.md
Details:
- MCP architecture & concepts
- Available MCP servers (filesystem, GitHub, Google Drive, Slack, etc.)
- Configuration for Claude Code & Claude Desktop
- Troubleshooting

### WORKFLOWS.md
Provides:
- Practical workflow examples
- Claude Desktop + MCP patterns
- Claude Code + VS Code workflows
- Best practices & FAQ
- Configuration templates

### TOOL_INTERACTIONS.md
Explains:
- How Slash Commands, Skills, Subagents, and Hooks interact
- SlashCommand tool for programmatic execution
- Progressive disclosure system
- Event-driven automation
- Decision matrices for choosing the right tool
- Advanced patterns & debugging

## Common Tasks

### Adding New Feature Documentation

1. Determine which file(s) need updates
2. Add content in appropriate section with version date
3. Mark with 🆕 emoji for new features
4. Update README.md's "Wichtigste Updates" if major
5. Add entry to README.md Changelog with version number
6. Update "Stand:" date at top of modified files

### Fixing Errors or Outdated Information

1. Locate incorrect information across files
2. Update with correct information
3. Add note in Changelog if significant correction
4. Consider whether archived documents need annotation (usually not)

### Restructuring Documentation

1. Discuss with repository owner before major restructuring
2. Preserve existing anchor links where possible
3. Update all cross-references in README.md and other files
4. Consider archiving old structure before major changes

## Language & Style Guidelines

- **Language:** German (de)
- **Tone:** Professional, technical, clear
- **Formatting:**
  - Use emoji prefixes for visual scanning
  - Code blocks with proper language tags
  - Tables for feature comparisons
  - Bullet points for lists
  - Clear section hierarchy with markdown headers
- **Dates:** German format (e.g., "22. Oktober 2025")
- **Technical Terms:** Keep English terms where standard (e.g., "Claude Code", "Checkpoints", "Skills")

## Important Notes

1. **No Build Process:** This is a documentation-only repository with no code to execute
2. **No Tests:** There are no automated tests or CI/CD pipelines
3. **No Dependencies:** No package.json, requirements.txt, or similar
4. **Pure Markdown:** All content is human-readable markdown
5. **German Primary:** All user-facing documentation is in German

## Resources

- Official Claude Code Docs: https://docs.claude.com/en/docs/claude-code
- MCP Website: https://modelcontextprotocol.io
- Anthropic Blog: https://anthropic.com/news
- Repository: https://github.com/trytofly94/Claude-Documentation
