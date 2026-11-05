JOB := $(shell scripts/jobname.sh)
PDF := build/$(JOB).pdf
LOG := build/$(JOB).log
TEX := main.tex $(wildcard config/*.tex preamble/*.tex sections/*.tex sections/*/*.tex appendices/*.tex)

.PHONY: pdf watch check lint clean name

pdf:
	scripts/gitinfo.sh
	latexmk -jobname=$(JOB) main.tex

watch:
	scripts/gitinfo.sh
	latexmk -jobname=$(JOB) -pvc main.tex

check:
	@test -f $(PDF) || { echo "Missing $(PDF)"; exit 1; }
	@! grep -E 'LaTeX Warning: (Reference|Citation|Label).*(undefined|multiply)' $(LOG)
	@echo "OK: $(PDF)"

lint:
	@out=$$(chktex -q -I0 -l .chktexrc $(TEX)); if [ -n "$$out" ]; then echo "$$out"; exit 1; fi; echo "chktex: clean"

name:
	@echo $(JOB).pdf

clean:
	rm -rf build
