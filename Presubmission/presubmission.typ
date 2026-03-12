// 7 4 10 2 2

#import "@preview/presentate:0.2.5": *

#let bgColor = rgb("EFECEC")
#let fgColor = rgb("37353E")
#let h1Color = rgb("213C51")
#let h2Color = rgb("B43F3F")
#let focusColor = rgb("4F709C")
#let papers = yaml("papers.yml")
#let h1Font = "Stack Sans Notch"
#let h2Font = "Stack Sans Headline"
#let mainFont = "Inter Display"


#let img(name, w: none, h: auto) = box(align(center, image("images/" + name, width: if w == none { auto } else { w }, height: h)), width: 1fr)
#let Img(name, w: none, h: auto) = align(center, image("images/" + name, width: if w == none { auto } else { w }, height: h))
#let focus(it) = text(weight: "bold", fill: focusColor, it)
#let cen(it) = align(center, smallcaps(text(font: "Barlow", weight: "extrabold", fill: h1Color, size: 1.2em, it)))
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
#let bbox(..args, factor: 100%) = scale(factor, box(inset: 0.5em, width: if args.pos().len() > 1 { args.pos().at(1) } else { auto }, align(center + horizon, text(fill: white, args.pos().at(0))), radius: 10pt, fill: gradient.linear(fgColor, h2Color, angle: 0deg)))
#let cols(..items, w: ()) = align(center, grid(columns: if w.len() > 0 { w } else { items.pos().map(x => 1fr) }, gutter: 1em, align: center + horizon, ..items.pos()))

#set page(paper: "presentation-16-9", fill: bgColor, margin: 1.5em)
#show image: set align(bottom)
#set text(size: 18pt, font: mainFont, weight: "medium", fill: fgColor)
#show math.equation: set text(font: "Noto Sans Math", weight: "black")
#set par(leading: 0.5em)
#let slideTop(it) = align(top, slide(it))
// #show emph: set text(font: "bitter")
#show heading.where(level: 1): set text(fill: h1Color, font: h1Font, size: 1.9em)
#show heading.where(level: 1): set par(leading: 0.3em)
#show heading.where(level: 2): set text(fill: h2Color, font: h2Font, size: 1.5em)
#show heading.where(level: 2): set par(leading: 0.4em)
#set list(marker: square(width: 0.6em, fill: fgColor), spacing: 1em)
#show list: set align(left)
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
  #box(inset: (x: 1em,),
  stack(dir: ttb, spacing: 1em,
      ..items
  )
  )
  #only(1)[#place(
    top,
    // dy: 2.3em,
    rect(width: 100%, height: 7em, stroke: (left: 0.2em + h2Color, rest: 0em)),
  )]
  #v(1fr)

  #let items = ()
  #for key in ("Mukherjee2022", "Patra_2023", "Anjan2025", "Debata2026") {
      let paper = papers.at(key)
      items.push([*#paper.display*.~~#authorise(paper.author).~~(#paper.date)])
  }
  
  #uncover(auto)[
    #place(
      bottom,
      // dy: -1em,
      rect(width: 100%, height: 8.5em, stroke: (left: 0.2em + h2Color, rest: 0em)),
    )
  #box(inset: (x: 1em,),
    stack(dir: ttb, spacing: 1em,
      ..items
    )
  )
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
  #cols(
    only(1, 2, [
      #cen[Explain Experiments]
      - Build and solve theoretical models for experiments
      - Compute measurables to explain observations
      - Kondo effect, quantum Hall effect, superconductivity
      #img("kondoExample.svg", w:70%)
      #v(1fr)
    ])
    + only(3, [
      #cen[Predict Experiments]
    - Identify interesting theoretical models for new systems
    - Predict novel phenomena by tweaking models and parameters
    - Abrikosov vortex lattice, spin liquids
    #img("abrikosovLattice.jpg", w:60%)
    #v(1fr)
    ]),
    only(2, [
      #cen[Predict Experiments]
    - Identify interesting theoretical models for new systems
    - Predict novel phenomena by tweaking models and parameters
    - Abrikosov vortex lattice, spin liquids
    #img("abrikosovLattice.jpg", w:60%)
    #v(1fr)
    ])
    + only(3, [
      #cen[Classify experiments]
    - organize experimental signatures into universal principles
    - come up with frameworks that explain a large class of phenomena
    - Examples: Landau theory of phase transition
    #img("mexicanHat.jpg", w:70%)
    #v(1fr)
    ])
  )
]

#slide[
  #title[Quantum Materials]
  Class of materials that #focus[cannot] be well-approximated by "classical" description

  #cols(
  unc(from: 2)[
    #img("graphene.jpg", w:80%)
  ],
  [
    #unc(from: 2)[
    #bbox([topological properties\ (_topological insulators_)], 100%)
    ]
    #unc(from: 3)[
    #bbox([non-local entanglement\ (_spin liquids_)], 100%)
    ]
    #unc(from: 4)[
    #bbox([collective excitations\ (_strange metals_)], 100%)
    ]
  ],
  unc(from: 3)[
    #img("QSL.jpg", w: 80%)
  ]
  )

  #unc(from: 5)[
    Needs dramatically #focus[new ideas] and methods!
    - #focus[non-local/collective] order parameters for transition
    - ability to work with a large number of #focus[interacting particles]
    - ability to work  with #focus[emergent] degrees of freedom
  ]

]

