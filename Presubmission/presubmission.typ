// 7 4 10 2 2

#import "@preview/presentate:0.2.5": *

#let bgColor = rgb("EFECEC")
#let fgColor = rgb("37353E")
#let h1Color = rgb("3C486B")
#let h2Color = rgb("BF3131")
#let h2Trans = rgb("BF3131cc")
#let focusColor = rgb("4e52a5")
#let papers = yaml("papers.yml")
#let h1Font = "Stack Sans Notch"
#let h2Font = "Stack Sans Headline"
#let mainFont = "Inter Display"


#let Img(name, w: none, h: auto) = align(center, image(if name.contains("/") { "images/" + name.split("/").last() } else { "images/" + name }, width: if w == none { auto } else { w }, height: h))
#let img(name, w: none, h: auto) = box(Img(name, w: w, h: h), width: 1fr)
#let focus(it, under: true) = text(weight: "extrabold", fill: focusColor, if under { underline(it) } else { it }, size: 1em)
#let head(it) = align(center, smallcaps(text(font: "Barlow", weight: "extrabold", fill: fgColor, size: 1.2em, it))) + v(-1em)
#let c(it) = align(center, it)
#let authorise(authors) = {
  let authorList = []
  for (i, a) in authors.enumerate() {
    let author = a
    if a.contains(", ") {
      author = a.split(", ").rev().join(" ")
    }
    if author == "Abhirup Mukherjee" {
      authorList = authorList + focus([AM], under: false)
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
#let title(title) = { 
  let title1 = []
  let title2 = []
  let sep = [ ]
  if title.split(" ").len() > 1 { 
    title1 = text(fill: h1Color, font: h1Font, eval(title.split(" ").at(0), mode: "markup"))
    title2 = text(fill: h2Color, eval(title.split(" ").slice(1).join(" "), mode: "markup")) 
  } else {
    title1 = text(fill: h1Color, font: h1Font, eval(title.slice(0, 3), mode: "markup"))
    title2 = text(fill: h2Color, eval(title.slice(3), mode: "markup"))
    sep = []
  }
  place(top, heading(level:2, title1 + sep + title2), float: true) 
}
#let section(title) = { align(horizon, heading(level: 1, title))}
#let bbox(..args, factor: 100%) = {
  set list(marker: square(width: 0.6em, fill: white), spacing: 1em)
  let bg = h1Color // gradient.linear(h1Color, fgColor, angle: 0deg)
  let fg = rgb("E1E5EA")//white
  let str = 0.2em + rgb("222831")//black
  let wid = if args.pos().len() > 1 { args.pos().at(1) } else { auto }
  scale(
    factor, 
    box(
      inset: 0.7em, 
      width: wid, 
      align(center + horizon, text(weight: "medium", font: "Stack Sans Notch", fill: fg, args.pos().at(0))), 
      radius: 3pt, 
      fill: bg, 
      stroke: str
    )
  )
}
#let cols(..items, w: ()) = align(center, grid(columns: if w.len() > 0 { w } else { items.pos().map(x => 1fr) }, gutter: 1em, align: center + horizon, ..items.pos()))
#let point(angle, f:3) = rotate(angle, scale(f * 100%, math.arrow.r.double.long))
#let unc(..args) = uncover(..args, update-pause: true)
#let und(it, ..args) = underline(it, ..args)
#let seq(..arr) = {
  for (i, t) in arr.pos().enumerate() {
    if calc.rem(i, 2) == 0 {
      if i > 0 {
        [ ❚ *#t*]
      } else {
        [*#t*]
      }
    } else {
      if i > 0 {
        [ ❚ #t]
      } else {
        [#t]
      }
    }
  }
}

#set page(paper: "presentation-16-9", fill: bgColor, margin: 1.5em)
#show image: set align(bottom)
#set text(size: 18pt, font: mainFont, weight: "medium", fill: fgColor)
#show math.equation: set text(font: "Fira Math", size: 1.1em, weight: "regular")

#set par(leading: 0.5em)
#let slideTop(it) = align(top, slide(it))
// #show emph: set text(font: "bitter")
#show heading.where(level: 1): set text(fill: h1Color, font: h1Font, size: 1.9em)
#show heading.where(level: 1): set par(leading: 0.3em)
#show heading.where(level: 2): set text(fill: h2Color, font: h2Font, size: 1.4em)
#show heading.where(level: 2): set par(leading: 0.4em)
#set list(marker: square(width: 0.6em, fill: fgColor), spacing: 1em)
#show list: set align(left)
#set underline(offset: 4pt, stroke: 2pt)

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

#title("Acknowledgements")
#slide[
  #cols(
    img("group1.jpeg", w: 100%),
    img("group2.jpeg", w: 85%),
    img("group4.png", w: 85%)
  )

  #cols(
    img("group3.jpeg"),
    img("group5.svg"),
    img("group6.svg"),
    w: (1fr, 1.3fr, 0.8fr)
  )
]

#slide[
  #title("Publications")

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

#slide[
  #title("Outline of Thesis")
  #grid(
    rows: auto,
    gutter: 1.2em,
    align: left+top,
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 1*.~Introduction#h(1fr)*Chap 2*.~Methods and Preliminaries], []),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 3*.~Kondo frustration via charge fluctuations: Mott localisation in $d=infinity$], [[#focus(under: false, eval(papers.Mukherjee2023.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 4*.~A New Auxiliary Model Mapping For Correlated Lattice Models], [[#focus(under: false, eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 5*.~Mott Criticality as the Confinement Transition of a Pseudogap-Mott Metal in $d=2$], [[#focus(under: false, eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 6*.~Competing tendencies In Heavy Fermion Systems: Kondo screening vs. Mott localisation], [[#focus(under: false, eval(papers.Mukherjee2026.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 7*.~Holographic entanglement renormalisation for fermionic quantum matter], [[#focus(under: false, eval(papers.Mukherjee2024.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 8*.~Conclusions], []),
  )
]

