---
name: typst
description: >
  Generate professional PDF documents using Typst typesetting system.
  Use when user asks to create PDF, write documents, generate reports,
  typeset papers, create presentations, or any document generation task.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# Typst Document Generation Skill

You are an expert Typst typesetter. Use Typst to generate professional PDF, PNG, SVG, or HTML documents.

## When to activate

Activate when the user asks to:
- Create or generate a PDF document
- Write a report, paper, thesis, or article
- Create a resume / CV
- Generate a presentation or slides-style document
- Typeset mathematical formulas or equations
- Create any formatted document (letter, invoice, certificate, etc.)

## Workflow

### 1. Verify Typst is available

```bash
typst --version
```

If not available, instruct the user to install:
```bash
winget install --id Typst.Typst   # Windows
brew install typst                 # macOS
cargo install typst-cli            # Any platform with Rust
```

### 2. Create the `.typ` source file

- Choose an appropriate template from `references/typst-templates.md`
- Consult `references/typst-language-reference.md` for syntax details
- Write the `.typ` file to the user's desired location

### 3. Compile to output

```bash
typst compile document.typ                          # Default: PDF
typst compile document.typ --format png --ppi 300   # High-res PNG
typst compile document.typ output.svg               # SVG
typst compile document.typ --open                   # Compile and open
```

See `references/typst-cli-reference.md` for all CLI options.

### 4. Iterate

If compilation fails, read the error output, fix the `.typ` file, and recompile.

## Key best practices

### Chinese / CJK documents

Always set the text language and use a CJK-capable font:

```typst
#set text(lang: "zh", font: ("Source Han Serif SC", "SimSun", "Microsoft YaHei"))
#set page(paper: "a4")
```

### Document structure

Use `set` rules at the top for global configuration, then write content:

```typst
#set page(paper: "a4", margin: 2.5cm)
#set text(font: "Linux Libertine", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 0.8em)

= Introduction
Content here...
```

### Math equations

```typst
$ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $
```

### Including external data

```typst
#let data = json("data.json")
#let records = csv("data.csv")
```

### Using packages

```typst
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/tablex:0.0.9": tablex
```

## Advanced design patterns

### Theme system (cascading defaults)

Use a dictionary-based theme with a fallback helper for customizable templates:

```typst
#let default-theme = (
  margin: 26pt,
  font: "Libre Baskerville",
  font-size: 8pt,
  font-secondary: "Roboto",
  font-tertiary: "Montserrat",
  text-color: rgb("#3f454d"),
)

#let my-template(theme: (), body) = {
  let th(key) = if key in theme { theme.at(key) } else { default-theme.at(key) }
  set text(font: th("font"), size: th("font-size"), fill: th("text-color"))
  body
}
```

### Scope-based show rules

Nest `show` rules inside blocks to apply styling only within a specific scope:

```typst
{
  show heading: set text(size: 26pt, weight: "regular")
  show heading: set block(above: 3pt, below: 0pt)
  heading(level: 1, last-name)
}
// The show rules above do NOT affect content outside this block
```

### Visual hierarchy through text color

Use `text.fill.lighten()` inside `context` blocks for secondary/tertiary text:

```typst
context {
  set text(weight: "light", fill: text.fill.lighten(30%))
  timeframe   // renders lighter than surrounding text
}
```

### Multi-column layout with grid

Use fractional units for responsive sidebar + main layouts:

```typst
#grid(
  columns: (3fr, 26pt, 6fr),  // aside, gutter, main
  aside-content,
  [],  // empty gutter
  main-content,
)
```

### Circular profile pictures

```typst
{
  set block(radius: 100%, clip: true, above: 1fr, below: 1fr)
  set align(center)
  set image(width: 55%)
  image("photo.jpg")
}
```

### Modular component functions

Build reusable entry components for structured documents (resumes, reports):

```typst
#let work-entry(timeframe: "", title: "", organization: "", body) = {
  stack(dir: ltr, spacing: 1fr,
    context { set text(weight: "light", fill: text.fill.lighten(30%)); timeframe },
    context { set text(weight: "light", fill: text.fill.lighten(30%)); location },
  )
  { set text(weight: "bold"); upper(title) } + " – " + organization
  line(stroke: 0.1pt, length: 100%)
  body
}
```

### Custom fonts with `--font-path`

When using non-system fonts, bundle them and compile with:

```bash
typst compile --font-path ./fonts document.typ
```

## PDF output capabilities

Typst's PDF backend (powered by `pdf-writer`) supports:
- **PDF standards**: PDF 1.4–2.0, PDF/A-1b through PDF/A-4e, PDF/UA-1
- **Tagged PDF**: Accessible documents with structure tags (enabled by default)
- **Color spaces**: RGB, CMYK, grayscale, ICC profiles, Lab color, spot colors
- **Fonts**: Full Unicode/CJK support via composite fonts (Type0 + CID)
- **Advanced graphics**: Transparency, blending modes, soft masks, gradients
- **Interactive elements**: Clickable links, annotations
- **Reproducible builds**: Use `SOURCE_DATE_EPOCH` for deterministic output

## Reference documentation

For detailed information, consult these reference files (read them when needed):

- **CLI Reference**: `references/typst-cli-reference.md` — All CLI commands, options, and environment variables
- **Language Reference**: `references/typst-language-reference.md` — Complete language syntax, functions, and features
- **Templates**: `references/typst-templates.md` — Ready-to-use document templates (general, Chinese, academic, resume, letter, report, slides, invoice)

## Output formats

| Format | Extension | Notes |
|--------|-----------|-------|
| PDF    | `.pdf`    | Default. Supports PDF/A standards and tagged PDF. |
| PNG    | `.png`    | One image per page. Use `--ppi` for resolution. |
| SVG    | `.svg`    | One file per page. Vector graphics. |
| HTML   | `.html`   | Experimental. Use `--features html`. |
