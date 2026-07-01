// Inject the current chapter's section headings (h2/h3) into the left sidebar,
// nested under the active chapter, with IntersectionObserver scroll-tracking.
// mdBook cannot place in-page anchors in SUMMARY.md, so we build this at runtime.
(function () {
  "use strict";

  function textOf(el) {
    return (el.textContent || "").replace(/¶/g, "").trim();
  }

  function build() {
    var sidebar = document.querySelector("#sidebar");
    if (!sidebar) return;
    var active = sidebar.querySelector("a.active");
    if (!active) return; // landing/other pages with no active chapter
    var main = document.querySelector("main");
    if (!main) return;
    if (sidebar.querySelector(".subsection-item")) return; // already built

    var headings = Array.prototype.slice.call(
      main.querySelectorAll("h2[id], h3[id]")
    );
    if (!headings.length) return;

    // The chapter's Exercises/Resources list (<ol class="section">) sits in the
    // <li> right after the active chapter's <li>. We inject INTO that same list
    // so there is no competing markup for mdBook's sidebar CSS.
    var chapterLi = active.closest("li.chapter-item");
    var sectionOl = null;
    if (chapterLi && chapterLi.nextElementSibling)
      sectionOl = chapterLi.nextElementSibling.querySelector("ol.section");

    var linkFor = Object.create(null);
    var frag = document.createDocumentFragment();

    headings.forEach(function (h) {
      var li = document.createElement("li");
      li.className = "subsection-item " + (h.tagName === "H3" ? "sub3" : "sub2");
      var a = document.createElement("a");
      a.href = "#" + h.id;
      a.className = "subsection-link";
      a.setAttribute("data-target", h.id);
      a.textContent = textOf(h);
      linkFor[h.id] = a;
      li.appendChild(a);
      frag.appendChild(li);
    });

    if (sectionOl) {
      sectionOl.insertBefore(frag, sectionOl.firstChild); // above Exercises/Resources
    } else if (chapterLi) {
      var ol = document.createElement("ol");
      ol.className = "section";
      ol.appendChild(frag);
      var wrap = document.createElement("li");
      wrap.appendChild(ol);
      chapterLi.parentNode.insertBefore(wrap, chapterLi.nextElementSibling);
    } else return;

    var scrollbox = document.querySelector(".sidebar-scrollbox");
    var current = null;

    function keepVisible(a) {
      if (!scrollbox) return;
      var ar = a.getBoundingClientRect();
      var br = scrollbox.getBoundingClientRect();
      if (ar.top < br.top + 12) scrollbox.scrollTop += ar.top - br.top - 12;
      else if (ar.bottom > br.bottom - 12)
        scrollbox.scrollTop += ar.bottom - br.bottom + 12;
    }

    function setActive(a) {
      if (current === a) return;
      if (current) current.classList.remove("active-sub");
      current = a;
      if (a) {
        a.classList.add("active-sub");
        keepVisible(a);
      }
    }

    active.parentNode.addEventListener("click", function (e) {
      var a = e.target.closest("a.subsection-link");
      if (!a) return;
      var el = document.getElementById(a.getAttribute("data-target"));
      if (!el) return;
      e.preventDefault();
      el.scrollIntoView({ behavior: "smooth", block: "start" });
      history.replaceState(null, "", "#" + a.getAttribute("data-target"));
      setActive(a);
    });

    var onScreen = new Set();
    function recompute() {
      var best = null,
        bestTop = Infinity;
      onScreen.forEach(function (h) {
        var t = h.getBoundingClientRect().top;
        if (t < bestTop) {
          bestTop = t;
          best = h;
        }
      });
      if (!best) {
        var probe = 130,
          cand = headings[0];
        for (var i = 0; i < headings.length; i++)
          if (headings[i].getBoundingClientRect().top <= probe)
            cand = headings[i];
        best = cand;
      }
      if (best && linkFor[best.id]) setActive(linkFor[best.id]);
    }

    if ("IntersectionObserver" in window) {
      var io = new IntersectionObserver(
        function (entries) {
          entries.forEach(function (en) {
            if (en.isIntersecting) onScreen.add(en.target);
            else onScreen.delete(en.target);
          });
          recompute();
        },
        { rootMargin: "-72px 0px -68% 0px", threshold: 0 }
      );
      headings.forEach(function (h) {
        io.observe(h);
      });
    } else {
      window.addEventListener("scroll", recompute, { passive: true });
    }
    recompute();
  }

  function boot() {
    var tries = 0;
    (function attempt() {
      build();
      if (
        tries++ < 12 &&
        !document.querySelector(".subsection-item") &&
        document.querySelector("#sidebar a.active")
      )
        setTimeout(attempt, 120);
    })();
  }

  if (document.readyState === "loading")
    document.addEventListener("DOMContentLoaded", boot);
  else boot();
})();
