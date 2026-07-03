// Build-version line at the bottom of the sidebar index. VERSION is
// overwritten at deploy time by CI (git describe --tags, i.e. the v2026.MM.N
// tag scheme, plus commit distance for untagged builds); "dev" appears only
// in local previews.
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
