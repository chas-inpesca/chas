# Chilean sardine-anchovy MSE (Chas)
## Getting started
### Windows ADMB installation
Download and execute install file from http://www.admb-project.org/downloads/ (admb-12.0-windows10-mingw64.exe)

Follow readme file instructions at: http://www.admb-project.org/downloads/admb-12.0/QuickStartWindows.html
or simply update (from chas directory)

### Test compilation ADMB installation
Clone (initial install of chas repository) or update:
```
git clone https://github.com/chas-inpesca/chas.git
```
or simply update (from chas directory)
```
git pull 
```

runmcmc.bat does the following
   1 ensures that om.exe and em.exe are copied from src directory
   2 executes a simple short mcmc sample to create a new om.psv file (from which to simulate)
   3 executes an om -mceval run which does the projection and estimation
        - note that runem.bat is called
runmceval.bat (only does step 3 above)
runem.bat executes the estimation model (em.exe) for the current file
```
ensures that om.exe and em.exe are copied from src directory

```