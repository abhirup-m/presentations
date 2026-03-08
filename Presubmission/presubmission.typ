// 7 4 10 2 2

#import "@preview/presentate:0.2.5": *

// #let focus(it) = text(fill: rgb("57564F"), weight: "bold", it)
#let papers = yaml("papers.yml")
#let authorise(authors) = {
  let authorList = []
  for (i, a) in authors.enumerate() {
    let author = a
    if a.contains(", ") {
      author = a.split(", ").rev().join(" ")
    }
    if author == "Abhirup Mukherjee" {
      authorList = authorList + [*AM*]
    } else {
      author = author.split(" ")
      author.at(0) = author.at(0).at(0)
      author = author.join(" ")
      authorList = authorList + author
    }
    if i < authors.len() - 1 {
      authorList = authorList + ", "
    }
  }
  return authorList
}
#let img(file, width) = box(image("images/" + file, width: width))
#set page(paper: "presentation-16-9", fill: rgb("ECECEC"), margin: 1.5em)
#set text(size: 18pt, font: "Stack Sans Text", fill: rgb("222831"))
#show strong: set text(fill: rgb("093FB4"))
#show math.equation: set text(font: "Fira Math")
#set par(leading: 0.5em)
#show emph: set text(font: "bitter")
#show heading.where(level: 1): set text(fill: rgb("213C51"), font: "Stack Sans Notch", size: 1.9em)
#show heading.where(level: 1): set par(leading: 0.3em)
#show heading.where(level: 2): set text(fill: rgb("A82323"), font: "Stack Sans Headline", size: 1.5em)
#show heading.where(level: 2): set par(leading: 0.4em)
#set list(marker: square(width: 0.6em, fill: rgb("3f3f3f")), spacing: 1.5em)

#set align(horizon)

#page(margin: 2em,[
= A New Auxiliary Model Approach For Fermionic Criticality
== Insights on Mottness in Strongly Correlated Systems
#v(0.5em)
#text(weight: "bold", size: 1.4em, [ABHIRUP MUKHERJEE])
#v(0.5em)
_Presubmission Open Seminar_
#v(0.5em)
#grid(
  columns: (0.15fr, 1fr, 0.15fr),
  align: (left + horizon, center + horizon, right + horizon),
  gutter: 2em,
  img("iiserk.png", 100%),
  text(size: 1.2em, [
   *Emergent Phenomena in Quantum Matter* group\
   IISER Kolkata
   ]),
  img("epqm.svg", 90%)
)
])

#let title(title) = { place(top, heading(level:2, title)) + v(1.5em) }
#let section(title) = { align(horizon, heading(level: 1, title))}

#title[Acknowledgements]
#slide[
]

#slide[
  #title[Publications]

  #let items = ()
  #for key in ("Mukherjee2023", "Mukherjee2024", "Mukherjee2025", "Mukherjee2026") {
      let paper = papers.at(key)
      items.push([*#paper.display*. ~~#authorise(paper.author).~~(#paper.date)])
  }
  #box(inset: 1em,[
  #stack(dir: ttb, spacing: 1em,
      ..items
  )
  ])
  #only(1)[#place(
    top,
    float: false,
    dy: 2.3em,
    rect(width: 100%, height: 7.5em, stroke: (left: 0.2em + rgb("A82323"), rest: 0em)),
  )]

  #let items = ()
  #for key in ("Mukherjee2022", "Patra_2023", "Anjan2025", "Debata2026") {
      let paper = papers.at(key)
      items.push([*#paper.display*.~~#authorise(paper.author).~~(#paper.date)])
  }
  
  #uncover(auto)[
    #place(
      bottom,
      float: false,
      dy: -1em,
      rect(width: 100%, height: 10em, stroke: (left: 0.2em + rgb("A82323"), rest: 0em)),
    )
  #box(inset: 1em,[
    #stack(dir: ttb, spacing: 1em,
      ..items
    )
  ])
  ]
]

