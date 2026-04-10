# Typst Skill for Claude Code

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill that enables professional document generation using the [Typst](https://typst.app/) typesetting system.

When installed, Claude Code can create PDFs, reports, academic papers, resumes, presentations, and more — directly from natural language requests.

## Features

- **Full Typst language coverage** — page setup, text formatting, math equations, tables, figures, layout, scripting, show/set rules, introspection, and more
- **Complete CLI reference** — all commands (`compile`, `watch`, `init`, `query`, `fonts`), options, and environment variables for Typst v0.14
- **8 ready-to-use templates** — general document, CJK document, academic paper, simple resume, typographic two-column resume, letter, technical report, presentation slides, and invoice
- **Advanced design patterns** — theme systems with cascading defaults, scope-based show rules, modular component functions, multi-column layouts, circular image clipping, typography hierarchy
- **CJK support** — font fallback configuration, `cjk-latin-spacing`, and proper paragraph settings for Chinese/Japanese/Korean documents
- **PDF capabilities** — PDF/A standards, tagged PDF for accessibility, ICC color profiles, reproducible builds
- **Package publishing** — `typst.toml` manifest format, directory structure, and font bundling

## Installation

### Option 1: Clone to skills directory

```bash
# Clone directly into Claude Code skills directory
git clone https://github.com/ChanMeng666/typst-claude-skill.git ~/.claude/skills/typst
```

### Option 2: Manual copy

```bash
git clone https://github.com/ChanMeng666/typst-claude-skill.git
cp -r typst-claude-skill/ ~/.claude/skills/typst/
```

### Prerequisites

Typst CLI must be installed on your system:

```bash
# Windows
winget install --id Typst.Typst

# macOS
brew install typst

# Any platform with Rust
cargo install typst-cli
```

## File Structure

```
~/.claude/skills/typst/
├── SKILL.md                              # Main skill file (workflow, quick reference, gotchas)
├── references/
│   ├── typst-cli-reference.md            # Complete CLI reference (v0.14.2)
│   ├── typst-language-reference.md       # Language syntax and features reference
│   ├── typst-templates.md                # Ready-to-use document templates
│   └── typst-design-patterns.md          # Advanced design patterns (themes, layouts, components)
├── scripts/
│   └── verify-typst.sh                   # Environment verification script
└── examples/
    ├── hello-world.typ                   # Minimal document example
    ├── cjk-document.typ                  # Chinese document with proper font setup
    └── resume-basic.typ                  # Simple resume example
```

## Usage

Once installed, the skill activates automatically when you ask Claude Code to generate documents. Examples:

```
> Create a PDF report about Q1 sales performance
> Write an academic paper template with two-column layout
> Generate a professional resume for a software engineer
> Typeset this math formula as a PDF: E = mc^2
> Create a presentation about our new product launch
```

You can also invoke it explicitly with `/typst`.

## Examples

The `examples/` directory contains minimal, self-contained `.typ` files that compile without external dependencies:

- **hello-world.typ** — Basic document setup with headings, math, and lists
- **cjk-document.typ** — Chinese document with proper font fallback chain
- **resume-basic.typ** — Simple one-page resume with reusable component functions

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
