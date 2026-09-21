#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

// ---- palette (matches the slide deck) ----
#let blue  = rgb("#1D4ED8")
#let orange = rgb("#C2410C")
#let grey  = rgb("#6B7280")
#let ink   = rgb("#1A1A1A")
#let rule  = rgb("#E5E7EB")
#let softblue = rgb("#EAF0FF")
#let softorange = rgb("#FBEDE6")

// ---- page & text ----
#set page(paper: "a4", margin: (x: 2.2cm, y: 2.2cm), numbering: "1")
#set text(font: ("Inter", "Helvetica Neue", "Arial"), size: 10.5pt, fill: ink)
#set par(justify: true, leading: 0.68em)
#show heading.where(level: 1): it => block(above: 1.6em, below: 0.9em, text(font: ("Newsreader", "Georgia"), size: 20pt, weight: 500, it.body))
#show heading.where(level: 2): it => block(above: 1.3em, below: 0.7em, text(font: ("Newsreader", "Georgia"), size: 15pt, weight: 500, it.body))
#show heading.where(level: 3): it => block(above: 1.0em, below: 0.5em, text(size: 11.5pt, weight: 700, fill: grey, it.body))
#set math.equation(numbering: none)
#show raw.where(block: true): it => block(fill: rgb("#F6F7F9"), inset: 9pt, radius: 3pt, width: 100%, text(size: 9pt, it))

// ---- helpers ----
#let callout(body, fill: softorange, bar: orange) = block(
  width: 100%, fill: fill, inset: 12pt, radius: 3pt,
  stroke: (left: 3pt + bar), below: 0.9em, above: 0.9em, body)
#let big(body) = align(center, block(width: 92%, above: 1em, below: 1em,
  text(size: 13pt, weight: 600, fill: ink, body)))
#let eqbox(body) = align(center, block(width: 100%, fill: white, stroke: 1pt + rule,
  inset: 12pt, radius: 3pt, above: 0.8em, below: 0.8em, body))

// ============================================================
#align(center)[
  #text(font: ("Newsreader","Georgia"), size: 26pt, weight: 500)[MeshConv]
  #v(-0.4em)
  #text(size: 12pt, fill: grey)[The four differential operators of the spherical U-Net]
  #v(0.2em)
  #text(size: 9.5pt, fill: grey)[Jiang et al. 2019 — a study guide]
]
#v(0.6em)
#line(length: 100%, stroke: 0.6pt + rule)

= The MeshConv equation

Everything in this guide serves one formula. A MeshConv layer replaces the fixed
$3 times 3$ square kernel of an ordinary CNN with a small basis of *geometric
measurements* taken on the mesh:

#eqbox[
  $ F * G_theta^"diff" = theta_0 thin I F + theta_1 thin nabla_"EW" F + theta_2 thin nabla_"NS" F + theta_3 thin nabla^2 F $
]

Read left to right, the symbols mean:

#block(inset: (left: 6pt))[
  / $F$: one feature defined on the mesh vertices (one number per vertex).
  / $I F$: the *original* feature value, untouched.
  / $nabla_"EW" F$: the rate of change of $F$ toward the east–west direction.
  / $nabla_"NS" F$: the rate of change of $F$ toward the north–south direction.
  / $nabla^2 F$: how the feature *bends / deviates* relative to its surrounding neighbourhood.
  / $theta_0, theta_1, theta_2, theta_3$: four *learned* coefficients.
]

#big[The geometry operators are fixed from the mesh. \ The four $theta$ values are learned.]

#align(center, diagram(
  spacing: (2.4em, 1.1em),
  node-stroke: 0.6pt + rule, node-fill: white, node-inset: 8pt,
  node((0,0), text(fill: blue)[geometry decides *how* to measure the local pattern]),
  node((0,1), text(fill: orange)[the network learns *how much* each measurement matters]),
  edge((0,0),(0,1), "->", stroke: grey),
))

The rest of this guide unpacks each of the four operators, from physical meaning
down to the exact number produced at a single vertex, and finally how MeshConv
consumes those numbers.

= Before the operators: what is $F$?

$F$ is not an image and not a vector field. It is simply *one feature value stored
at every vertex* of the mesh. If the feature is cortical curvature:

