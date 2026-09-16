## The U Shape

<svg viewBox="0 70 900 430" width="900" style="max-width:100%;display:block;margin:0 auto;">
<g class="fragment">
<rect x="81" y="82" width="30" height="92" fill="#EAF0FF" stroke="#1D4ED8" stroke-width="2" rx="2"/>
<text x="96" y="192" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#1D4ED8">input</text>
<line x1="112" y1="128" x2="234" y2="128" stroke="#6B7280" stroke-width="1.6" /><polygon points="242,128 234,132 234,124" fill="#6B7280" />
<rect x="242" y="82" width="16" height="92" fill="#fff" stroke="#1D4ED8" stroke-width="2" rx="2"/>
<rect x="237" y="172" width="26" height="66" fill="#fff" stroke="#1D4ED8" stroke-width="2" rx="2"/>
<rect x="231" y="259" width="38" height="46" fill="#fff" stroke="#1D4ED8" stroke-width="2" rx="2"/>
<line x1="250" y1="174" x2="250" y2="180" stroke="#6B7280" stroke-width="1.6" /><polygon points="250,172 254,180 246,180" fill="#6B7280" />
<line x1="250" y1="238" x2="250" y2="251" stroke="#6B7280" stroke-width="1.6" /><polygon points="250,259 246,251 254,251" fill="#6B7280" />
<text x="150" y="320" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#1D4ED8">encoder</text>
<text x="150" y="340" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#6B7280">downsample · learn what</text>
</g>
<g class="fragment">
<line x1="250" y1="305" x2="415.28" y2="349.903" stroke="#6B7280" stroke-width="1.6" /><polygon points="423,352 414.231,353.763 416.329,346.043" fill="#6B7280" />
<rect x="423" y="335" width="54" height="34" fill="#FBEDE6" stroke="#C2410C" stroke-width="2" rx="2"/>
<text x="450" y="387" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#C2410C">bottleneck</text>
</g>
<g class="fragment">
<line x1="477" y1="352" x2="642.28" y2="307.097" stroke="#6B7280" stroke-width="1.6" /><polygon points="650,305 643.329,310.957 641.231,303.237" fill="#6B7280" />
<rect x="642" y="82" width="16" height="92" fill="#fff" stroke="#1D4ED8" stroke-width="2" rx="2"/>
<rect x="637" y="172" width="26" height="66" fill="#fff" stroke="#1D4ED8" stroke-width="2" rx="2"/>
<rect x="631" y="259" width="38" height="46" fill="#fff" stroke="#1D4ED8" stroke-width="2" rx="2"/>
<line x1="650" y1="259" x2="650" y2="246" stroke="#6B7280" stroke-width="1.6" /><polygon points="650,238 654,246 646,246" fill="#6B7280" />
<line x1="650" y1="172" x2="650" y2="166" stroke="#6B7280" stroke-width="1.6" /><polygon points="650,174 646,166 654,166" fill="#6B7280" />
<text x="750" y="320" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#1D4ED8">decoder</text>
<text x="750" y="340" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#6B7280">upsample · rebuild where</text>
</g>
<g class="fragment">
<line x1="258" y1="128" x2="634" y2="128" stroke="#C2410C" stroke-width="1.8" stroke-dasharray="6 5" /><polygon points="642,128 634,132 634,124" fill="#C2410C" />
<line x1="263" y1="205" x2="629" y2="205" stroke="#C2410C" stroke-width="1.8" stroke-dasharray="6 5" /><polygon points="637,205 629,209 629,201" fill="#C2410C" />
<line x1="269" y1="282" x2="623" y2="282" stroke="#C2410C" stroke-width="1.8" stroke-dasharray="6 5" /><polygon points="631,282 623,286 623,278" fill="#C2410C" />
<text x="450" y="456" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="15" fill="#C2410C">skip connections (orange) copy fine detail straight across</text>
</g>
<g class="fragment">
<line x1="658" y1="128" x2="766" y2="128" stroke="#6B7280" stroke-width="1.6" /><polygon points="774,128 766,132 766,124" fill="#6B7280" />
<rect x="789" y="82" width="30" height="92" fill="#FBEDE6" stroke="#C2410C" stroke-width="2" rx="2"/>
<text x="804" y="192" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="13" fill="#C2410C">labels</text>
<text x="450" y="486" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#6B7280">same size in, same size out — a class for every pixel</text>
</g></svg>
