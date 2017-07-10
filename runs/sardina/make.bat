cd ..\..\src
call admb em.tpl
cd ..\runs\sardina
copy ..\..\src\em.exe 
em -nox -iprint 200
