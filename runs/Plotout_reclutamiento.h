rm(list=ls())
wd= getwd()
setwd(wd)
library(PBSadmb)
# packages
library(reshape)
require(ggplot2)
require (lattice)
library(xtable)
# Read rep

dats= readList("sardina/em.rep");
data= readList("anchoveta/em.rep");
datse= read.table(file = "sardina/em.std", header = T,na.strings = "*")
datae= read.table(file = "anchoveta/em.std", header = T,na.strings = "*")
ran=data$Reclutamiento/1000 # a miles
ras=dats$Reclutamiento/1000 #
y=seq(1991,2016,1)
#####################################################
dsardi=data.frame(list(year = y,Reclutas=ran))
dancho=data.frame(list(year = y,Reclutas=ras))
#plotsardina
png(file=paste("output/1.png"))
ggplot(data=dsardi,aes(x=year, y=Reclutas,fill=year)) +geom_bar(stat = "identity")+
labs(y = "Reclutamiento",x="a?o")+ggtitle("Reclutamiento sardina (miles)")
dev.off()

#plotanchoveta
png(file=paste("output/2.png"))
ggplot(data=dancho,aes(x=year, y=Reclutas,fill=year)) +geom_bar(stat = "identity")+
labs(y = "Reclutamiento",x="a?o")+ggtitle("Reclutamiento anchoveta (miles)")
dev.off()

# Tablas
#write.table(dsardi, file = "output/tabla_s.prn", sep = " ", col.names = T,qmethod = "double")
#write.table(dancho, file = "output/tabla_a.prn", sep = " ", col.names = T,qmethod = "double")
tabla1=xtable(dsardi)
tabla2=xtable(dancho)
print.xtable(tabla1, type="latex", file="output/t1.tex", append=F, caption.placement="top")
print.xtable(tabla2, type="latex", file="output/t2.tex", append=F, caption.placement="top")
