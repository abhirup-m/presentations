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
#let head(it) = align(center, smallcaps(text(font: "Barlow", weight: "extrabold", fill: fgColor, size: 1.2em, it))) + v(-0.5em)
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
  if title.len() == 0 { 
    []
  } else if title.split(" ").len() == 1 { 
    title1 = text(fill: h1Color, font: h1Font, eval(title.slice(0, 3), mode: "markup"))
    title2 = text(fill: h2Color, eval(title.slice(3), mode: "markup"))
    sep = []
  } else {
    title1 = text(fill: h1Color, font: h1Font, eval(title.split(" ").at(0), mode: "markup"))
    title2 = text(fill: h2Color, eval(title.split(" ").slice(1).join(" "), mode: "markup")) 
  }
  place(top, heading(level:2, title1 + sep + title2), float: true) 
}
#let section(title) = { align(horizon, heading(level: 1, title))}
#let bbox(..args, factor: 100%) = {
  set list(marker: square(width: 0.6em, fill: white), spacing: 1em)
  scale(
    factor, 
    box(
      inset: 0.7em, 
      width: if args.pos().len() > 1 { args.pos().at(1) } else { auto }, 
      radius: 3pt, 
      fill: h1Color, 
      stroke: 0.2em + rgb("222831"),
      align(center + horizon, text(font: h1Font, fill: white, args.pos().at(0)))
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
        [#h(1fr)❚#h(1fr)*#t*]
      } else {
        [*#t*]
      }
    } else {
      if i > 0 {
        [#h(1fr)❚#h(1fr)#t]
      } else {
        [#t]
      }
    }
  }
}
#let footcite(keys) = {
  keys = keys.split(",")
  let content = []
  for (i, key) in keys.enumerate() {
    key = key.trim(" ")
    if i == 0 {
      content = cite(label(key))
    } else {
      content = content + [,] + h(10pt) + cite(label(key))
    }
  }
  return place(bottom + left, dy: 1.7em, rect(stroke: (top: 2pt), inset: (x: 0pt), text(size: 0.9em, content)))
}

#set page(paper: "presentation-16-9", fill: bgColor, margin: (rest: 1em, top: 1em, bottom: 2em))
#show image: set align(bottom)
#set text(size: 19pt, font: mainFont, weight: "medium", fill: fgColor)
#show math.equation: set text(font: "New Computer Modern Math", size: 1.1em, weight: "thin", fill: h1Color, stroke: 1pt + h1Color)

#set par(leading: 0.5em)
#let slideTop(it) = align(top, slide(it))
#show heading.where(level: 1): set text(fill: h1Color, font: h1Font, size: 50pt)
#show heading.where(level: 1): set par(leading: 0.3em)
#show heading.where(level: 2): set text(fill: h2Color, font: h2Font, size: 30pt)
#show heading.where(level: 2): set par(leading: 0.4em)
#set list(marker: square(width: 0.6em, fill: fgColor), spacing: 1em)
#show list: set align(left)
#set underline(offset: 4pt, stroke: 2pt)
#set cite(form: "full")
#set footnote(numbering: x => none)
#set footnote.entry(clearance: -3em)
#show cite: set text(size: 0.9em, weight: "extrabold", fill: h2Color)
#show footnote.entry: set par(leading: -4em)
#show bibliography: none
#bibliography("references.bib", style: "style.csl")

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
  gutter: 1em,
  img("iiserk.png"),
  text(size: 1.1em, [
    #head[Emergent Phenomena in Quantum Matter group]
   #head[IISER Kolkata]
   ]),
  img("epqm.svg")
)
])

#slide[
  #only(1)[#title("Publications (in thesis)")]
  #only(2)[#title("Publications (not in thesis)")]

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
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 3*.~Kondo frustration via charge fluctuations: Mott localisation in _D=∞_], [[#focus(under: false, eval(papers.Mukherjee2023.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 4*.~A New Auxiliary Model Mapping For Correlated Lattice Models], [[#focus(under: false, eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 5*.~Mott Criticality as the Confinement Transition of a Pseudogap-Mott Metal in _D=2_], [[#focus(under: false, eval(papers.Mukherjee2025.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 6*.~Competing tendencies In Heavy Fermion Systems: Kondo screening vs. Mott localisation], [[#focus(under: false, eval(papers.Mukherjee2026.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 7*.~Holographic entanglement renormalisation for fermionic quantum matter], [[#focus(under: false, eval(papers.Mukherjee2024.display, mode: "markup"))]]),
    grid(columns: (1fr, 0.5fr), gutter:1em, [*Chap 8*.~Conclusions], []),
  )
]

#slide[
#section[Introduction To Fermionic Criticality and Quantum Materials]
// == What's the Big Idea?
]

