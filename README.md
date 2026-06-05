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

### Method 1 — Claude Code plugin marketplace (recommended)

Inside Claude Code, run two commands:

```text
/plugin marketplace add ChanMeng666/typst-claude-skill
/plugin install typst@chan-typst
```

Auto-updates when the plugin's `version` field in `.claude-plugin/plugin.json` bumps. The marketplace name (`chan-typst`) and plugin name (`typst`) are declared in `.claude-plugin/marketplace.json` and `.claude-plugin/plugin.json` respectively.

### Method 2 — Git clone (for users who want to hack on the skill)

The repo's actual skill content lives at `skills/typst/` (so the plugin marketplace path can pick it up). To install via direct clone, copy that subdirectory into your user-level skills folder:

```bash
# macOS / Linux / Windows (Git Bash or WSL)
git clone --depth 1 https://github.com/ChanMeng666/typst-claude-skill.git /tmp/_typst-src \
  && mv /tmp/_typst-src/skills/typst ~/.claude/skills/typst \
  && rm -rf /tmp/_typst-src
```

> Windows PowerShell users: replace `~` with `$env:USERPROFILE`, so the destination is `$env:USERPROFILE\.claude\skills\typst`. Use `Move-Item` instead of `mv` and `Remove-Item -Recurse` instead of `rm -rf`.

### Method 3 — Manual ZIP

For users without Git:

1. Visit [`github.com/ChanMeng666/typst-claude-skill`](https://github.com/ChanMeng666/typst-claude-skill), click **Code → Download ZIP**.
2. Extract the archive.
3. Inside the extracted folder, navigate to `skills/typst/` — that subdirectory **is** the skill.
4. Move and rename `skills/typst/` to `~/.claude/skills/typst` (macOS / Linux) or `%USERPROFILE%\.claude\skills\typst` (Windows).
5. Confirm `SKILL.md` exists at the top of that destination folder.

### Method 4 — Project-level (per-project)

Use this when the skill should be available **only** inside one project (e.g. you want to commit it alongside the project so collaborators get it automatically):

```bash
# Run from the project root
git clone --depth 1 https://github.com/ChanMeng666/typst-claude-skill.git /tmp/_typst-src \
  && mkdir -p .claude/skills \
  && mv /tmp/_typst-src/skills/typst .claude/skills/typst \
  && rm -rf /tmp/_typst-src
```

The skill is now active whenever Claude Code runs from this project directory and is silent everywhere else.

## Verify your installation

After installing by **any** method, run the bundled environment check.

For **Method 1** (plugin marketplace), Claude Code installs the plugin to its cache; ask Claude Code:

> Run `bash $CLAUDE_PLUGIN_ROOT/scripts/verify-typst.sh` for the typst plugin.

For **Methods 2, 3, 4** (skill copied into `~/.claude/skills/typst/` or `.claude/skills/typst/`):

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

### Repo layout (what you see on GitHub / after `git clone`)

```
typst-claude-skill/
├── .claude-plugin/
│   ├── plugin.json                       # Plugin manifest (used by Method 1)
│   └── marketplace.json                  # Marketplace catalog
├── .github/workflows/validate.yml        # CI: validates frontmatter, compiles examples
├── skills/
│   └── typst/                            # ← THE SKILL ITSELF
│       ├── SKILL.md                      # Main skill file (workflow, decision tree, gotchas, recovery)
│       ├── references/                   # Loaded on demand by Claude Code
│       │   ├── typst-cli-reference.md
│       │   ├── typst-language-reference.md
│       │   ├── typst-templates.md
│       │   └── typst-design-patterns.md
│       ├── scripts/
│       │   └── verify-typst.sh           # Environment verification
│       └── examples/
│           ├── hello-world.typ
│           ├── cjk-document.typ
│           └── resume-basic.typ
├── README.md
├── CHANGELOG.md
└── LICENSE
```

### Installed layout (what the skill loader sees)

For **Method 1 (plugin marketplace)**: files live under `~/.claude/plugins/cache/<marketplace>/<plugin>/<version>/skills/typst/` — Claude Code resolves paths automatically; you do not need to know the exact location.

For **Methods 2, 3, 4 (clone-and-move / ZIP / per-project)**: only the `skills/typst/` subdirectory is moved to your skills folder, so the resulting layout is flat:

```
~/.claude/skills/typst/  (or .claude/skills/typst/ for Method 4)
├── SKILL.md
├── references/…
├── scripts/verify-typst.sh
└── examples/…
```

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

---

<!-- CHAN MENG PERSONAL BRAND -->
<div align="center">
  <a href="https://github.com/ChanMeng666" target="_blank">
    <img src="./.github/brand/chan-meng-logo.svg" alt="Chan Meng" width="160" />
  </a>

  <p><strong>Chan Meng</strong><br/>Need a custom app like this one? I build them — let's talk.</p>

  <a href="mailto:chanmeng.dev@gmail.com"><img src="https://img.shields.io/badge/Email-chanmeng.dev@gmail.com-EA4335?style=flat-square&logo=gmail&logoColor=white" alt="Email Chan Meng"/></a>
  <a href="https://github.com/ChanMeng666"><img src="https://img.shields.io/badge/GitHub-ChanMeng666-181717?style=flat-square&logo=github&logoColor=white" alt="Chan Meng on GitHub"/></a>
</div>
<!-- /CHAN MENG PERSONAL BRAND -->
