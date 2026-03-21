(function () {
  'use strict';

  var root = document.getElementById('moxiaoling-root');
  if (!root) return;

  var panel = document.getElementById('moxiaoling-panel');
  var openBtn = document.getElementById('moxiaoling-open-panel');
  var closeBtn = document.getElementById('moxiaoling-close-panel');
  var backdrop = panel && panel.querySelector('.moxiaoling-panel__backdrop');
  var iframe = document.getElementById('moxiaoling-assistant-frame');
  var fallback = document.getElementById('moxiaoling-iframe-fallback');
  var assistantUrl = root.getAttribute('data-assistant-url') || '';

  function openPanel() {
    if (!panel || !iframe || !assistantUrl) return;
    panel.classList.add('is-open');
    panel.setAttribute('aria-hidden', 'false');
    if (!iframe.getAttribute('src')) {
      iframe.setAttribute('src', assistantUrl);
    }
    openBtn && openBtn.setAttribute('aria-expanded', 'true');
    document.body.style.overflow = 'hidden';
    window.setTimeout(function () {
      closeBtn && closeBtn.focus();
    }, 320);
  }

  function closePanel() {
    if (!panel) return;
    panel.classList.remove('is-open');
    panel.setAttribute('aria-hidden', 'true');
    openBtn && openBtn.setAttribute('aria-expanded', 'false');
    document.body.style.overflow = '';
  }

  if (openBtn) {
    openBtn.addEventListener('click', function () {
      openPanel();
    });
  }
  if (closeBtn) {
    closeBtn.addEventListener('click', function () {
      closePanel();
    });
  }
  if (backdrop) {
    backdrop.addEventListener('click', function () {
      closePanel();
    });
  }
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && panel && panel.classList.contains('is-open')) {
      closePanel();
    }
  });

  if (iframe && fallback) {
    iframe.addEventListener('error', function () {
      fallback.classList.add('is-visible');
    });
  }

  root.querySelectorAll('.moxiaoling-hero__chip').forEach(function (chip) {
    chip.addEventListener('click', function () {
      var url = chip.getAttribute('data-href') || assistantUrl;
      if (url) window.open(url, '_blank', 'noopener,noreferrer');
    });
    chip.addEventListener('keydown', function (e) {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        chip.click();
      }
    });
  });
})();
