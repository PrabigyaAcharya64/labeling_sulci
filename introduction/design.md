# DESIGN.md — build rules

## Stack
Reveal.js, slides in external Markdown, loaded per section.

introduction/
  index.html          reveal init + all custom CSS
  facts.md            source of truth for every claim
  slides/
    01-sulci.md
    02-types.md
    03-why.md
    04-preprocessing.md
    05-augmentation.md
    06-training.md
    07-inference.md
    08-results.md
    09-limitations.md
    10-takeaway.md
  figs/               screenshots of paper Figures 1, 2, 3, 5

Run: `python3 serve.py` from the project root, open localhost:8000/introduction/

## Slide content — the core rule
Slides carry a HEADING and a VISUAL. Nothing else.
No bullet points. No sentences. No body text.
The presenter explains verbally.

If a slide has no visual, it needs only the heading.
Exception: numbers and labels inside diagrams, which are part of
the visual.

## Markdown syntax
`---` new slide
`<!-- .element: class="fragment" -->` reveal on click

Flat horizontal deck only. No vertical sub-slides — they conflict
with the ↓ binding below.

## Navigation — behave like PowerPoint
→ / Space   advance one animation step; when none remain, next slide
←           step back through steps, then previous slide
↓           jump to next slide, skipping any remaining steps
↑           jump to previous slide
Esc         overview grid
F           fullscreen
B           blank screen

```js
Reveal.initialize({
  plugins: [ RevealMarkdown ],
  navigationMode: 'linear',
  transition: 'fade',
  transitionSpeed: 'fast',
  controls: false,
  progress: false,
  slideNumber: false,
  hash: true,
  fragments: true
});

Reveal.addKeyBinding({ keyCode: 40, key: '↓', description: 'Next slide' },
  () => Reveal.slide(Reveal.getIndices().h + 1, 0));
Reveal.addKeyBinding({ keyCode: 38, key: '↑', description: 'Prev slide' },
  () => Reveal.slide(Math.max(0, Reveal.getIndices().h - 1), 0));
```

Fragments fire in document order. Use `data-fragment-index` only when
reveal order must differ from source order.

## Colour — meaning only, never decoration
--bg      #FFFFFF   pure white, no gradients
--ink     #1A1A1A   headings
--muted   #6B7280   labels
--new     #C2410C   the paper's contribution
--old     #1D4ED8   borrowed / setup / baselines
--rule    #E5E7EB   hairlines
No shadows, no cards, no dark mode, no seventh colour.

## Type
Headings  serif, 44px  (Newsreader / Georgia)
Labels    sans, 18px+  (Inter / system-ui)
Numbers   mono         (IBM Plex Mono)
Diagram labels never below 16px — must survive projection.

## Diagrams
Inline SVG, hand-authored, flat 2D.
Label directly on the diagram. Avoid legends.
Generous white space — do not fill the slide.

Paper Figures 1, 2, 3, 5: screenshot into figs/, place as <img>.
Do not redraw them.

Custom SVGs only for what the paper does not illustrate:
the stencil, spherical-harmonic truncation, the 3→9 channel flow.

## Animation
Sequencing, not decoration.
- `fragment` class for step reveals, max 5 per slide
- CSS transitions 200–400ms ease-out
- No bounce, spin, or fly-in
- Continuous change (fold→sphere, warp trajectory): a slider the
  presenter drags. More reliable live than autoplay.
- Respect prefers-reduced-motion

## Accuracy
Check facts.md before any factual claim.
Never state a number absent from facts.md.
Never imply the architecture is novel.
Mark preprocessing explicitly as borrowed setup.

## Section weight
05-augmentation is the longest — it is the contribution.
01–04 are setup. 07–10 are verification.

## Do not
Emoji, icons, stock images, per-slide logos, slide numbers,
typewriter text, more than the six colours above.