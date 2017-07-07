ifdef ComSpec
    RM=del /F /Q
    COPY=copy
else
    RM=rm -rf
    COPY=cp
endif

all: build/chas 

build/chas: build chas.tpl 
	@admb -g chas.tpl $(LIB)
	@$(COPY) chas build/
	@$(RM) chas

build:
	@echo creating build directory
	@mkdir -p build

clean:
	@$(RM) build
	@$(RM) gmacs.cpp
	@$(RM) gmacs.htp
	@$(RM) gmacs.obj
	@$(RM) lib/*.obj
