# Typst Skill for Claude Code

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Typst v0.14+](https://img.shields.io/badge/Typst-v0.14%2B-blue)](https://typst.app/)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-green)](https://docs.anthropic.com/en/docs/claude-code/skills)
[![Validate](https://github.com/ChanMeng666/typst-claude-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/ChanMeng666/typst-claude-skill/actions/workflows/validate.yml)

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill that enables professional document generation using the [Typst](https://typst.app/) typesetting system.

When installed, Claude Code can create PDFs, reports, academic papers, resumes, presentations, and more — directly from natural language requests.

## Features

- **Full Typst language coverage** — page setup, text formatting, math equations, tables, figures, layout, scripting, show/set rules, introspection, and more
- **Complete CLI reference** — all commands (`compile`, `watch`, `init`, `query`, `fonts`), options, and environment variables for Typst v0.14
- **9 ready-to-use templates** — general document, CJK document, academic paper, simple resume, typographic two-column resume, letter, technical report, presentation slides, and invoice
- **Advanced design patterns** — theme systems with cascading defaults, scope-based show rules, modular component functions, multi-column layouts, circular image clipping, typography hierarchy
- **CJK support** — font fallback configuration, `cjk-latin-spacing`, and proper paragraph settings for Chinese/Japanese/Korean documents
- **PDF capabilities** — PDF/A standards, tagged PDF for accessibility, ICC color profiles, reproducible builds
- **Package publishing** — `typst.toml` manifest format, directory structure, and font bundling
- **Plugin packaging** — installable as a Claude Code plugin (with marketplace) **or** dropped directly into `~/.claude/skills/`

## Prerequisites — install Typst CLI

The Typst skill drives the `typst` binary, so install it first:

```bash
# Windows
winget install --id Typst.Typst

# macOS
brew install typst

# Any platform with Rust
cargo install --locked typst-cli
```

Verify with `typst --version` (should print v0.14 or newer).

## Installation

Pick **one** of the four methods below. They are equivalent in capability — choose by your environment.

### Method 1 — Git clone (recommended for most users)

Clones this repo directly into Claude Code's user-level skills directory. One command, works on macOS / Linux / Windows (Git Bash or WSL):

```bash
git clone https://github.com/ChanMeng666/typst-claude-skill.git ~/.claude/skills/typst
```

> Windows PowerShell users: replace `~` with `$env:USERPROFILE`, so the destination is `$env:USERPROFILE\.claude\skills\typst`.

### Method 2 — Claude Code plugin marketplace

Inside Claude Code, run:

```text
/plugin marketplace add ChanMeng666/typst-claude-skill
/plugin install typst@chan-typst
```

Auto-updates when the plugin's `version` field bumps. The marketplace name (`chan-typst`) and plugin name (`typst`) are declared in `.claude-plugin/marketplace.json` and `.claude-plugin/plugin.json` respectively.

### Method 3 — Manual ZIP

For users without Git:

1. Visit <https://github.com/ChanMeng666/typst-claude-skill>, click **Code → Download ZIP**.
2. Extract the archive.
3. Move and rename the extracted folder to `~/.claude/skills/typst` (macOS / Linux) or `%USERPROFILE%\.claude\skills\typst` (Windows).
4. Confirm `SKILL.md` exists at the top of that folder.

### Method 4 — Project-level (per-project)

Use this when the skill should be available **only** inside one project (e.g. you want to commit it alongside the project so collaborators get it automatically):

```bash
# Run from the project root
mkdir -p .claude/skills
git clone https://github.com/ChanMeng666/typst-claude-skill.git .claude/skills/typst
```

The skill is now active whenever Claude Code runs from this project directory and is silent everywhere else.

## Verify your installation

After installing by **any** method, run the bundled environment check:

```bash
bash ~/.claude/skills/typst/scripts/verify-typst.sh
# (or `bash .claude/skills/typst/scripts/verify-typst.sh` for Method 4)
```

Expected output:

```
=== Typst Environment Check ===
[PASS] Typst found: typst 0.14.x
[PASS] Current directory is writable
--- Available CJK Fonts ---
[PASS] CJK fonts found:
  ...
=== Done ===
```

Then ask Claude Code:

> Read `~/.claude/skills/typst/SKILL.md` and tell me the skill name from its YAML frontmatter.

If Claude reports `typst`, the skill is loaded.

## File Structure

If installed via Method 1, 3, or 4, this is the layout you'll see (under `~/.claude/skills/typst/` or `.claude/skills/typst/`):

```
typst/
├── SKILL.md                              # Main skill file (workflow, decision tree, gotchas, recovery)
├── references/
│   ├── typst-cli-reference.md            # Complete CLI reference (v0.14)
│   ├── typst-language-reference.md       # Language syntax and features reference
│   ├── typst-templates.md                # 9 ready-to-use document templates
│   └── typst-design-patterns.md          # Advanced design patterns (themes, layouts, components)
├── scripts/
│   └── verify-typst.sh                   # Environment verification script
├── examples/
│   ├── hello-world.typ                   # Minimal document example
│   ├── cjk-document.typ                  # Chinese document with proper font setup
│   └── resume-basic.typ                  # Simple resume example
├── .claude-plugin/                       # Plugin metadata (used only by Method 2)
│   ├── plugin.json
│   └── marketplace.json
├── README.md
├── CHANGELOG.md
└── LICENSE
```

If installed via Method 2 (plugin marketplace), files live under `~/.claude/plugins/cache/<marketplace>/<plugin>/<version>/` instead — Claude Code resolves paths automatically; you do not need to know the exact location.

## Usage

Once installed, the skill activates automatically when you ask Claude Code to generate documents. Examples:

```
> Create a PDF report about Q1 sales performance
> Write an academic paper template with two-column layout
> Generate a one-page resume for a software engineer
> 帮我用 Typst 生成一份中文求职信 PDF
> Typeset this math formula as a PDF: E = mc^2
> Create a presentation about our new product launch
```

You can also invoke it explicitly with `/typst`.

## Templates Included

| Template | Description |
|----------|-------------|
| General Document | TOC, headers, footers, page numbering |
| CJK Document | Chinese/Japanese/Korean font and paragraph configuration |
| Academic Paper | Two-column, abstract, keywords, bibliography, equation numbering |
| Simple Resume | Single-column with section entries |
| Typographic Resume | Two-column sidebar layout with theme system |
| Letter | Formal letter with sender/recipient blocks |
| Technical Report | Cover page, confidential headers, appendix |
| Presentation | Landscape slides with title/content pattern |
| Invoice | Styled table with totals and payment terms |

## Examples

The `examples/` directory contains minimal, self-contained `.typ` files that compile without external dependencies:

- **hello-world.typ** — Basic document setup with headings, math, and lists
- **cjk-document.typ** — Chinese document with proper font fallback chain
- **resume-basic.typ** — Simple one-page resume with reusable component functions

Compile any example with:

```bash
typst compile examples/hello-world.typ
```

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Claude Code says "I don't see a Typst skill" | `SKILL.md` missing or in the wrong place | Verify the file exists at `~/.claude/skills/typst/SKILL.md` (or your chosen install path) and that the YAML frontmatter starts with `name: typst` |
| `typst: command not found` | Typst CLI not on PATH | Reinstall via Prerequisites above; on Windows, restart the terminal after `winget install` |
| `verify-typst.sh: Permission denied` | Script not executable on Linux/macOS | `chmod +x ~/.claude/skills/typst/scripts/verify-typst.sh` |
| `tofu` (□) glyphs in CJK output | Missing CJK font fallback chain | See SKILL.md § Gotchas; or run `typst fonts` to list installed fonts |
| `/plugin install typst@chan-typst` fails with "marketplace not found" | Marketplace was not added in this Claude Code session | Re-run `/plugin marketplace add ChanMeng666/typst-claude-skill` first |
| Plugin installs but skill does not appear | Stale plugin cache | `/plugin marketplace update chan-typst` then retry install |

For deeper diagnostics, run Claude Code with `claude --debug` and look for `loading plugin` messages.

## Contributing

Contributions are welcome! Feel free to:

- Add new templates
- Improve language reference coverage
- Fix errors or outdated information
- Add support for more Typst packages

## License

[MIT](LICENSE)

## Acknowledgments

- [Typst](https://typst.app/) — the typesetting system
- [typst-typographic-resume](https://github.com/tsnobip/typst-typographic-resume) — inspiration for the theme system and two-column resume patterns
- [pdf-writer](https://github.com/typst/pdf-writer) — reference for PDF capabilities documentation
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — Anthropic's CLI for Claude