#title[Outline of Thesis]
#slide[
  #grid(
    rows: auto,
    gutter: 1.2em,
    align: left+top,
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 1*.~Introduction#h(1fr)*Chap 2*.~Methods and Preliminaries], []),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 3*.~Kondo frustration via charge fluctuations: Mott localisation in $d=infinity$], [[#strong(eval(papers.Mukherjee2023.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 4*.~A New Auxiliary Model Mapping For Correlated Lattice Models], [[#strong(eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 5*.~Mott Criticality as the Confinement Transition of a Pseudogap-Mott Metal in $d=2$], [[#strong(eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 6*.~Competing tendencies In Heavy Fermion Systems: Kondo screening vs. Mott localisation], [[#strong(eval(papers.Mukherjee2026.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 7*.~Holographic entanglement renormalisation for fermionic quantum matter], [[#strong(eval(papers.Mukherjee2024.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 8*.~Conclusions], []),
  )
]

#slide[
#section[Introduction To Fermionic Criticality and Quantum Materials]
// == What's the Big Idea?
]

#slide[
  #title[What Do Condensed Matter Theorists Do?]

  - solving models to explain experiments
  - coming up with models to predict experiments
  - coming up with frameworks to classify signatures
  Use this to slide into experiments and materials
]

#slide[
  #title[Quantum Materials]

  - various classes of strongly correlated materials
  - why they are strongly correlated (f/d orbitals)
  - why it's hard to study them (weak coupling not enough, multiple energy scales, etc)
]

#slide[
  #title[Strongly Correlated Phenomena]
  Talk about experimental features of quantum matter
  - Mott insulation
  - strange metal
  - pseudogap
  - high-Tc superconductivity
]

#slide[
  #title[Theoretical Models of Materials]
  Describe these models and how they embody correlations
  - Hubbard model
  - Impurity lattice model
]

#slide[
  #title[Quantum Impurity Models as Auxiliary Models]
  - Broad idea behind Auxiliary models
  - What are quantum impurity models
  - Example of mapping (mean-field) to previously mentioned models
]

#slide[
  #title[Quantum Impurity Models as Auxiliary Models]
  More details
  - discuss Kondo screening
  - discuss Kondo breakdown
  - argue how LFL and LM can be thought of as metallic vs insulating behaviour
]

#slide[
  #title[Questions]
  - Questions about solving models
  - Questions about developing methods
]

#slide[
#section[Minimal Model For Kondo Breakdown]
== A Route to Mott Localisation in Infinite Dimensions\ \
*#papers.Mukherjee2023.display (#papers.Mukherjee2023.date)*\
#authorise(papers.Mukherjee2023.author)
]

#slide[
]

#slide[
#section[Capturing Spatial Fluctuations and Lattice Geometry]
== Impurity-Lattice Mapping Beyond Mean-Field\ \
*#papers.Mukherjee2025.display (#papers.Mukherjee2025.date)*\
#authorise(papers.Mukherjee2025.author)
]

#slide[
]

#slide[
#section[Kondo Breakdown On The Square Lattice]
== Revisiting the Mott Transition in Two Dimensions\ \
*#papers.Mukherjee2025.display (#papers.Mukherjee2025.date)*\
#authorise(papers.Mukherjee2025.author)
]

#slide[
]

#slide[
#section[Competing tendencies In a Multi-Orbital System]
== Kondo screening vs. Mott localisation in a Heavy-Fermion model\ \
*(in progress)*\
#authorise(papers.Mukherjee2026.author)
]

#slide[
]

#slide[
#section[Holography of Entanglement in 2D Free Fermions]
== Emergent Geometry and Fermionic Criticality\ \
*#papers.Mukherjee2024.display (#papers.Mukherjee2024.date)*\
#authorise(papers.Mukherjee2024.author)
]

#slide[
  #image("images/wormhole_gapless.svg", width: 50%)#image("images/wormhole_gapped.svg", width: 50%)
]

#slide[
#section[Closing Remarks]
]

#slide[
  #title[Summary of Primary Results]

]

#slide[
  #title[Main Conclusions and Takeaways]

]

#slide[
  #title[Future Work]

]

