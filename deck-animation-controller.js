(function () {
  'use strict';

  const controller = window.animationPauseController;
  if (!controller || window.deckAnimationController) return;

  function sendState(targetWindow) {
    try {
      targetWindow.postMessage({
        type: 'set-animation-paused',
        paused: controller.isPaused()
      }, '*');
    } catch (_) { }
  }

  function broadcastState() {
    document.querySelectorAll('iframe').forEach(function (frame) {
      if (frame.contentWindow) sendState(frame.contentWindow);
    });
  }

  window.addEventListener('animationpausechange', broadcastState);

  window.addEventListener('message', function (event) {
    if (!event.data) return;
    if (event.data.type === 'deck-pause-toggle') {
      controller.toggle();
    } else if (event.data.type === 'animation-controller-ready' && event.source) {
      sendState(event.source);
    }
  });

  document.addEventListener('load', function (event) {
    if (event.target && event.target.tagName === 'IFRAME' && event.target.contentWindow) {
      sendState(event.target.contentWindow);
    }
  }, true);

  window.addEventListener('load', broadcastState);

  window.deckAnimationController = Object.freeze({
    isPaused: controller.isPaused,
    setPaused: controller.setPaused,
    toggle: controller.toggle,
    broadcastState: broadcastState
  });
})();
