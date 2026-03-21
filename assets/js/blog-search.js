/**
 * Chirpy panel search: debounced, ranked results (title matches first).
 * Replaces SimpleJekyllSearch for this site — theme still loads that library unused.
 */
(function (window) {
  'use strict';

  function escapeHtml(s) {
    return String(s == null ? '' : s)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  function normalizeQuery(q) {
    return String(q || '')
      .trim()
      .replace(/\s+/g, ' ')
      .toLowerCase();
  }

  function queryWords(normalized) {
    if (!normalized) return [];
    return normalized.split(' ').filter(Boolean);
  }

  /** `textL` is already lowercased; `words` are lowercased tokens. */
  function wordsInLowerField(textL, words) {
    if (textL == null || textL === '') return false;
    for (let i = 0; i < words.length; i++) {
      if (textL.indexOf(words[i]) === -1) return false;
    }
    return true;
  }

  /**
   * One-time fields for hot path (avoid per-keystroke toLowerCase / Date.parse on huge strings).
   */
  function indexPostRow(p) {
    p._titleL = (p.title || '').toLowerCase();
    p._catL = String(p.categories || '').toLowerCase();
    p._tagsL = String(p.tags || '').toLowerCase();
    p._urlL = String(p.url || '').toLowerCase();
    p._bodyL = String(p.content || '').toLowerCase();
    const t = Date.parse(p.date || '');
    p._dateMs = isNaN(t) ? 0 : t;
  }

  /**
   * Lower rank = better. 0 = exact title, 1 = full phrase in title, 2 = all words in title, …
   */
  function matchRank(post, qNorm, words) {
    if (!words.length) return 99;

    const title = post._titleL;

    if (title === qNorm) return 0;
    if (qNorm.length >= 2 && title.indexOf(qNorm) !== -1) return 1;
    if (wordsInLowerField(title, words)) return 2;
    if (wordsInLowerField(post._catL, words) || wordsInLowerField(post._tagsL, words)) return 3;
    if (wordsInLowerField(post._urlL, words)) return 4;
    if (wordsInLowerField(post._bodyL, words)) return 5;
    return 99;
  }

  function searchPosts(data, rawQuery, maxResults) {
    const qNorm = normalizeQuery(rawQuery);
    const words = queryWords(qNorm);
    if (!words.length) return [];

    const out = [];
    for (let i = 0; i < data.length; i++) {
      const post = data[i];
      const rank = matchRank(post, qNorm, words);
      if (rank < 99) out.push({ post: post, rank: rank });
    }

    out.sort(function (a, b) {
      if (a.rank !== b.rank) return a.rank - b.rank;
      return b.post._dateMs - a.post._dateMs;
    });

    return out.slice(0, maxResults).map(function (x) {
      return x.post;
    });
  }

  function renderCategories(value) {
    if (!value) return '';
    return (
      '<div class="me-sm-4"><i class="far fa-folder fa-fw"></i>' +
      escapeHtml(value) +
      '</div>'
    );
  }

  function renderTags(value) {
    if (!value) return '';
    return '<div><i class="fa fa-tag fa-fw"></i>' + escapeHtml(value) + '</div>';
  }

  function renderArticle(post, previewLen) {
    const content = post.content || '';
    const preview =
      content.length > previewLen ? content.slice(0, previewLen) + '…' : content;

    return (
      '<article class="px-1 px-sm-2 px-lg-4 px-xl-0">' +
      '<header>' +
      '<h2><a href="' +
      escapeHtml(post.url) +
      '">' +
      escapeHtml(post.title) +
      '</a></h2>' +
      '<div class="post-meta d-flex flex-column flex-sm-row text-muted mt-1 mb-1">' +
      renderCategories(post.categories) +
      renderTags(post.tags) +
      '</div>' +
      '</header>' +
      '<p>' +
      escapeHtml(preview) +
      '</p>' +
      '</article>'
    );
  }

  window.BlogSearch = {
    init: function (options) {
      const input = options.input;
      const resultsEl = options.results;
      const jsonUrl = options.jsonUrl;
      const noResultsHtml = options.noResultsHtml || '<p class="mt-5">No results found</p>';
      const debounceMs = typeof options.debounceMs === 'number' ? options.debounceMs : 280;
      const maxResults = typeof options.maxResults === 'number' ? options.maxResults : 40;
      const previewLen = typeof options.contentPreviewLen === 'number' ? options.contentPreviewLen : 220;

      if (!input || !resultsEl || !jsonUrl) return;

      let data = null;
      let loadPromise = null;
      let debounceTimer = null;
      let searchGeneration = 0;

      function loadData() {
        if (data) return Promise.resolve(data);
        if (loadPromise) return loadPromise;
        loadPromise = fetch(jsonUrl, { credentials: 'same-origin' })
          .then(function (r) {
            if (!r.ok) throw new Error('search json ' + r.status);
            return r.json();
          })
          .then(function (json) {
            const rows = Array.isArray(json) ? json : [];
            for (let i = 0; i < rows.length; i++) {
              indexPostRow(rows[i]);
            }
            data = rows;
            return data;
          })
          .catch(function () {
            loadPromise = null;
            data = [];
            return data;
          });
        return loadPromise;
      }

      function run(raw) {
        const q = String(raw || '').trim();
        if (!q) {
          resultsEl.innerHTML = '';
          return;
        }

        const myGen = ++searchGeneration;
        loadData().then(function (rows) {
          if (myGen !== searchGeneration) return;
          const hits = searchPosts(rows, q, maxResults);
          if (hits.length === 0) {
            resultsEl.innerHTML = noResultsHtml;
            return;
          }
          resultsEl.innerHTML = hits.map(function (p) {
            return renderArticle(p, previewLen);
          }).join('');
        });
      }

      input.addEventListener('input', function () {
        clearTimeout(debounceTimer);
        const v = input.value;
        debounceTimer = setTimeout(function () {
          run(v);
        }, debounceMs);
      });

      input.addEventListener('search', function () {
        clearTimeout(debounceTimer);
        run(input.value);
      });
    }
  };
})(window);
