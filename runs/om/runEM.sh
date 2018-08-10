echo "Hi there, running an EM now..."
cp sem.dat em.dat
em -nox -nohess -iprint 300
# Reglas / HCR to write "newabc.dat"
cp newabc.rep s_abc.dat
cat newabc.rep

cp aem.dat em.dat
em -nox -nohess -iprint 300
cp newabc.rep a_abc.dat
cat newabc.rep



