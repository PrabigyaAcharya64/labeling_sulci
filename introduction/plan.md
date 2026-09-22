# PLAN.md — remaining slides

Status: 01-08 built. 09-23 specified below, not built.
Every claim below is traceable to facts.md. Numbers marked `mono`
render in IBM Plex Mono.

Colour discipline per design.md:
  --old  borrowed machinery, setup, baselines
  --new  the paper's contribution
Preprocessing (09-11) is ALL --old. It is borrowed setup and must read
that way. The contribution does not start until 12.

## Build step 0 — assets

`figs/` does not exist yet. design.md says paper Figures 1, 2, 3, 5 are
screenshotted and placed as <img>, never redrawn. Extract them from
1-s2.0-S1053811921000355.pdf before building 12, 14, and 20:
  Fig 1  sulci in LPFC, 5 subjects + the area/depth scatter
  Fig 2  schematic overview of the whole method
  Fig 3  the augmentation trajectory
  Fig 5  visual inspection of label inference, per method

Each new slide also needs a <section data-markdown> entry in
index.html. It does not pick up files automatically.

---

## Finish preprocessing — steps 5 to 7

### 09-sphere.md — "Step 5 — Sphere Mapping"
Visual: inflated surface -> unit sphere, arrow back again to show the
mapping is invertible. Colour --old.
Fragments
  1. the mapping
  2. the inverse arrow (this is what puts labels back on folded cortex)
  3. `0.12%` mono, average area distortion
Presenter says: the sphere is an address system. It carries no shape
information, which is why nothing is measured on it.

### 10-icosahedron.md — "Step 6 — Icosahedral Grid"
Custom SVG. The paper does not illustrate this, so design.md permits
drawing it. Colour --old.
Visual: subdivision sequence with counts in mono
  L4 `2,562`   L5 `10,242`   L6 `40,962`   L7 `163,842`
  formula `10 x 4^n + 2`
Fragments
  1. the subdivision sequence
  2. L5 = network input, L6 = registration
  3. exactly `12` vertices have 5 neighbours, at every level; all
     others have 6 — this is why the paper says "semi-uniform"
Highlight the 12 pentagons directly on the mesh. Do not use a legend.

### 11-features.md — "Step 7 — Three Feature Channels"
Visual: three spherical maps stacked, each labelled with what it
captures. Colour --old.
  1. mean curvature of inflated surface     -> coarse folding
  2. average convexity (sulcal depth)       -> white vs inflated
  3. mean curvature of smoothed white       -> fine detail
One fragment per channel.
Two things the presenter must say, both from facts.md:
  - nothing is measured on the sphere
  - position is the row index, NOT a feature column

---

## The contribution — augmentation

design.md: this is the longest section. Colour --new from here.

### 12-problem.md — "The Problem"
Visual: the same row index in two brains, landing on approximately the
same spherical coordinate but not the same anatomy. Use Fig 1 to show
how variable LPFC folding is across 5 subjects.
This residual mismatch IS the problem the paper attacks.
CAUTION: never claim row 4200 is the same anatomy across brains.
Second beat: 60 pediatric / 36 adult is a small sample.

### 13-registration.md — "Registering A to B"
Visual: brain A's features deform toward brain B. Colour --old — this
machinery is borrowed from Lyu et al. 2019 (the second PDF).
Number: `~2 min` per pair at L6, single CPU thread.

### 14-harmonics.md — "Decomposing the Deformation"  ** core slide **
The single most important visual in the deck. Own file: viz/harmonics.html.
Per design.md, continuous change gets a presenter-dragged SLIDER, not
autoplay. Slider sweeps `l = 0 .. 10`.
  at l=0   pure rigid rotation — annotate: this is the rotation baseline
  as l rises  finer local warping is layered on
Framing that must not be got wrong (facts.md): the layers are LEVELS OF
DETAIL, not steps of a journey. Version k = layers 0..k-1 applied fresh
to brain A.
Why truncation is free: the SH basis is orthonormal, so the terms are
independent. One registration, then 11 reconstructions in `~5 sec`.
Degree 10 because deformation was marginal beyond it.

### 15-invariants.md — "What the Deformation Cannot Do"
Visual: one valid warp, beside the moves that are ruled out. Colour --new.
  allowed:   displace, stretch, change depth
  forbidden: create, destroy, merge, split, cross
Diffeomorphic — no triangle flip, no sign change in surface normal.
Second beat, the one people get wrong: the warped sample keeps brain
A's VALUES in brain B's ARRANGEMENT. Nothing is copied from B. Labels
warp with the features.

### 16-combinatorics.md — "How Many Samples"
Visual: n brains -> `n(n-1)` ordered pairs -> `x 11` degrees.
Fragments
  1. the pairing
  2. the 11 degrees per pair
  3. pairs touching validation or test are excluded — no leakage
