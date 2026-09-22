(function () {
  'use strict';

  window.installOverviewCarousel = function (deck) {
    if (!deck || window.overviewCarousel) return;

    const root = document.documentElement;
    const gestureThreshold = 36;
    const gestureEndDelay = 180;
    let accumulatedDelta = 0;
    let movedThisGesture = false;
    let gestureEndTimer = null;

    const style = document.createElement('style');
    style.textContent =
      'html.overview-carousel-open, ' +
      'html.overview-carousel-open body {' +
      'overscroll-behavior: none;' +
      'touch-action: none;' +
      '}';
    document.head.appendChild(style);

    function resetGesture() {
      if (gestureEndTimer !== null) clearTimeout(gestureEndTimer);
      accumulatedDelta = 0;
      movedThisGesture = false;
      gestureEndTimer = null;
    }

    function finishGestureSoon() {
      clearTimeout(gestureEndTimer);
      gestureEndTimer = setTimeout(resetGesture, gestureEndDelay);
    }

    function horizontalSlides() {
      return Array.from(document.querySelectorAll('.reveal .slides > section'));
    }

    function moveSelection(direction) {
      const slides = horizontalSlides();
      if (!slides.length) return;
      const current = deck.getIndices().h;
      const next = Math.max(0, Math.min(slides.length - 1, current + direction));
      if (next !== current) deck.slide(next, 0);
    }

    function wheelDelta(event) {
      return Math.abs(event.deltaX) >= Math.abs(event.deltaY)
        ? event.deltaX
        : event.deltaY;
    }

    function onWheel(event) {
      if (!deck.isOverview()) return;

      event.preventDefault();
      event.stopPropagation();

      finishGestureSoon();
      if (movedThisGesture) return;

      accumulatedDelta += wheelDelta(event);
      if (Math.abs(accumulatedDelta) < gestureThreshold) return;

      moveSelection(accumulatedDelta > 0 ? 1 : -1);
      movedThisGesture = true;
    }

    function setOpen(open) {
      root.classList.toggle('overview-carousel-open', open);
      resetGesture();
    }

    window.addEventListener('wheel', onWheel, { capture: true, passive: false });
    deck.on('overviewshown', function () { setOpen(true); });
    deck.on('overviewhidden', function () { setOpen(false); });
    deck.on('ready', function () { setOpen(deck.isOverview()); });

    window.overviewCarousel = Object.freeze({
      movePrevious: function () { moveSelection(-1); },
      moveNext: function () { moveSelection(1); }
    });
  };
})();
