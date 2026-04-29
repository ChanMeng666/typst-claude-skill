---
name: typst
description: >
  Generate professional PDF documents using the Typst typesetting system.
  Use when the user asks to create a PDF, write a document, generate a
  report, typeset a paper, build a presentation, or make a resume / CV /
  cover letter / letter / invoice / thesis / handout / poster — even when
  they do not say "Typst" explicitly. Especially trigger when the user
  mentions one-page CV, two-column resume, academic paper with bibliography,
  or any CJK (Chinese / Japanese / Korean) document.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Typst Document Generation Skill

> **Trigger me when** the user wants any of: PDF · CV · résumé · cover letter · academic paper · report · invoice · slides · poster · 简历 · 学术论文 · 报告 · 发票 · 幻灯片 · Typst — even if they did not say "Typst" explicitly.

You are an expert Typst typesetter. Generate professional PDF, PNG, SVG, or HTML documents using Typst.

## Decision Tree — pick a template before writing

Ask, in this order, before writing any `.typ`:

1. **What is the artefact?**
   - Resume / CV → `references/typst-templates.md` § Simple Resume or Typographic Resume
   - Cover letter / formal letter → § Letter
   - Academic / research paper → § Academic Paper (two-column, abstract, bibliography)
   - Internal report / whitepaper → § Technical Report
   - Slide deck → § Presentation
   - Bill / receipt → § Invoice
   - Anything else → § General Document

2. **Is the language CJK (Chinese / Japanese / Korean)?**
   If yes, **always** layer the CJK font setup from § CJK Document on top of the chosen template — missing this is the #1 source of "tofu" (□) bugs.

3. **Does the user have a JSON / CSV data source?**
   If yes, generate a `.typ` that calls `#let data = json("path.json")` (or `csv(...)`) and loops over it — do **not** hardcode values from the data into the template.

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
| Evaluate expression | `typst eval "1 + 2"` |
| Conditional format | `#if target() == "html" { ... } else { ... }` |
| List fonts | `typst fonts` |

## Workflow

### 1. Verify the environment

```bash
typst --version
```

For a deeper check (CJK fonts available, write permissions, version ≥ 0.14), run the bundled script from this skill's directory:

```bash
bash scripts/verify-typst.sh
```

If `typst` is not installed:

- Windows: `winget install --id Typst.Typst`
- macOS: `brew install typst`
- Any platform with Rust: `cargo install --locked typst-cli`

### 2. Create the `.typ` source file

- Use the Decision Tree above to pick a template from `references/typst-templates.md`
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

Read compilation errors, consult the Recovery Recipes below, fix the `.typ` file, and recompile.

## Gotchas / Common Mistakes

| Mistake | Fix |
|---------|-----|
| CJK glyphs missing or tofu (□) | Set `lang` AND provide a CJK font fallback chain: `#set text(lang: "zh", font: ("Source Han Serif SC", "SimSun"))` |
| Windows path errors in `#image()` / `#include()` | Use forward slashes: `image("images/photo.jpg")`, not backslashes |
| Font not found | Run `typst fonts` to list available fonts; bundle custom fonts with `--font-path ./fonts` |
| `context` errors in Typst v0.14+ | Accessing `counter()`, `state()`, or `text.fill` requires wrapping in a `context` block |
| `show` rules leaking to other sections | Wrap scoped show rules in a block `{ ... }` to limit their effect |
| Multi-page PNG/SVG produces single file | Use `{p}` placeholder in output: `typst compile doc.typ "page-{p}.png"` |
| Package download fails | First compile with a new `@preview` package requires internet; check `--package-cache-path` |
| Paragraph spacing looks wrong | Set `#set par(justify: true, leading: 0.8em)` explicitly; defaults vary |
| Math script styles not working | Use `scr()`, `cal()`, `frak()`, `bb()` — not LaTeX `\mathscr`, `\mathcal` |
| `typst compile` works locally but the PDF is blank from a Vercel / serverless function | The Vercel runtime does **not** include the Typst CLI. Either ship a static prebuilt binary in the deploy bundle (`vercel.json` `includeFiles`) or call a separate compile service (Fly.io / Railway). See `references/typst-design-patterns.md` § Serverless. |

## Recovery Recipes

When `typst compile` fails, paste stderr's first line into this lookup before guessing:

| stderr starts with | Most likely cause | First thing to try |
|--------------------|-------------------|--------------------|
| `error: file not found (...) image(...)` | wrong relative path | `cd` to the `.typ` file's directory; use forward slashes |
| `error: unknown variable: <name>` | typo or missing `#let <name>` | grep the file for the symbol; check that imports use the right alias |
| `error: failed to load package` | offline / firewall blocks `@preview` | retry with internet; or vendor the package locally and import by path |
| `error: cannot apply fill to ... (context error)` | v0.14 introspection requires `context` | wrap the access in `context { ... }` |
| `error: type mismatch: expected ..., found ...` | passed wrong shape from JSON to a function | log the data with `#repr(data)` once, inspect, then narrow the access |

## When NOT to use

- **Existing LaTeX projects** — use LaTeX directly for `.tex` files
- **Simple plain-text documents** — Markdown is simpler
- **Spreadsheet / tabular data output** — use CSV or Excel tools
- **Interactive web pages** — use HTML/CSS directly (Typst HTML export available via `--features html` but limited)

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
