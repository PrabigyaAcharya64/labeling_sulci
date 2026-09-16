## The Steps

<svg viewBox="0 70 900 380" width="900" style="max-width:100%;display:block;margin:0 auto;">
<g class="fragment">
<text x="150" y="118" text-anchor="end" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="22" fill="#C2410C">1</text>
<text x="178" y="118" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="21" fill="#1A1A1A">an image is just a grid of numbers</text>
</g>
<g class="fragment">
<text x="150" y="164" text-anchor="end" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="22" fill="#C2410C">2</text>
<text x="178" y="164" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="21" fill="#1A1A1A">a small kernel slides across it — convolution</text>
</g>
<g class="fragment">
<text x="150" y="210" text-anchor="end" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="22" fill="#C2410C">3</text>
<text x="178" y="210" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="21" fill="#1A1A1A">ReLU keeps the strong responses, zeros the rest</text>
</g>
<g class="fragment">
<text x="150" y="256" text-anchor="end" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="22" fill="#C2410C">4</text>
<text x="178" y="256" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="21" fill="#1A1A1A">pooling shrinks the map, keeps the peaks</text>
</g>
<g class="fragment">
<text x="150" y="302" text-anchor="end" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="22" fill="#C2410C">5</text>
<text x="178" y="302" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="21" fill="#1A1A1A">repeat — deeper layers see larger patterns</text>
</g>
<g class="fragment">
<text x="150" y="348" text-anchor="end" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="22" fill="#C2410C">6</text>
<text x="178" y="348" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="21" fill="#1A1A1A">flatten the final maps into one long vector</text>
</g>
<g class="fragment">
<text x="150" y="394" text-anchor="end" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="22" fill="#C2410C">7</text>
<text x="178" y="394" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="21" fill="#1A1A1A">a dense layer turns the vector into class scores</text>
</g></svg>
