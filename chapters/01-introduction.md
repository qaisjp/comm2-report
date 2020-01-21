Introduction
============

The document structure should include:

-   The title page in the format used above.

-   An optional acknowledgements page.

-   The table of contents.

-   The report text divided into chapters as appropriate.

-   The bibliography.

Commands for generating the title page appear in the skeleton file and
are self explanatory. The file also includes commands to choose your
report type (project report, thesis or dissertation) and degree. These
will be placed in the appropriate place in the title page.

The default behaviour of the documentclass is to produce documents
typeset in 12 point. Regardless of the formatting system you use, it is
recommended that you submit your thesis printed (or copied) double
sided.

The report should be printed single-spaced. It should be 30 to 60 pages
long, and preferably no shorter than 20 pages. Appendices are in
addition to this and you should place detail here which may be too much
or not strictly necessary when reading the relevant section.

Citations
---------

Note that citations (like [@P1] or [@P2]) can be generated using
`BibTeX` or by using the `thebibliography` environment. This makes sure
that the table of contents includes an entry for the bibliography. Of
course you may use any other method as well.

Options
-------

There are various documentclass options, see the documentation. Here we
are using an option (`bsc` or `minf`) to choose the degree type, plus:

-   `frontabs` (recommended) to put the abstract on the front page;

-   `twoside` (recommended) to format for two-sided printing, with each
    chapter starting on a right-hand page;

-   `singlespacing` (required) for single-spaced formating; and

-   `parskip` (a matter of taste) which alters the paragraph formatting
    so that paragraphs are separated by a vertical space, and there is
    no indentation at the start of each paragraph.