#slide[
#section[Introduction To Fermionic Criticality and Quantum Materials]
// == What's the Big Idea?
]

#slideTop[
  #title("What Do Condensed Matter Theorists Do?")

  #show: pause
  #head[Explain Experiments]
  Build and solve theoretical models that explain observations

  #focus[Examples:] Quantum Hall effect, superconductivity

  #v(1fr)
  #show: pause
  #head[Predict Experiments]
  Identify interesting theoretical models that predict novel phenomena

  #focus[Examples:] Abrikosov vortex lattice, spin liquids

  #v(1fr)
  #show: pause
  #head[Classify experiments]
  Come up with frameworks that explain a large class of phenomena

  #focus[Examples:] Landau theory of phase transition
  #v(1fr)
  // #cols(
  //   only(1, 2, [
  //     #head[Explain Experiments]
  //     - Build and solve theoretical models for experiments
  //     - Compute measurables to explain observations
  //     - Kondo effect, quantum Hall effect, superconductivity
  //     #img("kondoExample.svg", w:70%)
  //     #v(1fr)
  //   ])
  //   + only(3, [
  //     #head[Predict Experiments]
  //   - Identify interesting theoretical models for new systems
  //   - Predict novel phenomena by tweaking models and parameters
  //   - Abrikosov vortex lattice, spin liquids
  //   #img("abrikosovLattice.jpg", w:60%)
  //   #v(1fr)
  //   ]),
  //   only(2, [
  //     #head[Predict Experiments]
  //   - Identify interesting theoretical models for new systems
  //   - Predict novel phenomena by tweaking models and parameters
  //   - Abrikosov vortex lattice, spin liquids
  //   #img("abrikosovLattice.jpg", w:60%)
  //   #v(1fr)
  //   ])
  //   + only(3, [
  //     #head[Classify experiments]
  //   - organize experimental signatures into universal principles
  //   - come up with frameworks that explain a large class of phenomena
  //   - Examples: Landau theory of phase transition
  //   #img("mexicanHat.jpg", w:70%)
  //   #v(1fr)
  //   ])
  // )
]

#slide[
  #title("Quantum Materials")
  Class of materials that #focus[cannot] be well-approximated by "classical" description

  #cols(
  unc(from: 2)[
    #v(-4em)
    #img("graphene.jpg", w:80%)
  ],
  [
    #unc(from: 2)[
      #place(auto, float: true, dx: 3em, bbox([topological properties\ (_topological insulators_)], factor: 100%))
    ]
    #unc(from: 3)[
    #place(auto, float: true, dx:0.5em, dy: -2.5em, bbox([non-local entanglement (_spin liquids_)], factor: 100%))
    ]
    #unc(from: 4)[
    #place(auto, float: true, dx:-3em, dy: -3.5em, bbox([collective excitations (_strange metals_)], factor: 100%))
    ]
  ],
  unc(from: 3)[
    #v(-4em)
    #img("QSL.jpg", w: 80%)
  ]
  )

  #v(-3.5em)
  #unc(from: 5)[
    Needs dramatically #focus[new ideas] and methods!
    - #focus[non-local/collective] order parameters for transition
    - ability to work with a large number of #focus[interacting particles]
    - ability to work  with #focus[emergent] degrees of freedom
  ]

]

#slide[
  #title("Strongly Correlated Phenomena")

  Materials with strong #focus[local] correlation, #focus[low dimensionality], multiple electronic #focus[orbitals]
  // #only(from:1, to: 2)[
  // #cols(
  //   unc(2)[
  //     #bbox[transition metals, rare\ earths, actinides]
  //
  //     #bbox[unpaired _f_ or\ _d_ electrons]
  //   ],
  //   unc(2)[
  //     - Transition metal oxides (high-$T_c$ cuprates)
  //     - Transition metal dichalcogenides ($"MoS"_2$)
  //     - Heavy-fermion compounds ($"CeCu"_2"Si"_2$)
  //
      // Localised _f_ and _d_ electrons \ #focus[enhance] effect of correlations.
    // ]
    // unc(4)[
    //   #img("cuprateStructure.png", w:100%)
    // ]
  // )]
  #only(from: 2, to: 6)[
    #head[Phenomena: Mott Insulation]

    #img("mottInsulator.svg", w:95%)
    #only(2)[#place(right + horizon, rect(fill: bgColor, width: 62%, height: 60%))]
    #only(3)[#place(right + horizon, rect(fill: bgColor, width: 40%, height: 60%))]

    #only(5,6)[
      #cols(
        [
          - Not accessible from 1-particle theory
        ],
        [
          - result of #focus[manybody effects]
        ],
      )
    ]
    #unc(6, place(center + horizon, bbox(factor: 120%, [How do we describe the transition\ from a metal into a Mott insulator?])))

  ]
  #only(from: 7, to: 10)[
    #head[Phenomena: Strange Metallicity]
    #cols(
      [
        #img("linearResistivity.svg", w: 100%)
      ],
      unc(from: 8)[
        Conventional metallic\
        theory predicts $R prop T^2$

        #img("TSquareScattering.svg", w: 70%)

        Source of $R prop T^2$?
      ],
      unc(from: 9)[
        Single particles must propagate\
        finite number of lattice spacing

        #img("mirSchematic.svg", w: 70%)

      ],
      w: (1fr, 0.8fr, 1fr)
    )
    #unc(10)[#place(center + horizon, bbox(factor: 120%, [Who is carrying current\ in strange metals?]))]

  ]
  #only(11, 12)[

    #cols(
      [
        Schematic phase diagram of *copper oxide materials*\

        #v(2em)
        #unc(12)[
        - Zoo of correlated phases!
        - Mechanism underlying various phases: *not settled*
        - Crossover/transition between various phases: *not settled*
        ]
      ],
      h(2em) + img("cuprates.svg", w: 100%),
      w: (1fr, 1.4fr),
    )
  ]
]

