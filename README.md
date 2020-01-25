# hub-report

Here's a template for writing your honours project in Markdown, but still using [the infthesis LaTeX template](https://www.inf.ed.ac.uk/teaching/courses/proj/Latex/index.html).

## Directory structure

- `chapters` folder contains your content. It's all joined together by alphabetical order, hence the numbers
- `includes` folder contains useful stuff to configure things
    - `includes/before-body.tex` contains your acknowledgments and declaration
    - `includes/header.tex` includes your degree, project kind and abstract
    - `includes/bibliography.yaml` is what it sounds like, but in YAML format.
    - `includes/metadata.yaml` configures pandoc and other pandoc filters, incl. the title and author

## Installing

On macOS you can just do: `brew install pandoc pandoc-citeproc pandoc-crossref`.

On Linux you can probably install `pandoc` and `pandoc-citeproc` from your package manager.
[`pandoc-crossref`] is harder to install, hard enough for me (or takes too long to install) to give up on adding continuous integration to this repo.

Pandoc uses Haskell, so you will need to install stuff. `pandoc-citeproc` is essential but you can survive without `pandoc-crossref`. You'll just lose a bunch of nifty features for referencing sections, figures, equations and tables.

I don't think you need any LaTeX stuff installed, `pandoc` alone will work fine.

[`pandoc-crossref`]:https://github.com/lierdakil/pandoc-crossref

## Usage

1. Read the entirety of this README file
1. Read all the files (even the Makefile!)
1. Run `make` and then you can just open `project.pdf`

## FAQ

**Does my bibliography need to be in YAML?**

[No, you can use any of the formats listed here.](https://pandoc.org/MANUAL.html#citations)
So that means `.bib`/`.bibtex` are supported. You just need to tweak this repo (the `Makefile`) to add support for it.

That link also provides a command for _automatically_ converting an existing `.bib(tex)` to a `.yaml` or `.json`.

**How do I configure pandoc / pandoc-citeproc / pandoc-crossref?**

There are links to documentation in `bibliography.yaml` and `metadata.yaml`. Recommended reading.

You can also just write LaTeX where you need to inside the markdown.
You'll notice I already do this a little for `\chapter{Some Chapter}`.

I'm not kidding when I say read the links to the documentation. There's some
really useful extensions here:

> Pandoc’s enhanced version of Markdown includes syntax for tables, definition lists, metadata blocks, footnotes, citations, math, and much more. See below under [Pandoc’s Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown).

If you have existing stuff in LaTeX, just copy the content to a new `.tex` file, and use this command to convert it to Markdown: `pandoc old.tex -o new.md`
