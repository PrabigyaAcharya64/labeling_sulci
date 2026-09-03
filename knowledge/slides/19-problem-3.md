## Problem 3 — Too Few Brains

<svg viewBox="0 0 900 506" width="900" style="max-width: 100%; display: block; margin: 0 auto;">
<defs>
  <pattern id="wantGrid" width="8" height="8" patternUnits="userSpaceOnUse">
    <rect x="0" y="0" width="6" height="6" fill="none" stroke="#E5E7EB" stroke-width="1" />
  </pattern>
  <g id="folds" fill="none" stroke="#1D4ED8" stroke-width="2" stroke-linecap="round">
    <path d="M -23,-9 Q -8,-20 10,-15" />
    <path d="M -25,4 Q -5,-6 17,2" />
    <path d="M -19,17 Q 1,9 21,16" />
    <path d="M 8,-22 Q 16,-8 11,8" />
  </g>
</defs>
<g class="fragment">
  <g fill="#6B7280">
    <rect x="92" y="167" width="6" height="6" /><rect x="100" y="167" width="6" height="6" />
    <rect x="108" y="167" width="6" height="6" /><rect x="116" y="167" width="6" height="6" />
    <rect x="124" y="167" width="6" height="6" /><rect x="132" y="167" width="6" height="6" />
    <rect x="92" y="175" width="6" height="6" /><rect x="100" y="175" width="6" height="6" />
    <rect x="108" y="175" width="6" height="6" /><rect x="116" y="175" width="6" height="6" />
    <rect x="124" y="175" width="6" height="6" /><rect x="132" y="175" width="6" height="6" />
    <rect x="92" y="183" width="6" height="6" /><rect x="100" y="183" width="6" height="6" />
    <rect x="108" y="183" width="6" height="6" /><rect x="116" y="183" width="6" height="6" />
    <rect x="124" y="183" width="6" height="6" /><rect x="132" y="183" width="6" height="6" />
    <rect x="92" y="191" width="6" height="6" /><rect x="100" y="191" width="6" height="6" />
    <rect x="108" y="191" width="6" height="6" /><rect x="116" y="191" width="6" height="6" />
    <rect x="124" y="191" width="6" height="6" /><rect x="132" y="191" width="6" height="6" />
    <rect x="92" y="199" width="6" height="6" /><rect x="100" y="199" width="6" height="6" />
    <rect x="108" y="199" width="6" height="6" /><rect x="116" y="199" width="6" height="6" />
    <rect x="124" y="199" width="6" height="6" /><rect x="132" y="199" width="6" height="6" />
    <rect x="92" y="207" width="6" height="6" /><rect x="100" y="207" width="6" height="6" />
    <rect x="108" y="207" width="6" height="6" /><rect x="116" y="207" width="6" height="6" />
    <rect x="124" y="207" width="6" height="6" /><rect x="132" y="207" width="6" height="6" />
  </g>
  <text x="115" y="318" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280"><tspan font-family="'IBM Plex Mono', ui-monospace, monospace">36</tspan> training hemispheres</text>
</g>
<g class="fragment">
  <rect x="210" y="110" width="240" height="160" fill="url(#wantGrid)" />
  <text x="330" y="318" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">what a network wants</text>
</g>
<g class="fragment">
  <g fill="none" stroke="#E5E7EB" stroke-width="1.5">
    <circle cx="524" cy="190" r="34" /><circle cx="614" cy="190" r="34" />
    <circle cx="704" cy="190" r="34" /><circle cx="794" cy="190" r="34" />
  </g>
  <g transform="translate(524,190) rotate(25)"><use href="#folds" /></g>
  <g transform="translate(614,190) rotate(100)"><use href="#folds" /></g>
  <g transform="translate(704,190) scale(-1,1)"><use href="#folds" /></g>
  <g transform="translate(794,190) rotate(-140)"><use href="#folds" /></g>
  <g font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280" text-anchor="middle">
    <text x="524" y="140">rotate</text><text x="614" y="140">rotate</text>
    <text x="704" y="140">flip</text><text x="794" y="140">rotate</text>
  </g>
  <text x="659" y="318" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">same folds, different orientation</text>
  <text x="450" y="410" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="18" fill="#C2410C">rotation changes position, not folding</text>
</g>
</svg>
