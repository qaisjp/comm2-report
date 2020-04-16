.PHONY: project.pdf

project.pdf:
	pandoc \
		--filter pandoc-crossref \
		--include-before-body includes/before-body.tex \
		--metadata-file includes/metadata.yaml \
		--bibliography includes/hub-report.bib \
		chapters/**/*.md \
		-o project.pdf
	scp project.pdf hgs:uploads/project.pdf &
