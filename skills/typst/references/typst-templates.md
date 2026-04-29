# Typst Document Templates

Ready-to-use templates for common document types.

---

## 1. General Document (with TOC, headers, footers)

```typst
#set document(title: "Document Title", author: "Author Name")
#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      _Document Title_
      #h(1fr)
      #datetime.today().display("[year]-[month]-[day]")
    ]
  },
  footer: context [
    #h(1fr)
    #counter(page).display("1 / 1", both: true)
    #h(1fr)
  ],
)
#set text(font: "Linux Libertine", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 0.8em)

// Title page
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[Document Title]
  #v(1em)
  #text(size: 14pt)[Author Name]
  #v(0.5em)
  #text(size: 12pt, fill: gray)[#datetime.today().display("[month repr:long] [day], [year]")]
]
#pagebreak()

// Table of contents
#outline(title: "Contents", depth: 3, indent: auto)
#pagebreak()

// Content
= Introduction

Your content here.

== Background

More content...

= Methods

== Data Collection

Description of methods...

= Results

Results discussion...

= Conclusion

Final thoughts...
```

---

## 2. CJK Document (Chinese / Japanese / Korean)

This template demonstrates CJK-specific configuration. Replace the placeholder
text with actual CJK content when using.

```typst
#set document(title: "CJK Document Title", author: "Author Name")
#set page(paper: "a4", margin: 2.5cm)
#set text(
  font: ("Source Han Serif SC", "SimSun", "Microsoft YaHei", "Noto Serif CJK SC"),
  size: 12pt,
  lang: "zh",             // "zh" for Chinese, "ja" for Japanese, "ko" for Korean
  cjk-latin-spacing: auto,
)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 1em, first-line-indent: 2em)

#align(center)[
  #text(size: 22pt, weight: "bold")[Document Title Here]
  #v(0.8em)
  #text(size: 14pt)[Author Name]
  #v(0.3em)
  #text(size: 12pt, fill: gray)[#datetime.today().display("[year]-[month]-[day]")]
]
#v(2em)

#outline(title: "Contents", depth: 3, indent: auto)
#pagebreak()

= Introduction

CJK document content goes here. When mixing CJK and Latin text,
Typst automatically inserts appropriate spacing between scripts.

== Background

Background content...

= Methods

== Data Collection

Description of data collection methods...

Math formulas are fully supported:
$ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $

= Conclusion

Summary content...
```

---

## 3. Academic Paper (English)

```typst
#let paper(
  title: "",
  authors: (),
  abstract: [],
  keywords: (),
  body,
) = {
  set document(title: title, author: authors.map(a => a.name))
  set page(paper: "us-letter", margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm))
  set text(font: "Linux Libertine", size: 11pt)
  set heading(numbering: "1.1")
  set par(justify: true, leading: 0.65em)
  set math.equation(numbering: "(1)")

  // Title block
  align(center)[
    #text(size: 16pt, weight: "bold")[#title]
    #v(1em)
    #for (i, author) in authors.enumerate() {
      if i > 0 [, ]
      [#author.name#super[#author.affiliation]]
    }
    #v(0.5em)
    #let affiliations = authors.map(a => a.affiliation).dedup()
    #for aff in affiliations {
      let author = authors.find(a => a.affiliation == aff)
      [#super[#aff] #author.institution \ ]
    }
  ]
  v(1em)

  // Abstract
  block(inset: (left: 2em, right: 2em))[
    #text(weight: "bold")[Abstract. ]
    #abstract
  ]
  v(0.5em)

  if keywords.len() > 0 {
    block(inset: (left: 2em, right: 2em))[
      #text(weight: "bold")[Keywords: ]
      #keywords.join(", ")
    ]
  }
  v(1em)

  // Body
  columns(2, gutter: 12pt, body)
}

// Usage:
#show: paper.with(
  title: "A Novel Approach to Something Important",
  authors: (
    (name: "Alice Smith", affiliation: "1", institution: "University of Example"),
    (name: "Bob Jones", affiliation: "2", institution: "Institute of Research"),
  ),
  abstract: [
    This paper presents a novel approach to solving an important problem.
    We demonstrate significant improvements over existing methods.
  ],
  keywords: ("machine learning", "optimization", "neural networks"),
)

= Introduction

The problem of...

= Related Work

Previous approaches include...

= Methodology

== Problem Formulation

Let $f: RR^n -> RR$ be a function...

$ min_(bold(x) in RR^n) f(bold(x)) = sum_(i=1)^n x_i^2 $

== Algorithm

Our algorithm proceeds as follows:

+ Initialize $bold(x)_0$ randomly
+ Compute gradient $nabla f(bold(x)_k)$
+ Update $bold(x)_(k+1) = bold(x)_k - alpha nabla f(bold(x)_k)$
+ Repeat until convergence

= Experiments

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),
    table.header([*Method*], [*Accuracy*], [*Speed*], [*Memory*]),
    [Baseline], [85.2%], [1.0x], [1.0 GB],
    [Ours], [*92.7%*], [*2.3x*], [0.8 GB],
  ),
  caption: [Comparison of methods.],
)

= Conclusion

We have presented...

#bibliography("refs.bib", style: "ieee")
```

