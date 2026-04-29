# Typst Language Reference (v0.14)

Complete reference for the Typst typesetting language.

---

## 1. Document Structure

### Modes

Typst has three modes:
- **Markup mode** — Default. Write text, headings, lists directly.
- **Code mode** — Entered with `#`. Write expressions, function calls.
- **Math mode** — Entered with `$...$`. Write mathematical notation.

### Basic markup

```typst
= Heading Level 1
== Heading Level 2
=== Heading Level 3

*bold text*
_italic text_
`inline code`
#underline[underlined]
#highlight[highlighted]
#smallcaps[Small Capitals]
#strike[strikethrough]
#super[superscript] and #sub[subscript]

- Bullet list item
- Another item
  - Nested item

+ Numbered list
+ Second item

/ Term: Definition
/ Another: Its definition

--- // Horizontal line
```

### Links and references

```typst
https://example.com                    // Auto-detected URL
#link("https://example.com")[Click me] // Explicit link
@label                                 // Reference to a label
#ref(<label>)                          // Explicit reference
```

### Labels

```typst
= My Heading <my-heading>
See @my-heading for details.
```

### Comments

```typst
// Single-line comment
/* Multi-line
   comment */
```

### Raw text / code blocks

````typst
`inline code`

```python
def hello():
    print("Hello, World!")
```
````

---

## 2. Page Setup

```typst
#set page(
  paper: "a4",           // "a4", "us-letter", "a5", etc.
  margin: 2.5cm,         // Uniform margin
  // margin: (top: 3cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
  numbering: "1",        // Page numbering: "1", "i", "I", "a", "A"
  number-align: center + bottom,
  header: [My Document],
  footer: context [
    #h(1fr)
    #counter(page).display("1 / 1", both: true)
  ],
  columns: 1,            // Number of columns
  fill: white,           // Background color
)
```

### Document metadata

```typst
#set document(
  title: "My Title",
  author: ("Author One", "Author Two"),
  date: datetime.today(),
)
```

---

## 3. Text and Fonts

```typst
#set text(
  font: "Linux Libertine",        // Font family (or array for fallback)
  size: 11pt,                      // Font size
  fill: black,                     // Text color
  lang: "en",                      // Language (affects hyphenation)
  region: "US",                    // Region variant
  weight: "regular",               // "thin", "light", "regular", "bold", "black"
  style: "normal",                 // "normal", "italic", "oblique"
  tracking: 0pt,                   // Letter spacing
  spacing: 100%,                   // Word spacing (percentage)
  ligatures: true,                 // Enable ligatures
  cjk-latin-spacing: auto,        // Auto spacing between CJK and Latin
)
```

### Chinese / CJK setup

```typst
#set text(
  lang: "zh",
  font: ("Source Han Serif SC", "SimSun", "Microsoft YaHei", "Noto Serif CJK SC"),
  size: 12pt,
  cjk-latin-spacing: auto,
)
#set par(leading: 1em, first-line-indent: 2em, justify: true)
```

### Paragraph settings

```typst
#set par(
  justify: true,           // Justified text
  leading: 0.65em,         // Line spacing
  first-line-indent: 0pt,  // First line indent
  spacing: 1.2em,          // Paragraph spacing
)
```

---

## 4. Headings and Outline

```typst
#set heading(numbering: "1.1")    // Numbered headings
// #set heading(numbering: "1.a.i")  // Alternative numbering

#outline(
  title: "Table of Contents",
  depth: 3,                // Max heading depth
  indent: auto,            // Auto indentation
)
```

---

## 5. Math Mode

Inline math: `$x^2 + y^2 = z^2$`

Display math (centered, on its own line):
```typst
$ sum_(k=1)^n k = (n(n+1)) / 2 $
```

### Common math syntax

