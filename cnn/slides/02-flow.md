## The Whole Network

<svg viewBox="0 120 900 260" width="900" style="max-width:100%;display:block;margin:0 auto;">
<g class="fragment">
<line x1="106" y1="205" x2="117" y2="205" stroke="#6B7280" stroke-width="1.6" /><polygon points="124,205 117,201 117,209" fill="#6B7280" />
<line x1="208" y1="205" x2="219" y2="205" stroke="#6B7280" stroke-width="1.6" /><polygon points="226,205 219,201 219,209" fill="#6B7280" />
<line x1="310" y1="205" x2="321" y2="205" stroke="#6B7280" stroke-width="1.6" /><polygon points="328,205 321,201 321,209" fill="#6B7280" />
<line x1="412" y1="205" x2="423" y2="205" stroke="#6B7280" stroke-width="1.6" /><polygon points="430,205 423,201 423,209" fill="#6B7280" />
<line x1="514" y1="205" x2="525" y2="205" stroke="#6B7280" stroke-width="1.6" /><polygon points="532,205 525,201 525,209" fill="#6B7280" />
<line x1="616" y1="205" x2="627" y2="205" stroke="#6B7280" stroke-width="1.6" /><polygon points="634,205 627,201 627,209" fill="#6B7280" />
<rect x="22" y="175" width="84" height="60" fill="none" stroke="#1D4ED8" stroke-width="2" rx="3"/>
<text x="64" y="203" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#1D4ED8">input</text>
<text x="64" y="221" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12.5" fill="#6B7280">image</text>
<text x="64" y="261" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="13" fill="#6B7280">H×W×3</text>
<rect x="124" y="175" width="84" height="60" fill="none" stroke="#C2410C" stroke-width="2" rx="3"/>
<text x="166" y="203" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#C2410C">conv</text>
<text x="166" y="221" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12.5" fill="#6B7280">+ ReLU</text>
<text x="166" y="261" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="13" fill="#6B7280">feature maps</text>
<rect x="226" y="175" width="84" height="60" fill="none" stroke="#6B7280" stroke-width="2" rx="3"/>
<text x="268" y="203" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#6B7280">pool</text>
<text x="268" y="221" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12.5" fill="#6B7280">downsample</text>
<text x="268" y="261" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="13" fill="#6B7280">smaller</text>
<rect x="328" y="175" width="84" height="60" fill="none" stroke="#C2410C" stroke-width="2" rx="3"/>
<text x="370" y="203" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#C2410C">conv</text>
<text x="370" y="221" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12.5" fill="#6B7280">+ ReLU</text>
<text x="370" y="261" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="13" fill="#6B7280">more maps</text>
<rect x="430" y="175" width="84" height="60" fill="none" stroke="#6B7280" stroke-width="2" rx="3"/>
<text x="472" y="203" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#6B7280">pool</text>
<text x="472" y="221" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12.5" fill="#6B7280">downsample</text>
<text x="472" y="261" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="13" fill="#6B7280">smaller</text>
<rect x="532" y="175" width="84" height="60" fill="none" stroke="#6B7280" stroke-width="2" rx="3"/>
<text x="574" y="203" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#6B7280">flatten</text>
<text x="574" y="221" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12.5" fill="#6B7280">to vector</text>
<text x="574" y="261" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="13" fill="#6B7280">1-D</text>
<rect x="634" y="175" width="84" height="60" fill="none" stroke="#1A1A1A" stroke-width="2" rx="3"/>
<text x="676" y="203" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="17" fill="#1A1A1A">dense</text>
<text x="676" y="221" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12.5" fill="#6B7280">fully conn.</text>
<text x="676" y="261" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="13" fill="#6B7280">classes</text>
<line x1="718" y1="205" x2="759" y2="205" stroke="#1A1A1A" stroke-width="1.6" /><polygon points="766,205 759,201 759,209" fill="#1A1A1A" />
<text x="798" y="210" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="16" fill="#1A1A1A">label</text>
</g>
<g class="fragment">
<line x1="22" y1="330" x2="718" y2="330" stroke="#E5E7EB" stroke-width="1"/>
<text x="166" y="352" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#C2410C">feature extraction</text>
<text x="575.2" y="352" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#1A1A1A">classification</text>
</g>
</svg>
