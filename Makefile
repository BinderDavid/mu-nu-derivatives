MODE = batchmode

LATEX = pdflatex -interaction=$(MODE) -synctex=1
BIB = bibtex

MAIN_DEPS = $(wildcard *.tex)

.PHONY: all view clean

all : paper.pdf

view:
	@xdg-open paper.pdf &

clean:
	@find . -name "*.aux" -type f -delete
	@find . -name "*.log" -type f -delete
	@find . -name "*.bbl" -type f -delete
	@find . -name "*.blg" -type f -delete
	@find . -name "*.bcf" -type f -delete
	@find . -name "*.run.xml" -type f -delete
	@find . -name "*.out" -type f -delete
	@find . -name "*.pdf" -type f -delete
	@find . -name "*.synctex.gz" -type f -delete
	@echo "Deleted .aux .log .out .synctex.gz .pdf files."

.PHONY : bib
bib : paper.tex bib.bib
	$(LATEX) paper ;true 
	$(BIB) paper
	$(LATEX) paper ;true
	$(LATEX) paper ;true

paper.pdf: $(MAIN_DEPS) paper.tex
	$(LATEX) paper.tex
