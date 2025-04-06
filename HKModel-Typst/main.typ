#import "presentation.typ": *
#show: presentation.with(
  title: "Exactly Solvable Model Of Correlated Metal-Insulator Transition",
  subtitle: "Insights on Non-Fermi Liquid and Mott Insulator",
  authors: "Abhirup Mukherjee",
  institution: "EPQM Seminar",
  extra: box(image("figures/cover.svg", height: 35%)),
)
#show heading: align.with(left)
#show heading: set block(below: 1.5em)

== In A Nutshell
- An _exactly solvable_ model that displays correlation-driven transition from a _non-Fermi liquid_ to a _Mott insulator_.
- Analyse the non-Fermi liquid in this _controlled setting_ to understand its features.
- Study a generalisation of this model to obtain _Fermi arcs_

= Where Do Mott Insulators and Non-Fermi Liquids Fit in the "Standard Model"?

== Mott Insulators Are Different

#fnote(<MottRMP1968>)
#box(width: 40%)[
  Half-filled system is _metallic_ \ in absence of interactions.
  #image("figures/band.svg", width: 70%)
  Dispersion away from band \ edge is _non-interacting_.
]
#hf
#pause
#box(width: 58%)[
  Add strong _interactions_ - Mott Insulator!
  #image("figures/MottGap.svg", width: 60%)
  #box[
  Gap opens inside \ the band:
  ]
  #box[
  $ mat(
    epsilon, U;
    U, epsilon;
  ) -> epsilon plus.minus U $
  ]
]

== Non-Fermi Liquids Are Different

#only(1)[
#fnote(<Landau1958>)
=== Landau Fermi Liquid Theory (Postulates)

- Theory describing how _metals arise_ in interacting systems
- Lack of scattering _phase space_ at low-energies
- Fermi surface and low-lying electronic excitations survive (_quasiparticles_).

#v(20pt)

#image("figures/phaseSpace.svg", height: 40%)
]
#only(2)[
#fnote(<Landau1958>)
#box(width: 64%)[
=== Landau Fermi Liquid Theory (Quantification)
- _Self-energy_ $Sigma~i omega^2$. Quantifies _decay_ rate. Vanishes very fast as $omega -> 0$: essential for _quasiparticle_ picture
- _Quasiparticle residue_: how similar are the true excitations to 1-particle excitations
$ Z = mel(Psi_"ex", c^dagger_(k sigma), Psi_"gs") $
- $Z = (1 - (partial ("Re" Sigma))/(partial omega))^(-1)$. Must be _non-zero_ for Landau Fermi liquid.
]
#box(width: 35%)[
  #image("figures/quasipRes.svg", height: 90%)
]
]
#only(3)[
=== Violations Of Landau Fermi Liquid Theory

#box(width: 69%)[
- _Tomonaga-Luttinger Liquid_: Interacting electrons in 1D $arrow$ spin-charge separation!
- _Overscreened_ fixed points in Kondo models \ $arrow$ fractional entropy, diverging $chi, C_v$
- _Strange Metal_: Normal state of unconventional SCs in Cu oxides, heavy fermions, pnictides
] 
#hf
#box(width: 30%)[
  #image("figures/strangeMetal.png", height: 40%)
]
#fnote(<EmeryKivelson1992>,<Haldane_1981>,<keimer2015quantum>,<Custers2003>,<LeyraudPnictide2009>)
]
#only(4)[
=== The Marginal Fermi Liquid
#fnote(<varma-physrevlett.63.1996>,<anirbanmott1>)

#box(width: 64%)[
- _Phenomenological_ explanation of normal state of cuprates: $Sigma ~ omega log(|omega|) - i pi |omega|$
- Quasiparticle residue _vanishes_ at Fermi surface\ 
$ Z^(-1) = 1 - (partial ("Re" Sigma))/(partial omega) ~ -log(omega) -> infinity $
- Not accessible through _perturbative_ corrections of Landau Fermi liquid
]
#hf
#box(width: 35%)[
  #image("figures/marginalFL.svg", height: 70%)
]
]

#only(5)[
  === Main Takeaways

  - Landau Fermi Liquid theory requires interacting eigenstates to be _adiabatically connected_ to non-interacting eigenstates
  - Non-Fermi liquids involve _vanishing quasiparticle residue_, signalling that the states are in fact not adiabatically connected.
  - This typically means _non-perturbative_ approaches are required to deal with such phases.
  - The qualitatively different nature of excitations means that LFL and NFL correspond to _distinct fixed points_ in the RG sense.
]

