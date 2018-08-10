rm(list=ls())
library(PBSadmb)
library(Hmisc)
library(lattice)
library(survival)
library(Formula)
library(ggplot2)

#Things to compare
# Biomasatotal
# Biomasadesovante
# Reclutamiento

# LECTURA REPORTE
comparefolders<-c("sardina18","sardina_cy")
dir.pres<-getwd()

setwd(file.path(dir.pres,"sardina18"))
bM <- readRep("em", suffix = c(".rep"))

setwd(file.path(dir.pres,"sardina_cy"))
cM <- readRep("em", suffix = c(".rep"))

setwd(dir.pres)

yrs<-1991:2018
colrs<-RColorBrewer::brewer.pal(2,"Set2")
###
par(mfrow=c(2,2))
Biomasatotal<-matrix(nrow=2,ncol=length(cM$Biomasatotal))
Biomasatotal[1,] <- bM$Biomasatotal
Biomasatotal[2,] <- cM$Biomasatotal

plot(NA,ylim=range(Biomasatotal),xlim=range(yrs),xlab="Year",ylab="Biomasa Total",main="Biomasa Total")
for(i in 1:2) {
lines(x=yrs,y=Biomasatotal[i,],col=colrs[i],lwd=2)
}
legend("topleft",lty=1,col=colrs,legend=c("Biological","Calendar"))

###

Biomasadesovante<-matrix(nrow=2,ncol=length(cM$Biomasadesovante))
Biomasadesovante[1,] <- bM$Biomasadesovante
Biomasadesovante[2,] <- cM$Biomasadesovante

plot(NA,ylim=range(Biomasadesovante),xlim=range(yrs),xlab="Year",ylab="Biomasa Desovante", main="Biomasa Desovante")
for(i in 1:2) {
lines(x=yrs,y=Biomasadesovante[i,],col=colrs[i],lwd=2)
}

###

Reclutamiento <- matrix(nrow=2,ncol=length(cM$Reclutamiento))
Reclutamiento[1,] <- bM$Reclutamiento
Reclutamiento[2,] <- cM$Reclutamiento

plot(NA,ylim=range(Reclutamiento),xlim=range(yrs),xlab="Year",ylab="Reclutamiento", main="Reclutamiento")
for(i in 1:2) {
lines(x=yrs,y=Reclutamiento[i,],col=colrs[i],lwd=2)
}

###

F60 <- c(bM$F60,cM$F60)
names(F60) <- c("Biological","Calendar")
barplot(F60, main="F60")

