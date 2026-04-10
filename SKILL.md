---
name: typst
description: >
  Use when user asks to create PDF, write documents, generate reports,
  typeset papers, create presentations, make resumes, invoices, letters,
  or any document generation task.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Typst Document Generation Skill

You are an expert Typst typesetter. Generate professional PDF, PNG, SVG, or HTML documents using Typst.

## Quick Reference

| Task | Code / Command |
|------|---------------|
| Compile to PDF | `typst compile doc.typ` |
| Compile to PNG | `typst compile doc.typ --format png --ppi 300` |
| Compile & open | `typst compile doc.typ --open` |
| Set page | `#set page(paper: "a4", margin: 2.5cm)` |
| Set font | `#set text(font: "Linux Libertine", size: 11pt)` |
| CJK font | `#set text(lang: "zh", font: ("Source Han Serif SC", "SimSun", "Microsoft YaHei"))` |
| Heading | `= Title` / `== Subtitle` / `=== Sub-subtitle` |
| Math | `$ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $` |
| Import package | `#import "@preview/cetz:0.3.4": canvas, draw` |
| Load data | `#let data = json("data.json")` or `csv("data.csv")` |
| List fonts | `typst fonts` |

## Workflow

### 1. Verify Typst is available

```bash
typst --version
```

If not installed, instruct the user:
- Windows: `winget install --id Typst.Typst`
- macOS: `brew install typst`
- Any platform: `cargo install typst-cli`

### 2. Create the `.typ` source file

- Choose a template from `references/typst-templates.md`
- Consult `references/typst-language-reference.md` for syntax
- For advanced layouts, see `references/typst-design-patterns.md`
- Write the `.typ` file to the user's desired location

### 3. Compile to output

```bash
typst compile document.typ                          # PDF (default)
typst compile document.typ --format png --ppi 300   # High-res PNG
typst compile document.typ output.svg               # SVG
```

See `references/typst-cli-reference.md` for all options.

### 4. Iterate

Read compilation errors, fix the `.typ` file, and recompile.

## Gotchas / Common Mistakes

| Mistake | Fix |
|---------|-----|
| CJK glyphs missing or tofu (□) | MUST set `lang` AND provide a CJK font fallback chain: `#set text(lang: "zh", font: ("Source Han Serif SC", "SimSun"))` |
| Windows path errors in `#image()` / `#include()` | Use forward slashes: `image("images/photo.jpg")`, not backslashes |
| Font not found | Run `typst fonts` to list available fonts; bundle custom fonts with `--font-path ./fonts` |
| `context` errors in Typst v0.14+ | Accessing `counter()`, `state()`, or `text.fill` requires wrapping in a `context` block |
| `show` rules leaking to other sections | Wrap scoped show rules in a block `{ ... }` to limit their effect |
| Multi-page PNG/SVG produces single file | Use `{p}` placeholder in output: `typst compile doc.typ "page-{p}.png"` |
| Package download fails | First compile with a new `@preview` package requires internet; check `--package-cache-path` |
| Paragraph spacing looks wrong | Set `#set par(justify: true, leading: 0.8em)` explicitly; defaults may vary |

## When NOT to use

- **Existing LaTeX projects** — use LaTeX directly for `.tex` files
- **Simple plain-text documents** — Markdown is simpler
- **Spreadsheet / tabular data output** — use CSV or Excel tools
- **Interactive web pages** — use HTML/CSS directly (Typst HTML output is experimental)

## Reference Documentation

Read these files on demand (not all at once):

| Reference | Path | Content |
|-----------|------|---------|
| CLI Reference | `references/typst-cli-reference.md` | All CLI commands, options, environment variables |
| Language Reference | `references/typst-language-reference.md` | Complete syntax, functions, and features |
| Templates | `references/typst-templates.md` | Ready-to-use templates (general, CJK, academic, resume, letter, report, slides, invoice) |
| Design Patterns | `references/typst-design-patterns.md` | Advanced patterns (themes, layouts, components, PDF capabilities) |

## Output Formats

| Format | Extension | Notes |
|--------|-----------|-------|
| PDF | `.pdf` | Default. Supports PDF/A standards and tagged PDF. |
| PNG | `.png` | One image per page. Use `--ppi` for resolution (default 144). |
| SVG | `.svg` | One file per page. Vector graphics. |
| HTML | `.html` | Experimental. Use `--features html`. |