= An Exactly Solvable Model

  == The Hatsugai-Kohmoto Model
  #fnote(<Baskaran1991>, <HatsugaiKohmoto1992>)

  #v(-30pt)
  Consider long-ranged interaction in real-space.
  $ H = -t sum_(< i,j >, sigma)c^dagger_(i,sigma)c_(j,sigma) + frac(U,L^d)sum_(i_1, i_2, r)c^dagger_(i_1 + r, arrow.t)c^dagger_(i_2 - r, arrow.b)c_(i_2, arrow.b)c_(i_1, arrow.t) $
  #image("figures/HKM.svg")

  Switch to momentum space, Hamiltonian _becomes local_!
  $ c^dagger_r ~ sum_k e^(-i k r) c^dagger_k;quad H = sum_(arrow(k)) H_(arrow(k)); quad H_(arrow(k)) = epsilon_(arrow(k))sum_sigma n_(arrow(k),sigma) + U n_(arrow(k) arrow.t) n_(arrow(k) arrow.b) $


  == The Hatsugai-Kohmoto Model
  Contrast with the Hubbard interaction.
  $ H_"int" &~ sum_(i)n_(i,arrow.t)n_(i,arrow.b) = sum_(k_1, k_2, q)c^dagger_(k_1 + q, arrow.t)c^dagger_(k_2 - q, arrow.b)c_(k_2, arrow.b)c_(k_1,arrow.t) $
  #image("figures/hubbard.svg")
  - local in real-space, highly _non-local_ in $k-$space
  - HK model is $q=0, k_1=k_2$ (_zero mode_!) component of the Hubbard
  - HKM is easier to solve than Hubbard (KE and PE _do not commute_)

  == Spectrum

  #v(-10pt)
  #box(width:55%)[
  $ H = sum_(arrow(k)) H_(arrow(k)); quad H_(arrow(k)) = epsilon_(arrow(k))sum_sigma n_(arrow(k),sigma) + U n_(arrow(k) arrow.t) n_(arrow(k) arrow.b) $
  Each $H_k$ can be diagonalised.
  $ ket(0): E = 0, quad ket(sigma): E = epsilon_k, quad ket(2): E = 2epsilon_k + U $
]
#hf
  #box(width:30%)[
    #pause
  #image("figures/states.svg")
  ]
  #v(20pt)
  #box(width:45%)[
  #pause
    *Case Of Half-Filling*
    $ E(mu) = E - mu n_k,quad mu = U/2 $
    $ E_0 = 0, quad E_1 = epsilon_k - U/2, quad E_2 = 2epsilon_k $
]
#hf
  #box(width:45%)[
  #pause
  #image("figures/groundStates.svg")
]

== Introduction to Greens Functions

Nature of _excitations_ can be studied through Greens function
$ G_nu (t) = -i theta(t)expval({c_nu (t), c^dagger_nu}) $

- Non-interacting system: $G_k (omega + i eta) = frac(1, omega + i eta - epsilon_k)$ 
- _Poles_ of Greens function #sym.arrow.r one-particle excitations
- _Zeroes_ of Greens function #sym.arrow.r destruction of one-particle excitations

== Exact Single-Particle Greens Function of the HKM

// #v(-100pt)
#box(width:60%)[
Greens function can be calculated as
$ G_(k sigma) (omega) = frac(P_e (k sigma), omega - E_X) + frac(P_h (k sigma), omega + E_X) $
]
#hf
#box(width:30%)[
  #image("figures/states.svg")
]

#v(10pt)
#only(2)[
#box(width:55%)[
  _If opposite spin is unoccupied_

- Particle addition: $E_X = epsilon_k$
- Particle removal: $E_X = -epsilon_k$
$ G arrow.r frac(1-expval(n_(k overline(sigma))), omega - epsilon_k) $
]
#box(width:35%)[
$ ket(0) arrow.r ket(sigma) $
#v(20pt)
$ ket(sigma) arrow.r ket(0) $
  #v(70pt)
]
]
#only(3)[
#box(width:55%)[
  _If opposite spin is occupied_

- Particle addition: $E_X = epsilon_k + U$
- Particle removal: $E_X = -epsilon_k - U$
$ G arrow.r frac(expval(n_(k overline(sigma))), omega - epsilon_k - U) $
]
#box(width:35%)[
$ ket(-sigma) arrow.r ket(sigma\,-sigma) $
#v(20pt)
$ ket(sigma\,-sigma) arrow.r ket(-sigma) $
  #v(70pt)
]
]
#only(4)[
  #underline[_Total Greens Function_]
