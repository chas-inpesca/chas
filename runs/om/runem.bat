echo "Hi there, running an EM now..." year %1 and sim %2
if not exist "results" mkdir results 
copy sem.dat em.dat
em -nox -nohess -iprint 300 >NUL
copy em.rep results\s_em_%3_%2_%1.rep
# Reglas / HCR to write "newabc.dat"
copy newabc.rep s_abc.dat
type newabc.rep

copy aem.dat em.dat
em -nox -nohess -iprint 300 >NUL
copy em.rep results\a_em_%3_%2_%1.rep
copy newabc.rep a_abc.dat
type newabc.rep