#slide[

  #title("Theoretical Models of Correlated Materials")
  #cols(
    [
      #head[Hubbard Model]
      #v(1fr)
      #show: pause

      - Correlated electrons hopping on a lattice
      #show: pause

      - Hopping probability is $t$.

      #img("hubbard2.svg", w:40%)
      #show: pause

      - Energy cost $U$ if two occupy same site.

      #img("hubbard3.svg", w:40%)
      #show: pause

      #v(1fr)
      $ H = -t sum_(i, j, sigma) \( c^dagger_(i, sigma) c_(j, sigma) + "h.c." \) + sum_i U n_(i, arrow.t) n_(i, arrow.b) $
      #v(1fr)
    ]
    // [
    //   #show: pause
    //   #head[Periodic Anderson Model]
    //
    //   - #focus[Multi-orbital] model: one localised, the other delocalised
    //
    //   #show: pause
    //
    //   #img("PAM2.svg", w:70%)
    //
    //   - Electrons can hop across orbitals
    //
    //   #show: pause
    //
    //   *Hamiltonian*: $ H_"Hub" + H_"hop" + V sum_(i,sigma) f^dagger_(i,sigma) c_(i,sigma) + "h.c."$
    //
    //   #v(1fr)
    // ],
  )
  #show: pause
  #place(center + top, dy: 4em, bbox(factor: 120%, [$t$ ⟹  Delocalisation\ $U$ ⟹ Localisation]))
  #show: pause
  #place(center + bottom, dy: -4em, bbox(factor: 120%, [
    🔥~~Competition\
    🫂~~Correlations
  ]))


]

#slide[
  #title("Quantum Impurity Models as Auxiliary Models")

  #cols(
    img("auxiliary1.svg"),
    [
      Lattice models of correlated electrons are *hard to solve* directly.\
      #show: pause

      #focus[Idea]: replace full problem with a simpler *auxiliary model* that captures the local correlations.
    ],
    unc(from: 2, img("auxiliary2.png")),
    w: (0.9fr, 1.1fr, 1.2fr),
  )

  // #show: pause
  // #v(1fr)
  // #cols(
  //   head[Example:\ Mean-field solution\ of Ising model],
  //   [
  //     #img("isingAux1.svg")
  //     $ H = sum_(i,j)J_(i,j)S_i^z S_j^z $
  //   ],
  //   [
  //     #show: pause
  //     *Mean-field* approximation:
  //
  //     $ H = sum_(i)h_"eff" S_i^z $
  //   ],
  //   [
  //     #uncover(3, [], update-pause: true)
  //     #show: pause
  //     #img("isingAux2.svg")
  //
  //     Rest ==> effective field
  //   ],
  //   w: (0.9fr, 0.9fr, 0.5fr, 0.9fr),
  // )

]

#slide[
  #title("Quantum Impurity Models as Auxiliary Models")

  #head[Auxiliary Model for Interacting Quantum Systems?]
  #show: pause
  // #only(2,3,4)[#cols(
  //   [
  //     #img("isingAux1.svg")
  //
  //     Ising model ==> #focus[Classical]
  //   ],
  //   [
  //     #show: pause
  //     #img("isingAux2.svg")
  //
  //     Mean-field ==> #focus[Static Model]
  //   ],
  //   [
  //     #show: pause
  //     Interacting Quantum Systems have #focus[time dynamics]
  //
  //     Auxiliary Model has to be *interacting* in order to capture temporal dynamics!
  //   ],
  // )]
  #only(from: 2)[
  #cols(
    [
      Auxiliary Model has to be #focus[interacting] in order to capture temporal dynamics!
    ],
    [
      #head[What is an appropriate auxiliary problem for lattice models with local correlation?]
    ],
    img("auxiliary1.svg"),
    w: (0.8fr, 1fr, 0.5fr),
  )
  #only(from: 3)[
    #v(1fr)
    #place(left + horizon, dy: 0em, head[Insight from Limit of Infinite Dimensions!])
    #v(1fr)
  ]
  #only(from:4, cols(
    [

      Local physics ==> #focus[Quantum Impurity Models]

      Core Idea of Dynamical Mean-Field Theory
    ],
    img("correlatedAuxiliary.svg"),
    unc(from: 5)[
      - Tractable
      - Contains dynamics 

      ($omega-$dependence of correlations)
    ],
    w: (0.25fr, 0.4fr, 0.2fr),
  ))]
  #unc(6)[#place(center + horizon, bbox(factor: 120%, [Local physics of correlated\ lattice models can be mapped\ on to impurity model.]))]

]

