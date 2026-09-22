## Problem 1 — Irregular Neighbourhoods

<svg viewBox="0 0 900 506" width="900" style="max-width: 100%; display: block; margin: 0 auto;">
<g class="fragment">
  <text x="225" y="62" text-anchor="middle" font-family="Newsreader, Georgia, serif" font-size="22" fill="#1A1A1A">image grid</text>
  <text x="675" y="62" text-anchor="middle" font-family="Newsreader, Georgia, serif" font-size="22" fill="#1A1A1A">cortical mesh</text>
  <g stroke="#E5E7EB" stroke-width="1">
    <line x1="105" y1="90" x2="105" y2="330" /><line x1="145" y1="90" x2="145" y2="330" />
    <line x1="185" y1="90" x2="185" y2="330" /><line x1="225" y1="90" x2="225" y2="330" />
    <line x1="265" y1="90" x2="265" y2="330" /><line x1="305" y1="90" x2="305" y2="330" />
    <line x1="345" y1="90" x2="345" y2="330" />
    <line x1="105" y1="90"  x2="345" y2="90"  /><line x1="105" y1="130" x2="345" y2="130" />
    <line x1="105" y1="170" x2="345" y2="170" /><line x1="105" y1="210" x2="345" y2="210" />
    <line x1="105" y1="250" x2="345" y2="250" /><line x1="105" y1="290" x2="345" y2="290" />
    <line x1="105" y1="330" x2="345" y2="330" />
  </g>
  <g fill="none" stroke="#E5E7EB" stroke-width="1">
    <polygon points="640,190 712,215 672,248" /><polygon points="640,190 672,248 620,252" />
    <polygon points="640,190 620,252 578,215" /><polygon points="640,190 578,215 568,175" />
    <polygon points="640,190 568,175 600,150" /><polygon points="640,190 600,150 655,140" />
    <polygon points="640,190 655,140 705,168" /><polygon points="640,190 705,168 712,215" />
    <polygon points="770,265 820,315 735,308" /><polygon points="770,265 735,308 712,215" />
    <polygon points="770,265 712,215 790,205" /><polygon points="770,265 790,205 838,250" />
    <polygon points="770,265 838,250 820,315" />
    <polygon points="672,248 712,215 735,308" /><polygon points="672,248 735,308 650,318" />
    <polygon points="620,252 672,248 650,318" /><polygon points="620,252 650,318 585,305" />
    <polygon points="578,215 620,252 585,305" /><polygon points="578,215 585,305 528,235" />
    <polygon points="578,215 528,235 568,175" /><polygon points="568,175 528,235 545,160" />
    <polygon points="568,175 545,160 592,105" /><polygon points="568,175 592,105 600,150" />
    <polygon points="600,150 592,105 660,92" /><polygon points="600,150 660,92 655,140" />
    <polygon points="655,140 660,92 722,112" /><polygon points="655,140 722,112 705,168" />
    <polygon points="705,168 722,112 790,205" /><polygon points="705,168 790,205 712,215" />
    <polygon points="722,112 800,130 790,205" /><polygon points="790,205 800,130 838,250" />
  </g>
  <g fill="#6B7280" opacity="0.45">
    <circle cx="640" cy="190" r="2" /><circle cx="600" cy="150" r="2" /><circle cx="655" cy="140" r="2" />
    <circle cx="705" cy="168" r="2" /><circle cx="712" cy="215" r="2" /><circle cx="672" cy="248" r="2" />
    <circle cx="620" cy="252" r="2" /><circle cx="578" cy="215" r="2" /><circle cx="568" cy="175" r="2" />
    <circle cx="770" cy="265" r="2" /><circle cx="790" cy="205" r="2" /><circle cx="838" cy="250" r="2" />
    <circle cx="820" cy="315" r="2" /><circle cx="735" cy="308" r="2" /><circle cx="585" cy="305" r="2" />
    <circle cx="650" cy="318" r="2" /><circle cx="528" cy="235" r="2" /><circle cx="545" cy="160" r="2" />
    <circle cx="592" cy="105" r="2" /><circle cx="660" cy="92" r="2" /><circle cx="722" cy="112" r="2" />
    <circle cx="800" cy="130" r="2" />
  </g>
  <text x="225" y="374" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="18" fill="#6B7280">every pixel: 8 neighbours, same arrangement</text>
  <text x="675" y="374" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="18" fill="#6B7280">neighbour count varies from vertex to vertex</text>
</g>
<g class="fragment">
  <g fill="#1D4ED8">
    <rect x="145" y="130" width="40" height="40" /><rect x="265" y="210" width="40" height="40" />
  </g>
  <g fill="none" stroke="#1D4ED8" stroke-width="1.5">
    <rect x="109" y="94"  width="32" height="32" /><rect x="149" y="94"  width="32" height="32" />
    <rect x="189" y="94"  width="32" height="32" /><rect x="109" y="134" width="32" height="32" />
    <rect x="189" y="134" width="32" height="32" /><rect x="109" y="174" width="32" height="32" />
    <rect x="149" y="174" width="32" height="32" /><rect x="189" y="174" width="32" height="32" />
    <rect x="229" y="174" width="32" height="32" /><rect x="269" y="174" width="32" height="32" />
    <rect x="309" y="174" width="32" height="32" /><rect x="229" y="214" width="32" height="32" />
    <rect x="309" y="214" width="32" height="32" /><rect x="229" y="254" width="32" height="32" />
    <rect x="269" y="254" width="32" height="32" /><rect x="309" y="254" width="32" height="32" />
  </g>
</g>
<g class="fragment">
  <g stroke="#C2410C" stroke-width="2">
    <line x1="640" y1="190" x2="712" y2="215" /><line x1="640" y1="190" x2="672" y2="248" />
    <line x1="640" y1="190" x2="620" y2="252" /><line x1="640" y1="190" x2="578" y2="215" />
    <line x1="640" y1="190" x2="568" y2="175" /><line x1="640" y1="190" x2="600" y2="150" />
    <line x1="640" y1="190" x2="655" y2="140" /><line x1="640" y1="190" x2="705" y2="168" />
    <line x1="770" y1="265" x2="820" y2="315" /><line x1="770" y1="265" x2="735" y2="308" />
    <line x1="770" y1="265" x2="712" y2="215" /><line x1="770" y1="265" x2="790" y2="205" />
    <line x1="770" y1="265" x2="838" y2="250" />
  </g>
  <g fill="#C2410C">
    <circle cx="640" cy="190" r="6" /><circle cx="770" cy="265" r="6" />
  </g>
  <g font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="19" fill="#C2410C" stroke="#FFFFFF" stroke-width="4" paint-order="stroke" text-anchor="middle">
    <text x="640" y="171">8</text>
    <text x="770" y="246">5</text>
  </g>
  <text x="450" y="446" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="18" fill="#6B7280">a convolution kernel cannot slide over an irregular neighbourhood</text>
</g>
</svg>