```typst
// Fractions
$ (a + b) / c $
$ frac(a + b, c) $     // explicit frac function

// Subscripts and superscripts
$ x_i^2 $
$ x_(i+1)^(n-1) $

// Roots
$ sqrt(x) $
$ root(3, x) $

// Integrals and sums
$ integral_0^infinity e^(-x) dif x $
$ sum_(i=0)^n binom(n, i) x^i $

// Matrices
$ mat(
  1, 2, 3;
  4, 5, 6;
  7, 8, 9;
) $

// Vectors
$ vec(x, y, z) $

// Cases
$ f(x) = cases(
  x^2 &"if" x >= 0,
  -x^2 &"if" x < 0,
) $

// Delimiters
$ lr(angle.l a, b angle.r) $
$ abs(x) $
$ norm(x) $
$ floor(x) $
$ ceil(x) $

// Accents
$ hat(x) $
$ tilde(x) $
$ dot(x) $
$ arrow(x) $

// Alignment in multi-line equations
$ a &= b + c \
    &= d + e $

// Text in math
$ "if" x > 0 $

// Bold and other variants
$ bold(A) dot bold(x) = bold(b) $

// Script styles
$ cal(L) $          // calligraphic
$ bb(R) $           // blackboard bold
$ scr(H) $          // script
$ frak(A) $         // fraktur

// Size overrides (force display/inline style)
$ display(sum_(k=1)^n k) $   // force display style in inline context
$ inline(sum) $               // force inline style in display context

// Cancel (cross out terms in derivations)
$ a + cancel(b) - cancel(b) = a $

// Norm and abs as dedicated elements
$ norm(bold(v)) $
$ abs(x - y) $

// Greek letters
$ alpha, beta, gamma, delta, epsilon $
$ Gamma, Delta, Theta, Lambda, Pi, Sigma, Phi, Psi, Omega $

// Common operators
$ plus.minus, times, div, dot, star, compose $
$ in, not in, subset, supset, union, sect $
$ forall, exists, not, and, or, implies, iff $
$ approx, equiv, lt.eq, gt.eq, != $
$ infinity, emptyset, gradient, partial, nabla $
```

### Equation numbering

```typst
#set math.equation(numbering: "(1)")

$ E = m c^2 $ <einstein>

See @einstein.
```

---

## 6. Layout

### Grid

```typst
#grid(
  columns: (1fr, 2fr, 1fr),   // Column widths
  rows: (auto, 1fr),           // Row heights
  gutter: 10pt,                // Spacing between cells
  [Cell 1], [Cell 2], [Cell 3],
  [Cell 4], [Cell 5], [Cell 6],
)
```

### Table

```typst
#table(
  columns: (auto, 1fr, 1fr),
  align: (left, center, right),
  stroke: 0.5pt,
  inset: 8pt,
  table.header(
    [*Name*], [*Value*], [*Unit*],
  ),
  [Mass], [1.0], [kg],
  [Speed], [3.0], [m/s],
  [Force], [3.0], [N],
)
```

### Columns

```typst
#columns(2, gutter: 12pt)[
  Left column content...
  #colbreak()
  Right column content...
]
```

### Stack

```typst
#stack(dir: ltr, spacing: 10pt,
  rect(width: 40pt, height: 40pt, fill: red),
  rect(width: 40pt, height: 40pt, fill: blue),
  rect(width: 40pt, height: 40pt, fill: green),
)
```

### Box and Block

```typst
// Inline container
#box(fill: luma(230), inset: 5pt, radius: 3pt)[inline content]

// Block-level container
#block(fill: luma(230), inset: 10pt, radius: 4pt, width: 100%)[
  Block content with background
]
```

### Alignment

```typst
#align(center)[Centered text]
#align(right)[Right-aligned]
#align(center + horizon)[Centered vertically and horizontally]
```

### Spacing

```typst
#v(1em)       // Vertical space
#h(1fr)       // Horizontal flex space (pushes content apart)
#h(2cm)       // Fixed horizontal space
#pagebreak()  // Page break
#colbreak()   // Column break
```

### Place (absolute positioning)