---

## 4a. Resume / CV (Simple Single-Column)

```typst
#let resume(name: "", contact: (), body) = {
  set document(title: name + " - Resume", author: name)
  set page(paper: "a4", margin: (top: 1.5cm, bottom: 1.5cm, left: 2cm, right: 2cm))
  set text(font: "Linux Libertine", size: 10pt)
  set par(justify: true)

  show heading.where(level: 1): it => {
    v(0.5em)
    text(size: 12pt, weight: "bold", fill: rgb("#2c3e50"))[#it.body]
    line(length: 100%, stroke: 0.5pt + rgb("#2c3e50"))
    v(0.3em)
  }

  // Header
  align(center)[
    #text(size: 20pt, weight: "bold")[#name]
    #v(0.3em)
    #text(size: 10pt, fill: gray)[#contact.join("  |  ")]
  ]
  v(0.5em)

  body
}

#let entry(title: "", company: "", date: "", location: "", details: ()) = {
  grid(columns: (1fr, auto),
    [*#title* — _#company _],
    align(right)[#text(fill: gray)[#date]],
  )
  if location != "" {
    text(fill: gray, size: 9pt)[#location]
  }
  v(0.2em)
  for detail in details {
    [- #detail]
  }
  v(0.3em)
}

// Usage:
#show: resume.with(
  name: "Jane Doe",
  contact: (
    "jane@example.com",
    "+1 (555) 123-4567",
    "github.com/janedoe",
    "San Francisco, CA",
  ),
)

= Education

#entry(
  title: "M.S. Computer Science",
  company: "Stanford University",
  date: "2020 – 2022",
  location: "Stanford, CA",
  details: (
    "GPA: 3.9/4.0",
    "Focus: Machine Learning and Natural Language Processing",
  ),
)

= Experience

#entry(
  title: "Senior Software Engineer",
  company: "Tech Corp",
  date: "2022 – Present",
  location: "San Francisco, CA",
  details: (
    "Led development of microservices architecture serving 10M+ users",
    "Reduced API latency by 40% through caching optimization",
    "Mentored team of 5 junior engineers",
  ),
)

= Skills

#grid(columns: (auto, 1fr),
  column-gutter: 1em,
  row-gutter: 0.4em,
  [*Languages:*], [Python, Rust, TypeScript, Go, SQL],
  [*Frameworks:*], [React, FastAPI, PyTorch, TensorFlow],
  [*Tools:*], [Docker, Kubernetes, AWS, Git, CI/CD],
)
```

---

## 4b. Resume / CV (Typographic Two-Column with Theme)

A professional two-column resume with a theme system, sidebar, and modular components.
Inspired by the `typst-typographic-resume` package pattern.

