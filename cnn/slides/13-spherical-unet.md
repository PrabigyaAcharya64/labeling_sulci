## On the Sphere

<svg viewBox="0 80 900 380" width="900" style="max-width:100%;display:block;margin:0 auto;">
<g class="fragment">
<circle cx="190" cy="250" r="78" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
<ellipse cx="190" cy="250" rx="32.76" ry="78" fill="none" stroke="#E5E7EB" stroke-width="1"/>
<ellipse cx="190" cy="250" rx="78" ry="31.2" fill="none" stroke="#E5E7EB" stroke-width="1"/>
<text x="190" y="150" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#1D4ED8">features on each vertex</text>
<text x="190" y="352" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="14" fill="#6B7280">3 numbers per vertex</text>
</g>
<g class="fragment">
<line x1="280" y1="250" x2="352" y2="250" stroke="#6B7280" stroke-width="1.6" /><polygon points="360,250 352,254 352,246" fill="#6B7280" />
<rect x="366" y="212" width="168" height="76" rx="6" fill="none" stroke="#C2410C" stroke-width="2"/>
<text x="450" y="246" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#C2410C">spherical U-Net</text>
<text x="450" y="270" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#6B7280">same U, on the mesh</text>
<line x1="540" y1="250" x2="612" y2="250" stroke="#6B7280" stroke-width="1.6" /><polygon points="620,250 612,254 612,246" fill="#6B7280" />
</g>
<g class="fragment">
<circle cx="710" cy="250" r="78" fill="#FAFAFA" stroke="#E5E7EB" stroke-width="1.5"/>
<ellipse cx="710" cy="250" rx="32.76" ry="78" fill="none" stroke="#E5E7EB" stroke-width="1"/>
<ellipse cx="710" cy="250" rx="78" ry="31.2" fill="none" stroke="#E5E7EB" stroke-width="1"/>
<circle cx="680" cy="230" r="7" fill="#C2410C"/>
<circle cx="720" cy="216" r="7" fill="#C2410C"/>
<circle cx="738" cy="256" r="7" fill="#C2410C"/>
<circle cx="696" cy="280" r="7" fill="#C2410C"/>
<circle cx="750" cy="244" r="7" fill="#C2410C"/>
<text x="710" y="150" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#C2410C">a label on each vertex</text>
<text x="710" y="352" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="14" fill="#6B7280">14 classes per vertex</text>
<text x="450" y="438" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">unmodified spherical U-Net (Jiang et al. 2019) — 3 features in, 14 classes out</text>
</g></svg>