// #slideTop[
//   #title("What Do Condensed Matter Theorists Do?")
//
//   #show: pause
//   #head[Explain Experiments]
//   Build and solve theoretical models that explain observations
//
//   #focus[Examples:] Quantum Hall effect, superconductivity
//
//   #v(1fr)
//   #show: pause
//   #head[Predict Experiments]
//   Identify interesting theoretical models that predict novel phenomena
//
//   #focus[Examples:] Abrikosov vortex lattice, spin liquids
//
//   #v(1fr)
//   #show: pause
//   #head[Classify experiments]
//   Come up with frameworks that explain a large class of phenomena
//
//   #focus[Examples:] Landau theory of phase transition
//   #v(1fr)
// ]

#slide[
  #title("Quantum Materials")
  Class of materials that #focus[cannot] be well-approximated by "classical" description

  // #v(1fr)
  #cols(
  unc(from: 2)[
    // #v(-4em)
    #img("graphene.jpg", w:80%)
  ],
  [
    #unc(from: 2)[
      #bbox([topological properties\ (_topological insulators_)], factor: 100%)
    ]
    #unc(from: 3)[
      #bbox([non-local entanglement (_spin liquids_)], factor: 100%)
    ]
    #unc(from: 4)[
      #bbox([collective excitations (_strange metals_)], factor: 100%)
    ]
  ],
  unc(from: 3)[
    #img("QSL.jpg", w: 80%)
  ]
  )
  #v(1fr)

  #v(-3.5em)
  #unc(from: 5)[
    Needs #focus[new ideas] and methods!
    - ability to work with a large number of #focus[interacting particles]
    - ability to work  with #focus[emergent] degrees of freedom and #focus[non-local/collective] order parameters
  ]

]

#slide[
  #title("Strongly Correlated Phenomena in Quantum Materials")

  - Phenomena arising from #focus[inter-electron repulsion] and many-electron effects

  - materials with strong local #focus[correlation], #focus[low dimensionality], multiple electronic #focus[orbitals]
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
    #footcite("Mott_1949,Mott_RMP_1968")
    // #v(-0.5em)
    #head[Phenomena: Mott Insulation]
    // #v(-0.5em)

    #img("mottInsulator.svg", w:92%)
    #only(2)[#place(right + horizon, dy: 2em, rect(fill: bgColor, width: 62%, height: 55%))]
    #only(3)[#place(right + horizon, dy: 2em, rect(fill: bgColor, width: 40%, height: 55%))]

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
    #unc(6, place(center + horizon, bbox(factor: 120%, [How do  the electrons morph when\ a metal gives way to a Mott insulator?])))

  ]
  #only(from: 7, to: 10)[
    #footcite("phillips2022,keimer2015quantum,hussey_2011")
    #cols(
      [
        #img("linearResistivity.svg", w: 100%)
      ],
      [
        #head[Phenomena: Strange Metallicity]
        #unc(from: 8)[
        #cols(
          [
          Expected: $R prop T^2$

          #img("TSquareScattering.svg", w: 60%)

          Source of $R prop T$?
        ],
        unc(from: 9)[
          #focus[Mean-free path] no less than one lattice spacing

          #img("mirSchematic.svg", w: 85%)

        ],
      )]],
      w: (1fr, 1.8fr)
    )
    #unc(10)[#place(center + horizon, bbox(factor: 120%, [Who is carrying current\ in strange metals?]))]

  ]
  // #only(11, 12)[
  //
  //   #cols(
  //     [
  //       A canonical example: *high-$T_c$ cuprate*\
  //       // - Layered #focus[Cu-O planes] --> effectively 2D electrons
  //       // - Cu 3d orbitals --> #focus[localized electrons] --> strong correlations
  //
  //       #unc(12)[
  //       // #v(1fr)
  //       #head[Several competing energy scales]
  //       // #v(1fr)
  //       - Zoo of correlated phases!
  //       - Mechanism underlying various phases: *not settled*
  //       - Crossover/transition between various phases remains unresolved
  //       ]
  //     ],
  //     img("cuprates.svg"),
  //     w: (1fr, 1.1fr),
  //   )
  // ]
]

#slide[

  #title("Theoretical Models of Correlated Materials")
  #cols(
    [
      #head[Hubbard Model]
      #footcite("hubbard1963electron,kanamori_1963,Gutzwiller1965")
      #show: pause

      - Correlated electrons hopping on a lattice

      - Hopping probability: $t$

      #img("hubbard2.svg", w:40%)
      #show: pause

      - Energy cost $U$ if two occupy same site.

      #img("hubbard3.svg", w:40%)
      #show: pause

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
  #place(center + horizon, bbox(factor: 120%, [
    t ⟹  Delocalisation

    U ⟹ Localisation

    🔥~~Competition
  ]))


]

#slide[
  #title("Quantum Impurity Models as Auxiliary Models")
  #footcite("martin_2016")

  #cols(
    img("auxiliary1.svg"),
    [
      Lattice models of correlated electrons are *hard to solve* directly.\
      #show: pause

      #focus[Idea]: replace full problem with a simpler *auxiliary model* that captures the local correlations.
    ],
    unc(from: 2, img("auxiliary2.png")),
    w: (0.8fr, 1.1fr, 1.1fr),
  )

  #show: pause
  // #v(-1em)
  #cols(
    head[Example: Mean-field solution\ of Ising model],
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
      #uncover(3, [], update-pause: true)
      #show: pause
      #img("isingAux2.svg")

      Rest ==> effective field
    ],
    w: (0.9fr, 0.9fr, 0.5fr, 0.9fr),
  )

]

