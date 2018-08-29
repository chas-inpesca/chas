cd ..\..\src
call admb om.tpl
cd ..\runs\mixsan
copy ..\..\src\om.exe 
om -nox -iprint 200
