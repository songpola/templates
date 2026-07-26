#let tabSize = 0.5in
#let h1Size = 20pt
#let h2Size = 18pt

#let setup(title, doc, doclang: "en") = {
  // Document metadata
  set document(title: title)

  // Body text
  set text(font: "TH Sarabun New", lang: doclang, size: 16pt)

  // Headings
  show heading: set block(spacing: 1em)
  show heading.where(level: 1): set text(size: h1Size)
  show heading.where(level: 1): set align(center)
  show heading.where(level: 2): set text(size: h2Size)

  doc
}