#slide[
  #title("Quantum Impurity Models as Auxiliary Models")

  #footcite("metzner_volhardt_1989,kotliar1996,kotliar1992")
  // #v(-1em)
  #head[Appropriate auxiliary problem for lattice models with local correlation?]
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
      Auxiliary Model has to be #focus[interacting]\ in order to capture local dynamics accurately!
    ],
    img("auxiliary1.svg"),
    w: (2fr, 0.5fr),
  )
  #unc(from: 3)[

    #place(left + horizon, dy: -1em, head[Insight from Limit of Infinite Dimensions!])

    // #v(0.5em)
  ]
  #unc(from:4, cols(
    [

      Local physics ==> #focus[Quantum Impurity Models]

      Core Idea of Dynamical Mean-Field Theory
    ],
    img("correlatedAuxiliary.svg"),
    unc(from: 5)[
      - Tractable
      - dynamics 

      ($omega-$dependence of correlations)
    ],
    w: (0.25fr, 0.4fr, 0.2fr),
  ))]
  #unc(6)[#place(center + horizon, bbox(factor: 120%, [Local physics of correlated\ lattice models can be mapped\ on to impurity model.]))]

]

#slide[
  #title("Phenomenology of Quantum Impurity Models")
  #footcite("anderson_1961,kondo1964resistance,anderson1970poor,wilson1975renormalization")
  #cols(
    [
      #head[Kondo Model]
      - Impurity spin $S_d$ + conduction bath
      - Spin-flip scattering

      $ H = sum_(k, sigma) epsilon_k n_(k,sigma) + 1/4 J S_d^z s_0^z + 1/2 S_d^+ s_0^- + 1/2 S_d^- s_0^+$
    ],
    img("kondoModel.svg"),
    w: (1fr, 0.8fr),
  )
  // #v(1fr)
  #show: pause
  #only(2,3)[
    #head[Low-energy $\( T << 1 \)$ Properties: Kondo Screening]
    #cols(
      [
        - Kondo coupling generates #focus[entanglement]
        - Impurity DOS has #focus[gapless excitations] and can #focus[delocalise] via c-bath
        
        #show: pause
        ==> #focus[metallic state] in lattice model
      ],
      img("Singlet.svg"),
      w: (1fr, 0.8fr),
    )
  ]
  #only(4,5,6)[
    #cols(
      [
        // #v(1fr)
        #head[Metallic State]
        #img("Singlet2.svg")
        #v(1fr)
      ],
      [
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
          #v(1fr)
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
    img("whichAuxiliary.svg"),
    w: (1fr, 0.9fr),
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
    head[Relation Between Various Correlated Phases in Quantum Materials?],
    img("cuprates.svg"),
    w: (1fr, 0.7fr)
  )
]

#slide[
  #v(3em)

  #text(size: 1.5em, head[Chapter 3 #h(1fr)])

  #section[Minimal Model For Kondo Breakdown and Mott Transition]
  == A Route to Mott Localisation in Infinite Dimensions\ \
  *#papers.Mukherjee2023.display (#papers.Mukherjee2023.date)*\
  #authorise(papers.Mukherjee2023.author)

]

#slide[
  #title("Mott Transition In Infinite Dimensions")
  // #v(-1em)

  #footcite("metzner_volhardt_1989,kotliar1992,Kotliar_physicstoday_2003")
  #cols(
    [
      #head[DMFT Results on Hubbard Model in _D = ∞_]
      #show: pause
      - numerical implementation means precise form of self-consistent impurity model *not known*
      - low-energy theory for *critical point* not known
      #show: pause
      // #v(1fr)
      #head[Our Approach: Add Local Bath Correlation]
      // #v(1fr)
      #cols(
        ellipse(width: 110%, height: 13%, stroke: 4pt + h2Color, c[$U_b n_(0 arrow.t) n_(0 arrow.b) $]),
        img("./images/esiamSchematic.svg", w: 100%),
        w: (1fr, 3fr),
      )
      // #v(1fr)
    ],
    [
      // #v(-2em)
      Dynamical mean-field theory --> *self-consistent* bath.

      #img("./images/dmftPhysicsToday.png", w: 95%)
    ],
    w: (1fr, 0.7fr),
  )
]

