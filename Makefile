.PHONY: test

MARKDOWN_FILES = $(shell find chapters -type f -name '*.md' | sort)

test: project.pdf
	-./quit.sh project.pdf
	open project.pdf
	-ag --ignore Makefile todo && say todo
	-ag --ignore Makefile citeme && say cite me
	-ag --ignore Makefile whilst && say remove whilst
	scp project.pdf hgs:uploads/project.pdf &

project.pdf: $(MARKDOWN_FILES) includes/*
	pandoc \
		--filter pandoc-crossref \
		--include-before-body includes/before-body.tex \
		--metadata-file includes/metadata.yaml \
		--bibliography includes/hub-report.bib \
		$(MARKDOWN_FILES) \
		-o project.pdf

project.docx: $(MARKDOWN_FILES) includes/*
	echo $(MARKDOWN_FILES)
	pandoc \
		--filter pandoc-crossref \
		--include-before-body includes/before-body.tex \
		--metadata-file includes/metadata.yaml \
		--bibliography includes/hub-report.bib \
		$(MARKDOWN_FILES) \
		-o project.docx
