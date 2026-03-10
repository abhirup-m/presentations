// 7 4 10 2 2

#import "@preview/presentate:0.2.5": *

#let bgColor = rgb("EFEFEF")
#let fgColor = rgb("222831")
#let h1Color = rgb("7D0A0A")
#let h2Color = rgb("E36414")
#let focusColor = rgb("7D0A0A")
#let papers = yaml("papers.yml")

#let img(name, w: none, h: auto) = align(center, box(image("images/" + name, width: if w == none { 100% } else { w }, height: h)))
#let Img(name, w: none, h: auto) = align(center, image("images/" + name, width: if w == none { 100% } else { w }, height: h))
#let focus(it) = text(weight: "bold", fill: focusColor, it)
#let cen(it) = align(center, text(weight: "bold", fill: focusColor, size: 1.2em, it))
#let authorise(authors) = {
  let authorList = []
  for (i, a) in authors.enumerate() {
    let author = a
    if a.contains(", ") {
      author = a.split(", ").rev().join(" ")
    }
    if author == "Abhirup Mukherjee" {
      authorList = authorList + focus[AM]
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
#let title(title) = { place(top, heading(level:2, title), float: true) }
#let section(title) = { align(horizon, heading(level: 1, title))}
#let bbox(it, w) = box(inset: 0.5em, align(center + horizon, text(fill: fgColor, it)), fill: white, stroke: 0.1em + h2Color)

#set page(paper: "presentation-16-9", fill: bgColor, margin: 1.5em)
#show image: set align(bottom)
#set text(size: 17pt, font: "Stack Sans Text", fill: fgColor)
#show math.equation: set text(font: "Fira Math")
#set par(leading: 0.5em)
#let slideTop(it) = align(top, slide(it))
#show emph: set text(font: "bitter")
#show heading.where(level: 1): set text(fill: h1Color, font: "Stack Sans Notch", size: 1.9em)
#show heading.where(level: 1): set par(leading: 0.3em)
#show heading.where(level: 2): set text(fill: h2Color, font: "Stack Sans Headline", size: 1.5em)
#show heading.where(level: 2): set par(leading: 0.4em)
#set list(marker: square(width: 0.6em, fill: fgColor), spacing: 1.5em)
#let unc(..args) = uncover(..args, update-pause: true)

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
  img("iiserk.png"),
  text(size: 1.2em, [
   *Emergent Phenomena in Quantum Matter* group\
   IISER Kolkata
   ]),
  img("epqm.svg", w:90%)
)
])

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
    rect(width: 100%, height: 7.5em, stroke: (left: 0.2em + h2Color, rest: 0em)),
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
      rect(width: 100%, height: 10em, stroke: (left: 0.2em + h2Color, rest: 0em)),
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
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 3*.~Kondo frustration via charge fluctuations: Mott localisation in $d=infinity$], [[#focus(eval(papers.Mukherjee2023.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 4*.~A New Auxiliary Model Mapping For Correlated Lattice Models], [[#focus(eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 5*.~Mott Criticality as the Confinement Transition of a Pseudogap-Mott Metal in $d=2$], [[#focus(eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 6*.~Competing tendencies In Heavy Fermion Systems: Kondo screening vs. Mott localisation], [[#focus(eval(papers.Mukherjee2026.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 7*.~Holographic entanglement renormalisation for fermionic quantum matter], [[#focus(eval(papers.Mukherjee2024.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 8*.~Conclusions], []),
  )
]

#slide[
#section[Introduction To Fermionic Criticality and Quantum Materials]
// == What's the Big Idea?
]

#slideTop[
  #title[What Do Condensed Matter Theorists Do?]
  #grid(
    columns: (1fr, 1fr),
    gutter: 0.5em,
    only(1, 2, [
      #cen[Explain experiments]
      - Build and solve theoretical models for experiments
      - Compute measurables to explain observations
      - Kondo effect, quantum Hall effect, superconductivity
      #img("kondoExample.svg", w:70%)
    ])
    + only(3, [
      #cen[Predict experiments]
    - Identify interesting theoretical models for new systems
    - Predict novel phenomena by tweaking models and parameters
    - Abrikosov vortex lattice, spin liquids
    #img("abrikosovLattice.jpg", w:60%)
    ]),
    only(2, [
      #cen[Predict experiments]
    - Identify interesting theoretical models for new systems
    - Predict novel phenomena by tweaking models and parameters
    - Abrikosov vortex lattice, spin liquids
    #img("abrikosovLattice.jpg", w:60%)
    ])
    + only(3, [
      #cen[Classify experiments]
    - organize experimental signatures into universal principles
    - come up with frameworks that explain a large class of phenomena
    - Examples: Landau theory of phase transition
    #img("mexicanHat.jpg", w:70%)
    ]),
  )
]

#slide[
  #title[Quantum Materials]
  Class of materials that #focus[cannot] be well-approximated by "classical" description

  #grid(columns: (1fr, 1fr, 1fr), gutter: 1em, 
  align: center + horizon,
  unc(from: 2)[
    #img("graphene.jpg", w:80%)
  ],
  [
    #unc(from: 2)[
    #bbox([topological properties\ (_topological insulators_)], 32%)
    ]

    #unc(from: 3)[
    #bbox([non-local entanglement\ (_spin liquids_)], 32%)
    ]

    #unc(from: 4)[
    #bbox([collective excitations\ (_strange metals_)], 32%)
    ]
  ],
  unc(from: 3)[
    #img("QSL.jpg", w: 80%)
  ]
  )

  #show: pause
  Needs dramatically #focus[new ideas] and methods!
  - #focus[non-local/collective] order parameters for transition
  - ability to work with a large number of #focus[interacting particles]
  - ability to work  with #focus[emergent] degrees of freedom

]

#slide[
  #title[Strongly Correlated Phenomena]
  Materials with #focus[strong] electronic interaction, #focus[low dimensionality], multiple electronic #focus[orbitals]

  Talk about experimental features of quantum matter
  - Mott insulation
  - strange metal
  - pseudogap
  - high-Tc superconductivity

  // - why it's hard to study them (weak coupling not enough, multiple energy scales, etc)
  // - various classes of strongly correlated materials
  // - why they are strongly correlated (f/d orbitals)
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