#slide[
  #title("Phase Diagram and Impurity Phase Transition")
  #show: pause
  #footcite("hrk_wilson_1980,Si_kotliar_NFL_1993")
  // #v(-2em)
  #only(2)[
    #cols(
      [
        #img("./images/esiamPhaseMapLabel1.svg")

        - Impurity has gapless excitations for small $U_b$
        - corresponds to weakly correlated #focus[metal]
      ],
      [
        #img("./images/esiamSchematic.svg", w: 90%)

        #img("./images/esiamSpecFunc1.svg", w: 90%)
      ],
      w: (1fr, 0.8fr),
    )
  ]
  #only(3)[
    #cols(
      [
        #img("./images/esiamPhaseMapLabel2.svg")
        - for $U_b < 0$, DOS #focus[suppressed] around $omega=0$
        - corresponds to strongly correlated #focus[metal]
      ],
      [
        #img("./images/esiamSchematic.svg")

        #img("./images/esiamSpecFunc2.svg")
      ],
      w: (1fr, 0.7fr),
    )
  ]
  #only(4)[
    #cols(
      [
        // #v(-0.5em)
        #img("./images/esiamPhaseMapLabel3.svg")
        - Impurity excitations #focus[gapped] for large negative $U_b$
        - corresponds to #focus[Mott insulator]
      ],
      [
        #img("./images/esiamSchematic.svg")

        #img("./images/esiamSpecFunc3.svg")
      ],
      w: (1fr, 0.7fr),
    )
    #place(center + horizon, bbox(factor: 110%, [line of critical points ⟹ non-Fermi liquid]))
  ]
  // #v(1fr)
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
        #place(center + horizon, bbox(factor: 120%, [Impurity model with weak attractive\ bath correlation is a good\ auxiliary system for Mott transition.]))
      ]
    ]
  ]
]

#slide[
  #v(3em)

  #text(size: 1.5em, head[Chapters 4 \& 5 #h(1fr)])
#section[Capturing Spatial Fluctuations and Lattice Geometry]
== Impurity-Lattice Mapping Beyond Mean-Field\ \
*#papers.Mukherjee2025.display (#papers.Mukherjee2025.date)*\
#authorise(papers.Mukherjee2025.author)
]

#slide[
  #title("Extending This To The More Interesting $D=2$ Case")
  #v(1fr)
  #cols(
    img("./images/esiamSchematic.svg"),
    only(1,)[
      Previous demonstration worked because
      - *non-local fluctuations vanish* in $d --> infinity$ (mean-field is exact)
      - Largely insensitive to *lattice details* $\{ epsilon_k \}$

    ]
    // + only(from: 5)[
    //   #cols(
    //     img("./images/latticeInf.svg", w: 80%),
    //     [
    //       - All paths symmetric
    //       - No non-trivial $k-$dependence
    //     ]
    //   )
    // ],
    // w: (0.7fr, 1fr),
  )
  #v(1fr)
  // #v(1fr)
  // #show: pause
  // #c(focus[Low-Dimensional Lattices Are More Interesting])
  // #show: pause
  // #cols(
  //     img("./images/lattice2D_1.svg", w: 75%),
  //     unc(from: 4)[#img("./images/lattice2D_2.svg", w: 85%)],
  //     w: (1fr, 1fr),
  // )
  // #unc(6, 7)[
  // #place(center + horizon, dy: -4em, bbox(factor: 120%, [What's the appropriate auxiliary model for a\ correlated system on a 2D square lattice?]))]
  // #unc(7)[
  // #place(center + horizon, dy: 4em, bbox(factor: 120%, [
  //   Must capture
  //   - Spatial fluctuations
  //   - Lattice geometry
  // ]))]
]

#slide[
  #title("Why is 2D Important?")
  // #v(-1.5em)
  #footcite("keimer2015quantum,ProustTaillefer2019,Imada1998")
  #cols(
    [- Many quantum materials are layered.],
    [- Weak interlayer coupling --> effectively 2D]
  )

  // #v(-0.5em)
  #head[Canonical Example: Copper Oxide Materials ⟶ Zoo of Mysterious Phases]
  #c[
    #only(4)[
      #focus[Overarching theory for strange metal not available]
    ]
    #only(5)[
      #focus[Nature of excitations within PG: unclear]
    ]
    #only(6)[
      #focus[Inter-relations between phases not clear!]
    ]
  ]
  #only(2)[
    #cols(
      Img("./images/cuprates.svg", w: 90%),
      // Img("./images/linearResistivity.svg", w: 60%),
      w: (1fr, 1fr),
    )
  ]
  #only(3)[
    #cols(
      Img("./images/cuprates1.svg", w: 90%),
      [
        - #focus[Fermi liquid]: conventional metal → described by *Landau Fermi-liquid theory*
        - long-lived weakly-interacting #focus[quasiparticles]
        - #focus[Mott insulator]: interaction-driven insulator at half-filling
        - Both endpoints are well understood
      ],
      w: (1fr, 1fr),
    )
  ]
  #only(4)[
    #cols(
      Img("./images/cuprates2.svg", w: 90%),
      Img("./images/linearResistivity.svg", w: 60%),
      w: (1fr, 1fr),
    )
  ]
  #only(5)[
    #cols(
      Img("./images/cuprates3.svg", w: 90%),
      [ARPES shows *partial gaps* on Fermi surface] + Img("./images/fermiArc1.png", w: 50%),
      w: (1fr, 1fr),
    )
  ]
  #only(6,7)[
    #cols(
      Img("./images/cuprates4.svg", w: 90%),
      [

        - How do electrons in Fermi liquid *morph* to into the strange metal/PG phases?

        - How do the excitations of the PG phase *bind* to stabilise the Mott insulator?

      #unc(7)[
        #head[Are there counterparts to these phases at half-filling?]
      ]
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
  #place(center + horizon, dy: -4em, bbox(factor: 130%, [Lattice-embedded impurity model is\ a reasonable auxiliary model for\ local correlation in lattice problems.]))
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
  // #v(-1em)
  #footcite("Calais_1995,stoyanova")
  #only(2, 3)[
    #c[Translation of 1-Particle States: *Wannier --> Bloch*]

      #img("./images/bloch1p.svg", w: 80%)
      #only(3)[
        #c[#focus[Many-electron Translation Operators]: ~ ~ $ tilde(T)\(a\) = Pi_i T_i \(a\)$ ]

        #img("./images/tilingPlan.svg", w: 90%)
      ]
  ]

  #only(4,5,6)[#cols(
    [

      #focus[Translation]:
      *Impurity --> Lattice*

      // #v(0.5em)
      $ H_"lat" = sum_i tilde(T)\(r_i\) H_"aux" tilde(T)^dagger \(r_i\) $

      #v(-0.5em)
      $ H_"hop" + U sum_i n_(i, arrow.t)n_(i, arrow.b) + sum_(<i,j>) S_i dot S_j $

    ],
    only(4)[#img("./images/tiledHamiltonian.svg")] + only(5, 6)[#img("./images/tiledHamiltonian2.svg")],
    w:(1fr, 1.1fr),
  )
  #only(5,6)[#cols(
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
  #only(6)[
    #place(center + horizon, dy: 0em, bbox(factor: 120%, [
      - Study lattice-embedded impurity model.
      - Use tiling relations to reconstruct\ low-energy physics of lattice model.
    ]))
  ]
  ]
]