```typst
// === Theme system ===
#let default-theme = (
  margin: 26pt,
  font: "Linux Libertine",
  font-size: 9pt,
  font-secondary: "Arial",
  font-tertiary: "Arial",
  text-color: rgb("#3f454d"),
  gutter-size: 4em,
  main-width: 6fr,
  aside-width: 3fr,
  profile-picture-width: 55%,
)

// === Component functions ===

#let section(theme: (), title, body) = {
  show heading.where(level: 1): set align(end)
  show heading.where(level: 1): set text(
    font: theme.at("font-tertiary", default: default-theme.font-tertiary),
    weight: "light",
    size: theme.at("font-size", default: default-theme.font-size),
  )
  v(1fr)
  heading(level: 1, upper(title))
  { set block(above: 2pt, below: 14pt); line(stroke: 1pt, length: 100%) }
  body
}

#let contact-entry(gutter, right) = {
  grid(
    columns: (default-theme.gutter-size, 1fr),
    { set align(center); gutter },
    right,
  )
}

#let work-entry(theme: (), timeframe: "", title: "", organization: "", location: "", body) = {
  v(1fr)
  {
    set text(font: theme.at("font-secondary", default: default-theme.font-secondary))
    set block(above: 0pt, below: 0pt)
    stack(dir: ttb, spacing: 5pt,
      stack(dir: ltr, spacing: 1fr,
        context { set text(weight: "light", fill: text.fill.lighten(30%)); timeframe },
        context { set text(weight: "light", fill: text.fill.lighten(30%)); location },
      ),
      { { set text(weight: "bold"); upper(title) } + " – " + organization },
    )
  }
  { set block(above: 6pt, below: 8pt); line(stroke: 0.1pt, length: 100%) }
  context { set text(fill: text.fill.lighten(30%)); set par(leading: 1em); body }
}

#let education-entry(theme: (), timeframe: "", title: "", institution: "", body) = {
  {
    set text(font: theme.at("font-secondary", default: default-theme.font-secondary))
    stack(spacing: 5pt,
      { set text(weight: "bold"); upper(title) },
      institution,
    )
    { set block(above: 6pt, below: 8pt); line(stroke: 0.1pt, length: 100%) }
  }
  context {
    set text(weight: "light", fill: text.fill.lighten(30%))
    stack(spacing: 8pt, body, {
      set text(font: theme.at("font-secondary", default: default-theme.font-secondary))
      timeframe
    })
  }
}

#let language-entry(language, level) = {
  set text(font: default-theme.font-secondary)
  stack(dir: ltr, language, { set align(end); level })
}

// === Main template ===

#let resume(
  first-name: "", last-name: "", profession: "", bio: "",
  profile-picture: none, theme: (), aside: [], main,
) = {
  let th(key) = if key in theme { theme.at(key) } else { default-theme.at(key) }

  set page(margin: th("margin"))
  show heading.where(level: 1): set text(size: th("font-size"))
  show heading.where(level: 2): set text(size: th("font-size"))
  show heading.where(level: 3): set text(size: th("font-size"))
  show heading.where(level: 1): set text(font: th("font-tertiary"), weight: "light")
  set text(font: th("font"), size: th("font-size"), fill: th("text-color"))
  set block(above: 10pt, below: 8pt, spacing: 10pt)

  grid(
    columns: (th("aside-width"), th("margin"), th("main-width")),
    // Aside
    {
      { show heading: set block(above: 0pt, below: 0pt)
        show heading: set text(size: 12pt, weight: "regular", font: th("font"))
        heading(level: 2, first-name) }
      { show heading: set block(above: 3pt, below: 0pt)
        show heading: set text(size: 26pt, weight: "regular", font: th("font"))
        heading(level: 1, last-name) }
      { show heading: set block(above: 10pt, below: 0pt)
        show heading: set text(weight: "light", font: th("font-tertiary"))
        heading(level: 3, upper(profession)) }

      if profile-picture != none {
        set block(radius: 100%, clip: true, above: 1fr, below: 1fr)
        set align(center)
        set image(width: th("profile-picture-width"))
        profile-picture
      } else { v(1fr) }

      { set text(weight: "light", style: "italic", hyphenate: true)
        set par(leading: 1.0em)
        bio }
      aside
    },
    [],  // gutter
    main,
  )
}

// === Usage ===

#show: resume.with(
  first-name: "Jane",
  last-name: "Doe",
  profession: "Software Engineer",
  bio: [Experienced engineer with a passion for building scalable systems.],
  // profile-picture: image("photo.jpg"),
  aside: {
    section("Contact", {
      contact-entry([Email], link("mailto:jane@example.com", "jane@example.com"))
      line(stroke: 0.1pt, length: 100%)
      contact-entry([Phone], link("tel:+1234567890", "+1 234 567 890"))
    })
    section("Skills", {
      set text(font: "Arial", size: 9pt)
      stack(spacing: 8pt, "Python", "Rust", "TypeScript", "Docker", "Kubernetes")
    })
    section("Languages", {
      language-entry("English", "Native")
      language-entry("Chinese", "Fluent")
    })
  },
)

#section(theme: (space-above: 0pt), "Experience", {
  work-entry(
    timeframe: "2022 – Present",
    title: "Senior Software Engineer",
    organization: "Tech Corp",
    location: "San Francisco",
    [Led team of 8 engineers. Reduced latency 40%. Built microservices for 10M+ users.],
  )
  work-entry(
    timeframe: "2020 – 2022",
    title: "Software Engineer",
    organization: "StartupCo",
    location: "Remote",
    [Built data pipelines processing 1TB+ daily. Improved test coverage to 85%.],
  )
})

#section("Education",
  education-entry(
    title: "M.S. Computer Science",
    institution: "Stanford University",
    timeframe: "2018 – 2020",
    [Machine Learning and Distributed Systems],
  ),
)
```

