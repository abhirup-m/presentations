// named colors
#let fgcolor = "EFEFEF"
#let bgcolor = "262629"
#let headercolor = "e45649"
#let emphcolor = "ffe080"
#let fnotecol = "a7aab0"
#let accentcolor = "a0a8b7"

// imports
#import "@preview/physica:0.9.4": *
#import "@preview/touying:0.5.5": *
#import themes.metropolis: *
#let hf = h(1fr, weak: true)
#let vf = v(1fr, weak: true)

// footnote style

#let fnote(..keys) = place(
  left + bottom,
  float: true,
  v(-30pt) + block(
    width: 100%,
    height: 0.8em,
    above: 0pt,
  line(length: 40%, stroke: 3pt + rgb(fnotecol)) + v(-5pt) + for key in keys.pos() {
  text(size: 18pt, weight: "medium", fill: rgb(fnotecol), 
  cite(style: "apa", form: "prose", key),
  )
  }) + v(-20pt)
)

 // Title Slide Customisation
#let cover-slide(
    config: (:),
    title: none,
    subtitle: none,
    author: none,
    institution: none,
    extra: none,
  ) = touying-slide-wrapper(self => {
    self = utils.merge-dicts(
      self,
      config,
      config-common(freeze-slide-counter: true),
      config-page(fill: self.colors.neutral-lightest),
    )
    let body = {
      set text(fill: self.colors.neutral-darkest)
      set std.align(horizon)
      align(left)[#block(
        width: 100%,
        height: 100%,
        {
              text(size: 1.4em, weight: "extrabold", upper(title), fill: rgb(accentcolor))
              linebreak()
              if subtitle != none {linebreak(); text(size: 1.2em, weight: "semibold", subtitle)}
          line(length: 100%, stroke: .2em + self.colors.primary)
          box[
            #block(text(fill: rgb(headercolor), weight: "bold", upper(author)))
            #block(utils.display-info-date(self))
            #block(institution)
          ]
          h(1fr, weak: true)
          box[
            #block(spacing: 0.1em, extra)
          ]
          h(1fr, weak: true)
        },
      )
    ]
    }
    touying-slide(self: self, body)
})

#let presentation(
  title: none,
  subtitle: none,
  authors: none,
  institution: none,
  extra: none,
  doc,
) = {
show list: set align(left)
show list.item: set align(left)

show: metropolis-theme.with(
    aspect-ratio: "16-9",
    // footer-progress: false,
    // footer-right: none,
    config-info(
      title: [title],
      subtitle: [subtitle],
      author: [authors],
      date: datetime.today().display("[month repr:long] [day], [year]"),
      institution: [institution],
    ),
    config-colors(
      primary: rgb(accentcolor),
      primary-light: rgb(yellow),
      secondary: rgb(headercolor),
      neutral-lightest: rgb(bgcolor),
      neutral-dark: rgb(fnotecol),
      neutral-darkest: rgb(fgcolor),
    )
  )

// miscellaneous
set page(footer: none)
set par(
  leading: 0.5em,
  spacing: 0.7em
)
show emph: it => {
   text(fill: rgb(emphcolor), weight: "bold", it.body)
 }
set list(marker: "🞍", spacing: 1.5em)
set text(
   font: "lato",
   size: 24pt,
 )
set align(center)
show math.equation: set text(font: "Noto Sans Math")
show footnote.entry: it => {v(-0pt); set text(size: 16pt); it; v(-20pt)}
set footnote(numbering: it => "")
show bibliography: it => {
  set align(left); set text(size: 18pt);
  it
}

cover-slide(
  title: title,
  subtitle: subtitle,
  author: authors,
  institution: institution,
  extra: extra
)
doc
}