```typst
#place(top + right, dx: -10pt, dy: 10pt)[
  Positioned element
]
```

### Transforms

```typst
#rotate(15deg)[Rotated text]
#scale(x: 150%, y: 100%)[Stretched horizontally]
#skew(ax: 10deg)[Skewed text]
```

### Measure and Layout

```typst
// Get the size of content
context {
  let size = measure[Hello, World!]
  [Width: #size.width, Height: #size.height]
}

// Respond to available space
layout(size => {
  if size.width > 300pt [Wide layout] else [Narrow layout]
})
```

### Padding

```typst
#pad(left: 20pt, rest: 10pt)[
  Padded content
]
```

---

## 7. Figures and Images

```typst
#figure(
  image("photo.png", width: 80%),
  caption: [A descriptive caption.],
) <fig-photo>

See @fig-photo.
```

### Image options

```typst
#image("diagram.svg",
  width: 100%,
  height: auto,
  fit: "contain",   // "contain", "cover", "stretch"
  alt: "Description for accessibility",
)
```

---

## 8. Shapes and Drawing

```typst
#rect(width: 100pt, height: 50pt, fill: blue, stroke: 1pt + black, radius: 5pt)
#circle(radius: 25pt, fill: red)
#ellipse(width: 80pt, height: 40pt, fill: green)
#line(length: 100%, stroke: 1pt + gray)
#polygon(fill: orange,
  (0pt, 0pt), (40pt, 0pt), (20pt, 30pt)
)
```

---

## 9. Colors and Gradients

```typst
// Named colors
red, blue, green, black, white, gray, orange, purple, yellow

// Color constructors
rgb("#FF5733")
rgb(255, 87, 51)
luma(128)              // Grayscale
cmyk(0%, 100%, 100%, 0%)
color.hsl(0deg, 100%, 50%)
color.hsv(120deg, 100%, 100%)
oklch(70%, 0.15, 200deg)

// Perceptually uniform color spaces
oklab(70%, 0.1, -0.1)
oklch(70%, 0.15, 200deg)

// Color operations
red.lighten(20%)
blue.darken(30%)
green.transparentize(50%)
red.opacify(50%)               // opposite of transparentize
blue.saturate(20%)
green.desaturate(30%)
red.negate()
color.mix(red, blue)

// Gradients
gradient.linear(red, blue)
gradient.radial(red, blue)
gradient.conic(red, yellow, green, blue)
```

---

## 10. Scripting

### Variables

```typst
#let name = "Typst"
#let count = 42
#let items = (1, 2, 3)
#let info = (name: "Alice", age: 30)

// Destructuring
#let (a, b, c) = (1, 2, 3)
#let (name: n, age: a) = (name: "Alice", age: 30)
```

### Functions

```typst
#let greet(name) = [Hello, #name!]
#greet("World")

// With default parameters
#let card(title, body, color: blue) = {
  rect(fill: color.lighten(80%), inset: 10pt)[
    *#title* \
    #body
  ]
}
```

### Control flow

```typst
// Conditionals
#if x > 0 [Positive] else if x < 0 [Negative] else [Zero]

// For loops
#for item in items [
  - #item
]

// For with index
#for (i, item) in items.enumerate() [
  #(i + 1). #item
]

// While loop
#{
  let i = 0
  while i < 5 {
    [Item #i ]
    i += 1
  }
}
```

### Arrays

```typst
#let arr = (1, 2, 3, 4, 5)
#arr.len()          // 5
#arr.at(0)          // 1
#arr.first()        // 1
#arr.last()         // 5
#arr.slice(1, 3)    // (2, 3)
#arr.contains(3)    // true
#arr.filter(x => x > 2)     // (3, 4, 5)
#arr.map(x => x * 2)        // (2, 4, 6, 8, 10)
#arr.fold(0, (acc, x) => acc + x)  // 15
#arr.join(", ")     // "1, 2, 3, 4, 5"
#arr.sorted()       // sorted copy
#arr.rev()          // reversed copy
#arr.enumerate()    // ((0,1), (1,2), ...)
#arr.zip(other)     // pair elements
#arr.chunks(2)      // ((1,2), (3,4), (5,))
#arr.windows(3)     // ((1,2,3), (2,3,4), (3,4,5))
#arr.intersperse(0) // (1, 0, 2, 0, 3, 0, 4, 0, 5)
```

