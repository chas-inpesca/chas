ifdef ComSpec
    RM=del /F /Q
    COPY=copy
		admb = C:\programs\ADMB\bin\admb.cmd
else
    RM=rm -rf
    COPY=cp
		admb = admb
endif

all: build/em build/om

build/em: build em.tpl 
	@$(admb) -f em.tpl $(LIB) 
	@$(COPY) em build/ 
	@$(RM) em

build/om: build om.tpl
	@$(admb) -f om.tpl $(LIB)
	@$(COPY) om build/ 
	@$(RM) om


build:
	@echo creating build directory
	@mkdir -p build

clean:
	@$(RM) build
	@$(RM) em.cpp
	@$(RM) em.htp
	@$(RM) em.obj
