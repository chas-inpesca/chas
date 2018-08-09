## Quick example of how to use adnuts for a SS model. To be updated
## later as package and ADMB functionality changes.

## Cole Monnahan 6/2017.

#install.packages("snowfall")
#install.packages("shinystan")
#install.packages("R2admb")
library(adnuts)
library(R2admb)
library(snowfall)
library(shinystan)

## Directory containing all files. When run in parallel copies of this are
## made in the working diretory.
d <- '.'
m <- './om' # executable name

## First step: optimize model and get admodel.cov and .par files.

## Step 2: Switch starter file to start from .par files. For technical
## reasons (for now) the model needs to be optimized (but -nohess) so
## starting from the .par speeds this up. You might want to turn off some
## of the reporting detail to clean up console.


## Step 3: Run RWM since it is more robust to crazy models (yours probably
## is!).
iter <- 1000 # iterations after thinning
warmup <- iter/2 # warmup iterations after thinning
thin <- 100 # thin rate
reps <- 4 # parallel chains to run
inits <- NULL #rep(list(rnorm(154)),4) #"mixchas.pin" #NULL # use MLE after optimizing
#inits <- (list(rnorm(154))) #"mixchas.pin" #NULL # use MLE after optimizing
## Prepare snowfall for parallel execution
sfStop()
sfInit(parallel=TRUE, cpus=reps)
sfExportAll()
fit.rwm <-
  sample_admb(model=m, iter=thin*iter, init=inits, thin=thin,
              #parallel=FALSE, chains=reps, warmup=thin*warmup,
              parallel=TRUE, chains=reps, warmup=thin*warmup,
              dir=d, cores=reps, control=list(metric=NULL),
              algorithm='RWM')
launch_shinyadmb(fit.rwm)
thin <- 1 # thin rate
fit.nuts <-
  sample_admb(model=m, iter=thin*iter, init=inits, thin=thin,
              #parallel=FALSE, chains=reps, warmup=thin*warmup,
              parallel=TRUE, chains=reps, warmup=thin*warmup,
              dir=d, cores=reps, control=list(metric=NULL),
              algorithm='NUTS')
launch_shinyadmb(fit.nuts)
names(fit.rwm$mle$nopar )
(fit.rwm$mle$nopar )
(fit.rwm$mle$fit )
mle.fit <- fit.rwm$mle
## Quickly compare variances
vars.mle <- fit.rwm$mle$se[1:(fit.rwm$mle$nopar)]
## data.frame of posterior draws, after thinning and discarding warmup(burnin)
samples <- extract_samples(fit.rwm, inc_warmup=FALSE, inc_lp=FALSE)
dim(samples)
vars.mcmc <- apply(samples, 2, sd)
plot(vars.mle, vars.mcmc)
## Examine the slowest mixing parameters
chains <- rep(1:reps, each=dim(fit.rwm$samples)[1]-fit.rwm$warmup)
pars <- names(sort(fit.rwm$ess))[1:15]
pairs_admb(posterior=samples, mle=mle.fit, pars=pars, chains=chains)
## Or look at certain params
pars <- names(fit.rwm$ess)[grep('MGparm', x=names(fit.rwm$ess))]
pairs_admb(posterior=samples, mle=mle.fit, pars=pars, chains=chains)
pars <- names(sort(abs(vars.mle-vars.mcmc)/vars.mle, decreasing=TRUE))[1:5]
pairs_admb(posterior=samples, mle=mle.fit, pars=pars, chains=chains)