#slide[
  #title("Phenomenology of Quantum Impurity Models")
  #cols(
    [
      #head[Kondo Model]
      - Impurity spin $S_d$ + conduction bath
      - Spin-flip scattering

      $ H = sum_(k, sigma) epsilon_k n_(k,sigma) + 1/4 J S_d^z s_0^z + 1/2 S_d^+ s_0^- + 1/2 S_d^- s_0^+$
    ],
    img("kondoModel.svg"),
    w: (1fr, 0.9fr),
  )
  #v(1fr)
  #show: pause
  #only(2,3)[
    #head[Low-energy $\( T << 1 \)$ Properties: Kondo Screening]
    #cols(
      [
        - Kondo coupling generates #focus[entanglement]
        - Impurity DOS supports #focus[gapless excitations]
        - Impurity electron can #focus[delocalise] via bath
        
        #show: pause
        ==> #focus[metallic state] in auxiliary model language.
      ],
      img("Singlet.svg"),
      w: (1fr, 1fr),
    )
  ]
  #only(4,5,6)[
    #cols(
      [
        #v(1fr)
        #head[Metallic State]
        #v(1fr)
        #img("Singlet2.svg")
      ],
      [
        #v(1fr)
        #head[How Do We Get an Insulating State?]
        #unc(5,6)[
          #cols(
            [
              - Tweak the bath
              - Destroy screening
              - Local moment emerges
            ],
            img("localMoment.svg"),
            w: (1fr, 2fr),
          )
        ]
      ],
      w: (0.5fr, 1fr),
    )
  ]
  #unc(6)[#place(center + horizon, bbox(factor: 120%, [
    Kondo screening ⟹ Metallicity
    #v(-0.2em)
    Local moment ⟹ Mott insulation
  ]))]
]

#slide[
  #title("Outstanding Questions")

  #cols(
    head[Appropriate impurity model to describe the Mott transition (locally)?],
    img("whichAuxiliary.svg", w: 90%)
  )
  #v(1fr)

  #place(
    left + horizon,
    box(
    width: 45%,
    head[General Approach To Incorporate Non-Local Fluctuations?]
  ))
  #v(1fr)

  #cols(
    head[Relation Between Various Correlated Phases?],
    img("cuprates.svg", w: 70%),
  )
]

#slide[
#section[Minimal Model For Kondo Breakdown and Mott Transition]
== A Route to Mott Localisation in Infinite Dimensions\ \
*#papers.Mukherjee2023.display (#papers.Mukherjee2023.date)*\
#authorise(papers.Mukherjee2023.author)
]

#slide[
  #title("Mott Transition In Infinite Dimensions")
  #cols(
    [
      #head[DMFT Results on Hubbard Model in ~~$D=infinity$]
      #v(1fr)
      #show: pause
      - numerical implementation means precise form of self-consistent impurity model *not known*
      - low-energy theory for $T=0$ *critical point* not known
      #show: pause
      #v(1fr)
      #head[Our Approach: Add Local Correlation in Bath]
      #v(1fr)
      #cols(
        [$-|U_b| n_(0 arrow.t) n_(0 arrow.b) $],
        img("./images/esiamSchematic.svg", w: 100%),
        w: (1fr, 3fr),
      )
    ],
    [
      Dynamical mean-field theory sees a metal-insulator transition by *self-consistent* determination of bath.

      #v(1fr)
      #img("./images/dmftPhysicsToday.png", w: 95%)
    ],
    w: (1fr, 0.7fr),
  )
]

#slide[
  #title("Phase Diagram and Impurity Phase Transition")
  #show: pause
  #cols(
    only(2)[#img("./images/esiamPhaseMapLabel2.png")]
    + only(3)[#img("./images/esiamPhaseMapLabel3.png")],
    [
      #img("./images/esiamSchematic.svg")
      - Impurity has gapless excitations at $U_b=0$ (#focus[metal])
      - Now, make bath correlation *attractive* (favours 2 electrons)
      #show: pause
      - *Destroys* Kondo screening for $|U_b| > J \/ 4$
    ],
    w: (1.5fr, 1fr),
  )
]

#slide[
  #title("Local Attractive Bath Correlation Is The Trick!")

  #cols(
    [#focus[Local attractive bath correlation] induces phase transition not present in vanilla impurity model.],
    img("./images/esiamSchematic.svg"),
    unc(from: 4)[State exactly at transition is a #focus[special metal] -- more on this later!],
    w: (1fr, 1.5fr, 1fr),
  )

  #v(1fr)
  #unc(from: 2, to: 5)[
    #place(center + horizon, dx: -10em, dy: -1em, point(140deg, f: 4))
    #img("./images/Singlet2.svg")
    #h(9em)
    #unc(from: 3)[
      #img("./images/localMoment.svg")

      #place(center + horizon, dx: 10em, dy: -1em, point(40deg, f: 4))\

      #unc(from: 5)[
        #place(center + horizon, bbox(factor: 120%, [Impurity model with local attractive\ bath correlation is a good\ auxiliary system for Mott transition.]))
      ]
    ]
  ]
]

#slide[
#section[Capturing Spatial Fluctuations and Lattice Geometry]
== Impurity-Lattice Mapping Beyond Mean-Field\ \
*#papers.Mukherjee2025.display (#papers.Mukherjee2025.date)*\
#authorise(papers.Mukherjee2025.author)
]

#slide[
  #title("Extending This To The More Interesting $D=2$ Case")
  #cols(
    img("./images/esiamSchematic.svg"),
    only(1, 2, 3, 4)[
      Previous demonstration worked because
      - *non-local fluctuations vanish* in $d --> infinity$ (mean-field is exact)
      - Largely insensitive to *lattice details* $\{ epsilon_k \}$

    ]
    + only(from: 5)[
      #cols(
        img("./images/latticeInf.svg", w: 80%),
        [
          - All paths symmetric
          - No non-trivial $k-$dependence
        ]
      )
    ],
    w: (0.7fr, 1fr),
  )
  #v(1fr)
  #show: pause
  #c(focus[Low-Dimensional Lattices Are More Interesting!])
  #show: pause
  #cols(
      img("./images/lattice2D_1.svg", w: 75%),
      unc(from: 4)[#img("./images/lattice2D_2.svg", w: 85%)],
      w: (1fr, 1fr),
  )
  #unc(6, 7)[
  #place(center + horizon, dy: -4em, bbox(factor: 120%, [What's the appropriate auxiliary model for a\ correlated system on a 2D square lattice?]))]
  #unc(7)[
  #place(center + horizon, dy: 4em, bbox(factor: 120%, [
    Must capture
    - Spatial fluctuations
    - Lattice geometry
  ]))]
]

