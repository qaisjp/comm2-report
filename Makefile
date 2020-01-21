.PHONY: project.tex project.pdf

project.tex:
	cat includes/header.tex > project.tex

	# Introduction
	printf "%s\n" "\chapter{Introduction}" >> project.tex
	pandoc chapters/01-introduction.md -t latex >> project.tex

	# Implementation
	printf "%s\n" "\chapter{Implementation}" >> project.tex
	pandoc chapters/02-implementation.md -t latex >> project.tex

	cat includes/footer.tex >> project.tex

project.pdf: project.tex
	latexmk -pdf project.tex