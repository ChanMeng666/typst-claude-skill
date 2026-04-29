// Minimal Typst document — compile with: typst compile hello-world.typ
#set document(title: "Hello World", author: "Author")
#set page(paper: "a4", margin: 2.5cm)
#set text(font: "Linux Libertine", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true, leading: 0.8em)

= Hello, Typst!

This is a minimal document demonstrating basic Typst setup.

== Math Example

The Gaussian integral:

$ integral_(-infinity)^infinity e^(-x^2) dif x = sqrt(pi) $

== Lists

- First item
- Second item
  - Nested item

+ Numbered one
+ Numbered two
