# Lyu et al. 2021 — verified facts

## Paper
Labeling lateral prefrontal sulci using spherical data augmentation
and context-aware training. NeuroImage 229 (2021) 117758.
File: 1-s2.0-S1053811921000355.pdf (16 pp)

Second PDF in this folder is the REGISTRATION engine this paper builds
on, not the paper itself:
Lyu et al., Hierarchical Spherical Deformation for Cortical Surface
Registration. File: nihms-1534325.pdf (50 pp). It supplies the
composite-rotation / spherical-harmonics machinery that the 2021 paper
extends into a deformation TRAJECTORY.

## Anatomy
- Gyri = ridges. Sulci = grooves between them.
- Primary: earliest gestation (~20-27wk), largest, deepest, consistent
- Secondary: intermediate on all measures
- Tertiary: latest (~36-39wk), smallest, shallowest, most variable;
  continues developing after birth

### Gestational timings — per sulcus (Chi et al. 1977, as cited by the paper)
- cs                 20-23 wk
- sprs, iprs         24-27 wk
- sfs_a, sfs_p       24-27 wk
- ifs                28-31 wk
- "tertiary superior, middle, inferior frontal" sulci   36-39 wk
CAUTION: the paper gives NO week range that separates primary from
secondary. It treats all 6 as one "primary/secondary" group. Do not
invent a secondary-only range.
CAUTION: the paper states exact gestational timestamps are UNKNOWN for
the 7 LPFC tertiary sulci; the 36-39wk figure is Chi's coarse category,
not a measurement of these 7.
- The paper discriminates tertiary from primary/secondary using
  (a) emergence timepoint and (b) variability in depth and surface area.
- Tertiary sulci in LPFC are ~1.2 cm deep, ~500 mm^2 surface area
  (Miller et al. 2020b). Called tertiary sulci, not "dimples".
- Authors state the primary/secondary/tertiary assignment can be
  contentious and they are "not fully tied to these definitions".
- Region: lateral prefrontal cortex (LPFC)
- 13 sulci = 6 primary/secondary + 7 tertiary
  easy 6: cs, sprs, iprs, sfs_p, sfs_a, ifs
  hard 7: pmfs_p, pmfs_i, pmfs_a, imfs_h, imfs_v, mfms, ifms
- 14th class = background (most vertices)

## Data
- Pediatric N=60, ages 6-18, NORA, 1.0mm voxels, FreeSurfer v6.0
- Adult N=36, ages 22-36, HCP, 0.8mm voxels, HCP-modified FreeSurfer
- 96 subjects x 2 hemispheres = 192 hemispheres
- Cohorts and hemispheres trained SEPARATELY -> 4 experiments
- 5-fold CV: 60% train / 20% val / 20% test

## Manual labeling — where the ground truth came from
- Protocol follows Petrides (2018); Petrides & Pandya (2012)
- Drawn on the INFLATED mesh; curvature separates sulcal from gyral;
  cross-checked against inflated, pial, and smoothed white surfaces
- Four-tiered coarse-to-fine: screenshots -> 3 independent raters
  coarsely label -> neuroanatomist revises -> finalised by discussion
- Finalised labels were produced ONCE, at the last stage. This is
  exactly why inter-rater reliability cannot be computed.
- All 7 tertiary sulci were identifiable in all 192 hemispheres, even
  though tertiary sulci in LPFC are often absent in other work.

## Surfaces (per hemisphere)
- white     grey/white boundary, folded
- pial      outer edge of grey matter (used only for label QC)
- inflated  partly smoothed, still brain-shaped, NOT a sphere
- sphere    unit ball, address system only
Same vertices and connectivity across all four.

## Features (N=3)
1. mean curvature of inflated surface   -> coarse folding
2. average convexity (sulcal depth)     -> white vs inflated
3. mean curvature of SMOOTHED white     -> fine detail
Nothing measured on the sphere (constant curvature -> no information).
Position is the row index, NOT a feature column.

## Icosahedral grid
- counts: 10*4^n + 2
- L4=2,562  L5=10,242  L6=40,962  L7=163,842
- L5 = network input. L6 = registration.
- Exactly 12 vertices have 5 neighbours; all others have 6. Always 12,
  at every level. Paper says "semi-uniform" for this reason.

## Augmentation
- Spherical harmonics degree l = 0..10 -> 11 versions per pair
- l=0 is pure rigid rotation (= the rotation baseline)
- Higher l adds finer local warping
- Layers are LEVELS OF DETAIL, not steps of a journey.
  version k = layers 0..k-1 applied fresh to brain A.
- Truncation works because SH basis is ORTHONORMAL (independent terms)
- Cost: ~2 min to register a pair at L6; ~5 sec for all 11
- Every ordered pair: n brains -> n(n-1) pairs
- Labels warp with features
- Diffeomorphic: sulci displace, stretch, change depth.
  Never created, destroyed, merged, split, or crossed.
- Warped sample keeps brain A's VALUES in brain B's ARRANGEMENT.
  Nothing is copied from B.
