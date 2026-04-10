// Basic resume — compile with: typst compile resume-basic.typ
#set document(title: "Resume", author: "Jane Doe")
#set page(paper: "a4", margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm))
#set text(font: "Linux Libertine", size: 10pt)
#set par(justify: true, leading: 0.7em)

// Helper: section heading with a line
#let section(title) = {
  v(0.6em)
  text(size: 12pt, weight: "bold", upper(title))
  line(length: 100%, stroke: 0.5pt)
  v(0.3em)
}

// Helper: work/education entry
#let entry(dates: "", title: "", org: "", body) = {
  grid(
    columns: (1fr, auto),
    text(weight: "bold")[#title — #org],
    text(fill: luma(100))[#dates],
  )
  body
  v(0.4em)
}

// --- Header ---
#align(center)[
  #text(size: 20pt, weight: "bold")[Jane Doe]
  #v(0.2em)
  jane.doe\@email.com | +1 (555) 123-4567 | San Francisco, CA
]

// --- Experience ---
#section("Experience")

#entry(dates: "2022 – Present", title: "Senior Engineer", org: "Acme Corp")[
  - Led migration of monolith to microservices, reducing deploy time by 60%
  - Mentored 3 junior engineers through code reviews and pair programming
]

#entry(dates: "2019 – 2022", title: "Software Engineer", org: "Startup Inc")[
  - Built real-time data pipeline processing 1M events/day
  - Designed REST API serving 50k daily active users
]

// --- Education ---
#section("Education")

#entry(dates: "2015 – 2019", title: "B.S. Computer Science", org: "University of California")[
  GPA: 3.8 / 4.0
]

// --- Skills ---
#section("Skills")

*Languages:* Python, TypeScript, Go, SQL \
*Tools:* Docker, Kubernetes, PostgreSQL, Redis \
*Practices:* CI/CD, TDD, code review, agile