#slide[
  #title("Why is 2D Important?")
  #cols(
  [- Many quantum materials are layered.],
  [- Weak interlayer coupling --> effectively 2D]
  )

  #head[Canonical Example: Copper Oxide Materials --> Plethora of Mysterious Phases]
  #v(1fr)
  #cols(
    unc(from: 4)[
      - Overarching theory for strange metal not available
    ],
    unc(from: 5)[
      - Nature of excitations within PG: unclear
    ],
    unc(from: 6)[
      - How are the phases related to each other?
    ],
  )
  #only(2)[
    #cols(
      Img("./images/cuprates.svg", w: 100%),
      // Img("./images/linearResistivity.svg", w: 60%),
      w: (1fr, 1fr),
    )
  ]
  #only(3)[
    #cols(
      Img("./images/cuprates1.svg", w: 100%),
      [
        - Fermi liquid: conventional metal → described by *Landau Fermi-liquid theory*
        - Excitations: long-lived *weakly-interacting* quasiparticles
        - Mott insulator: interaction-driven insulator at half-filling (often AF ordered)
        - Both endpoints are *well understood*
      ],
      w: (1fr, 1fr),
    )
  ]
  #only(4)[
    #cols(
      Img("./images/cuprates2.svg", w: 100%),
      Img("./images/linearResistivity.svg", w: 60%),
      w: (1fr, 1fr),
    )
  ]
  #only(5)[
    #cols(
      Img("./images/cuprates3.svg", w: 100%),
      [ARPES shows *partial gaps* on Fermi surface] + Img("./images/fermiArc1.png", w: 50%),
      w: (1fr, 1fr),
    )
  ]
  #only(from: 6)[
    #cols(
      Img("./images/cuprates4.svg", w: 100%),
      [
        #focus[Inter-relations between the phases not clear!]

        - How do the electrons in Fermi liquid *morph* to form the strange metal/PG phases?

        - How do the excitations of the PG phase *bind* to stabilise the Mott insulator?
      ],
      w: (1fr, 1fr),
    )
  ]
]

#slide[
  #title("Embedding An Impurity Into The Lattice")
  #cols(
    [
      Embed an impurity into a 2D square lattice

      #v(1fr)
      #img("./images/pWaveEsiam.svg", w: 70%)
      #v(1fr)

      - Impurity-Bath spin-interaction (J) can *probe lattice structure*
    ],
    [
  #show: pause
      Contrast with $D=infinity$ limit
      #v(1fr)

      #img("./images/esiamSchematic.svg", w: 90%)
      #v(1fr)
      - Impurity-Bath interaction is purely local --> insensitive to lattice geometry
    ]
  )
  #show: pause
  #place(center + horizon, dy: -4em, bbox(factor: 130%, [Lattice-embedded impurity model\ is a reasonable auxiliary model\ for 2D lattice problems.]))
  #show: pause
  #place(center + horizon, dy: 4em, bbox(factor: 130%, [Lattice geometry encoded\ in impurity-bath correlation.]))
]

#slide[
  #title("Reconstructing Spatial Fluctuations")
  #v(1fr)
  #cols(
    img("./images/pWaveEsiam.svg"),
    [
      #point(0deg)

      #head[Lattice Translation symmetry needs to be restored]
      #v(0.8em)


      #point(0deg)
    ],
    img("./images/latticeModel.svg"),
    w: (1fr, 1.8fr, 1fr),
  )
  #v(1fr)
]

#slide[
  #title("Reconstructing Spatial Fluctuations")
  #head[Lattice Translation symmetry needs to be restored: #und[Bloch's Theorem!]]
  #v(2em)
  #only(2, 3)[#cols(
    v(2em) +
    [
      Translation of\ 1-Particle States:\
      *Wannier --> Bloch*
    ],
    img("./images/bloch1p.svg"),
    w:(1fr, 4fr),
  )]
  #v(1fr)

  #only(3, 4)[#cols(
    [
      Many-electron Translation Operators:#v(-0.7em)
      $ tilde(T)\(a\) = Pi_i T_i \(a\) $

    ],
    img("./images/tilingPlan.svg"),
    w:(1fr, 3.7fr),
  )]
  #only(from: 4)[#cols(
    [

      Many-electron translation:\
      *Impurity --> Lattice*

      $ H_"lat" = sum_i tilde(T)\(r_i\) H_"aux" tilde(T)^dagger \(r_i\) $

      #v(-1em)
      $ -t sum_(<i,j>) \(c^dagger_i c_j + "h.c."\) + U sum_i n_(i, arrow.t)n_(i, arrow.b) + sum_(<i,j>) S_i dot S_j $

    ],
    img("./images/tiledHamiltonian.svg"),
    w:(1fr, 1.4fr),
  )]
  #only(from: 5)[#cols(
    [
      *Plan*: Tiling Procedure + Many-body Bloch's theorem 

      Connects Hamiltonians, Eigenstates, Correlations
    ],
    [
      $ Psi_"lat" = sum_i tilde(T) \( r_i \) psi_"aux" $
      $ tilde(G)_"loc" = G \( r_d, r_d \) + C_0 G \(r_d, r_0\) + C_1 G \(r_d, r_1\) + dots $
    ],
    w:(1fr, 1.5fr,),
  )]
  #v(1fr)
  #only(6)[
    #place(center + horizon, dy: 0em, bbox(factor: 130%, [
      - Study lattice-embedded impurity model.
      - Use tiling relations to reconstruct\ low-energy physics of lattice model.
    ]))
  ]
]

