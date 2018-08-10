rm(list=ls())
library(PBSadmb)
source("c:/CEGM/MODEL/MSE2018/chas/runs/plotsite/funciones/read.admb.R")
source("c:/CEGM/MODEL/MSE2018/chas/runs/plotsite/funciones/FunctionMixSAN.R")
setwd("c:/CEGM/MODEL/MSE2018/chas/runs/sardina/")

# packages
library(reshape)
require(ggplot2)
require (lattice)
dat <- readRep("em", suffix = c(".REP"))

# Variables
So= dat$So
F60= dat$F60
rcaptura=dat$residualcaptura
rcpue=dat$residualcpue
rreclas=dat$residualreclas
rpelaces=dat$residualpelaces
NPS=dat$Numerodepecesenelstock
Reclutas=dat$Reclutamiento
F=dat$Mortalidadporpesca 
surveyobs= dat$SurveyObs
Surveyest= dat$SurveyEstReclas
surveyobsp=dat$SurveyObsPelaces
surveyestp=dat$SurveyEstPelaces
edad=dat$edad
ysurv=dat$yrsurv
yfish=dat$yrfish
obscpue=dat$DatosobservadosCPUE
estcpue=dat$DatospredichosCPUE
Yobs=dat$Capturaobservada
Yest=dat$Capturapredicha
Fy=dat$Mortalidadporpescaanual
BT=dat$Biomasatotal 
BA=dat$Biomasaadulta 
BD=dat$Biomasadesovante 
Potrep=dat$potencialreproductivo 
respropfish=dat$Residualesproporcionpesqueria 
respropreclas=dat$Residualesproporcionreclas 
resproppela=dat$Residualesproporcionpelaces 
pobs=dat$Propobservada
ppred=dat$Proppredicha 
pobsvadar=dat$Propobservadar
ppredchar=dat$Proppredichar 
pobsdap=dat$Propobservadap
ppredchap=dat$Proppredichap 
fobj=dat$FuncionObjetivo 
Sreclas=dat$selectividadreclas
Spela=dat$selectividadpelaces 
Sfish=dat$selectividadpesquerias 
rbmsylast=dat$rbmsylast 
Fmsylast =dat$Fmsylast 
trans=dat$trans 

# Falta agregar años pelaces
ypela= c(2003,2005,2006,2007,2009,2010,2011,2012,2013,2014, 2015, 2016, 2017, 2018)

################################################################################
# plot estimation model #
#########################################################################################
## capturas fit
Data1 = data.frame(list(year=yfish, Yflo_obs= Yobs,Yflo_pred=Yest))
datay=melt(Data1,id=c("year"))
colnames(datay)=c("año","Captura","Ton")
#plot tendencias
png(file=paste("Figuras/capturas.png")) 
ggplot(datay,aes(x=año,y=Ton,colour=Captura,group=Captura)) + geom_point()+
geom_line(data=datay[datay$Captura=="Yflo_pred",])+labs(y = "captura",x="año")+
ggtitle("Captura")
dev.off()

# survey1 fit RECLAS
Bsyear=NULL
a= NULL
nro=length(ysurv)
for (i in 1:nro)
	{
    a[i]=(ysurv[i]-1991)+1;	
	Bsyear=Surveyest[a];
	}
Bsyear
fit.acu = data.frame(list(year = ysurv,obs=surveyobs,pred=Bsyear))
fitacu=melt(fit.acu,id=c("year"))
colnames(fitacu)=c("año","variable","ton")
#plot
png(file=paste("Figuras/reclas.png"))
ggplot(fitacu,aes(x=año,y=ton,colour=variable,group=variable)) + geom_point()+
geom_line(data=fitacu[fitacu$variable=="pred",])+labs(y = "Reclasfit",x="año")+
ggtitle("Crucero RECLAS")
dev.off()

# survey2 fit PELACES
Bsyear2=NULL
a= NULL
nro=length(ypela)
for (i in 1:nro)
	{
    a[i]=(ypela[i]-1991)+1;	
	Bsyear2=surveyestp[a];
	}
Bsyear2
fit.acu2 = data.frame(list(year = ypela,obs=surveyobsp,pred=Bsyear2))
fitacu2=melt(fit.acu2,id=c("year"))
colnames(fitacu2)=c("año","variable","ton")
#plot
png(file=paste("Figuras/pelaces.png"))
ggplot(fitacu2,aes(x=año,y=ton,colour=variable,group=variable)) + geom_point()+
geom_line(data=fitacu2[fitacu2$variable=="pred",])+labs(y = "Pelafit",x="año")+
ggtitle("Crucero PELA")
dev.off()






#########################################################################################
#Salidas
#Biomasas y abundancias
#########################################################################################
Data.flu = data.frame(list(year = yfish,BT=BT,BA=BA,BD=BD,Reclutas=Reclutas))
dataf=melt(Data.flu,id=c("year"))
colnames(dataf)=c("año","tipo","ton")
# BT y desovante
databiom<-subset(dataf, tipo=="BT" | tipo=="BA"| tipo=="BD")
# Reclutas
datareclu=subset(dataf, tipo == "Reclutas", select = c(año,tipo,ton))
colnames(datareclu)=c("año","tipo","Número")
#plot biomasa
png(file=paste("Figuras/biomasas.png"))
ggplot(data=databiom,aes(x=año, y=ton, fill=tipo)) +geom_bar(stat = "identity")+
facet_grid(~tipo)+facet_wrap(~ tipo,ncol=2)+
labs(y = "Biomasa (t)",x="año")+ggtitle("Biomasas total, adulta y desovante")
dev.off()

#plot reclutas
options(scipen=10000)
png(file=paste("Figuras/reclutamiento.png"))
ggplot(data=datareclu,aes(x=año, y=Número, colour=año, fill=año)) +geom_bar(stat = "identity")+
labs(y = "Número",x="año")+ggtitle("Reclutamiento")
dev.off()


###############################################
#Selectividad
###############################################
Data.sel = data.frame(list(edad = edad,S1=Sfish[1,],Sreclas=Sreclas[1,],Spela=Spela[1,]))
datasel=melt(Data.sel,id=c("edad"))
colnames(datasel)=c("edad","fuente","S")

#plot Selectividades
png(file=paste("Figuras/selectividades.png"))
ggplot(data=datasel,aes(x=edad, y=S, fill=fuente)) +geom_line(stat = "identity")+
facet_grid(~fuente)+facet_wrap(~ fuente,ncol=2)+
labs(y = "Biomasa (t)",x="año")+ggtitle("Sfish, recla, pela")
dev.off()






