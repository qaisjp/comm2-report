# .PHONY: project.pdf

MARKDOWN_FILES = $(shell find chapters -type f -name '*.md' | sort)

project.pdf: $(MARKDOWN_FILES) includes/*
	echo $(MARKDOWN_FILES)
	pandoc \
		--filter pandoc-crossref \
		--include-before-body includes/before-body.tex \
		--metadata-file includes/metadata.yaml \
		--bibliography includes/hub-report.bib \
		$(MARKDOWN_FILES) \
		-o project.pdf
	open project.pdf
	ag TODO && say TODO
	ag CITEME && say CITEME
	ag whilst && say REMOVE WHILST
	scp project.pdf hgs:uploads/project.pdf &
