# Read in dat file
# Assumes you're working in the EM directory

source(file.path(here::here("R"),"read.admb.R"))

emfile <- read.admb("em")

# Separate EM elements
names(emfile) <- stringr::str_replace(names(emfile),"\\$","")

list2env(emfile,env=environment())

Nyrsurv <- length(yrsurv)
Nyrfish <- length(yrfish)

yrsCPUE <- 1991:2000

yrsr <- yrsurv[(Nyrsurv-NROW(Propobservadar)+1):Nyrsurv]
yrsp <- yrsurv[(Nyrsurv-NROW(Propobservadap)+1):Nyrsurv]

#------------------
# Plot Length Comps
#------------------
getgridrange <- function(Nyears) {
	return(c(round(Nyears/5),5))
}

plotLengthComps <- function(obs,est,yrs,txt="Length Comps") {
	Nyrs<-NROW(obs)
	par(mfrow=getgridrange(Nyrs),mar=c(.1,1,1,.1),oma=c(2,1,2,1)) 
	for(i in 1:Nyrs) {
		barplot(obs[i,],xaxt='n',ylim=range(obs),yaxt='n')
		lines(x=1:NCOL(obs),y=est[i,],lwd=2)
		mtext(side=3,yrs[i],line=-1.5)
	}
	par(mfrow=c(1,1))
	mtext(side=3, txt,line=1.5)

}

#-----------------------
# Fits to survey biomass
#-----------------------
plotDataFit <- function(obs,est,yrsobs,yrsest=yrfish,txt="Survey Fits",...) {
	ylims <- range(c(obs,est))
	plot(y=est,x=yrsest, type='l',lwd=2,ylim=ylims,xlab="Year",ylab=NA,...)
	points(y=obs,x=yrsobs)
	mtext(side=3,txt)
}

#-----------
# Make plots
#-----------
pdf("EMplots.pdf")
plotLengthComps(Propobservada,Proppredicha,yrfish,"Fishery Length Comps")
plotLengthComps(Propobservadar,Proppredichar,yrsr, "Reclas Length Comps")
plotLengthComps(Propobservadap,Proppredichap,yrsp, "Pelaces Length Comps")

par(mfrow=c(2,1),mar=c(2,2,.1,.1),oma=c(1,1,2,1))
plotDataFit(SurveyObs,SurveyEstReclas,yrsr,txt="Reclas Fits",xaxt='n')
plotDataFit(SurveyObsPelaces,SurveyEstPelaces,yrsp,txt="Pelaces Fits")
par(mfrow=c(1,1))

plotDataFit(DatosobservadosCPUE,DatospredichosCPUE,yrsobs=yrsCPUE,txt="CPUE")
plotDataFit(Capturaobservada,Capturapredicha,yrsobs=yrfish,txt="Catch")
dev.off()