#slide[
  #title("$T=0$ Phase Diagram Of Embedded Impurity Model")

  #head[How To Obtain The Low-Energy Theory]

  #show: pause
  #v(1fr)
  #cols(
    [
      Kondo interaction mixes low and high-energy states:

      $ J\(k_L, k_H\) S_d^+ c^dagger_(k_L, arrow.b)c_(k_H, arrow.t) $

      #show: pause
      *Unitary renormalisation group* approach:
      - unitary transforms. *integrate out* high energy states
      - *fold in* their effects into low-energy states: $J\(k_1, k_2\) --> J^prime\(k_1, k_2\)$
    ],
    w: (1fr, 0.4fr),
  )
  #place(left + horizon, dx: 15em, dy: -3em, img("urgProcesses.svg"))
  #show: pause

  #v(1fr)
  Repeated applications leads to #focus[flow of Hamiltonian]: $H^"(1)", H^"(2)", ..., H^*$
  - Low-energy theory: focus on fixed-point Hamiltonian $H^*$
  - Dynamical information: focus on entire flow
  #v(1fr)
]

#slide[
  #title("$T=0$ Phase Diagram Of Embedded Impurity Model")

  #only(1)[Analyse fixed-point *distribution* of $J(k_1, k_2)$ on #focus[Fermi surface] to classify phases.]

  #v(1fr)
  #unc(2,3,4)[
    #only(2)[
      #place(top + center, head[Small $|W|$])
      #v(1fr)

      #img("phaseDiagram-77-1.svg", w: 90%)
      #v(1fr)

      #cols(
        [
          - $J(k_1, k_2)$ is *strong all over* the Fermi surface
          - Kondo screening successful --> *Fermi liquid*
        ],
        img("./images/Singlet2.svg"),
        w: (1fr, 0.7fr),
      )
      #v(1fr)
    ]

    #only(3)[
      #place(top + center, head[Large $|W|$])
      // #v(0.5em)

      #img("phaseDiagram-77-2.svg", w: 90%)
      // #v(1fr)

      #cols(
        [
          - $J(k_1, k_2)$ *vanishes all over* the Fermi surface
          - Kondo screening absent --> *Mott insulator*
        ],
        img("./images/localMoment.svg"),
        w: (1fr, 0.7fr),
      )
      // #v(1fr)
    ]

    #only(4)[
      #place(top + center, head[Intermediate $|W|$])

      #img("phaseDiagram-77-3.svg", w: 100%)

      #v(1fr)
      #cols(
        [
          - $J(k_1, k_2)$ *vanishes partially* on the Fermi surface
          - *antinodes* decouple from impurity, *nodes* remains coupled
          - Momentum-space *anisotropy*!
        ],
        [
          #focus[What is this phase of matter?]

          Metal or insulator?
        ],
        w: (1fr, 0.5fr),
      )
      #v(1fr)

    ]
  ]
]

#slide[
  #title("Impurity Physics in The Pseudogap")
  #cols(
    [
      #show:pause
      #head[Impurity Magnetisation]
      #v(0.5em)

      - Impurity magnetisation $!= 0$
      - Impurity screening hindered
      - Signature of #focus[breakdown of Fermi liquid]
    ],
    [
      #show:pause
      #head[Density Of States]
      #v(0.5em)

      - Central peak replaced by dip
      - Loss of states at $omega=0$
      - #focus[Destruction of electronic excitations]
    ],
    [
      #show:pause
      #head[Quasiparticle Residue]
      #v(0.5em)

      - strength of electronic excitations
      - Highly suppressed in PG
      - #focus[morphing of excitations]
    ],
  )
  #uncover(1, [], update-pause: true)
  #cols(
    [
      #show:pause
      #img("sdz_77-1500.pdf")
    ],
    [
      #show:pause
      #img("Ad_zoomin_77-1500.pdf")
    ],
    [
      #show:pause
      #img("QPR_77-1500.pdf")
    ]
  )
]

#slide[
  #title("Lattice Physics in The Pseudogap")
  #cols(
    [
      #show:pause
      #head[Lattice~~$K$-- space~~DOS]
      #v(0.5em)

      - Antinodes gapped, nodes gapless
      - Similar to ARPES measurements in cuprates
    ],
    [
      #uncover(1, [], update-pause: true)
      #show:pause
      #img("fermiArc1.png", w: 50%)
    ],
    [
      #show:pause
      #head[Electronic Self-Energy]
      #v(0.5em)

      - large near antinode, small near node
      #show: pause
      - FL: $Sigma^(prime prime) \~ Sigma_0^(prime prime) + omega^2$
      - PG: $1\/Sigma^(prime prime) \~ 1\/Sigma_0^(prime prime) + omega^2$
    ],
  )
  #uncover(1, [], update-pause: true)
  #cols(
    [
      #show:pause
      #img("kspaceDOS-77.pdf")
    ],
    [
      #show:pause
      #img("selfEnergyKspace.pdf")
    ],
    [
      #show:pause
      #img("selfEnergy_d_fit_77-1500.pdf")
    ]
  )
]