#slide[
  #title[Strongly Correlated Phenomena]

  Materials with strong #focus[local] electronic correlation, #focus[low dimensionality], multiple electronic #focus[orbitals]
  #only(from:1, to: 4)[
  #cols(
    unc(2,3,4)[
      - Transition metal oxides (high-$T_c$ cuprates)
      - Transition metal dichalcogenides ($"MoS"_2$)
      - Heavy-fermion compounds ($"CeCu"_2"Si"_2$)
    ]
    + unc(3,4)[
      #bbox[transition metals, rare\ earths, actinides]

      #bbox[unpaired _f_ or\ _d_ electrons]

      Localised _f_ and _d_ electrons \ #focus[enhance] effect of correlations.
    ],
    unc(4)[
      #img("cuprateStructure.png", w:100%)
    ]
  )]
  #only(from: 5, to: 9)[
    #cen[Phenomena: Mott Insulation]

    #img("mottInsulator.svg", w:95%)
    #only(5)[#place(right + horizon, rect(fill: bgColor, width: 62%, height: 60%))]
    #only(6)[#place(right + horizon, rect(fill: bgColor, width: 40%, height: 60%))]

    #only(8,9)[
      #cols(
        [
          - Not accessible from 1-particle theory
        ],
        [
          - result of #focus[manybody effects]
        ],
      )
    ]
    #unc(9, place(center + horizon, bbox(factor: 120%, [How do we describe the transition\ from a metal into a Mott insulator?])))

  ]
  #only(from: 10, to: 13)[
    #cen[Phenomena: Strange Metallicity]
    #cols(
      [
        #img("linearResistivity.svg", w: 100%)
      ],
      unc(from: 11)[
        Conventional metallic\
        theory predicts $R prop T^2$

        #img("TSquareScattering.svg", w: 70%)

        Source of $R prop T^2$?
      ],
      unc(from: 12)[
        Single particles must propagate\
        finite number of lattice spacing

        #img("mirSchematic.svg", w: 70%)

      ],
      w: (1fr, 0.8fr, 1fr)
    )
    #unc(13)[#place(center + horizon, bbox(factor: 120%, [Who is carrying current\ in strange metals?]))]

  ]
  // TODO: Add pseudogap here if time permits
]

#slide[

  #title[Theoretical Models of Correlated Materials]
  #cols(
    [
      #cen[Hubbard Model]
      #show: pause

      - Correlated electrons hopping on a lattice

      #img("hubbard1.svg", w:80%)
      #show: pause

      - Hopping probability is $t$.

      #img("hubbard2.svg", w:80%)
      #show: pause

      - Energy cost $U$ if two occupy same site.

      #img("hubbard3.svg", w:80%)
      #show: pause

      *Hamiltonian*: $-t sum_(i, j, sigma) (c^dagger_(i, sigma) c_(j, sigma) + "h.c.") + sum_i U n_(i, arrow.t) n_(i, arrow.b)$
      #v(1fr)
    ],
    [
      #show: pause
      #cen[Periodic Anderson Model]

      - #focus[Multi-orbital] model: one localised, the other delocalised

      #show: pause

      #img("PAM2.svg", w:70%)

      - Electrons can hop across orbitals

      #show: pause

      *Hamiltonian*: $ H_"Hub" + H_"hop" + V sum_(i,sigma) f^dagger_(i,sigma) c_(i,sigma) + "h.c."$

      #v(1fr)
    ],
  )
  // Describe these models and how they embody correlations
  // - Hubbard model
  // - Impurity lattice model
]

#slide[
  #title[Quantum Impurity Models as Auxiliary Models]

  Lattice models of correlated electrons are *hard to solve* directly.

  #cols(
    img("auxiliary1.svg"),
    [#focus[Idea]: replace full problem with a simpler *auxiliary model* that captures the local correlations.],
    unc(from: 2, img("auxiliary2.png")),
    w: (1fr, 1fr, 1.2fr),
  )

  #show: pause
  #cols(
    cen[Example: Mean-field solution of Ising model],
    [
      #img("isingAux1.svg")
      $ H = sum_(i,j)J_(i,j)S_i^z S_j^z $
    ],
    [
      #show: pause
      *Mean-field* approximation:

      $ H = sum_(i)h_"eff" S_i^z $
    ],
    [
      #show: pause
      #img("isingAux2.svg")

      Environment replaced by effective field
    ]
  )

]

#slide[
  #title[Quantum Impurity Models as Auxiliary Models]

  // - Broad idea behind Auxiliary models
  // - What are quantum impurity models
  // - Example of mapping (mean-field) to previously mentioned models
  //
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

