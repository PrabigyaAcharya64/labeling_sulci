(function () {
  'use strict';

  window.installOverviewCarousel = function (deck) {
    if (!deck || window.overviewCarousel) return;

    const root = document.documentElement;

    const controls = document.createElement('div');
    controls.className = 'overview-carousel-controls';
    controls.setAttribute('aria-label', 'Slide picker navigation');

    const previousButton = document.createElement('button');
    previousButton.type = 'button';
    previousButton.className = 'overview-carousel-button';
    previousButton.setAttribute('aria-label', 'Previous slide');
    previousButton.title = 'Previous slide';
    previousButton.textContent = '\u2190';

    const nextButton = document.createElement('button');
    nextButton.type = 'button';
    nextButton.className = 'overview-carousel-button';
    nextButton.setAttribute('aria-label', 'Next slide');
    nextButton.title = 'Next slide';
    nextButton.textContent = '\u2192';

    controls.append(previousButton, nextButton);
    document.body.appendChild(controls);

    const style = document.createElement('style');
    style.textContent =
      'html.overview-carousel-open, ' +
      'html.overview-carousel-open body {' +
      'overscroll-behavior: none;' +
      '}' +
      '.overview-carousel-controls {' +
      'position: fixed;' +
      'left: 50%;' +
      'bottom: 24px;' +
      'z-index: 50;' +
      'display: none;' +
      'align-items: center;' +
      'gap: 12px;' +
      'transform: translateX(-50%);' +
      '}' +
      'html.overview-carousel-open .overview-carousel-controls {' +
      'display: flex;' +
      '}' +
      '.overview-carousel-button {' +
      'display: grid;' +
      'place-items: center;' +
      'width: 44px;' +
      'height: 44px;' +
      'padding: 0;' +
      'border: 1px solid #D1D5DB;' +
      'border-radius: 50%;' +
      'background: #FFFFFF;' +
      'color: #1A1A1A;' +
      'font: 500 23px/1 Inter, system-ui, sans-serif;' +
      'cursor: pointer;' +
      'box-shadow: 0 3px 12px rgba(0, 0, 0, 0.10);' +
      '}' +
      '.overview-carousel-button:hover:not(:disabled) {' +
      'border-color: #1A1A1A;' +
      '}' +
      '.overview-carousel-button:focus-visible {' +
      'outline: 3px solid rgba(29, 78, 216, 0.35);' +
      'outline-offset: 3px;' +
      '}' +
      '.overview-carousel-button:disabled {' +
      'opacity: 0.32;' +
      'cursor: default;' +
      'box-shadow: none;' +
      '}' +
      '@media (max-width: 640px) {' +
      '.overview-carousel-controls { bottom: 16px; }' +
      '}';
    document.head.appendChild(style);

    function horizontalSlides() {
      return Array.from(document.querySelectorAll('.reveal .slides > section'));
    }

    function updateButtons() {
      const slides = horizontalSlides();
      const current = deck.getIndices().h;
      previousButton.disabled = current <= 0;
      nextButton.disabled = !slides.length || current >= slides.length - 1;
    }

    function moveSelection(direction) {
      const slides = horizontalSlides();
      if (!slides.length) return;
      const current = deck.getIndices().h;
      const next = Math.max(0, Math.min(slides.length - 1, current + direction));
      if (next !== current) deck.slide(next, 0);
      updateButtons();
    }

    function onWheel(event) {
      if (!deck.isOverview()) return;
      event.preventDefault();
      event.stopPropagation();
    }

    function setOpen(open) {
      root.classList.toggle('overview-carousel-open', open);
      controls.setAttribute('aria-hidden', open ? 'false' : 'true');
      updateButtons();
    }

    previousButton.addEventListener('click', function (event) {
      event.preventDefault();
      event.stopPropagation();
      moveSelection(-1);
    });
    nextButton.addEventListener('click', function (event) {
      event.preventDefault();
      event.stopPropagation();
      moveSelection(1);
    });
    window.addEventListener('wheel', onWheel, { capture: true, passive: false });
    deck.on('overviewshown', function () { setOpen(true); });
    deck.on('overviewhidden', function () { setOpen(false); });
    deck.on('slidechanged', updateButtons);
    deck.on('ready', function () { setOpen(deck.isOverview()); });

    window.overviewCarousel = Object.freeze({
      movePrevious: function () { moveSelection(-1); },
      moveNext: function () { moveSelection(1); }
    });
  };
})();
