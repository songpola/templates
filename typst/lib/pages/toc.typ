#let toc = {
  [= Table of Contents]
  align(right)[Page]
  outline(title: none)
}

#let listOfTables = {
  [= List of Tables]
  align(right)[Page]
  outline(title: none, target: figure.where(kind: table))
}

#let listOfFigures = {
  [= List of Figures]
  align(right)[Page]
  outline(title: none, target: figure.where(kind: image))
}

#{
  toc

  pagebreak(weak: true)

  listOfTables

  pagebreak(weak: true)

  listOfFigures

  pagebreak(weak: true)
}
