.PHONY: project.pdf

project.pdf:
	pandoc \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--include-in-header includes/header.tex \
		--include-before-body includes/before-body.tex \
		--metadata-file includes/metadata.yaml \
		--bibliography includes/bibliography.yaml \
		chapters/* \
		-o project.pdf
	scp project.pdf hgs:uploads/project.pdf &
