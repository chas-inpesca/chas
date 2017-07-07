ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: pdf clean

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: AjusteQuotaMixta.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("AjusteQuotaMixta.Rmd");'
	pandoc -V geometry:margin=1in AjusteQuotaMixta.md -o AjusteQuotaMixta.pdf --latex-engine=xelatex

clean:
	$(RM) *.md
