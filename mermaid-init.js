(() => {
    const darkThemes = ['ayu', 'navy', 'coal'];
    const lightThemes = ['light', 'rust'];

    const classList = document.getElementsByTagName('html')[0].classList;

    let lastThemeWasLight = true;
    for (const cssClass of classList) {
        if (darkThemes.includes(cssClass)) {
            lastThemeWasLight = false;
            break;
        }
    }

    const theme = lastThemeWasLight ? 'default' : 'dark';
    // useMaxWidth:false renders flowcharts at natural size (readable labels)
    // instead of shrinking wide LR diagrams to fit the column; custom.css makes
    // the container scroll horizontally when a diagram is wider than the page.
    mermaid.initialize({
        startOnLoad: true,
        theme,
        themeVariables: { fontSize: '15px' },
        flowchart: { useMaxWidth: false, nodeSpacing: 35, rankSpacing: 45 },
        er: { useMaxWidth: false },
        class: { useMaxWidth: false },
    });

    // Measure the real content area (mdBook's .page already excludes the
    // sidebar in its current open/closed state) and publish it as a CSS
    // variable; custom.css caps diagram width to it. Re-measure on resize
    // and when the sidebar slides.
    const setDiagramAvail = () => {
        const page = document.querySelector('.page') || document.body;
        const avail = Math.max(300, page.clientWidth - 48);
        document.documentElement.style.setProperty('--diagram-avail', avail + 'px');
    };
    setDiagramAvail();
    window.addEventListener('resize', setDiagramAvail, { passive: true });
    const sidebarToggle = document.getElementById('sidebar-toggle');
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', () => {
            setTimeout(setDiagramAvail, 350); // after the slide transition
        });
    }

    // Simplest way to make mermaid re-render the diagrams in the new theme is via refreshing the page

    for (const darkTheme of darkThemes) {
        document.getElementById(darkTheme).addEventListener('click', () => {
            if (lastThemeWasLight) {
                window.location.reload();
            }
        });
    }

    for (const lightTheme of lightThemes) {
        document.getElementById(lightTheme).addEventListener('click', () => {
            if (!lastThemeWasLight) {
                window.location.reload();
            }
        });
    }
})();
