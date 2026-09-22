(function () {
  'use strict';

  if (window.animationPauseController) return;

  const nativeNow = performance.now.bind(performance);
  const nativeSetTimeout = window.setTimeout.bind(window);
  const nativeClearTimeout = window.clearTimeout.bind(window);
  const nativeRequestAnimationFrame = window.requestAnimationFrame.bind(window);
  const nativeCancelAnimationFrame = window.cancelAnimationFrame.bind(window);

  const timeouts = new Map();
  const intervals = new Map();
  const frames = new Map();
  const pausedDocumentAnimations = new Set();

  let paused = false;
  let pausedAt = 0;
  let totalPausedTime = 0;
  let nextHandle = -1;

  function delay(value) {
    const number = Number(value);
    return Number.isFinite(number) && number > 0 ? number : 0;
  }

  function runCallback(callback, args) {
    if (typeof callback === 'function') callback.apply(window, args);
    else window.eval(String(callback));
  }

  function animationNow() {
    return (paused ? pausedAt : nativeNow()) - totalPausedTime;
  }

  try {
    Object.defineProperty(performance, 'now', {
      configurable: true,
      value: animationNow
    });
  } catch (_) {
    try { performance.now = animationNow; } catch (_) { }
  }

  function scheduleTimeout(record) {
    record.startedAt = nativeNow();
    record.nativeId = nativeSetTimeout(function () {
      record.nativeId = null;
      timeouts.delete(record.handle);
      runCallback(record.callback, record.args);
    }, record.remaining);
  }

  window.setTimeout = function (callback, wait) {
    const record = {
      handle: nextHandle--,
      callback: callback,
      args: Array.prototype.slice.call(arguments, 2),
      remaining: delay(wait),
      startedAt: 0,
      nativeId: null
    };
    timeouts.set(record.handle, record);
    if (!paused) scheduleTimeout(record);
    return record.handle;
  };

  window.clearTimeout = function (handle) {
    const record = timeouts.get(handle);
    if (!record) return nativeClearTimeout(handle);
    if (record.nativeId !== null) nativeClearTimeout(record.nativeId);
    timeouts.delete(handle);
  };

  function scheduleInterval(record, wait) {
    record.remaining = wait;
    record.startedAt = nativeNow();
    record.nativeId = nativeSetTimeout(function tick() {
      record.nativeId = null;
      if (!intervals.has(record.handle)) return;
      runCallback(record.callback, record.args);
      if (intervals.has(record.handle) && !paused) {
        scheduleInterval(record, record.delay);
      }
    }, wait);
  }

  window.setInterval = function (callback, wait) {
    const record = {
      handle: nextHandle--,
      callback: callback,
      args: Array.prototype.slice.call(arguments, 2),
      delay: delay(wait),
      remaining: delay(wait),
      startedAt: 0,
      nativeId: null
    };
    intervals.set(record.handle, record);
    if (!paused) scheduleInterval(record, record.delay);
    return record.handle;
  };

  window.clearInterval = function (handle) {
    const record = intervals.get(handle);
    if (!record) return nativeClearTimeout(handle);
    if (record.nativeId !== null) nativeClearTimeout(record.nativeId);
    intervals.delete(handle);
  };

  function scheduleFrame(record) {
    record.nativeId = nativeRequestAnimationFrame(function () {
      record.nativeId = null;
      frames.delete(record.handle);
      record.callback(animationNow());
    });
  }

  window.requestAnimationFrame = function (callback) {
    const record = { handle: nextHandle--, callback: callback, nativeId: null };
    frames.set(record.handle, record);
    if (!paused) scheduleFrame(record);
    return record.handle;
  };

  window.cancelAnimationFrame = function (handle) {
    const record = frames.get(handle);
    if (!record) return nativeCancelAnimationFrame(handle);
    if (record.nativeId !== null) nativeCancelAnimationFrame(record.nativeId);
    frames.delete(handle);
  };

  const pauseStyle = document.createElement('style');
  pauseStyle.textContent =
    'html[data-animations-paused="true"] *, ' +
    'html[data-animations-paused="true"] *::before, ' +
    'html[data-animations-paused="true"] *::after {' +
    'animation-play-state: paused !important;}';
  document.head.appendChild(pauseStyle);

  function pauseDocumentAnimations() {
    if (!document.getAnimations) return;
    document.getAnimations().forEach(function (animation) {
      if (animation.playState !== 'running') return;
      try {
        animation.pause();
        pausedDocumentAnimations.add(animation);
      } catch (_) { }
    });
  }

  function resumeDocumentAnimations() {
    pausedDocumentAnimations.forEach(function (animation) {
      try { animation.play(); } catch (_) { }
    });
    pausedDocumentAnimations.clear();
  }

  function setPaused(nextPaused) {
    nextPaused = Boolean(nextPaused);
    if (nextPaused === paused) return;

    if (nextPaused) {
      paused = true;
      pausedAt = nativeNow();

      timeouts.forEach(function (record) {
        if (record.nativeId === null) return;
        record.remaining = Math.max(
          0,
          record.remaining - (pausedAt - record.startedAt)
        );
        nativeClearTimeout(record.nativeId);
        record.nativeId = null;
      });
      intervals.forEach(function (record) {
        if (record.nativeId === null) return;
        record.remaining = Math.max(
          0,
          record.remaining - (pausedAt - record.startedAt)
        );
        nativeClearTimeout(record.nativeId);
        record.nativeId = null;
      });
      frames.forEach(function (record) {
        if (record.nativeId === null) return;
        nativeCancelAnimationFrame(record.nativeId);
        record.nativeId = null;
      });
      document.documentElement.dataset.animationsPaused = 'true';
      pauseDocumentAnimations();
    } else {
      totalPausedTime += nativeNow() - pausedAt;
      paused = false;
      delete document.documentElement.dataset.animationsPaused;
      resumeDocumentAnimations();
      timeouts.forEach(scheduleTimeout);
      intervals.forEach(function (record) {
        scheduleInterval(record, record.remaining);
      });
      frames.forEach(scheduleFrame);
    }

    window.dispatchEvent(new CustomEvent('animationpausechange', {
      detail: { paused: paused }
    }));
  }

  function toggle() {
    setPaused(!paused);
  }

  window.animationPauseController = Object.freeze({
    isPaused: function () { return paused; },
    setPaused: setPaused,
    toggle: toggle
  });

  window.addEventListener('keydown', function (event) {
    const isPauseKey = event.key === 'p' || event.key === 'P';
    const isOverviewKey = event.key === 'o' || event.key === 'O';
    if (!isPauseKey && !isOverviewKey) return;
    if (event.repeat || event.metaKey || event.ctrlKey || event.altKey) return;
    const target = event.target;
    if (target && (target.isContentEditable || /^(INPUT|TEXTAREA|SELECT)$/.test(target.tagName))) {
      return;
    }
    if (isOverviewKey) {
      if (window.parent !== window) {
        event.preventDefault();
        event.stopImmediatePropagation();
        window.parent.postMessage({ type: 'deckkey', key: 'o' }, '*');
      }
      return;
    }
    event.preventDefault();
    event.stopImmediatePropagation();
    if (window.parent !== window) {
      window.parent.postMessage({ type: 'deck-pause-toggle' }, '*');
    } else {
      toggle();
    }
  }, true);

  window.addEventListener('message', function (event) {
    if (!event.data) return;
    if (event.data.type === 'set-animation-paused') {
      setPaused(event.data.paused);
    } else if (event.data.type === 'toggle-pause') {
      toggle();
    }
  });

  if (window.parent !== window) {
    window.parent.postMessage({ type: 'animation-controller-ready' }, '*');
  }
})();
