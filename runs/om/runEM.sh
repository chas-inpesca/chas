echo "Hi there, running an EM now..." year $1 and sim $2
cp sem.dat em.dat
em -nox -nohess -iprint 300 >NUL
cp em.rep results/s_em_$3_$2_$1.rep
# Reglas / HCR to write "newabc.dat"
cp newabc.rep s_abc.dat
cat newabc.rep

cp aem.dat em.dat
em -nox -nohess -iprint 300 >NUL
cp em.rep results/a_em_$3_$2_$1.rep
cp newabc.rep a_abc.dat
cat newabc.rep



