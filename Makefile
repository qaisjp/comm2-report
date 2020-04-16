.PHONY: project.pdf

project.pdf:
	pandoc \
		--filter pandoc-crossref \
		--include-before-body includes/before-body.tex \
		--metadata-file includes/metadata.yaml \
		--bibliography includes/hub-report.bib \
		chapters/**/*.md \
		-o project.pdf
	ag TODO && say TODO
	ag CITEME && say CITEME
	ag whilst && say REMOVE WHILST
	scp project.pdf hgs:uploads/project.pdf &
