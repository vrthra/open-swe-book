// Build-version line at the bottom of the sidebar index. VERSION is
// overwritten at deploy time by CI (git describe --tags, i.e. the v2026.MM.N
// tag scheme, plus commit distance for untagged builds); "dev" appears only
// in local previews.
// The print icon leads to the per-language PDF/EPUB downloads instead of
// print.html: a printout should come from a single-language edition, not the
// all-languages print page.
(() => {
    const el = document.getElementById('print-button');
    const btn = el && (el.tagName === 'A' ? el : el.closest('a'));
    if (btn) {
        btn.href = 'https://github.com/tghastings/open-swe-book/releases/latest';
        btn.title = 'Download a PDF or EPUB edition (per language)';
        btn.removeAttribute('target');
    }
})();

// Sidebar numbering: the appendix displays as "A." and the suffix entries
// (curriculum, contributing) carry no number, so the sidebar matches the
// "thirteen chapters + appendix" framing rather than looking like 17 chapters.
(() => {
    document.querySelectorAll('#sidebar ol.chapter > li.chapter-item > a > strong')
        .forEach((st) => {
            const n = parseInt(st.textContent, 10);
            if (n === 14) st.textContent = 'A.';
            else if (n > 14) st.textContent = '';
        });
})();

(() => {
    const VERSION = "dev";
    const box = document.querySelector('#sidebar .sidebar-scrollbox');
    if (!box) return;
    const div = document.createElement('div');
    div.className = 'site-version';
    const link = document.createElement('a');
    link.href = 'https://github.com/tghastings/open-swe-book/releases';
    link.textContent = VERSION;
    link.title = 'Release history';
    div.append('build ');
    div.appendChild(link);
    box.appendChild(div);
})();
