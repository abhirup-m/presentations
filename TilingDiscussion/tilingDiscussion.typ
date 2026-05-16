#import "@preview/presentate:0.2.5": *

#let bgColor = rgb("EFECEC")
#let fgColor = rgb("37353E")
#let h1Color = rgb("3C486B")
#let h2Color = rgb("BF3131")
#let h2Trans = rgb("BF3131cc")
#let focusColor = rgb("4e52a5")
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
  place(top, heading(level:2, title1 + sep + title2), float: true) + v(1em)
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

#set page(paper: "presentation-16-9", fill: bgColor, margin: (rest: 3em, top: 2em, bottom: 2em))
#show image: set align(bottom)
#set text(size: 19pt, font: mainFont, weight: "medium", fill: fgColor)
#show math.equation: set text(font: "New Computer Modern Math", size: 1.1em, weight: "thin", fill: h1Color, stroke: 1pt + h1Color)

#set par(leading: 0.5em)
#let slideTop(it) = align(horizon, slide(it))
#show heading.where(level: 1): set text(fill: h1Color, font: h1Font, size: 50pt)
#show heading.where(level: 1): set par(leading: 0.3em)
#show heading.where(level: 2): set text(fill: h2Color, font: h2Font, size: 35pt)
#show heading.where(level: 2): set par(leading: 0.4em)
#show heading.where(level: 3): set text(fill: h2Color, font: h2Font, size: 25pt)
#show heading.where(level: 3): set par(leading: 0.4em)
#set list(marker: square(width: 0.6em, fill: fgColor), spacing: 1em)
#show list: set align(left)
#set underline(offset: 4pt, stroke: 2pt)
#set cite(form: "full")
#set footnote(numbering: x => none)
#set footnote.entry(clearance: -3em)
#show cite: set text(size: 0.9em, weight: "extrabold", fill: h2Color)
#show footnote.entry: set par(leading: -4em)
#show bibliography: none

#page(margin: 2em,[
= Lattice-Embedding + Tiling Discussion
== Algorithms and Implementation
#v(0.5em)
#text(weight: "bold", size: 1.4em, [ABHIRUP MUKHERJEE])
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
  #section[Renormalisation Group Equation Simulation]
]

#slideTop[
  #title("Define Some Constants")

  ```julia
  const K_MIN = -pi
  const K_MAX = pi
  const TOLERANCE = 1e-8
  const HOP_T = 1.0
  const OMEGA_BY_t = -2 * HOP_T
  const NODAL_POINTS = [(-π/2, -π/2), (-π/2, π/2), (π/2, π/2), (π/2, -π/2)]
  const ANTINODAL_POINTS = [(-π, 0.), (0., π), (π, 0.), (0., -π)]
  const RG_RELEVANCE_TOL = 1e-3
  ```

  - Keep unchanged throughout all calculations

  - Try to keep them dimensionless
]

#slideTop[
  #title("Working In Momentum Space: Variables")

  - Each $(k_x, k_y)$ --> $m$

  - Store single momentum-dependent variable as vector. Dispersion, density of states:
  $ E_(k_x, k_y) --> E[m] $
   

  - Store two momentum-dependent variable as matrix. Kondo coupling:
  $ J_(k_1, k_2) --> J[m, n] $

  - Store four momentum-dependent variable as function. Call when needed. Bath interaction:
  $ W_(k_1, k_2, k_3, k_4) --> W(...k) $
]

#slideTop[
  #title("Working In Momentum Space: Helpers")
  - `map1DTo2D(m)` --> `(kx, ky)`

  - `map2DTo1D(kx, ky)` --> `m`

  - `getIsoEngCont(dispersion, E)` --> `[m1, m2, ..., mN]`
  (loop through points, check which energies are equal to probe energy upto some tolerance)
]

#slideTop[
  #title("Density Of States")

  - Dispersion is easy
  `E[m] = Dispersion(kx, ky)`

  - DOS:
  `rho[m] ~ 1/Delta(E[m]) ~ 1/(E[m+1] - E[m])`

  - Take care of infinities (replace with largest finite value?!)

  - Normalise per some convention to keep things bounded
  $ integral d E rho(E) ~ N $
]

#slideTop[
  #title("RG Equation")

  $ Delta J[k_1, k_2] ~ sum_q (J[k_1, q] J[q, k_2] - 4 J[q, overline(q)] W[k_1, k_2]) G[q] $

  Write as matrix equation for vectorisation:
  $ Delta J ~ J G_"UV" J^dagger - 4 W "Tr"(overline(J)G_"UV") $
  where
  $ J --> J[k_1, k_2], "  "G_"UV" --> G[q], "  "W --> W[k_1, k_2], "  "overline(J) = J[q, overline(q)] $

]


#slideTop[
  #title("RG Flow Simulation: Initialisation")

  $ Delta J ~ J G_"UV" J^dagger - 4 W "Tr"(overline(J)G_"UV") $

  - Define dispersion and density of states

  - Define bath interaction matrix and initial Kondo matrix

  - Extract cutoff energies from dispersion (by varying $k_x$ from 0 --> $pi$ keeping $k_y=0$)

]

#slideTop[
  #title("RG Flow Simulation: Iteration")

  $ Delta J ~ J G_"UV" J^dagger - 4 W "Tr"(overline(J)G_"UV") $

  At each step,

  - extract UV and IR momentum points

  - define propagator diagonal matrix $G$ by setting only UV points
  ```julia
  GMatrix[q, q] = densityOfStates[q] ./ (OMEGA_BY_t * HOP_T - energyCutoff / 2 
                                         + kondoJArray[q, q] / 4 + bathW / 2) 
  ```

  - use matrix multiplication to calculate $Delta J$

  ```julia
  delta = -abs(deltaEnergy) * (J[IR, UV] * G[UV, UV] * J[UV, IR] 
                               .- 4 * bathW * traceGprime .* WMatrix[IR, IR])
  ```

  (Use broadcasting to make the syntax readable)

]

#slideTop[
  #title("Notes")

  - Parallelisation does not really help here
  - Using reflection and particle-hole symmetries might help but makes code complicated (measure tradeoffs before finalising)
  - Choosing system size as $N = 4m + 5$ helps (makes sure nodes, antinodes and midway point is available)
]

#slideTop[
  #head[Thank You]
]
