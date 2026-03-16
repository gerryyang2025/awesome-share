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

      btn.innerHTML = '<span class="code-copy-icon">' +
        '<svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 010 1.5h-1.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-1.5a.75.75 0 011.5 0v1.5A1.75 1.75 0 019.25 16h-7.5A1.75 1.75 0 010 14.25v-7.5z"/><path fill-rule="evenodd" d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0114.25 11h-7.5A1.75 1.75 0 015 9.25v-7.5zm1.5-.25a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-7.5a.25.25 0 00-.25-.25h-7.5z"/></svg>' +
        '</span><span class="code-copy-check">' +
        '<svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"/></svg>' +
        '</span>';

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
    btn.classList.add('copied');
    setTimeout(function () {
      btn.classList.remove('copied');
    }, 2000);
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