### Dictionaries

```typst
#let dict = (name: "Alice", age: 30, role: "Engineer")
#dict.at("name")
#dict.keys()
#dict.values()
#dict.pairs()
#dict.len()
```

### String operations

```typst
#let s = "Hello, World!"
#s.len()
#s.contains("World")
#s.starts-with("Hello")
#s.ends-with("!")
#s.trim()
#s.split(", ")
#upper(s)
#lower(s)
#s.replace("World", "Typst")
#s.slice(0, 5)
#s.rev()            // "!dlroW ,olleH"
#s.codepoints()     // individual Unicode codepoints
```

### Type checking and casting

```typst
#type(42)       // integer
#type("hi")     // string
#int("42")      // parse string to int
#float("3.14")  // parse string to float
#str(42)        // int to string
#decimal("3.14159")  // precise decimal (no floating-point error)

// Evaluate a string as Typst code
#eval("1 + 2")                    // 3
#eval("$ x^2 $", mode: "markup")  // renders math
```

---

## 11. Set and Show Rules

### Set rules (configure elements globally)

```typst
#set text(size: 12pt, font: "Georgia")
#set page(margin: 2cm)
#set heading(numbering: "1.1")
#set par(justify: true)
#set list(marker: [--])
#set enum(numbering: "a)")
#set table(stroke: 0.5pt)
#set figure(placement: auto)
#set block(above: 10pt, below: 8pt, spacing: 10pt)  // Global block spacing
#set grid(columns: (auto, 1fr))                       // Default grid columns
```

### Conditional set rules

Apply set rules conditionally using `if`:

```typst
set text(font: theme.font) if "font" in theme
set text(font: default-font) if "font" not in theme
set align(center) if not "align-gutter" in theme
```

### Show rules (transform elements)

```typst
// Style all headings
#show heading: it => {
  set text(fill: blue)
  block(below: 0.8em)[#it]
}

// Style level-1 headings specifically
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  text(size: 20pt, weight: "bold")[#it.body]
  v(0.5em)
}

// Style links
#show link: set text(fill: blue)
#show link: underline

// Style raw/code blocks
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)

// Replace text patterns
#show "LaTeX": [La#h(-.12em)#text(size: .8em, baseline: -.2em)[T]#h(-.08em)E#h(-.12em)X]
```

### Selector combinators

```typst
// Filter by field value
#show heading.where(level: 1): set text(fill: blue)

// Union: apply one rule to multiple selectors
#show heading.where(level: 1).or(heading.where(level: 2)): set text(font: "Georgia")

// Where with multiple conditions
#show raw.where(block: true): block.with(fill: luma(240), inset: 10pt, radius: 4pt)
```

### Scope-based show rules

Nest show rules inside blocks to limit their scope — they only affect content within the block:

```typst
// These show rules ONLY affect the heading inside this block
{
  show heading: set block(above: 0pt, below: 0pt)
  show heading: set text(size: 12pt, weight: "regular", font: "Libre Baskerville")
  heading(level: 2, "First Name")
}
{
  show heading: set block(above: 3pt, below: 0pt)
  show heading: set text(size: 26pt, weight: "regular")
  heading(level: 1, "Last Name")
}
// Outside both blocks, default heading styling applies
```

### Context blocks

Use `context` to access current styling values dynamically:

```typst
// Access current text fill color and derive lighter variant
context {
  set text(weight: "light", fill: text.fill.lighten(30%))
  [This text is lighter than surrounding text]
}

// Context for conditional alignment
context {
  set align(center) if not "align-gutter" in theme
  set align(theme.align-gutter) if "align-gutter" in theme
  gutter-content
}
```