#slide[
  #title("Phase Diagram Of Lattice-Embedded Impurity Model")

  #c[
    Analyse low-energy *distribution* of $J(k_1, k_2)$ on #focus[Fermi surface] to classify phases.
  ]

  // #v(1fr)
  #unc(2,3,4,5)[

    // #v(1em)
    #only(2)[
      #img("phaseDiagram-77-1.svg", w: 80%)

      #cols(
        [
    $J^*(k_1, k_2) S_d^+ c^dagger_(k_1, arrow.b) c_(k_2, arrow.t)$

          #head[Small $|W|$]
          - $J(k_1, k_2)$ is *strong all over* the Fermi surface
          - Kondo screening successful --> *Fermi liquid*
        ],
        img("./images/Singlet2.svg"),
        w: (1fr, 0.7fr),
      )
      #v(1fr)
    ]

    #only(3)[
      // #v(0.5em)

      #img("phaseDiagram-77-2.svg", w: 80%)
      // #v(-0.5em)

      #v(-0.5em)
      #cols(
        [
        $J^*(k_1, k_2) S_d^+ c^dagger_(k_1, arrow.b) c_(k_2, arrow.t)$
          #head[Large $|W|$]
          - $J(k_1, k_2)$ *vanishes all over* the Fermi surface
          - Kondo screening absent --> *Mott insulator*
        ],
        img("./images/localMoment.svg"),
        w: (1fr, 0.7fr),
      )
      // #v(1fr)
    ]

    #only(4,5)[

      #img("phaseDiagram-77-3.svg", w: 90%)

      // #v(1fr)
      #cols(
        [
          #head[Intermediate $|W|$]
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
      // #v(1fr)

      #unc(5)[
        #place(center + horizon, dy: 0em, bbox(factor: 130%, [
          - Conventional metal ❯ Partially Gapped Metal ❯ Mott insulator
          - Lattice geometry forces momentum-space anisotropy
        ]))
      ]
    ]
  ]
]

#slide[
  #title("Impurity Model Physics in The Pseudogap")
  #footcite("dzyaloshinskii2003some,Huang2022")
  #cols(
    [
      #show:pause
      #head[Impurity Magnetisation]
      // #v(0.5em)

      - Impurity magnetisation $!= 0$
      - #focus[breakdown of Fermi liquid]
    ],
    [
      #show:pause
      #head[Density Of States]
      // #v(0.5em)

      - Central resonance lost
      - #focus[Destruction of electronic excitations]
    ],
    // [
    //   #show:pause
    //   #head[Quasiparticle Residue]
    //   // #v(0.5em)
    //
    //   - strength of electronic excitations
    //   - #focus[morphing of excitations into emergent objects]
    // ],
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
    // [
    //   #show:pause
    //   #img("QPR_77-1500.pdf")
    // ]
  )
]

