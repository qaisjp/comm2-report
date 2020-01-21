.PHONY: project.pdf

project.pdf:
	pandoc \
		--filter pandoc-citeproc \
		--include-in-header includes/include.tex \
		--include-before-body includes/acknowledgements.tex \
		--metadata-file includes/metadata.yaml \
		includes/bibliography.yaml \
		chapters/01-introduction.md chapters/02-implementation.md \
		-o project.pdf