- Pairs involving val/test subjects excluded (no leakage)

## Training
- Architecture: spherical U-Net from Jiang et al. 2019, UNMODIFIED
- Stage 1: 3 channels in -> 7 outputs (6 sulci + background)
- Stage 2: 9 channels in (3 features + 6 likelihoods) -> 14 outputs
- Background likelihood dropped between stages; the 6 are NOT
  renormalised
- Adam, lr 0.01, categorical cross-entropy, temperature scaling
- Entry feature layer size 32
- Layer counts / kernel sizes NOT stated in the paper

## Inference
new brain -> preprocess -> stage 1 -> stage 2 -> argmax
-> graph cut -> invert sphere mapping -> labels on folded surface
- NO registration at test time
- Graph cut: Boykov & Kolmogorov 2004, lambda=1
- Interpolates likelihoods then argmax, not labels directly

## Results
- Dice ~0.75 primary/secondary, ~0.50 tertiary
- Beats: multi-atlas, no augmentation, rotation-only augmentation
- Largest gains on tertiary sulci
- Area distortion from spherical mapping ~0.12%

### Table 3 — mean Dice, verbatim (overall / prim-sec / tertiary)
Five methods, in order: Multi-atlas, Naive, Rotation, Non-rigid,
Non-rigid+Context. Naive = spherical U-Net, no augmentation.

Pediatric Left   .4528 / .6610 / .2744
                 .5296 / .6989 / .3844
                 .5718 / .7595 / .4110
                 .5944 / .7649 / .4482
                 .6159 / .7650 / .4880
Pediatric Right  .4348 / .6375 / .2611
                 .5156 / .6895 / .3665
                 .5742 / .7355 / .4360
                 .5908 / .7478 / .4562
                 .6076 / .7574 / .4791
Adult Left       .4843 / .6521 / .3404
                 .4227 / .5778 / .2897
                 .5712 / .7185 / .4450
                 .6046 / .7449 / .4843
                 .6333 / .7471 / .5357
Adult Right      .4703 / .6450 / .3205
                 .4136 / .6034 / .2508
                 .5544 / .7460 / .3901
                 .5893 / .7508 / .4508
                 .6067 / .7654 / .4707

Read off the shape, not the decimals: tertiary is the column that moves
(.27 -> .49 pediatric left), primary/secondary barely moves past
rotation (.7595 -> .7650).

### What is and is not significant
- vs multi-atlas and vs Naive: significant, both cohorts, both measures
- vs Rotation: significant for TERTIARY only. Primary/secondary shows
  NO significant gain over rotation-only augmentation.
- Region-wise, after FDR q=.05 over 13 sulci:
  pediatric, vs multi-atlas 12 (L) / 12 (R) of 13; vs Naive 9 / 10
  adult,     vs multi-atlas 10 (L) / 10 (R) of 13; vs Naive 13 / 13
- Context-aware training vs augmentation alone: significant on the
  AVERAGE Dice, but NO per-sulcus significance survives FDR.
- Pediatric vs adult accuracy: comparable (p > .05) for the proposed
  method. Without augmentation the two cohorts differ by ~.1 Dice
  (p < .005).

### Area distortion — exact
112.17 +/- 20.40 mm^2 left, 116.81 +/- 19.92 mm^2 right, across the
96 subjects = .1202 +/- .0180 % (L) and .1247 +/- .0183 % (R) of total
surface area.

### Graph cut (Table 2) — Dice gain, all < .01
Largest single value anywhere in the table is .0097 (multi-atlas,
pediatric left). Qualitative effect: removes tiny isolated clusters.

## Baselines — what each one is
- Multi-atlas: majority voting, LEAVE-ONE-OUT (all other subjects
  registered to the target). The paper notes this gives it an advantage
  in capturing sample variation, and it still performs worst.
- Naive: the same spherical U-Net, no augmentation at all.
- Rotation: rigid alignment for every training pair = the l=0 case of
  the proposed method.
All methods share hyperparameters, architecture, CV partitions, and
graph-cut post-processing. Only the input channel count differs.

## Compute
- Intel Xeon Silver 4114 CPU, NVIDIA Titan Xp 12 GB
- Registration: ~2 min per pair at L6 (single CPU thread)
- Reconstruction of all 11 degrees: ~5 sec
- Degree 10 chosen because deformation was marginal beyond l=10
- Test phase uses NO registration, which is what makes annotation fast

## Limitations (stated by the authors)
- Inter-rater reliability NOT measurable (labels finalised once)
- Context-aware training: no per-sulcus significance after FDR
- Graph cut improves Dice by <0.01 — mostly cosmetic
- Cannot cover folding patterns far outside the training set
- Possible bias toward larger sulci (class imbalance)

## Do not claim
- That the network architecture is novel
- That row 4200 is the SAME anatomy across brains (only approximately
  the same spherical coordinate — this residual mismatch is the
  problem the paper attacks)
- A total augmented-sample count (paper never states one; n(n-1)x11
  follows from their description but is not a quoted figure)
- Any layer count or kernel size