---

## 5. Letter

```typst
#set page(paper: "a4", margin: 2.5cm)
#set text(font: "Linux Libertine", size: 11pt)
#set par(justify: true)

// Sender
#align(right)[
  Your Name \
  123 Main Street \
  City, State 12345 \
  email\@example.com \
  #v(0.5em)
  #datetime.today().display("[month repr:long] [day], [year]")
]

#v(2em)

// Recipient
Recipient Name \
Company Name \
456 Business Ave \
City, State 67890

#v(1.5em)

Dear Mr./Ms. Last Name,

#v(0.5em)

I am writing to express my interest in the position of Software Engineer at your company. With my background in distributed systems and machine learning, I believe I would be a strong addition to your team.

In my current role at Tech Corp, I have led the development of scalable microservices serving millions of users. My experience with cloud infrastructure and data pipeline optimization aligns well with the requirements outlined in your job posting.

I would welcome the opportunity to discuss how my skills and experience can contribute to your team's success. Thank you for your time and consideration.

#v(1.5em)

Sincerely,

#v(2em)

Your Name

---

## 6. Technical Report

```typst
#set document(title: "Technical Report", author: "Engineering Team")
#set page(
  paper: "a4",
  margin: 2.5cm,
  header: context {
    if counter(page).get().first() > 1 [
      #text(size: 9pt, fill: gray)[Technical Report — CONFIDENTIAL]
      #h(1fr)
      #text(size: 9pt, fill: gray)[#datetime.today().display("[year]-[month]-[day]")]
    ]
  },
  footer: context {
    align(center, text(size: 9pt)[Page #counter(page).display()])
  },
)
#set text(font: "Linux Libertine", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 0.8em)

// Cover
#align(center + horizon)[
  #text(size: 12pt, fill: gray)[Company Name]
  #v(1em)
  #text(size: 24pt, weight: "bold")[Technical Report Title]
  #v(0.5em)
  #text(size: 14pt)[System Architecture Review]
  #v(2em)
  #text(size: 12pt)[
    Prepared by: Engineering Team \
    Version: 1.0 \
    Date: #datetime.today().display("[month repr:long] [day], [year]") \
    Classification: Internal
  ]
]
#pagebreak()

#outline(title: "Table of Contents", depth: 3, indent: auto)
#pagebreak()

= Executive Summary

This report presents findings from our system architecture review conducted in Q1 2024...

= System Overview

== Current Architecture

The system consists of the following components:

#figure(
  table(
    columns: (auto, 1fr, auto),
    align: (left, left, center),
    table.header([*Component*], [*Description*], [*Status*]),
    [API Gateway], [Handles authentication and routing], [Active],
    [Worker Pool], [Processes async tasks], [Active],
    [Database], [PostgreSQL with read replicas], [Active],
    [Cache Layer], [Redis cluster], [Degraded],
  ),
  caption: [System components overview.],
)

== Performance Metrics

Current system performance:

$ "Throughput" = frac("Requests", "Time") = frac(10000, "1 second") = "10k RPS" $

= Recommendations

+ Upgrade cache layer to resolve degraded status
+ Implement circuit breakers for external dependencies
+ Add horizontal scaling for worker pool

= Appendix

== Configuration Details