#slide[
  #title("Lattice Physics in The Pseudogap")
  #footcite("keimer2015quantum,Georgi2007PRL,PhillipsLectures2014")
  #cols(
    [
      #show:pause
      #head[Lattice _K_ -- space~~DOS]

      - Antinodes gapped, nodes gapless
      - Similar to #focus[ARPES] measurements in cuprates
    ],
    [
      #uncover(1, [], update-pause: true)
      #show:pause
      #img("fermiArc1.png", w: 50%)
    ],
    [
      #show:pause
      #head[Electronic Self-Energy]

      - large near #focus[antinode]
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
      #img("selfEnergyFit.svg")
    ]
  )
  #show:pause
  #place(center + horizon, dy: 0em, bbox(factor: 130%, [
    Pseudogap phase
    - loss of central resonance in local DOS
    - k-space anisotropy in lattice DOS
    - Diverging self-energy on parts of Fermi surface
  ]))
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
  #show: pause
  #place(center + horizon, bbox(factor: 120%)[Entanglement also\ becomes long-ranged.])
]

#slide[
  #title("Singular Nodal Metal At Critical Point")
  #footcite("Baskaran1991,Hatsugai1992,Phillips2020")

  #cols(
    [
      #head[Mott critical point as a nodal non-Fermi liquid]

      #v(1em)
      Integrate out impurity spin to obtain #focus[low-energy theory] for gapless excitations at the critical point.

      #cols(
        focus[Hatsugai-Kohmoto model: ],
        [$ H_"eff" = sum_q \[ epsilon_q tilde(n)_(q,sigma) + U_"eff" tilde(n)_(q,sigma) tilde(n)_(q,-sigma) \] $],
        w: (1fr, 1.2fr),
      )

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
      - Subdominant #focus[pairing] fluctuations
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
  // #show: pause
  // #place(center + horizon, dy: 0em, bbox(factor: 130%, [
  //   Mott metal --- parent metal of Mott insulator
  //   - robust self-energy exponent
  //   - holon-doublon excitations
  //   - critical, long-range correlations
  // ]))
]



#slide[
  #title("Mott Criticality As Holon-Doublon Deconfinement")

  #only(1)[
    #head[Fermi Liquid]
    #v(1fr)
    #h(1fr)#seq("electrons as carriers", "short-range entanglement", "vanishing self-energy")#h(1fr)
    #v(1fr)
    #img("mottPictureCuprates1.svg", w: 70%)
  ]

  #only(2)[
    #head[Pseudogap]
    #v(1fr)
    #h(1fr)#seq("holons-doublons deconfined", "\"noisy\" environment", "long-range entanglement")#h(1fr)
    #v(1fr)
    #img("mottPictureCuprates2.svg", w: 70%)
  ]

  #only(3)[
    #head[Mott insulator]
    #v(1fr)
    #h(1fr)#seq("holons-doublons confined", "hard gap in spectrum", "only spin physics active")#h(1fr)
    #v(1fr)
    #img("mottPictureCuprates3.svg", w: 70%)
  ]
]


#slide[
  #v(3em)

  #text(size: 1.5em, head[Chapter 6 #h(1fr)])
#section[Competing tendencies In a Multi-Orbital System]
== Kondo screening vs. Mott localisation in a Heavy-Fermion model\ \
*(IN PROGRESS)*\
#authorise(papers.Mukherjee2026.author)
]

#slide[
  #title("Heavy Fermions: When Itineracy Meets Localisation")
  #footcite("Stewart1984,Custers2003,Si2010")

  Intermetallic alloys containing rare earth metals and actinides: #focus[_f_--electrons]
  #cols(
    [
      - each site can host two electrons: #focus[light + heavy]
      - delocalised electrons _Kondo screen_ localised electrons. #focus[Result ==> heavy carriers]
      - dramatic #focus[enhancement] of mass
    ],
    img("heavyFermions.svg"),
    w: (1.5fr, 1fr),
  )

  #show: pause
  #cols(
    img("HFPhaseDiagram.svg"),
    [
      // #v(1fr)
      #head[QCP, non-Fermi liquid, Superconductivity]
      // #v(0.5em)
      localised electrons order magnetically across transition

      #head[Questions]
      // #v(0.5em)
      - Source of the #focus[non-Fermi liquid] above the QCP?
      - How do the heavy carriers #focus[morph] across the QCP?
      // #v(1fr)

    ],
    w: (1fr, 2fr)
  )
]

#slide[
  #title("Kondo Lattice Model and Phase Diagram")
  #v(-1em)
  #cols(
    [
      #focus[Model]: Two correlated layers + inter-layer hybridisation

      - $W_f$: correlation within localised layer
      - $V_perp$: inter-layer hybridisation
    ],
    img("HF_model.svg"),
    w: (1fr, 0.5fr),
  )

  #cols(
    [
      #head[Phase Diagram: Spin Correlation]

      We analyse $f-c$ and $f-f$ spin correlation

      - Increasing $V_perp$ causes transition into #focus[heavy Fermi liquid]
      - For intermediate $|W_f|$, conduction electrons hybridise with non-Fermi liquid

      #show: pause
      Diagonally up: #focus[entanglement redistribution]
    ],
    [
      #only(1, img("HF_PD-1.svg"))
      #only(2, img("HF_PD-2.svg"))
    ]
  )
]

