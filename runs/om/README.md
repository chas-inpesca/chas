# Operating model 

## Getting started
```
 make mcmc 
```
  will check of ../../src/om.tpl needs compiling, then run a rudimentary set from MCMC posterior and call runEM.sh...which needs updating obviously.

```
 make mceval 
```
uses the existing .psv for redoing the MSE

*Key files:* 
runEM.sh

### OM Commands

Command     | Description
------------|--------------
`om -nox`   | Runs the operating model once
`make`		| Recompiles `../../src/om.tpl` as necessary, runs the model and generates plots
`make mcmc`	| Runs the model, generates a .psv file, generates new data files (current default set to 10000 mcmc runs, saves every 1000, but overwrites a single data file each run (`sardina.dat` & `anchoveta.dat`))
`make mceval`	| Generates new data files, assuming `mcmc` has already been done and `.psv file` exists

`runEM.sh` is equivalent to .bat file; contains the defaults