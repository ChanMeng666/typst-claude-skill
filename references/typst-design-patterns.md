# Typst Design Patterns

Reusable patterns for document design in Typst — from basic setup to advanced layouts.

---

## Basic Document Setup

The canonical preamble pattern — put `set` rules at the top, then write content:

```typst
#set page(paper: "a4", margin: 2.5cm)
#set text(font: "Linux Libertine", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 0.8em)

= Introduction
Content here...
```

---

## CJK Document Setup

Always set the text language and provide a font fallback chain for Chinese/Japanese/Korean:

```typst
#set text(lang: "zh", font: ("Source Han Serif SC", "SimSun", "Microsoft YaHei"))
#set page(paper: "a4")
```

Omitting `lang` or a CJK-capable font causes missing glyphs (tofu □).

---

## Math Equations

```typst
$ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $
```

---

## Including External Data

```typst
#let data = json("data.json")
#let records = csv("data.csv")
#let config = yaml("config.yaml")
```

---

## Using Packages

```typst
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/tablex:0.0.9": tablex
```

First compile with a new `@preview` package requires internet access.

---

## Theme System (Cascading Defaults)

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

---

## Scope-Based Show Rules

Nest `show` rules inside blocks to apply styling only within a specific scope:

```typst
{
  show heading: set text(size: 26pt, weight: "regular")
  show heading: set block(above: 3pt, below: 0pt)
  heading(level: 1, last-name)
}
// The show rules above do NOT affect content outside this block
```

---

## Visual Hierarchy Through Text Color

Use `text.fill.lighten()` inside `context` blocks for secondary/tertiary text:

```typst
context {
  set text(weight: "light", fill: text.fill.lighten(30%))
  timeframe   // renders lighter than surrounding text
}
```

---

## Multi-Column Layout with Grid

Use fractional units for responsive sidebar + main layouts:

```typst
#grid(
  columns: (3fr, 26pt, 6fr),  // aside, gutter, main
  aside-content,
  [],  // empty gutter
  main-content,
)
```

---

## Circular Profile Pictures

```typst
{
  set block(radius: 100%, clip: true, above: 1fr, below: 1fr)
  set align(center)
  set image(width: 55%)
  image("photo.jpg")
}
```

---

## Modular Component Functions

Build reusable entry components for structured documents (resumes, reports):

```typst
#let work-entry(timeframe: "", title: "", organization: "", location: "", body) = {
  stack(dir: ltr, spacing: 1fr,
    context { set text(weight: "light", fill: text.fill.lighten(30%)); timeframe },
    context { set text(weight: "light", fill: text.fill.lighten(30%)); location },
  )
  { set text(weight: "bold"); upper(title) } + " – " + organization
  line(stroke: 0.1pt, length: 100%)
  body
}
```

---

## Custom Fonts with `--font-path`

When using non-system fonts, bundle them and compile with:

```bash
typst compile --font-path ./fonts document.typ
```

Use `typst fonts --font-path ./fonts` to verify fonts are discovered.

---

## PDF Output Capabilities

Typst's PDF backend (powered by `pdf-writer`) supports:

- **PDF standards**: PDF 1.4–2.0, PDF/A-1b through PDF/A-4e, PDF/UA-1
- **Tagged PDF**: Accessible documents with structure tags (enabled by default)
- **Color spaces**: RGB, CMYK, grayscale, ICC profiles, Lab color, spot colors
- **Fonts**: Full Unicode/CJK support via composite fonts (Type0 + CID)
- **Advanced graphics**: Transparency, blending modes, soft masks, gradients
- **Interactive elements**: Clickable links, annotations
- **Reproducible builds**: Use `SOURCE_DATE_EPOCH` for deterministic output