#slide[
  #title("Kondo Lattice Model and Fermi Surface Transition")
  #footcite("gleis_2024")
  #cols(
    [
      Spectral function in bonding-antibonding basis: $c_plus.minus = c plus.minus f$

      - non-interacting metal splits into #focus[two bands]
      - small Fermi surface metal --> #focus[large Fermi surface] insulator
    ],
    [
      #v(-1em)
      #img("HF_model.svg", w: 80%)
    ],
    w: (2fr, 1fr),
  )

  #v(1fr)
  #img("HF_specfunc.svg", w: 85%)

  #show: pause
  #place(center + horizon, dy: 0em, bbox(factor: 110%, [
    - Auxiliary Model Approach Correctly Shows a Kondo Insulator
    - Effect of Interlayer Hybririsation on Pseudoga-Mott Metal ??
  ]))
]

#slide[
  #v(3em)

  #text(size: 1.5em, head[Chapter 7 #h(1fr)])
#section[Holography of Entanglement in 2D Free Fermions]
== Emergent Geometry and Fermionic Criticality\ \
*#papers.Mukherjee2024.display (#papers.Mukherjee2024.date)*\
#authorise(papers.Mukherjee2024.author)
]

#slide[
  #title("What is The Holographic Principle?")
  #footcite("hartnoll_lucas_sachdev2018,heemskerk2011")

  #head[Quantum field theory in $D$ -- dimensions ⟹ Gravity in $D+1$ -- dimensions]

  #img("./images/holography.svg", w: 80%)

  #v(1fr)
  #cols(
    [
      #v(1fr)
      - Extra dimension arises from *renormalisation group flow* of quantum theory
      - *Geometric measures* in +1 dimension arise from *entanglement* on the boundary
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
  #footcite("van2010building,cao_2017")
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
      - #focus[wormhole]-like geometry appears between UV & IR
    ],
    [
      #img("images/wormhole_gapless.svg")

      #img("images/wormhole_gapped.svg")
    ],
    w: (1fr, 0.7fr),
  )
  #show: pause
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

  #head[#focus[Ch 3:] Impurity model with attractive bath correlation is a reasonable auxiliary model for capturing the local physics of Mott transition.]
  #v(1fr)

  //   #img("./images/esiamSchematic.svg", w: 40%)
  //   #place(center + horizon, dx: -10em, dy: -1em, point(140deg, f: 4))
  //   #img("./images/Singlet2.svg")
  //   #h(9em)
  //   #img("./images/localMoment.svg")
  //
  //   #place(center + horizon, dx: 10em, dy: -1em, point(40deg, f: 4))
  //
  // ]
  // #only(3)[
  #head[#focus[Ch 4:] Manybody Translation ("tiling") With Lattice-Embedded Impurity Model Encodes Spatial Fluctuations and Lattice Geometry]
  
  #v(1fr)
  //   #img("./images/tilingPlan.svg", w: 80%)
  //
  //   #img("./images/tiledHamiltonian.svg", w: 50%)
  //   // #v(1fr)
  //
  // ]
  // #only(4)[
  #show: pause
  #head[#focus[Ch 5:] Mott Transition in 2D Involves Confinement of Holon-Doublon Excitations Through a Pseudogap With Critical Long-Range Correlations]
  
  #v(1fr)
    // #img("mottPictureCuprates4.svg", w: 60%)
    // #v(1fr)
  // ]

  // #only(5)[
  #head[#focus[Ch 7:] Metal-Insulator Transition In Electrons Is Accompanied By Inversion of Curvature Of An Emergent Space, With a Wormhole Geometry At Transition]
  
  //   #v(1fr)
  //   #img("images/wormhole_gapless.svg",w: 100%)
  //   #h(3em)
  //   #img("images/wormhole_gapped.svg",w: 100%)
  //   #v(1fr)
  // ]
  // #only(5)[
  //   #head[]
  // ]
]

// #slide[
//   #title("Outline of Thesis")
//   #grid(
//     rows: auto,
//     gutter: 1.2em,
//     align: left+top,
//     grid(columns: (1fr, 0.6fr), gutter:1em, [*Chap 1*.~Introduction#h(1fr)*Chap 2*.~Methods and Preliminaries], []),
//     grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 3*.~Kondo frustration via charge fluctuations: Mott localisation in $D=infinity$], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Developed auxiliary model for Mott transition in $D=infinity$]),
//     grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 4*.~A New Auxiliary Model Mapping For Correlated Lattice Models], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Developed formalism for applying auxiliary model to 2D]),
//     grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 5*.~Mott Criticality as the Confinement Transition of a Pseudogap-Mott Metal in $D=2$], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Applied formalism to Mott transition in 2D]),
//     grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 6*.~Competing tendencies In Heavy Fermion Systems: Kondo screening vs. Mott localisation], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Applied formalism to heavy fermions in 2D]),
//     grid(columns: (1fr, 0.05fr, 0.55fr), align:(left, center, right), gutter:1em, [*Chap 7*.~Holographic entanglement renormalisation for fermionic quantum matter], line(angle: 90deg, stroke: 0.2em + h2Color), emph[Metal-insulator transition and the holographic principle]),
//     grid(columns: (1fr, 0.05fr, 0.55fr), gutter:1em, [*Chap 8*.~Conclusions], []),
//   )
// ]
//
#slide[
  #title("Open Questions & Future Work")

  #v(1fr)
  #head[Capture topological effects]
  #v(1fr)
  #head[Study the effects of doping on holon-doublon excitations]
  #v(1fr)
  #head[Obtain finite temperature characteristics]
  #v(2fr)
]

