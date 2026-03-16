/**
 * Add copy button to code blocks (Chirpy + Rouge highlight).
 * Targets .highlight (figure/div from kramdown syntax_highlighter_opts).
 */
(function () {
  function initCodeCopy() {
    var blocks = document.querySelectorAll('.highlight');
    blocks.forEach(function (block) {
      if (block.querySelector('.code-copy-btn')) return;

      var codeEl = block.querySelector('code');
      if (!codeEl) return;

      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'code-copy-btn';
      btn.setAttribute('aria-label', 'Copy code');
      btn.textContent = 'Copy';

      btn.addEventListener('click', function () {
        var text = codeEl.innerText || codeEl.textContent || '';
        if (!text) return;

        if (navigator.clipboard && navigator.clipboard.writeText) {
          navigator.clipboard.writeText(text).then(function () {
            showCopied(btn);
          }).catch(function () {
            fallbackCopy(text, btn);
          });
        } else {
          fallbackCopy(text, btn);
        }
      });

      block.style.position = block.style.position || 'relative';
      block.insertBefore(btn, block.firstChild);
    });
  }

  function showCopied(btn) {
    btn.textContent = 'Copied!';
    btn.classList.add('copied');
    setTimeout(function () {
      btn.textContent = 'Copy';
      btn.classList.remove('copied');
    }, 2500);
  }

  function fallbackCopy(text, btn) {
    var ta = document.createElement('textarea');
    ta.value = text;
    ta.setAttribute('readonly', '');
    ta.style.position = 'absolute';
    ta.style.left = '-9999px';
    document.body.appendChild(ta);
    ta.select();
    try {
      document.execCommand('copy');
      showCopied(btn);
    } catch (e) {}
    document.body.removeChild(ta);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCodeCopy);
  } else {
    initCodeCopy();
  }
})();
