.PHONY: project.pdf

project.pdf:
	pandoc \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--include-in-header includes/header.tex \
		--include-before-body includes/before-body.tex \
		--metadata-file includes/metadata.yaml \
		includes/bibliography.yaml \
		chapters/* \
		-o project.pdf