```
vertex 0     -> curvature =  0.12
vertex 1     -> curvature =  0.18
vertex 2     -> curvature = -0.05
   ...
vertex 10241 -> curvature =  0.09
```

Collected into a column, that is the whole of $F$:

#eqbox[
  $ F = mat(F_0; F_1; F_2; dots.v; F_10241) quad quad "shape" quad [V] $
]

where $V$ is the number of vertices (for the paper's level-5 icosphere, $V = 10{,}242$).
With a batch of $B$ examples and $C$ feature channels the tensor is:

#align(center)[```
[B, C, V]
```]

#callout(fill: softblue, bar: blue)[
  *Key idea.* Every differential operator below receives these vertex values and
  returns *one new value at every vertex*. Input $[V]$, output $[V]$. The operators
  differ only in *what they measure* about the local neighbourhood.
]

= Operator 1 — Identity $I$

== Intuitive meaning
Identity asks only one question: *"what is the feature value at this vertex?"*
It adds no neighbourhood information whatsoever. If
```
vertex X : curvature = 0.8
```
then
```
I(F)(X) = 0.8
```

== The formula
$ I F = F quad quad "or at vertex" i: quad (I F)_i = F_i $
No approximation is required — this is the zeroth-order operator.

== Matrix picture
$ I = mat(1,0,0,0; 0,1,0,0; 0,0,1,0; 0,0,0,1) quad quad I F = F $

Row $i$ reads *only* vertex $i$; nothing enters from the neighbours. For cortical
data at vertex $4200$ with curvature $0.8$, the Identity branch simply preserves
$0.8$. This lets MeshConv learn from the *absolute* feature value, not only from
how it changes.

#align(center, cetz.canvas({
  import cetz.draw: *
  // neighbour vertices (faded)
  let nb = ((1.2,0.5),(0.9,1.4),(-0.4,1.5),(-1.3,0.4),(-0.9,-1.1),(0.6,-1.3))
  for p in nb { line((0,0), p, stroke: rule + 1pt) }
  for p in nb { circle(p, radius: 0.13, fill: rgb("#D9DCE1"), stroke: none) }
  for p in nb { content((p.at(0)*1.28, p.at(1)*1.28), text(size: 7pt, fill: grey)[0.#calc.rem(int(p.at(0)*10+20),9)]) }
  // centre
  circle((0,0), radius: 0.2, fill: blue, stroke: none)
  content((0,-0.42), text(size: 8pt, fill: blue)[X])
  content((0,0.42), text(size: 9pt, weight: 700)[0.8])
  // identity arrow to output box
  line((0.9,0), (3.0,0), stroke: orange + 1.4pt, mark: (end: ">"))
  content((1.95,0.32), text(size: 8pt, fill: orange)[Identity $I$])
  rect((3.0,-0.4),(4.0,0.4), stroke: orange + 1pt, fill: softorange)
  content((3.5,0), text(size: 10pt, weight: 700)[0.8])
}))
#align(center, text(size: 9pt, fill: grey)[*Identity:* preserve the value at the current vertex — no neighbour arrows are used.])

= Operator 2 — Gradient

Before east–west and north–south, we need the ordinary derivative.

== The ordinary derivative (1-D)
```
position:   0 ---- 1 ---- 2
value:      2      5      9
```
A derivative asks: *how quickly is the signal changing as I move?* The central
difference estimates it from the two neighbours:
$ (d F)/(d x) approx (F_"right" - F_"left")/(2 h) quad => quad (9 - 2)/(2) = 3.5 quad (h=1) $

The same number is a *dot product* of a fixed row with the values:
$ mat(-0.5, 0, 0.5) mat(2; 5; 9) = 3.5 $

#callout[
  *Matrix multiplication does not magically create the derivative.* The derivative
  formula is already *encoded in the coefficients* $mat(-0.5,0,0.5)$. Multiplying by
  the feature values just evaluates that formula.
]

#align(center, diagram(spacing: (2em,0.9em), node-stroke: 0.6pt+rule, node-inset: 7pt, node-fill: white,
  node((0,0),[geometry / math]), edge((0,0),(0,1),"->",stroke:grey),
  node((0,1),[construct derivative operator]), edge((0,1),(0,2),"->",stroke:grey),
  node((0,2),[operator $times$ feature values]), edge((0,2),(0,3),"->",stroke:grey),
  node((0,3), text(fill: orange)[derivative values]),
))

== Why gradients are harder on a mesh
On a raster image the four directions *left / right / up / down* are obvious
because pixels sit on a rectangular grid, so a derivative can be literally
"right pixel $-$ left pixel". On a triangular mesh the neighbours are *not* on a
square:

#align(center, cetz.canvas({
  import cetz.draw: *
  let nb = ((1.3,0.2),(0.5,1.3),(-0.9,1.0),(-1.3,-0.2),(-0.4,-1.3),(0.9,-1.1))
  for p in nb { line((0,0),p, stroke: grey+0.8pt) }
  // outer edges
  for i in range(nb.len()) { line(nb.at(i), nb.at(calc.rem(i+1,nb.len())), stroke: rule+0.8pt) }
  for p in nb { circle(p, radius:0.1, fill: grey, stroke:none) }
  circle((0,0), radius:0.15, fill: blue, stroke:none)
  content((0,-0.4), text(size:8pt, fill: blue)[X])
}))

So the derivative cannot be a fixed "$"right" - "left"$". Instead the mesh
*geometry* — vertex coordinates, triangles, triangle areas, and tangent
directions — supplies the coefficients.

== How the paper computes the mesh gradient
A continuous scalar feature is approximated as a *piecewise-linear* function over
the triangles, built from "hat" basis functions $phi_i$:
$ f(x) = sum_(i=1)^n phi_i (x) thin f_i $
where $f_i$ is the value at vertex $i$, and $phi_i = 1$ at vertex $i$ and $0$ at
every other vertex. Differentiating,
$ nabla f(x) = sum_(i=1)^n nabla phi_i (x) thin f_i . $
Because each triangle interpolates *linearly*, its gradient is *constant inside
that triangle*. The paper writes this per-face gradient as
$ nabla f^("face") = G thin f^("vertex")  $
where $G$ is a fixed operator built from the triangle's coordinates and its
finite-element basis (we do not derive $G$ here — it comes from the geometry).

A single vertex touches *several* triangles, each with its own gradient vector.
The paper averages them, weighting each face by its area:
$ nabla f_i^("vertex") = (sum_(j in N(i)) a_j^("face") thin nabla f_j^("face"))/(sum_(j in N(i)) a_j^("face")) . $
Larger triangles contribute proportionally more.

#align(center, cetz.canvas({
  import cetz.draw: *
  let fac = ((1.4,0.8),(0.2,1.6),(-1.3,0.9),(-1.4,-0.7),(0.1,-1.6),(1.3,-0.8))
  // per-face gradient arrows (varied directions)
  let dirs = ((0.6,0.5),(-0.2,0.7),(-0.7,0.2),(-0.4,-0.5),(0.2,-0.6),(0.6,-0.2))
  for i in range(fac.len()) {
    let p = fac.at(i); let d = dirs.at(i)
    line(p, (p.at(0)+d.at(0), p.at(1)+d.at(1)), stroke: grey+1pt, mark:(end:">"))
  }
  circle((0,0), radius: 0.16, fill: blue, stroke:none)
  content((0,-0.42), text(size:8pt, fill: blue)[X])
  content((0,2.0), text(size:8pt, fill: grey)[per-face gradients])
  // combined vertex gradient
  line((2.6,0),(4.4,0.7), stroke: orange+2pt, mark:(end:">"))
  content((3.5,-0.35), text(size:8pt, fill: orange)[$nabla f$ (per-vertex)])
  line((1.0,0),(2.4,0), stroke: rule+1pt, mark:(end:">"))
  content((1.7,0.28), text(size:7.5pt, fill: grey)[area-weighted])
}))

= Operator 2a — East–West gradient

The full gradient $nabla f$ is a *vector* along the surface — direction and speed
of fastest increase. MeshConv wants *directional* information, so the paper defines
a local unit tangent $hat(e)_"EW"$ pointing east–west and takes the component of
the gradient along it:
$ nabla_"EW" f = nabla f dot.op hat(e)_"EW" . $
This dot product asks: *how much of the full gradient points east–west?*

- gradient points strongly east $=>$ large *positive* EW
- strongly west $=>$ large *negative* EW
- gradient almost north–south $=>$ EW $approx 0$

*Numerical example.* If $nabla f = (3,4)$ and $hat(e)_"EW" = (1,0)$ then
$ nabla_"EW" f = (3,4) dot.op (1,0) = 3 . $

#grid(columns: (1fr, 1fr), gutter: 1em,
  cetz.canvas({
    import cetz.draw: *
    // tangent axes
    line((-1.6,0),(1.6,0), stroke: grey+1pt, mark:(end:">"))
    content((1.85,0), text(size:8pt, fill: grey)[E])
    line((0,-1.6),(0,1.6), stroke: grey+1pt, mark:(end:">"))
    content((0,1.85), text(size:8pt, fill: grey)[N])
    // full gradient NE
    line((0,0),(1.2,1.6), stroke: blue+2pt, mark:(end:">"))
    content((1.35,1.7), text(size:8pt, fill: blue)[$nabla f$])
    // projection onto EW
    line((1.2,1.6),(1.2,0), stroke: grey+0.7pt, dash: "dashed")
    line((0,0),(1.2,0), stroke: orange+2.5pt)
    content((0.6,-0.3), text(size:8.5pt, fill: orange)[$nabla_"EW" f$])
    circle((0,0), radius:0.09, fill: ink, stroke:none)
  }),
  align(horizon)[
    #text(fill: grey, size: 9.5pt)[The EW derivative is the *component of the surface
    gradient pointing east–west*: the orthogonal projection of $nabla f$ onto the
    east–west tangent axis.]
  ]
)

= Operator 2b — North–South gradient

Exactly the same logic with the perpendicular unit tangent $hat(e)_"NS"$:
$ nabla_"NS" f = nabla f dot.op hat(e)_"NS" . $
With $nabla f = (3,4)$ and $hat(e)_"NS" = (0,1)$:
$ nabla_"NS" f = (3,4) dot.op (0,1) = 4 . $

Sign: *positive* $=>$ increases toward the chosen north; *negative* $=>$ increases
the opposite way; *near zero* $=>$ little change along that axis.

#callout(fill: softblue, bar: blue)[
  The paper constructs east–west and north–south *direction fields* over the sphere
  and projects the per-vertex gradient onto those unit tangents. So EW and NS are
  *not* arbitrary labels attached to neighbours — they are genuine *directional
  components of the tangent-gradient approximation.*
]

== Full gradient vs. its two components
$nabla f$ is a single tangent vector. MeshConv does *not* feed the whole vector in
as one quantity — it separates it into two *scalar* directional components,
$nabla_"EW" f$ and $nabla_"NS" f$, giving the kernel directional information.

#align(center, cetz.canvas({
  import cetz.draw: *
  line((0,0),(1.6,1.2), stroke: blue+2pt, mark:(end:">")); content((1.8,1.35), text(size:8pt, fill: blue)[$nabla f$])
  line((0,0),(1.6,0), stroke: orange+2pt, mark:(end:">")); content((1.9,0), text(size:8pt, fill: orange)[EW])
  line((0,0),(0,1.2), stroke: orange+2pt, mark:(end:">")); content((-0.35,1.2), text(size:8pt, fill: orange)[NS])
  circle((0,0), radius:0.08, fill: ink, stroke:none)
}))

= Operator 3 — Laplacian $nabla^2$

This operator deserves more than "neighbours minus centre."

== Continuous meaning
In a flat 2-D domain,
$ nabla^2 f = (partial^2 f)/(partial x^2) + (partial^2 f)/(partial y^2) . $
The *first* derivative asks "is the value changing?"; the *second* derivative asks
"is the *rate of change itself* changing?" So the Laplacian measures the local
*bending / concavity* of the scalar signal.

#callout[
  *Crucial:* this is the Laplacian of the *feature* $f$ living on the surface — it
  is *not* the geometric curvature of the cortical surface itself. If the input
  feature happens to be cortical curvature, then $nabla^2 f$ measures *how that
  curvature value varies* across the mesh, not the shape of the cortex.
]

== 1-D second difference (intuition)
The second difference $f_"left" - 2 f_"center" + f_"right"$ captures peakiness.
Sharp peak `[1,5,1]`: $1 - 2(5) + 1 = -8$. #h(1.4em) Flat `[5,5,5]`: $5 - 2(5) + 5 = 0$.
Large magnitude $=>$ the centre is a strong peak/valley relative to its neighbours;
zero $=>$ locally flat.

#grid(columns: (1fr,1fr), gutter: 1.5em,
  cetz.canvas({ import cetz.draw:*
    line((-1.2,-0.5),(0,0.9), stroke: orange+1.6pt); line((0,0.9),(1.2,-0.5), stroke: orange+1.6pt)
    for p in ((-1.2,-0.5),(0,0.9),(1.2,-0.5)) { circle(p, radius:0.08, fill: orange, stroke:none) }
    content((0,-1.0), text(size:8pt)[$1-2(5)+1=-8$])
    content((0,1.35), text(size:8pt, fill: grey)[large $|nabla^2|$])
  }),
  cetz.canvas({ import cetz.draw:*
    line((-1.2,0),(1.2,0), stroke: blue+1.6pt)
    for p in ((-1.2,0),(0,0),(1.2,0)) { circle(p, radius:0.08, fill: blue, stroke:none) }
    content((0,-1.0), text(size:8pt)[$5-2(5)+5=0$])
    content((0,1.35), text(size:8pt, fill: grey)[$nabla^2 approx 0$])
  })
)

== The Laplacian on a triangular mesh
We cannot use "$"left" - 2 "center" + "right"$" because the neighbours are not
equally spaced, there are several of them, the triangles have different angles, and
the surface is curved. The paper uses the *cotangent discretisation* of the mesh
Laplace–Beltrami operator:

#eqbox[
  $ nabla^2 F_i approx 1/(2 A_i) sum_(j in N(i)) (cot alpha_(i j) + cot beta_(i j)) (F_i - F_j) $
]

#callout(fill: rgb("#FBF6EC"), bar: grey)[
  *Sign convention.* Some texts write $(F_j - F_i)$ instead. That is only a sign
  convention on the Laplacian; follow the sign used in the Jiang paper when
  reproducing its formulation.
]

Symbol by symbol:

#block(inset:(left:6pt))[
  / $i$: the current centre vertex.
  / $j in N(i)$: each one-ring neighbour vertex.
  / $F_i, F_j$: feature values at centre and neighbour.
  / $F_i - F_j$: how different the centre is from that neighbour.
  / $alpha_(i j), beta_(i j)$: the two angles *opposite the edge* $i j$ (one in each adjacent triangle).
  / $cot alpha + cot beta$: the geometry-derived *weight* of that edge.
  / $A_i$: the dual area associated with vertex $i$.
  / $sum$: combine contributions from all one-ring neighbours.
]

#align(center, diagram(spacing:(2em,0.85em), node-stroke:0.6pt+rule, node-inset:7pt, node-fill:white,
  node((0,0),[for each neighbour $j$: difference $F_i - F_j$]),
  edge((0,0),(0,1),"->",stroke:grey),
  node((0,1),[$times$ geometry weight $cot alpha_(i j)+cot beta_(i j)$]),
  edge((0,1),(0,2),"->",stroke:grey),
  node((0,2),[sum over all one-ring neighbours]),
  edge((0,2),(0,3),"->",stroke:grey),
  node((0,3),[normalise by local area $2A_i$]),
  edge((0,3),(0,4),"->",stroke:grey),
  node((0,4), text(fill: orange)[Laplacian at vertex $i$]),
))

== The two angles $alpha_(i j)$ and $beta_(i j)$
The edge $i j$ is shared by two triangles. In the upper triangle the third vertex
is $k$; in the lower it is $l$. The weight uses the angles *at $k$ and at $l$* —
the angles *opposite* the edge $i j$ — *not* the angles at $i$ or $j$.

#align(center, cetz.canvas({
  import cetz.draw: *
  let I=(-1.4,0); let J=(1.4,0); let K=(0,1.7); let Lv=(0,-1.7)
  // triangles
  line(I,J, stroke: orange+2pt)
  line(I,K, stroke: grey+1pt); line(J,K, stroke: grey+1pt)
  line(I,Lv, stroke: grey+1pt); line(J,Lv, stroke: grey+1pt)
  // vertices
  for (p,c) in ((I,blue),(J,blue),(K,grey),(Lv,grey)) { circle(p, radius:0.12, fill:c, stroke:none) }
  content((-1.7,0.05), text(size:9pt, fill: blue)[$i$]); content((-1.75,-0.32), text(size:8pt, fill: grey)[$F_i$])
  content((1.7,0.05), text(size:9pt, fill: blue)[$j$]);  content((1.75,-0.32), text(size:8pt, fill: grey)[$F_j$])
  content((0,1.95), text(size:9pt, fill: grey)[$k$])
  content((0,-1.95), text(size:9pt, fill: grey)[$l$])
  // opposite angles at k and l
  content((0,1.28), text(size:9pt, fill: orange)[$alpha_(i j)$])
  content((0,-1.28), text(size:9pt, fill: orange)[$beta_(i j)$])
  content((0,0.22), text(size:8pt, fill: orange)[edge $i j$])
}))

$ w_(i j) = cot alpha_(i j) + cot beta_(i j) quad quad "neighbour contribution" = w_(i j) (F_i - F_j) $

== The one-ring neighbourhood $N(i)$
$N(i)$ is simply the set of vertices *directly connected* to $i$. The differential
operators need *only* this local ring — which is exactly why MeshConv stays local,
like a $3 times 3$ CNN kernel.

#align(center, cetz.canvas({
  import cetz.draw: *
  let ring = ()
  for a in range(6) { let ang = 90deg - a*60deg; ring.push((1.5*calc.cos(ang), 1.5*calc.sin(ang))) }
  for p in ring { line((0,0), p, stroke: grey+0.9pt) }
  for i in range(6) { line(ring.at(i), ring.at(calc.rem(i+1,6)), stroke: orange+1.4pt) }
  for i in range(6) {
    circle(ring.at(i), radius:0.13, fill: grey, stroke:none)
    content((ring.at(i).at(0)*1.28, ring.at(i).at(1)*1.28), text(size:8pt, fill: grey)[$j_#(i+1)$])
  }
  circle((0,0), radius:0.16, fill: blue, stroke:none)
  content((0.3,-0.28), text(size:9pt, fill: blue)[$i$])
  content((0,-2.45), text(size:8.5pt, fill: orange)[$N(i)$ — the one-ring])
}))

= Approximate vs. exact

#grid(columns:(1fr,1fr), gutter: 1em,
  callout(fill: softblue, bar: blue)[
    *Continuous world.* If $f$ were an analytic function on a perfectly continuous
    sphere, $nabla f$ and $nabla^2 f$ would be *exact* continuous derivatives.
  ],
  callout(fill: rgb("#F6F7F9"), bar: grey)[
    *Mesh world.* We only know values $F_0, F_1, F_2, dots$ at *discrete* vertices,
    so the exact continuous derivatives are *unavailable*. We *estimate* them from
    triangle geometry + neighbour values + discrete-differential-geometry formulas.
  ]
)

#big[The network does not learn how to calculate derivatives. \ The mesh geometry
determines the derivative approximation. \ The network learns *how strongly to use*
each derivative.]

= From operators to tensors

Each operator is a linear map $bb(R)^V -> bb(R)^V$. Conceptually it is a matrix:

#align(center)[```
[V, V]  ×  [V]   ->   [V]
```]

For one feature, `L @ F` yields one Laplacian value at every vertex; likewise
`EW @ F`, `NS @ F`, `I @ F` each return shape `[V]`. Stacking the four:

#align(center)[```
I @ F , L @ F , EW @ F , NS @ F   ->   stack   ->   [V, 4]
```]

and with channels and batches, `[B, C, V, 4]`.

#callout[
  *Implementation-accuracy note.* An educational version may store `L`, `EW`, `NS`
  as dense `[V,V]` matrices because that is easy to read. Jiang's *actual* code does
  *not*: it computes
  #align(center)[```
vertex features -> per-face gradient -> area-weighted face->vertex average -> project onto EW/NS tangents
  ```]
  using *sparse* matrices for efficiency. So
  #align(center)[```python
east_west = x @ EW.T
  ```]
  is the *conceptual* final linear operator — do not read the dense `[V,V]` form as
  the literal production implementation.
]

= Complete flow at ONE vertex

#align(center, diagram(
  spacing: (1.5em, 1.0em), node-stroke: 0.6pt + rule, node-inset: 6pt, node-fill: white,
  node((1.5,0), text(fill: ink)[feature $F$ at centre vertex $i$]),
  edge((1.5,0),(0,1),"->",stroke:grey), edge((1.5,0),(1,1),"->",stroke:grey),
  edge((1.5,0),(2,1),"->",stroke:grey), edge((1.5,0),(3,1),"->",stroke:grey),
  node((0,1), text(fill: blue)[Identity]), node((1,1), text(fill: orange)[Laplacian]),
  node((2,1), text(fill: orange)[EW]), node((3,1), text(fill: orange)[NS]),
  node((0,2), $I_i$), node((1,2), $L_i$), node((2,2), $"EW"_i$), node((3,2), $"NS"_i$),
  edge((0,1),(0,2),"->",stroke:grey), edge((1,1),(1,2),"->",stroke:grey),
  edge((2,1),(2,2),"->",stroke:grey), edge((3,1),(3,2),"->",stroke:grey),
  edge((0,2),(1.5,3),"->",stroke:grey), edge((1,2),(1.5,3),"->",stroke:grey),
  edge((2,2),(1.5,3),"->",stroke:grey), edge((3,2),(1.5,3),"->",stroke:grey),
  node((1.5,3), text(fill: ink)[learned weights $theta_0, theta_1, theta_2, theta_3$]),
  edge((1.5,3),(1.5,4),"->",stroke:grey),
  node((1.5,4), $theta_0 I_i + theta_1 "EW"_i + theta_2 "NS"_i + theta_3 L_i$),
  edge((1.5,4),(1.5,5),"->",stroke:grey),
  node((1.5,5), text(fill: orange, weight: 700)[new feature at $i$]),
))
#align(center, text(size:9pt, fill: grey)[Term order matches the MeshConv equation: $theta_0 I + theta_1 nabla_"EW" + theta_2 nabla_"NS" + theta_3 nabla^2$.])

= Complete flow at ALL vertices

#align(center, diagram(spacing:(2.2em,0.95em), node-stroke:0.6pt+rule, node-inset:7pt, node-fill:white,
  node((0,0), [feature $F$ · #raw("[V]")]),
  edge((0,0),(0,1),"->",stroke:grey),
  node((0,1), [$I$, $L$, EW, NS #h(4pt) each #raw("->") #raw("[V]")]),
  edge((0,1),(0,2),"->",stroke:grey),
  node((0,2), [stack #raw("->") #raw("[V, 4]")]),
  edge((0,2),(0,3),"->",stroke:grey),
  node((0,3), text(fill: orange)[learned kernel #raw("->") new feature #raw("[V]")]),
))

Generalised to batches and multiple channels, the layer maps

#align(center)[```
[B, Cin, V, 4]   +   kernel [Cout, Cin, 4]   ->   [B, Cout, V]
```]

= MeshConv vs. a $3 times 3$ convolution

#grid(columns:(1fr,1fr), gutter: 1.2em,
  block(stroke: 1pt+rule, inset: 10pt, radius: 3pt)[
    #text(weight:700)[Standard $3 times 3$ convolution]
    #v(4pt)
    A learned kernel of spatial coefficients — the grid gives consistent positions:
    $ mat(w_1, w_2, w_3; w_4, w_5, w_6; w_7, w_8, w_9) $
  ],
  block(stroke: 1pt+rule, inset: 10pt, radius: 3pt)[
    #text(weight:700)[MeshConv]
    #v(4pt)
    No universal square neighbourhood exists, so a small *geometric basis* is fixed
    and only its combination is learned:
    #align(center)[Identity · EW · NS · Laplacian #h(6pt)$->$#h(6pt) learn $theta_0, theta_1, theta_2, theta_3$]
  ]
)

#big[A standard CNN learns weights for fixed *grid positions*. \ MeshConv learns
weights for fixed *geometric differential measurements*.]

= Summary

#callout(fill: white, bar: blue)[
  #grid(columns: (auto, 1fr), row-gutter: 6pt, column-gutter: 10pt,
    text(fill: blue, weight:700)[IDENTITY], [“What is the value here?”],
    text(fill: orange, weight:700)[EW GRADIENT], [“How fast does the feature change east–west?”],
    text(fill: orange, weight:700)[NS GRADIENT], [“How fast does the feature change north–south?”],
    text(fill: orange, weight:700)[LAPLACIAN], [“How is the feature locally bending / deviating relative to its one-ring neighbourhood?”],
  )
]

#align(center, diagram(spacing:(2em,0.85em), node-stroke:0.6pt+rule, node-inset:7pt, node-fill:white,
  node((0,0),[geometry computes these four measurements]),
  edge((0,0),(0,1),"->",stroke:grey),
  node((0,1),[MeshConv learns how to combine them]),
  edge((0,1),(0,2),"->",stroke:grey),
  node((0,2), text(fill:orange)[new feature at every vertex]),
))

#callout(fill: rgb("#FBF0EC"), bar: orange)[
  *Final warning.* Do not confuse the Laplacian of a cortical *feature* with the
  physical curvature of the cortical *mesh*. If the input feature itself is
  curvature, the Laplacian measures how that curvature *value* changes across the
  surface — not the shape of the cortex.
]

#pagebreak()

= Appendix — Prompts for generating operator visualizations

#block(stroke: 1pt + rule, inset: 12pt, radius: 3pt)[
  #set text(size: 9.5pt)
  #set par(justify: false)

  *Identity.* “Scientific vector diagram of a triangular spherical mesh patch.
  Highlight one center vertex X with scalar value 0.8. Neighbor vertices are visible
  but faded. Show an arrow from X directly to an output value 0.8 labeled Identity I.
  No neighbor contributions. White background, clean educational style.”

  #v(6pt)
  *Gradient construction.* “Scientific infographic of a triangular mesh around center
  vertex X. Each incident triangular face contains a small gradient vector. Show face
  areas and weighted arrows converging toward X, producing one area-weighted
  per-vertex gradient vector ∇f. Clearly distinguish per-face gradients from the
  final vertex gradient.”

  #v(6pt)
  *East–West derivative.* “Scientific tangent-plane diagram at one vertex on a sphere.
  Show local east-west and north-south tangent axes and a diagonal full surface
  gradient vector ∇f. Orthogonally project ∇f onto the east-west axis and highlight
  that component as ∇EW f = ∇f · eEW.”

  #v(6pt)
  *North–South derivative.* “Scientific tangent-plane diagram at one vertex on a
  sphere. Show local east-west and north-south tangent axes and a diagonal full
  surface gradient vector ∇f. Orthogonally project ∇f onto the north-south axis and
  highlight that component as ∇NS f = ∇f · eNS.”

  #v(6pt)
  *Laplacian.* “Scientific triangular-mesh diagram explaining the cotangent
  Laplacian. Highlight center vertex i and neighbor j sharing an edge. Show the two
  triangles adjacent to edge ij and clearly mark the two angles αij and βij opposite
  that edge. Show Fi and Fj beside the vertices. Beside the mesh show contribution
  (cot αij + cot βij)(Fi − Fj). Extend faintly to other one-ring neighbors to
  indicate that all contributions are summed.”

  #v(6pt)
  *Full MeshConv.* “Scientific flowchart showing one scalar feature defined on a
  spherical triangular mesh entering four parallel branches: Identity I, East-West
  derivative, North-South derivative, and Laplacian. Each branch produces one scalar
  per vertex. The four outputs enter learned coefficients θ0, θ1, θ2, θ3, are summed,
  bias is added, and a new feature map over all mesh vertices is produced. Include
  tensor annotations [V] → four [V] signals → [V,4] → learned combination → [V].”
]
