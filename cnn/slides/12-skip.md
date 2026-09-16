## Why Skip Connections

<svg viewBox="0 80 900 400" width="900" style="max-width:100%;display:block;margin:0 auto;">
<g class="fragment">
<text x="450" y="140" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="20" fill="#1A1A1A">Downsampling learns WHAT is there, but blurs away WHERE.</text>
</g>
<g class="fragment">
<rect x="120" y="285" width="70" height="70" fill="none" stroke="#1D4ED8" stroke-width="2"/>
<text x="155" y="372" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#6B7280">full detail</text>
<line x1="190" y1="320" x2="248" y2="320" stroke="#6B7280" stroke-width="1.6"/><polygon points="256,320 248,316 248,324" fill="#6B7280"/>
<rect x="256" y="305" width="30" height="30" fill="none" stroke="#1D4ED8" stroke-width="2"/>
<text x="271" y="372" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#6B7280">coarse</text>
<line x1="286" y1="320" x2="344" y2="320" stroke="#6B7280" stroke-width="1.6"/><polygon points="352,320 344,316 344,324" fill="#6B7280"/>
<rect x="352" y="305" width="30" height="30" fill="none" stroke="#1D4ED8" stroke-width="2"/>
<line x1="382" y1="320" x2="440" y2="320" stroke="#6B7280" stroke-width="1.6"/><polygon points="448,320 440,316 440,324" fill="#6B7280"/>
<rect x="448" y="285" width="70" height="70" fill="none" stroke="#1D4ED8" stroke-width="2"/>
<text x="483" y="372" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#6B7280">upsampled</text>
<text x="320" y="272" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#6B7280">the coarse route loses the edges</text>
</g>
<g class="fragment">
<path d="M 155,283 C 220,205 418,205 483,283" fill="none" stroke="#C2410C" stroke-width="2" stroke-dasharray="6 5"/>
<polygon points="483,283 477,273 489,273" fill="#C2410C"/>
<text x="320" y="200" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#C2410C">skip: carry the sharp detail forward</text>
<text x="450" y="430" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#6B7280">so the decoder places each label exactly where it belongs</text>
</g></svg>