$ G_(k sigma) = frac(1-expval(n_(k overline(sigma))), omega - epsilon_k) + frac(expval(n_(k overline(sigma))), omega - epsilon_k - U) \
(epsilon_k arrow.r epsilon_k - mu) $
]

== Correlated Metal-Insulator Transition

#v(-5pt)
#fnote(<Phillips2020>)
The Case Of _Half-Filling_: $2mu = U, expval(n_(k sigma)) = 1/2$
$ G_(k sigma) = frac(1, 2)[(omega - epsilon_k + U\/2)^(-1) + (omega - epsilon_k - U\/2)^(-1)] $

#box(width:45%)[
  #pause
  $U > W$ (_Mott Insulator_)
  #image("figures/insulator.svg", width: 89%)
]
#hf
#box(width:45%)[
  #pause
  $U < W$ (Metal)
  #image("figures/metal.svg", width: 89%)
]

= Non-Fermi Liquid Signatures In Metallic Phase

== Signature I: Composite Gapless Excitations

#fnote(<Phillips2020>)
$ G_(k sigma) = frac(1, 2)[(omega - epsilon_k + U\/2)^(-1) + (omega - epsilon_k - U\/2)^(-1)] $

Momentum states classified into three groups:

#box(width:50%)[
  #only(1)[
- $S_2: epsilon_k < -U\/2$:\ _Both poles_ below $omega=0$: $expval(n_k) = 2$
- $S_1: -U\/2 < epsilon_k < U\/2$:\ _One pole_ below $omega=0$: $expval(n_k) = 1$
- $S_0: epsilon_k > U\/2$:\ _No pole_ below $omega=0$: $expval(n_k) = 0$
  ]
  #only(2)[
    Ground state is a _mixed_ state.

    - $k-$states in $S_2$ are doubly-occupied.
    - $k-$states in $S_1$ are half-filled.
    - $2^(N_1)$-fold degenerate.
  ]
]
#box(width:45%)[
  #only("1-2")[
  #image("figures/regions.svg", width: 90%)
  ]
]

== Signature I: Composite Gapless Excitations
#fnote(<Phillips2020>,<zhao2024review2024>,<Baskaran1991>)
#box(width:59%)[
  _Near $S_2-S_1$ boundary_ $(epsilon_k = -U\/2)$

  - Excitation operator: $c^dagger_(k sigma) n_(k overline(sigma))$
  - Excitation energy is $epsilon_k + U/2 arrow.r 0^+$ \ \ 
]
#box(width:40%)[
  #image("figures/LHBExcitation.svg", width: 90%)
]

#box(width:59%)[
  _Near $S_1-S_0$ boundary_ $(epsilon_k = U\/2)$

  - Excitation operator: $c^dagger_(k sigma) (1 - n_(k overline(sigma)))$
  - Excitation energy is $epsilon_k - U/2 arrow.r 0^+ $ \ \ 
]
#box(width:40%)[
  #image("figures/UHBExcitation.svg", width: 90%)
]

_Projectors are needed_ because the other excitations are gapped.

== Signature I: Composite Gapless Excitations
#fnote(<Phillips2020>,<zhao2024review2024>,<Baskaran1991>)

#box(width:49%)[
  _Near $S_2-S_1$ boundary_
$ c^dagger_(k sigma) n_(k overline(sigma)) $
]
#box(width:49%)[
  _Near $S_1-S_0$ boundary_
$ c^dagger_(k sigma) (1 - n_(k overline(sigma))) $
]

=== Excitations are Non-Fermi Liquid In Nature!

- Strong correlations lead to _composite_ (hole/double) excitations
- Excitations are _not electronic_ (do not satisfy {#sym.dot} relations)
- _Breakdown_ of quasiparticle picture, and hence of Fermi liquid theory

== Signature II: Divergence of Self-Energy
#box(width:54%)[
We have at 1/2-filling:
$ G_(k sigma) = frac(1, omega - epsilon_k + frac(U^2 \/ 4, omega - epsilon_k)). $
_Self-energy_ is $Sigma(omega) = frac(U^2 \/ 4, omega - epsilon_k)$

#uncover(2)[

- _Diverges_ along $epsilon_k=0$ as $omega arrow.r 0$
- _Violates_ Fermi Liquid Theory
- Leads to zeros of Greens function
- Death of Landau _quasiparticles_
]
]
#box(width:45%)[
#uncover(2)[
#image("figures/HKMSelfEnergy.svg", width: 90%)
]
]