```yaml
server:
  port: 8080
  workers: 4
  timeout: 30s
database:
  host: db.internal
  pool_size: 20
```
```

---

## 7. Presentation-Style Document

```typst
// Landscape slides-style document
#set page(
  width: 254mm,
  height: 190.5mm,
  margin: (top: 2cm, bottom: 1.5cm, left: 2.5cm, right: 2.5cm),
  fill: white,
)
#set text(font: "Linux Libertine", size: 20pt)

#let slide(title: none, body) = {
  pagebreak(weak: true)
  if title != none {
    text(size: 28pt, weight: "bold", fill: rgb("#2c3e50"))[#title]
    v(0.5em)
    line(length: 100%, stroke: 2pt + rgb("#3498db"))
    v(0.8em)
  }
  body
}

// Title slide
#align(center + horizon)[
  #text(size: 36pt, weight: "bold", fill: rgb("#2c3e50"))[
    Presentation Title
  ]
  #v(1em)
  #text(size: 20pt, fill: rgb("#7f8c8d"))[
    Subtitle or Description
  ]
  #v(2em)
  #text(size: 16pt)[
    Author Name \
    #datetime.today().display("[month repr:long] [day], [year]")
  ]
]

#slide(title: "Overview")[
  #set text(size: 18pt)
  - First major point
  - Second major point
  - Third major point

  #v(1em)
  #align(center)[
    #rect(fill: rgb("#ecf0f1"), inset: 15pt, radius: 8pt, width: 70%)[
      #text(size: 16pt)[Key takeaway or highlight]
    ]
  ]
]

#slide(title: "Data")[
  #set text(size: 16pt)
  #figure(
    table(
      columns: 3,
      align: center,
      table.header([*Metric*], [*Before*], [*After*]),
      [Performance], [65%], [92%],
      [Reliability], [99.5%], [99.99%],
      [Cost], [$100k], [$75k],
    ),
  )
]

#slide(title: "Conclusion")[
  #set text(size: 18pt)
  + Summary point one
  + Summary point two
  + Summary point three

  #v(1em)
  #align(center)[
    #text(size: 24pt, weight: "bold", fill: rgb("#27ae60"))[
      Thank you!
    ]
  ]
]
```

---

## 8. Invoice

```typst
#set page(paper: "a4", margin: 2cm)
#set text(font: "Linux Libertine", size: 10pt)

#grid(columns: (1fr, 1fr),
  [
    #text(size: 18pt, weight: "bold")[INVOICE]
    #v(0.3em)
    Invoice \#: INV-2024-001 \
    Date: #datetime.today().display("[year]-[month]-[day]") \
    Due: 2024-03-15
  ],
  align(right)[
    *Your Company Name* \
    123 Business Street \
    City, State 12345 \
    contact\@company.com
  ],
)

#v(1.5em)
#line(length: 100%, stroke: 0.5pt)
#v(0.5em)

*Bill To:* \
Client Name \
Client Company \
456 Client Ave \
City, State 67890

#v(1.5em)

#table(
  columns: (1fr, auto, auto, auto),
  align: (left, center, right, right),
  stroke: none,
  table.header(
    table.cell(fill: rgb("#2c3e50"))[#text(fill: white)[*Description*]],
    table.cell(fill: rgb("#2c3e50"))[#text(fill: white)[*Qty*]],
    table.cell(fill: rgb("#2c3e50"))[#text(fill: white)[*Rate*]],
    table.cell(fill: rgb("#2c3e50"))[#text(fill: white)[*Amount*]],
  ),
  table.hline(),
  [Web Development], [40 hrs], [\$150.00], [\$6,000.00],
  table.hline(stroke: 0.3pt),
  [UI/UX Design], [20 hrs], [\$120.00], [\$2,400.00],
  table.hline(stroke: 0.3pt),
  [Server Setup], [8 hrs], [\$175.00], [\$1,400.00],
  table.hline(),
)

#v(0.5em)
#align(right)[
  #grid(columns: (auto, auto),
    column-gutter: 2em,
    align: (right, right),
    [Subtotal:], [\$9,800.00],
    [Tax (10%):], [\$980.00],
    [*Total:*], [*\$10,780.00*],
  )
]

#v(3em)
#text(fill: gray)[
  *Payment Terms:* Net 30. Please make payment to the bank account provided separately.

  Thank you for your business!
]
```