CAUTION: show the formula, never a product. The paper states no total
augmented-sample count and neither may the deck.

---

## Training and inference

### 17-training.md — "Context-Aware Training"
Custom SVG — design.md names the 3->9 channel flow as worth drawing.
  Stage 1:  3 channels in  -> 7 out   (6 primary/secondary + background)
  Stage 2:  9 channels in  -> 14 out  (3 features + 6 likelihoods)
Fragments
  1. stage 1
  2. background likelihood dropped
  3. the 6 are NOT renormalised — renormalising would inflate one of them
  4. stage 2
Colour: the U-Net box is --old and labelled as unmodified (Jiang et al.
2019). The two-stage wiring around it is --new. That contrast is the
whole point of the slide.
CAUTIONS: never imply the architecture is novel. Never state a layer
count or kernel size — the paper gives none.

### 18-inference.md — "Inference"
Visual: a single chain, one fragment per link.
  new brain -> preprocess -> stage 1 -> stage 2 -> argmax -> graph cut
  -> invert sphere mapping -> labels on the folded surface
Beats worth isolating
  - NO registration at test time. This is what makes annotation fast.
  - the graph cut interpolates likelihoods and then takes argmax; it
    does not interpolate labels
  - final fragment, stated plainly: the graph cut improves Dice by
    `< 0.01`. It is mostly cosmetic — it removes tiny isolated regions.

---

## Verification

### 19-results.md — "Results"
The paper's whole result in one picture. Slope chart:
  x-axis  the 5 methods, in order
          multi-atlas, naive, rotation, non-rigid, non-rigid+context
  y-axis  Dice
  two lines: primary/secondary in --old, tertiary in --new
Pediatric left, from Table 3 in facts.md:
  primary/secondary  .6610  .6989  .7595  .7649  .7650
  tertiary           .2744  .3844  .4110  .4482  .4880
The shape carries the argument: tertiary climbs, primary/secondary
flattens after rotation. Label the two end values directly on the lines.
Do not print the whole table.

### 20-significance.md — "What Actually Improved"
The honest slide. Colour --new for what held, --muted for what did not.
  - against multi-atlas and against no augmentation: significant,
    both cohorts, both measures
  - against rotation-only: significant for TERTIARY sulci only.
    Primary/secondary shows no significant gain.
  - context-aware training beats augmentation alone on average Dice,
    but NO per-sulcus result survives FDR at q=.05
  - pediatric and adult accuracy are comparable (p > .05); without
    augmentation the cohorts differ by about `.1` Dice

### 21-limitations.md — "Limitations"
The five the authors state, as labelled items:
  - inter-rater reliability cannot be measured — labels were finalised
    once, at the last stage of a four-tiered procedure
  - context-aware training: no per-sulcus significance after FDR
  - graph cut improves Dice by < 0.01
  - cannot cover folding patterns far outside the training set
  - possible bias toward larger sulci (class imbalance)

### 22-takeaway.md — "Takeaway"
One line, no diagram. The contribution is the DATA, not the network.
The architecture is unmodified; the augmentation is generic and
applies to any genus-zero surface study short of training samples.

---

## Open questions

1. 04-process.md is a heading with no visual. It reads like it wants a
   roadmap of steps 1-7 acting as a section divider. Confirm, or leave
   it bare — design.md permits a heading-only slide.
2. 15 new slides takes the deck to 23. design.md envisaged 10. If that
   is too long, the compressible ones are 13 (fold into 14), 16 (fold
   into 14), and 20 (fold into 19) — that lands at 20 slides without
   losing an argument.
3. Slide 01 — checked in the browser, 2026-09-01. Verified working:
   the model loads, both fragments fire in the right order, and the
   camera is genuinely locked (min = max = camera-orbit).
   Two things still to settle:
   a. The brain reads as tilted. The camera is NOT at fault — it sits
      at theta -90deg, phi 90deg, a true lateral position, and the
      model's narrowest axis is x (0.83 vs y 1.24, z 2.00), so the
      lateral surface IS what faces us. The tilt is a roll baked into
      the GLB. Only an in-plane roll fixes it; orbit cannot.
      `orientation="0deg -25deg 0deg"` on <model-viewer> levels it
      reasonably. Worth a couple more passes between -20 and -40 to
      settle, then bake the chosen value into the file.
   b. Once rolled, both pointer endpoints must be re-aimed — the
      x2/y2 values were estimates and the roll moves every feature.
      Aim only after the roll is fixed, not before.
   Also consider tightening the camera-orbit radius from 105% to ~80%:
   the model currently fills a small part of the 800x600 stage and the
   folds will be hard to read under projection.
   Labels remain Sulcus top-left, Gyrus bottom-right — reversed from
   the original spec. Harmless, but confirm it is deliberate.