---

## 12. Imports and Modules

```typst
// Import from local file
#import "utils.typ": helper-fn, my-constant
#import "template.typ": *   // Import everything

// Include file content directly
#include "chapter1.typ"

// Import from packages
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx
#import "@preview/showybox:2.0.4": showybox
```

---

## 13. Data Loading

```typst
#let data = json("data.json")
#let records = csv("data.csv")
#let config = yaml("config.yaml")
#let settings = toml("settings.toml")
#let doc = xml("data.xml")
#let binary = cbor("data.cbor")
#let content = read("file.txt")   // Read raw text
```

---

## 14. Bibliography and Citations

```typst
// At end of document
#bibliography("refs.bib", style: "ieee")
// Styles: "ieee", "apa", "chicago-author-date", "mla", etc.

// In text
@einstein1905     // Citation
#cite(<einstein1905>, form: "prose")  // "Einstein (1905)"
```

---

## 15. Footnotes

```typst
This has a footnote.#footnote[This appears at the bottom of the page.]
```

---

## 16. Introspection

### Counters

```typst
#let mycounter = counter("my-counter")
#mycounter.step()
#context mycounter.display()

// Built-in counters
#context counter(page).display()
#context counter(heading).display()
#context counter(figure).display()
```

### State

```typst
#let total = state("total", 0)
#total.update(x => x + 1)
#context total.get()
#context total.final()
```

### Query

```typst
// Query all headings
#context {
  let headings = query(heading)
  for h in headings [
    - #h.body (#h.level)
  ]
}

// Query labeled elements
#context query(<my-label>).first()
```

---

## 17. Date and Time

```typst
#datetime.today()
#datetime(year: 2024, month: 1, day: 15)
#datetime.today().display("[year]-[month]-[day]")
#datetime.today().display("[month repr:long] [day], [year]")
```

---

## 18. Useful Packages

Popular packages from `@preview`:

| Package | Description |
|---------|-------------|
| `cetz` | 2D/3D drawing (like TikZ) |
| `tablex` | Advanced tables with row/colspan |
| `showybox` | Colored boxes and callouts |
| `codly` | Beautiful code listings |
| `fletcher` | Diagrams with arrows |
| `physica` | Physics notation |
| `algorithmic` | Algorithm pseudocode |
| `modern-cv` | Modern CV template |
| `charged-ieee` | IEEE conference template |
| `unequivocal-ams` | AMS article template |
| `grape-suite` | Presentation slides |
| `mitex` | LaTeX math in Typst |

Install by importing: `#import "@preview/package:version": ...`

---

## 19. sys Module

```typst
// Access CLI --input key=value pairs
#sys.inputs.at("key", default: "fallback")

// Typst version
#sys.version

// Detect export target for conditional rendering
#if target() == "html" {
  [HTML-specific content]
} else {
  [PDF-specific content]
}
```

---

## 20. Common Patterns

### Template function pattern

```typst
#let template(title: "", author: "", body) = {
  set document(title: title, author: author)
  set page(paper: "a4", margin: 2.5cm)
  set text(size: 11pt)
  // Title
  align(center)[
    #text(size: 18pt, weight: "bold")[#title]
    #v(0.5em)
    #text(size: 12pt)[#author]
  ]
  v(2em)
  body
}

// Usage
#show: template.with(title: "My Doc", author: "Me")

Content starts here...
```

### Theme system with cascading defaults

A dictionary-based theme system with a helper function for user-customizable templates:

```typst
#let default-theme = (
  margin: 26pt,
  font: "Libre Baskerville",
  font-size: 8pt,
  font-secondary: "Roboto",
  font-tertiary: "Montserrat",
  text-color: rgb("#3f454d"),
  gutter-size: 4em,
  main-width: 6fr,
  aside-width: 3fr,
)

#let my-template(theme: (), body) = {
  // Cascading lookup: user theme → default theme
  let th(key, default: none) = {
    if key in theme and theme.at(key) != none {
      theme.at(key)
    } else if default != none and default in theme {
      theme.at(default)
    } else if default != none {
      default-theme.at(default)
    } else {
      default-theme.at(key)
    }
  }

  set page(margin: th("margin"))
  set text(font: th("font"), size: th("font-size"), fill: th("text-color"))
  body
}

// Usage: user only overrides what they need
#show: my-template.with(theme: (font-size: 10pt, text-color: black))
```

### Modular component functions

Build reusable entry components (for resumes, reports, etc.):

```typst
#let work-entry(theme: (), timeframe: "", title: "", organization: "", location: "", body) = {
  // Metadata row with flexible spacing
  {
    set text(font: theme.at("font-secondary", default: "Roboto"))
    set block(above: 0pt, below: 0pt)
    stack(dir: ltr, spacing: 1fr,
      context { set text(weight: "light", fill: text.fill.lighten(30%)); timeframe },
      context { set text(weight: "light", fill: text.fill.lighten(30%)); location },
    )
  }
  // Title + organization
  { set text(weight: "bold"); upper(title) } + " – " + organization
  // Thin divider
  { set block(above: 6pt, below: 8pt); line(stroke: 0.1pt, length: 100%) }
  // Description in lighter color
  context { set text(fill: text.fill.lighten(30%)); set par(leading: 1em); body }
}
```

### Two-column layout with sidebar

Use grid with fractional units for a responsive aside + main layout:

```typst
#grid(
  columns: (3fr, 26pt, 6fr),  // aside, gutter, main
  {
    // Aside: profile, contact, skills
    { show heading: set text(size: 26pt, weight: "regular")
      heading(level: 1, "Name") }
    // Profile picture (circular)
    { set block(radius: 100%, clip: true)
      set align(center)
      set image(width: 55%)
      image("photo.jpg") }
    aside-sections
  },
  [],  // empty gutter column
  {
    // Main: work experience, education
    main-sections
  },
)
```

### Two-column layout with spanning title

```typst
#page(columns: 2)[
  #place(top + center, scope: "parent", float: true)[
    #align(center)[
      #text(size: 18pt, weight: "bold")[Spanning Title]
    ]
  ]
  Column content here...
]
```

### Typography hierarchy with font families

Use multiple font families to create visual hierarchy:

```typst
// Primary: serif for body text (elegance, readability)
#set text(font: "Libre Baskerville", size: 8pt, fill: rgb("#3f454d"))

// Secondary: clean sans-serif for metadata
#show heading.where(level: 2): set text(font: "Roboto")

// Tertiary: modern sans-serif for section titles
#show heading.where(level: 1): set text(font: "Montserrat", weight: "light")
```

### Circular image clipping

```typst
{
  set block(radius: 100%, clip: true, above: 1fr, below: 1fr)
  set align(center)
  set image(width: 55%)
  image("profile.jpg", alt: "profile picture")
}
```

### Stack for horizontal/vertical layouts

```typst
// Horizontal: items spread with flexible spacing
#stack(dir: ltr, spacing: 1fr,
  [Left item],
  [Right item],
)

// Vertical: items stacked top-to-bottom
#stack(dir: ttb, spacing: 5pt,
  [First item],
  [Second item],
)
```

### Text transformation

```typst
#upper("section title")   // SECTION TITLE
#lower("HELLO")           // hello
#smallcaps[Small Caps]    // Small Caps in small capitals
```

---

## 21. Package Publishing

To publish a Typst package, create a `typst.toml` manifest:

```toml
[package]
name = "my-template"
version = "0.1.0"
entrypoint = "package.typ"
authors = ["Your Name"]
license = "MIT"
description = "A description of your template"

[template]
path = "template"
entrypoint = "main.typ"
thumbnail = "images/thumbnail.png"
```

Users can then use your template via:
```bash
typst init @preview/my-template:0.1.0 my-project
```
