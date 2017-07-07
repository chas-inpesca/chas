ifdef ComSpec
    RM=del /F /Q
    COPY=copy
else
    RM=rm -rf
    COPY=cp
endif

all: build/chas build/mixchas

build/chas: build chas.tpl 
	@admb -g chas.tpl $(LIB)
	@$(COPY) chas build/
	@$(RM) chas

build/mixchas: build mixchas.tpl
	@admb -g mixchas.tpl $(LIB)
	@$(COPY) mixchas build/
	@$(RM) mixchas


build:
	@echo creating build directory
	@mkdir -p build

clean:
	@$(RM) build
	@$(RM) chas.cpp
	@$(RM) chas.htp
	@$(RM) chas.obj