#slide[
  #title("Long-Range Correlations: Signatures of Criticality")

  #cols(
    [
      #head[How Far Away Are Spin-Flips Correlated?]
      #v(1em)
  
      $ chi(d,r) = chevron.l arrow(S)_d dot arrow(S)_r chevron.r $
    ],
    img("distanceCorrelations.svg"),
    w: (2fr, 1fr),
  )
  #v(1fr)

  #cols(
    [
      #show: pause

      #img("SF-di_77-700.pdf", w: 100%)
    ],
    [
      #uncover(1, [], update-pause: true)
      #show: pause
      Correlations become *long-ranged* within PG

      #show: pause
      #img("singletStretching.svg")

      Kondo singlet "stretched thin" --> #focus[critical state]
    ],
    w: (0.8fr, 1fr),
  )
]

#slide[
  #title("Long-Range Correlations: Signatures of Criticality")

  #cols(
    [
      #head[Quantum Entanglement Also Becomes Long-Ranged]
      #v(1em)
  
      *Mutual Information* $I_2 (A:B)$: how much do I know about region $A$ if I measure region $B$?
    ],
    // img("distanceCorrelations.svg"),
    w: (2fr, 0fr),
  )
  #v(1fr)

  #cols(
    [
      #show: pause

      $I_2 (d:r)$ becomes long-ranged, another sign of *criticality*

      #img("I2-di_77-700.pdf")
    ],
    [
      #show: pause
      Quantum Fisher Information reveals #focus[5-partite nature] of entanglement

      #img("qfi_77-2000.pdf")
    ],
    w: (1fr, 1fr),
  )
]

#slide[
  #title("Singular Nodal Metal At Critical Point")

  #cols(
    [
      #head[Mott critical point as a nodal non-Fermi liquid]

      #v(1em)
      Integrate out impurity spin to obtain #focus[low-energy theory] for gapless excitations at the critical point.

      $ #focus[Hatsugai-Kohmoto model]: H_"eff" = sum_(q,sigma) \[ epsilon_q tilde(n)_(q,sigma) + U_"eff" tilde(n)_(q,sigma) tilde(n)_(q,-sigma) \] $

      #show: pause
      Model is #focus[exactly solvable] and has a gapless phase:
      - electronic self-energy diverges at $omega=0$ (*non-Fermi liquid*)
    ],
    img("nodalMetal.svg"),
    w: (2.5fr, 1fr)
  )

  #show: pause
  #cols(
    [
      - Electronic excitations decay easily\ \
      #show: pause
      - #focus[Holes and doubles] are long-lived
    ],
    [
      #img("holesDoubles1.svg", w: 100%)
    ],
    [
      #uncover(3, [], update-pause: true)
      #show: pause
      #img("holesDoubles2.svg", w: 100%)
    ],
    w: (1fr, 0.6fr, 0.8fr),
  )
]

#slide[
  #title("Mott Criticality As Holon-Doublon Deconfinement")

  #only(1)[
    #focus[Fermi Liquid]: #seq("electrons as carriers", "short-range entanglement", "vanishing self-energy")

    #img("mottPictureCuprates1.svg", w: 70%)
  ]

  #only(2)[
    #focus[Pseudogap]: #seq("holons-doublons deconfined", "\"noisy\" environment", "long-range entanglement")

    #img("mottPictureCuprates3.svg", w: 70%)
  ]

  #only(3)[
    #focus[Mott insulator]: #seq("holons-doublons confined", "hard gap in spectrum", "only spin physics active")

    #img("mottPictureCuprates4.svg", w: 70%)
  ]
]


#slide[
#section[Competing tendencies In a Multi-Orbital System]
== Kondo screening vs. Mott localisation in a Heavy-Fermion model\ \
*(IN PROGRESS)*\
#authorise(papers.Mukherjee2026.author)
]

#slide[
  #title("Heavy Fermions: When Itineracy Meets Localisation")

  #cols(
    [
      Intermetallic alloys containing rare earth metals and actinides: #focus[_f_--electrons]

      - each site can host two electrons: #focus[one light, one heavy]
      - delocalised electrons _Kondo screen_ localised electrons and "drag" them ==> large number of #focus[heavy carriers]
    ],
    img("heavyFermions.svg"),
    w: (1.5fr, 1fr),
  )

  #v(1fr)
  #cols(
    img("HFPhaseDiagram.svg"),
    [
      #v(1fr)
      #head[QCP, non-Fermi liquid, Superconductivity]
      #v(0.5em)
      localised electrons order magnetically across transition

      #head[Questions]
      #v(0.5em)
      - Source of the #focus[non-Fermi liquid] above the QCP?
      - How do the heavy carriers #focus[morph] across the QCP?
      - How does Kondo screening #focus[breakdown] across the QCP?
      #v(1fr)

    ],
    w: (1fr, 2fr)
  )

]

#slide[
#section[Holography of Entanglement in 2D Free Fermions]
== Emergent Geometry and Fermionic Criticality\ \
*#papers.Mukherjee2024.display (#papers.Mukherjee2024.date)*\
#authorise(papers.Mukherjee2024.author)
]

#slide[
  #title("What is The Holographic Principle?")

  #head[Quantum field theory in $D$ -- dimensions ⟹ Gravity theory in $D+1$ -- dimensions]

  #img("./images/holography.svg", w: 80%)

  #v(1fr)
  #cols(
    [
      #v(1fr)
      - Extra dimension arises from *renormalisation group flow* of quantum theory
      - *Geometric measures* in +1 dimension arise from *quantum measures* on the boundary
    ],
    [
      #show: pause
      #v(1fr)
      #head[Questions?]
      #v(1fr)
      - Can we demonstrate this in the case of a prototypical metal-insulator transition?
      - What effect does the critical point have on the emergent dimensions?
    ],
  )
]