== Signature II: Divergence of Self-Energy

=== How Does A Diverging Self-Energy Leave The System Metallic?

#uncover(2)[
Greens functions for composite excitations do not have self-energy!
$ d^dagger_(k sigma) = c^dagger_(k sigma) n_(k sigma), & quad G_d = frac(1, omega - epsilon_k - U/2) \
h^dagger_(k sigma) = c^dagger_(k sigma) (1 - n_(k sigma)), & quad G_h = frac(1, omega - epsilon_k + U/2) $

These can therefore propagate with _long lifetimes_.
]

= Is This A Realistic Model of Interacting Electrons?

== Stability Under Small Perturbations
#fnote(<Zhao2023>,<Phillips2020>)

#box(width: 55%)[
$ S = S_"FL" + U integral c^dagger_(k arrow.t) c^dagger_(k arrow.b) c_(k arrow.b) c_(k arrow.t) + #linebreak() u integral c^dagger_(k_1+q, arrow.t) c^dagger_(k_2-q, arrow.b) c_(k_2, arrow.b) c_(k_1, arrow.t) $
#uncover("2-3")[
- HK interaction strongly _relevant_ under RG flow
- _Stable_ under local interaction terms
- Displays superconducting instability
]
]
#box(width: 40%)[
#uncover("2-3")[
#image("figures/HKModelRG.png", width: 100%)
]
]

#v(1em)
#uncover(3)[_Key Point_: HK interaction is the _source of Mottness_ in Hubbard model.]

== Link With The 2D Hubbard Model
#fnote(<Baskaran1991>,<anirbanmott1>)

#box(width: 48%)[
  Alternative form of HK interaction:
  $ U sum_k n_(k arrow.t) n_(k arrow.b) tilde -J sum_k bold(S)_k dot bold(S)_k$
#linebreak()
#linebreak()
  _Baskaran Model_
  $ sum_k epsilon_k n_(k sigma) + (sum_k bold(S)_k)^2 - J sum_k bold(S)_k dot bold(S)_k $
#linebreak()
  - Spin-charge separation of NFL
  - Gapped spinon excitations
]
#h(1fr)
#uncover(2)[
#box(width: 45%)[
  - Similar model emerges from 2D Hubbard Model, _Mott liquid_

  $ -sum_k bold(S)_k dot bold(S)_(-k) + sum_k bold(C)_k dot bold(C)_(-k)$

  #linebreak()
  $ S^z = n_(k arrow.t) - n_(k^T arrow.t), C^z = n_(k arrow.t) + n_(k^R arrow.t) - 1 $

  #image("figures/MottLiquid.svg", width: 60%)
]
]



= Summary of Main Ideas

== Summary of Main Ideas



= Avenues for Futher Investigation

== Kondo Screening in Hatsugai-Kohmoto Model

#hf
#box[
  #image("figures/Kondo-HKM.svg", width: 40%)
]
#hf
#box[
  #vf
  Consider local moment \ hybridising with HK Model
  $ H = H_"Kondo" + H_"HKM" $
  #pause
  How does _absence_ of quasiparticles \ affect Kondo screening?
  #vf
]
#hf

== Toy Model for Thermalisation and Many-Body Scars

#box[
  #image("figures/Hubbard-HKM.svg", width: 50%)
]
#hf
#box[
Consider HK Model perturbed by\ Hubbard interaction
$ H = H_"HKM" + P_nu H_"Hub" P_nu $
#pause
- $H_"Hub"$ allows _thermalisation_ \ of $k-$states
#pause
- $P_nu$ will preserve certain sectors.\  _Scars_?
]

== Effect of Hatsugai-Kohmoto Interaction on Edge Modes of SSH Chain
#box[
  #image("figures/HKM-SSH.svg", width: 45%)
]
#hf
#box[
  Add long-ranged HKM interactions\ to SSH chain.
  $ H_"SSH" = -t_1 c^dagger_1 c_2 -t_2 c^dagger_2 c_3 + dots $
$ H = H_"HKM" + H_"SSH" $
#pause
- Fate of topological _edge modes_?
]

== Bibliography
#bibliography(title: none, style: "nature", "bib.bib")
