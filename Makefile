.PHONY: project.pdf

project.pdf:
	pandoc \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--include-in-header includes/include.tex \
		--include-before-body includes/acknowledgements.tex \
		--metadata-file includes/metadata.yaml \
		includes/bibliography.yaml \
		chapters/* \
		-o project.pdf
	scp project.pdf hgs:uploads/project.pdf &