## Inference

<svg viewBox="0 124 900 262" width="900" style="max-width: 100%; display: block; margin: 0 auto;">
<g class="fragment">
<line x1="124" y1="177" x2="139" y2="177" stroke="#6B7280" stroke-width="1.6" /><polygon points="146,177 139,173 139,181" fill="#6B7280" />
<rect x="20" y="148" width="104" height="58" fill="none" stroke="#6B7280" stroke-width="2" />
<text x="72" y="183" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#1A1A1A">new brain</text>
<text x="72" y="236" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">MRI in</text>
<rect x="146" y="148" width="104" height="58" fill="none" stroke="#6B7280" stroke-width="2" />
<text x="198" y="183" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#1A1A1A">preprocess</text>
<text x="198" y="236" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">3 features,</text>
<text x="198" y="255" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">10,242 points</text>
</g>
<g class="fragment">
<line x1="250" y1="177" x2="265" y2="177" stroke="#6B7280" stroke-width="1.6" /><polygon points="272,177 265,173 265,181" fill="#6B7280" />
<line x1="376" y1="177" x2="391" y2="177" stroke="#6B7280" stroke-width="1.6" /><polygon points="398,177 391,173 391,181" fill="#6B7280" />
<rect x="272" y="148" width="104" height="58" fill="none" stroke="#C2410C" stroke-width="2" />
<text x="324" y="183" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#C2410C">stage 1</text>
<text x="324" y="236" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">6 easy sulci</text>
<rect x="398" y="148" width="104" height="58" fill="none" stroke="#C2410C" stroke-width="2" />
<text x="450" y="183" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#C2410C">stage 2</text>
<text x="450" y="236" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">all 13 sulci</text>
</g>
<g class="fragment">
<line x1="502" y1="177" x2="517" y2="177" stroke="#6B7280" stroke-width="1.6" /><polygon points="524,177 517,173 517,181" fill="#6B7280" />
<line x1="628" y1="177" x2="643" y2="177" stroke="#6B7280" stroke-width="1.6" /><polygon points="650,177 643,173 643,181" fill="#6B7280" />
<line x1="754" y1="177" x2="769" y2="177" stroke="#6B7280" stroke-width="1.6" /><polygon points="776,177 769,173 769,181" fill="#6B7280" />
<rect x="524" y="148" width="104" height="58" fill="none" stroke="#6B7280" stroke-width="2" />
<text x="576" y="183" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#1A1A1A">pick winner</text>
<text x="576" y="236" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">highest</text>
<text x="576" y="255" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">likelihood</text>
<text x="576" y="274" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">per point</text>
<rect x="650" y="148" width="104" height="58" fill="none" stroke="#6B7280" stroke-width="2" />
<text x="702" y="183" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#1A1A1A">clean up</text>
<text x="702" y="236" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">remove stray</text>
<text x="702" y="255" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">specks</text>
<rect x="776" y="148" width="104" height="58" fill="none" stroke="#6B7280" stroke-width="2" />
<text x="828" y="173" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#1A1A1A">back to</text>
<text x="828" y="193" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="17" fill="#1A1A1A">brain</text>
<text x="828" y="236" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">invert the</text>
<text x="828" y="255" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">sphere</text>
<text x="828" y="274" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="16" fill="#6B7280">mapping</text>
<text x="450" y="340" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="18" fill="#6B7280">no registration at test time</text>
<text x="450" y="366" text-anchor="middle" font-family="Inter, system-ui, sans-serif" font-size="18" fill="#6B7280">weights are frozen — nothing is learned here</text>
</g>
</svg>
