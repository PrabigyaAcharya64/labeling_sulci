## Solution to Problem 1 & 2

<svg viewBox="0 0 900 506" width="900" style="max-width: 100%; display: block; margin: 0 auto;">
<defs>
  <g id="scatA" fill="#6B7280">
    <circle cx="-24" cy="-11" r="2.5" /><circle cx="-9" cy="-19" r="2.5" /><circle cx="7" cy="-16" r="2.5" />
    <circle cx="22" cy="-6" r="2.5" /><circle cx="29" cy="7" r="2.5" /><circle cx="15" cy="19" r="2.5" />
    <circle cx="-1" cy="22" r="2.5" /><circle cx="-16" cy="15" r="2.5" /><circle cx="-29" cy="2" r="2.5" />
    <circle cx="0" cy="2" r="2.5" /><circle cx="12" cy="-2" r="2.5" /><circle cx="-12" cy="5" r="2.5" />
  </g>
  <g id="scatB" fill="#6B7280">
    <circle cx="-19" cy="-15" r="2.5" /><circle cx="-4" cy="-19" r="2.5" /><circle cx="12" cy="-14" r="2.5" />
    <circle cx="27" cy="-4" r="2.5" /><circle cx="24" cy="11" r="2.5" /><circle cx="10" cy="21" r="2.5" />
    <circle cx="-6" cy="17" r="2.5" /><circle cx="-21" cy="9" r="2.5" /><circle cx="-32" cy="-4" r="2.5" />
    <circle cx="4" cy="0" r="2.5" /><circle cx="17" cy="2" r="2.5" /><circle cx="-11" cy="-2" r="2.5" />
  </g>
  <g id="sten2" fill="#1D9E75">
    <circle cx="0" cy="0" r="3" />
    <circle cx="18" cy="0" r="3" /><circle cx="9" cy="16" r="3" /><circle cx="-9" cy="16" r="3" />
    <circle cx="-18" cy="0" r="3" /><circle cx="-9" cy="-16" r="3" /><circle cx="9" cy="-16" r="3" />
    <circle cx="36" cy="0" r="3" /><circle cx="31" cy="18" r="3" /><circle cx="18" cy="31" r="3" />
    <circle cx="0" cy="36" r="3" /><circle cx="-18" cy="31" r="3" /><circle cx="-31" cy="18" r="3" />
    <circle cx="-36" cy="0" r="3" /><circle cx="-31" cy="-18" r="3" /><circle cx="-18" cy="-31" r="3" />
    <circle cx="0" cy="-36" r="3" /><circle cx="18" cy="-31" r="3" /><circle cx="31" cy="-18" r="3" />
  </g>
</defs>
<g class="fragment">
  <text x="165" y="62" text-anchor="middle" font-family="Newsreader, Georgia, serif" font-size="20" fill="#1A1A1A">two brains</text>
  <g fill="none" stroke="#1D4ED8" stroke-width="2" stroke-linejoin="round" vector-effect="non-scaling-stroke">
    <polygon transform="translate(165,140) scale(0.62)" points="-75,-11 -58,-36 -28,-49 -2,-39 18,-53 50,-43 75,-19 82,11 65,39 35,55 2,61 -32,51 -60,29 -72,9" />
    <polygon transform="translate(165,258) scale(0.62)" points="-79,1 -66,-27 -39,-41 -12,-31 14,-47 44,-37 68,-47 86,-21 78,9 56,35 24,49 -6,41 -32,57 -62,43 -78,21" />
  </g>
  <use href="#scatA" transform="translate(165,140)" />
  <use href="#scatB" transform="translate(165,258)" />
  <text x="165" y="340" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">different shapes · different points</text>
</g>
<g class="fragment">
  <line x1="289" y1="199" x2="323" y2="199" stroke="#6B7280" stroke-width="1.5" />
  <polygon points="331,199 321,194 321,204" fill="#6B7280" />
  <text x="450" y="62" text-anchor="middle" font-family="Newsreader, Georgia, serif" font-size="20" fill="#1A1A1A">sphere</text>
  <g fill="none" stroke="#1D4ED8" stroke-width="2">
    <circle cx="450" cy="140" r="48" /><circle cx="450" cy="258" r="48" />
  </g>
  <use href="#scatA" transform="translate(450,140)" />
  <use href="#scatB" transform="translate(450,258)" />
  <text x="450" y="340" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">same shape · points still differ</text>
</g>
<g class="fragment">
  <line x1="574" y1="199" x2="608" y2="199" stroke="#6B7280" stroke-width="1.5" />
  <polygon points="616,199 606,194 606,204" fill="#6B7280" />
  <text x="735" y="62" text-anchor="middle" font-family="Newsreader, Georgia, serif" font-size="20" fill="#1A1A1A">stencil</text>
  <g fill="none" stroke="#1D4ED8" stroke-width="2">
    <circle cx="735" cy="140" r="48" /><circle cx="735" cy="258" r="48" />
  </g>
  <g opacity="0.4">
    <use href="#scatA" transform="translate(735,140)" />
    <use href="#scatB" transform="translate(735,258)" />
  </g>
  <use href="#sten2" transform="translate(735,140)" />
  <use href="#sten2" transform="translate(735,258)" />
  <text x="735" y="340" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">same points · every brain</text>
</g>
<g class="fragment">
  <g font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#1A1A1A" text-anchor="middle">
    <text x="450" y="392">sphere → solves correspondence</text>
    <text x="450" y="416">stencil → solves neighbours and count</text>
  </g>
  <text x="450" y="456" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="16" fill="#6B7280">10,242 points · the same in every brain</text>
</g>
</svg>
