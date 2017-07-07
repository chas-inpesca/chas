EXEC = chas
ARGS = -nox -iprint 50 

	DIST = ../../src/build/

ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: run plot

$(EXEC): $(DIST)$(EXEC).tpl
	ln -sf $(DIST)$(EXEC) $@

$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../src

run: $(EXEC)
	./$(EXEC) $(ARGS)

plot:
	R CMD BATCH plot.R

clean:
	@$(RM) -f $(EXEC)
	@$(RM) -f gradient.[0123456789]
	@$(RM) -f admodel.*
	@$(RM) -f $(EXEC)  $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance

clobber: clean
	@$(RM) -f *.par *_in.* *.rep
