cd ..\..\src
call admb em.tpl
cd ..\runs\anchoveta
copy ..\..\src\em.exe 
em -nox -iprint 200