#slide[
  #only(1, img("ack1.png"))
  #only(2, img("ack2.png"))
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

#slide[
  #title("Greens Function Zeros And Anomalies In Pseudogap")

  #v(-0.5em)
  #place(left + top, [Partial #focus[gaps] near antinodes])
  #place(horizon + left, dy: -3em, [$ G = 0$ ==> #focus[singular]\ structure in self-energy])
  #cols(
    [
      #v(-1em)
      $ G_k (omega) = 1 / (omega - epsilon_k - Sigma) $
    ],
    [
      #img("greenZeros.svg")
    ],
    [
      #cols(
        [#focus[Why is this important?] Defines LW functional:],
        [$ delta Phi ~ integral dif omega med Sigma med delta G$],
        w: (1fr,0.5fr)
      )

      #cols(
        [$Phi$ acts as effective action:],
        [$ partial S = J med partial A$],
        w: (1fr,0.45fr)
      )
      $J_Phi ~ delta Phi \/ delta G $ --> "generalised current"

      Number density $N$  = topological charge of $J_Phi$ (#focus[winding] of $G$ in frequency)
    ],
    w: (0.7fr, 0.7fr, 1.9fr),
  )

  #v(-0.8em)
  #cols(
    [

      #head[What's this about an anomaly?]

      In QED, $J = n_"left" - n_"right"$ not conserved with gauge field: #focus[chiral anomaly]

      #img("chiralAnomaly.svg")

      - Symmetry is satisfied classically but #focus[breaks down] upon quantisation

    ],
    [
      #head[Something analogous happens here]

      *Fermi liquid*: $Phi$ analytic ==> $delta Phi = 0$: #focus[conserved]

      *Pseudogap*: $Phi$ singular ==> current #focus[not conserved]

      Breakdown of generalised symmetry ==> #focus[anomaly]

      Breakdown in topology: $N != "charge of" J_Phi$
    ],
    w: (1fr, 1.2fr)
  )

  #show: pause
  #place(
    center + horizon,
    dy: -3em,
    bbox(factor: 110%,
      [Zeros of G ⟹  non-analytic Φ ⟹  Anomaly in Non-Fermi Liquid]
    )
  )

  #show: pause
  #place(
    center + horizon,
    dy: 3em,
    bbox(factor: 110%,
      [Φ defines generalised symmetry ⟹  breakdown signals non-Fermi liquid]
    )
  )
]

#slide[
  #title("Details of Unitary RG Transformations")

  #img("urg-scheme.svg", w: 90%)
  #img("urg_ham_full.svg", w: 60%)

  - Wanted: low energy theory
  - RG procedure accounts for non-trivial scattering into various energy sectors 
  - RG proceeds via decoupling of high energy degrees of freedom via many-body unitary transformations

]

#slide[
  #head[How To Obtain The Low-Energy Theory]

  #cols(
    [
      Kondo interaction mixes low and high-energy states:

      $ J\(k_L, k_H\) S_d^+ c^dagger_(k_L, arrow.b)c_(k_H, arrow.t) $

      // #v(1fr)
      #show: pause
      *Unitary renormalisation group* approach:
      - unitary transformations *integrate out* high energy states
      - *fold in* their effects into low-energy states: $J\(k_1, k_2\) --> J^prime\(k_1, k_2\)$
    ],
    w: (1fr, 0.3fr),
  )
  #place(left + horizon, dx: 14em, dy: -5em, img("urgProcesses.svg", w: 35%))
  #show: pause

  #v(1fr)
  Repeated applications leads to #focus[flow of Hamiltonian]: $H^"(1)", H^"(2)", ..., H^*$
  - Low-energy theory: focus on fixed-point Hamiltonian $H^*$
  - Dynamical information: focus on entire flow
  #v(1fr)
  #footcite("anirbanurg2")

]

#slide[
  #title("Additional Results")
  #only(1)[#img("selfEnergy_d_zoomin_77-1500.pdf", h: 80%,)]
  #only(2)[#rect(fill: white, img("Ad_fit.pdf", h:80%))]
  #only(3)[#img("sigma_in.pdf", h: 80%)]
  #only(4)[
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

        $I_2 (d:r)$ becomes long-ranged

        #img("I2-di_77-700.pdf")
      ],
      [
        #show: pause
        #focus[5-partite nature] of entanglement

        #img("qfi_77-2000.pdf")
      ],
      w: (1fr, 1fr),
    )
  ]
]

#slide[
  #title("Mott Transition As Holon-Doublon Binding-Unbinding")
  #img("mottPicture.svg", w: 100%)
]


// TODO
// IMPORTANT: ADD CITATIONS
