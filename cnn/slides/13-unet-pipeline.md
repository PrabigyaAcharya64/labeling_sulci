## U-Net — the Full Pipeline

<svg viewBox="0 60 900 446" width="900" style="max-width:100%;display:block;margin:0 auto;">
<rect x="72" y="76" width="12" height="80" fill="#EAF0FF" stroke="#1D4ED8" stroke-width="1.6"/>
<text x="78" y="172" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12" fill="#1D4ED8">input</text>
<rect x="197.5" y="76" width="7" height="80" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="192.5" y="76" width="7" height="80" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="187.5" y="76" width="7" height="80" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/>
<text x="196" y="172" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="11" fill="#6B7280">224²</text>
<rect x="200" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="195" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="190" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="185" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/>
<text x="196" y="231" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="11" fill="#6B7280">112²</text>
<rect x="202.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="197.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="192.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="187.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="182.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/>
<text x="196" y="293" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="11" fill="#6B7280">56²</text>
<rect x="437" y="315" width="7" height="30" fill="#FBEDE6" stroke="#C2410C" stroke-width="1.4"/><rect x="432" y="315" width="7" height="30" fill="#FBEDE6" stroke="#C2410C" stroke-width="1.4"/><rect x="427" y="315" width="7" height="30" fill="#FBEDE6" stroke="#C2410C" stroke-width="1.4"/><rect x="422" y="315" width="7" height="30" fill="#FBEDE6" stroke="#C2410C" stroke-width="1.4"/><rect x="417" y="315" width="7" height="30" fill="#FBEDE6" stroke="#C2410C" stroke-width="1.4"/><rect x="412" y="315" width="7" height="30" fill="#FBEDE6" stroke="#C2410C" stroke-width="1.4"/>
<text x="428" y="361" text-anchor="middle" font-family="'IBM Plex Mono', ui-monospace, monospace" font-size="11" fill="#6B7280">28²</text>
<rect x="661.5" y="76" width="7" height="80" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="656.5" y="76" width="7" height="80" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="651.5" y="76" width="7" height="80" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/>
<rect x="664" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="659" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="654" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="649" y="157" width="7" height="58" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/>
<rect x="666.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="661.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="656.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="651.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/><rect x="646.5" y="235" width="7" height="42" fill="#fff" stroke="#1D4ED8" stroke-width="1.4"/>
<line x1="84" y1="116" x2="177.5" y2="116" stroke="#6B7280" stroke-width="1.6" /><polygon points="185.5,116 177.5,120 177.5,112" fill="#6B7280" />
<text x="140" y="108" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">conv</text>
<line x1="196" y1="156" x2="196" y2="149" stroke="#6B7280" stroke-width="1.6" /><polygon points="196,157 192,149 200,149" fill="#6B7280" />
<text x="172" y="154" text-anchor="end" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">pool</text>
<line x1="196" y1="215" x2="196" y2="227" stroke="#6B7280" stroke-width="1.6" /><polygon points="196,235 192,227 200,227" fill="#6B7280" />
<text x="172" y="224" text-anchor="end" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">pool</text>
<line x1="196" y1="277" x2="402.235" y2="328.077" stroke="#6B7280" stroke-width="1.6" /><polygon points="410,330 401.273,331.959 403.196,324.194" fill="#6B7280" />
<text x="306" y="287" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">pool</text>
<line x1="446" y1="330" x2="652.235" y2="278.923" stroke="#6B7280" stroke-width="1.6" /><polygon points="660,277 653.196,282.806 651.273,275.041" fill="#6B7280" />
<text x="552" y="287" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">up-conv</text>
<line x1="660" y1="235" x2="660" y2="223" stroke="#6B7280" stroke-width="1.6" /><polygon points="660,215 664,223 656,223" fill="#6B7280" />
<text x="686" y="224" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">up-conv</text>
<line x1="660" y1="157" x2="660" y2="164" stroke="#6B7280" stroke-width="1.6" /><polygon points="660,156 664,164 656,164" fill="#6B7280" />
<text x="686" y="154" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">up-conv</text>
<line x1="206.5" y1="116" x2="641.5" y2="116" stroke="#C2410C" stroke-width="1.6" stroke-dasharray="6 5" /><polygon points="649.5,116 641.5,120 641.5,112" fill="#C2410C" />
<line x1="209" y1="186" x2="639" y2="186" stroke="#C2410C" stroke-width="1.6" stroke-dasharray="6 5" /><polygon points="647,186 639,190 639,182" fill="#C2410C" />
<line x1="211.5" y1="256" x2="636.5" y2="256" stroke="#C2410C" stroke-width="1.6" stroke-dasharray="6 5" /><polygon points="644.5,256 636.5,260 636.5,252" fill="#C2410C" />
<text x="428" y="100" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12" fill="#C2410C">copy + concatenate</text>
<line x1="670.5" y1="116" x2="804" y2="116" stroke="#6B7280" stroke-width="1.6" /><polygon points="812,116 804,120 804,112" fill="#6B7280" />
<text x="760" y="108" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="11" fill="#6B7280">1×1 conv</text>
<rect x="812" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="828" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="836" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="844" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="852" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="860" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="868" y="84" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="92" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="92" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="828" y="92" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="836" y="92" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="844" y="92" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="852" y="92" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="860" y="92" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="868" y="92" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="100" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="100" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="828" y="100" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="836" y="100" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="844" y="100" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="852" y="100" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="860" y="100" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="868" y="100" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="108" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="108" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="828" y="108" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="836" y="108" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="844" y="108" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="852" y="108" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="860" y="108" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="868" y="108" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="116" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="116" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="828" y="116" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="836" y="116" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="844" y="116" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="852" y="116" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="860" y="116" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="868" y="116" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="124" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="124" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="828" y="124" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="836" y="124" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="844" y="124" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="852" y="124" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="860" y="124" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="868" y="124" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="132" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="132" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="828" y="132" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="836" y="132" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="844" y="132" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="852" y="132" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="860" y="132" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="868" y="132" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="140" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="820" y="140" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="828" y="140" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="836" y="140" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="844" y="140" width="8.4" height="8.4" fill="#C2410C"/>
<rect x="852" y="140" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="860" y="140" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="868" y="140" width="8.4" height="8.4" fill="#D9DCE1"/>
<rect x="812" y="84" width="64" height="64" fill="none" stroke="#C2410C" stroke-width="1.6"/>
<text x="844" y="172" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="12" fill="#C2410C">labels</text>
<line x1="150" y1="486" x2="176" y2="486" stroke="#6B7280" stroke-width="1.6"/>
<text x="182" y="490" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="12" fill="#6B7280">conv</text>
<text x="258" y="490" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="12" fill="#6B7280">│ pool</text>
<text x="330" y="490" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="12" fill="#6B7280">│ up-conv</text>
<line x1="430" y1="486" x2="456" y2="486" stroke="#C2410C" stroke-width="1.6" stroke-dasharray="6 5"/>
<text x="462" y="490" text-anchor="start" font-family="Inter, system-ui, sans-serif" font-size="12" fill="#C2410C">skip (copy)</text>
<text x="430" y="74" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="14" fill="#6B7280">contracting  →  expanding · maps shrink then rebuild, skips restore detail</text>
</svg>
