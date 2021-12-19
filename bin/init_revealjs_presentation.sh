#!/usr/bin/env bash
set -e
set -u

echo "Initialize a new revealjs presentation in current directory?  Press any key to continue..."
read x

[ -e reveal.js ] || (git clone https://github.com/hakimel/reveal.js.git && cd reveal.js && git checkout dev && npm install)

[ -e reveal.js-plugins ] || git clone --recurse-submodules -j8 https://github.com/rajgoel/reveal.js-plugins.git

[ -e mathjax ] || git clone https://github.com/mathjax/MathJax.git mathjax

[ -e starter_template.html ] || cat <<EOF > starter_template.html
<!DOCTYPE html>
<html lang="en-us">
<head>
  <title>TITLE</title>
  <meta name="author" content="AUTHOR">
  <link rel="icon" href="favicon.jpeg">
  <link rel="stylesheet" href="reveal.js/dist/theme/serif.css">
  <link rel="stylesheet" href="reveal.js/dist/reveal.css">
  <link rel="stylesheet" href="reveal.js/dist/theme/white.css">
  <meta charset="utf-8"/>
  <style type="text/css">
    .reveal .slides section div.cite {
      display: flex;
      flex-direction: column;
      text-align:left;
      font-size:.5em;
    }
    .reveal .slides section div.cite p {
      float: right;
      height: 100%;
      display: flex;
      margin-left:0;
      margin-right:0;
      margin-top:0;
      margin-bottom:5px;
      align-items: flex-end;
      shape-outside: inset(calc(100% - 100px) 0 0);
    }
    .slide-menu-wrapper .slide-menu-overlay.active {
      opacity: 0 !important;
    }
</style>
</head>
<body>
  <div class="reveal"> <div class="slides">

    <section>
      <h1 style="margin-top:20%;" class="title">Title</h1>
      <p class="author">Author</p>
      <!-- <p class="date">2021-02-23 Dec 9, 2020</p> -->
    </section>

  </div> </div>
  <script src="reveal.js/dist/reveal.js"></script>
  <script src="reveal.js/plugin/markdown/markdown.js"></script>
  <script src="reveal.js/plugin/math/math.js"></script>
  <script src="reveal.js/plugin/notes/notes.js"></script>
  <script src="reveal.js/plugin/highlight/highlight.js"></script>
  <script src="reveal.js/plugin/search/search.js"></script>
  <script src="reveal.js-plugins/chalkboard/plugin.js"></script>
  <script src="reveal.js-plugins/menu/menu.js"></script>
  <script>
    Reveal.initialize({
      plugins: [
        RevealMarkdown, RevealMath, RevealNotes, RevealSearch, RevealHighlight,
        RevealChalkboard, RevealMenu],
      slideNumber: true,
      hashOneBasedIndex: false,
      hash: true,
      controls: false,
      math: {
        <!-- mathjax: 'mathjax/es5/tex-chtml-full.js', -->
        config: 'TeX-AMS_HTML-full',
        // pass other options into `MathJax.Hub.Config()`
        <!-- TeX: { Macros: { RR: "{\\bf R}" } }, -->
        extensions: ["tex2jax.js"],
        jax: ["input/TeX", "output/HTML-CSS"],
        tex2jax: {
            inlineMath: [ ['$','$'], ["\\(","\\)"] ],
            displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
        },
        "HTML-CSS": { availableFonts: ["TeX"] }
      },
      chalkboard: {
        readOnly: undefined,
        src: "chalkboard.json",
        theme: "whiteboard",
        toggleChalkboardButton: false,
        toggleNotesButton: false,
      },
      menu: {
        numbers: true,  // show slide numbers in menu titles
        openSlideNumber: true,  // click page number to access menu
        custom: [
          {
            title: 'Tools',
            icon: '<i class="fa fa-medkit">',
            src: 'revealjs_menu_panel_chalkboard.html'
          }
        ],
      },
      <!-- width: "100%", height:"100%" -->
      width: 1280, height:720
    });

    // trick to enable <section class="hide-menu-button">
    Reveal.on( 'slidetransitionend', event => {
      var menubutton = document.getElementsByClassName("slide-menu-button")[0]
      // store default display setting
      if (typeof(menubutton.__stored_display) == "undefined") {
          menubutton.__stored_display = menubutton.style.display;
      }
      if (event.currentSlide.classList.contains("hide-menu-button")) {
        console.log("current slide hide");
          menubutton.style.display = 'none';
      } else if (event.previousSlide.classList.contains("hide-menu-button")) {
        console.log("current slide show");
        menubutton.style.display = menubutton.__stored_display;
      }
    });
  </script>
</body>
</html>
EOF

[ -e revealjs_menu_panel_chalkboard.html ] || cat <<EOF > revealjs_menu_panel_chalkboard.html
<!-- RevealJs Menu and Chalkboard plugin integration -->
<ul class="slide-menu-items">
  <li class="slide-menu-item"  onmousedown="window.RevealChalkboard.toggleChalkboard()">Whiteboard</li>
  <li class="slide-menu-item"  onmousedown="window.RevealChalkboard.toggleNotesCanvas()">Annotate Slide</li>
  <li class="slide-menu-item"  onmousedown="window.RevealChalkboard.download()">Save Annotations to File</li>
  <li class="slide-menu-item" ><a href="?print-pdf" >Print PDF</a></li>
</ul>
EOF

[ -e serve.sh ] || cat <<EOF > serve.sh
#!/bin/bash
watchexec -r --no-meta -- python -m http.server &
wait
EOF
chmod +x serve.sh

echo
echo
echo "FINISHED! Next tasks:"
echo "edit starter_template.html"
echo "run ./serve.sh"