#slide[
  #title("Entanglement RG Of 2D Dirac Electrons On a Torus")
  #cols(
    [
      non-interacting *Dirac electrons* moving on a torus

      - *Entanglement entropy* of a subsystem of length $l$
      - RG: Apply *coarse-graining* transformation in $k_x$-space
      
      Entanglement measure $S_"EE" (j)$ at every step --> *RG Flow of entanglement*
    ],
    img("./images/subsystem-torus.pdf"),
    w: (1fr, 0.5fr),
  )

  #img("./images/holographyScaling.svg", w: 90%)
]

#slide[
  #title("Flow of Entanglement Defines Geometry")
  #cols(
    [
      Define distance using #focus[mutual information]: $ x_j = -log(I_2 (j+1) - I_2 (j)) \/ log(I_2 ("max")) $
      - high mutual information ==> small distance

      Use distance to define curvature, metric, etc!

      These define geometry of emergent extra dimension ==> can be used to obtain a #focus[discrete metric]

      #v(1fr)
      #head[What's happens at metal-insulator transition?]

      #v(1fr)
      - geometry changes from open to closed
      - wormhole-like geometry appears, between UV and IR
    ],
    [
      #img("images/wormhole_gapless.svg")

      #img("images/wormhole_gapped.svg")
    ],
    w: (1fr, 0.7fr),
  )
  #place(center + horizon, dy: 0em, bbox(factor: 110%, [
    - We showed how holography works \ in a prototypical fermionic model.
    - The metal-insulator transition leads to a\ wormhole geometry in the emergent space.
  ]))
]

#slide[
#section[Closing Remarks]
]

#slide[
  #title("Key Results")
  #only(2)[
    #place(top + center, head[Impurity model with attractive bath correlation is a reasonable auxiliary model for capturing the local physics of Mott transition.])
    #v(1fr)

    #img("./images/esiamSchematic.svg", w: 40%)
    #place(center + horizon, dx: -10em, dy: -1em, point(140deg, f: 4))
    #img("./images/Singlet2.svg")
    #h(9em)
    #img("./images/localMoment.svg")

    #place(center + horizon, dx: 10em, dy: -1em, point(40deg, f: 4))

  ]
  #only(3)[
    #place(top + center, head[Manybody Translation ("tiling") With Lattice-Embedded Impurity Model Encodes Spatial Fluctuations and Lattice Geometry])
  
    #v(1fr)
    #img("./images/tilingPlan.svg", w: 80%)

    #img("./images/tiledHamiltonian.svg", w: 50%)
    // #v(1fr)

  ]
  #only(4)[
    #place(top + center, head[Mott Transition in 2D Involves Confinement of Holon-Doublon Excitations Through a Pseudogap With Long-Range Multipartite Correlations])
  
    #v(1fr)
    #img("mottPictureCuprates4.svg", w: 60%)
    // #v(1fr)
  ]

  #only(5)[
    #place(top + center, head[Metal-Insulator Transition In Dirac Electrons Is Associated With The Inversion of Curvature Of An Emergent Space, With a Wormhole Geometry Separating Them])
  
    #v(1fr)
    #img("images/wormhole_gapless.svg",w: 100%)
    #h(3em)
    #img("images/wormhole_gapped.svg",w: 100%)
    #v(1fr)
  ]
  #only(5)[
    #head[]
  ]
]

#slide[
  #title("Outline of Thesis")
  #grid(
    rows: auto,
    gutter: 1.2em,
    align: left+top,
    grid(columns: (1fr, 0.6fr), gutter:1em, [*Chap 1*.~Introduction#h(1fr)*Chap 2*.~Methods and Preliminaries], []),
    grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 3*.~Kondo frustration via charge fluctuations: Mott localisation in $D=infinity$], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Developed auxiliary model for Mott transition in $D=infinity$]),
    grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 4*.~A New Auxiliary Model Mapping For Correlated Lattice Models], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Developed formalism for applying auxiliary model to 2D]),
    grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 5*.~Mott Criticality as the Confinement Transition of a Pseudogap-Mott Metal in $D=2$], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Applied formalism to the problem of Mott transition in 2D]),
    grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 6*.~Competing tendencies In Heavy Fermion Systems: Kondo screening vs. Mott localisation], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Applied formalism to the problem of heavy fermions in 2D]),
    grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 7*.~Holographic entanglement renormalisation for fermionic quantum matter], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Metal-insulator transition and the holographic principle]),
    grid(columns: (1fr, 0.05fr, 0.55fr), gutter:1em, [*Chap 8*.~Conclusions], []),
  )
]

#slide[
  #title("Open Questions & Future Work")

  #v(1fr)
  - Extend the tiling formalism to capture topological effects
  - Study the effects of doping on the holon-doublon deconfinement in the pseudogap
  - Obtain finite temperature characteristics
  #v(1fr)

  #v(2fr)
]

#page(margin: 2em,[
= A New Auxiliary Model Approach For Fermionic Criticality
== Insights on Mottness in Strongly Correlated Systems
#v(0.5em)
#cols(
  img("iiserk.png"),
  scale(300%, head[Thank You!]),
  img("epqm.svg", w:90%),
  w: (0.2fr, 1fr, 0.2fr)
)
])


// TODO
// IMPORTANT: ADD CITATIONS
// Remove PAM and Strange metal discussion in intro if too long
// Take stock at the end about whether to put in one or two slides on the URG
// Add more bboxes (punchlines) in Mott metal slides
// Add more detailed description of cuprates beside phase diagram
// Talk about the symmetry/topological order paramter/chiral anomaly aspects
