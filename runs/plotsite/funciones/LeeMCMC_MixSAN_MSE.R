rm(list=ls())
library(reshape)
library(lattice)
library(ggplot2)
theme_set(theme_bw())

dir <- "Ricker"
dir <- "avgR"
dir <- "BevHoltSR"
#dir<-"Rciclico"
#OutDir <- paste("~/ADMwork/MixSan2013/MixSANIFOP/Salidas_MSE/",dir,sep="")
#OutDir <- paste("~/ADMwork/MixSan2013/MixSANIFOP/MSEv2/",dir,sep="")
#OutDir <- paste("~/ADMwork/MixSan2013/MixSANIFOP/MSEv3/",dir,sep="")

OutDir <- paste("~/ADMwork/MixSan2013/MixSANIFOPv2/Salidas_MSE/",dir,sep="")

setwd(OutDir)

if(dir=="avgR"){nr=266}else{nr=175}
nstr<-9
nr <- 100*nstr
yrs <-c("2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021")
Str<-rep(c("AF60","AF40","BF60","BF40","CF60","CF40","DF60","DF40","DF75"),nr/9)

#Lectura de datos
## RAZON SSB(t)/SSBo
# Razón St/So
s_spro=as.matrix(read.table("s_ssb_rat3_mcmc",nrow=nr,fill=T))
a_spro=as.matrix(read.table("a_ssb_rat3_mcmc",nrow=nr,fill=T))
# Captura
s_cyr=as.matrix(read.table("sben_cyr_mcmc",nrow=nr,fill=T))
a_cyr=as.matrix(read.table("erin_cyr_mcmc",nrow=nr,fill=T))
# Mort. Pesca
s_fyr=as.matrix(read.table("sben_fyr_mcmc",nrow=nr,fill=T))
a_fyr=as.matrix(read.table("erin_fyr_mcmc",nrow=nr,fill=T))
# Biomasa desovante
s_syr=as.matrix(read.table("sben_syr_mcmc",nrow=nr,fill=T))
a_syr=as.matrix(read.table("erin_syr_mcmc",nrow=nr,fill=T))
# Proporcion reclutamiento
s_p_cyr=as.matrix(read.table("prop_catch_ini_est",nrow=nr,fill=T))
s_p_cyr_mop=as.matrix(read.table("prop_catch_mop",nrow=nr,fill=T))
s_p_ryr_mop=as.matrix(read.table("prop_recl_mop",nrow=nr,fill=T))

###### Manipulacion ######
s_spro<-data.frame(s_spro)
a_spro<-data.frame(a_spro)
s_cyr<-data.frame(s_cyr)
a_cyr<-data.frame(a_cyr)
s_fyr<-data.frame(s_fyr)
a_fyr<-data.frame(a_fyr)
s_syr<-data.frame(s_syr)
a_syr<-data.frame(a_syr)
s_p_cyr<-data.frame(s_p_cyr)
s_p_cyr_mop<-data.frame(s_p_cyr_mop)
s_p_ryr_mop<-data.frame(s_p_ryr_mop)
colnames(s_spro)<-yrs
colnames(a_spro)<-yrs
colnames(s_cyr)<-yrs
colnames(a_cyr)<-yrs
colnames(s_fyr)<-yrs
colnames(a_fyr)<-yrs
colnames(s_syr)<-yrs
colnames(a_syr)<-yrs
colnames(s_p_cyr)<-yrs
colnames(s_p_cyr_mop)<-yrs
colnames(s_p_ryr_mop)<-yrs
s_spro$Str <- Str
a_spro$Str <- Str
s_cyr$Str <- Str
a_cyr$Str <- Str
s_fyr$Str <- Str
a_fyr$Str <- Str
s_syr$Str <- Str
a_syr$Str <- Str
s_p_cyr$Str<-Str
s_p_cyr_mop$Str<-Str
s_p_ryr_mop$Str<-Str
s_spro2 <- melt(s_spro)
a_spro2 <- melt(a_spro)
s_cyr2 <- melt(s_cyr)
a_cyr2 <- melt(a_cyr)
s_fyr2 <- melt(s_fyr)
a_fyr2 <- melt(a_fyr)
s_syr2 <- melt(s_syr)
a_syr2 <- melt(a_syr)
s_p_cyr2<-melt(s_p_cyr)
s_p_cyr_mop2<-melt(s_p_cyr_mop)
s_p_ryr_mop2<-melt(s_p_ryr_mop)

#Asigna Probabilidad
#Pr[SSB/SSBo<0.2]
s_spro2$p20<-ifelse(s_spro2$value<0.2,1,0)
a_spro2$p20<-ifelse(a_spro2$value<0.2,1,0)
#Pr[SSB/SSBo<0.4]
s_spro2$p40<-ifelse(s_spro2$value<0.4,1,0)
a_spro2$p40<-ifelse(a_spro2$value<0.4,1,0)
#Pr[SSB/SSBo>0.6]
s_spro2$p60<-ifelse(s_spro2$value<0.6,1,0)
a_spro2$p60<-ifelse(a_spro2$value<0.6,1,0)
n <- length(s_spro2$p20)/11 ##11 años por 100 replicas

#Pr[SSB/SSBo<0.2]
tapply(s_spro2$p20,s_spro2$Str,sum)/n 
tapply(a_spro2$p20,a_spro2$Str,sum)/n 
#Pr[SSB/SSBo<0.4]
tapply(s_spro2$p40,s_spro2$Str,sum)/n 
tapply(a_spro2$p40,a_spro2$Str,sum)/n 
#Pr[SSB/SSBo<0.6]
tapply(s_spro2$p60,s_spro2$Str,sum)/n 
tapply(a_spro2$p60,a_spro2$Str,sum)/n 
#Captura promedio
head(s_cyr)
tapply(s_cyr[,11],s_cyr$Str,mean) 
tapply(s_cyr[,11],s_cyr$Str,sd)/tapply(s_cyr[,11],s_cyr$Str,mean) 
 
if(dir=="avgR"){tit<-"Rprom"}
if(dir=="Ricker"){tit<-"Ricker"}
if(dir=="BevHoltSR"){tit<-"Bev.Holt"}
if(dir=="Rciclico"){tit="Rt Cíclico"}
#Graficas
quartz()
s1<-ggplot(s_spro2, aes(variable, value)) + geom_boxplot() + facet_grid(.~Str)+ylab("St/So") +xlab("Años")+ geom_hline(y=c(1,0.6,0.2),col=c("blue","green","red"))+labs(title = paste("Sardina - Pesca Mixta -",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
s1
ggsave(filename=paste("s_spro_MSE_",tit,".pdf",sep=""),plot=s1,width=12,height=8)

quartz()
a1<-ggplot(a_spro2, aes(variable, value)) + geom_boxplot() + facet_grid(.~Str)+ylab("St/So")+ xlab("Años")+ geom_hline(y=c(1,0.6,0.2),col=c("blue","green","red"))+labs(title = paste("Anchoveta - Pesca Mixta -",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
a1
ggsave(filename=paste("a_spro_MSE_",tit,".pdf",sep=""),plot=a1,width=12,height=8)


quartz()
s2<-ggplot(s_cyr2, aes(variable, value/1000)) + geom_boxplot() + facet_grid(.~Str)+ylab("Captura (1000 t)") +xlab("Años")+ geom_hline(y=c(800,200),col=c("red","green"))+labs(title = paste("Sardina - Ct - Pesca Mixta -",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
s2
ggsave(filename=paste("s_cyr_MSE_",tit,".pdf",sep=""),plot=s2,width=12,height=8)

quartz()
a2<-ggplot(a_cyr2, aes(variable, value/1000)) + geom_boxplot() + facet_grid(.~Str)+ylab("Captura (1000 t)") +xlab("Años")+ geom_hline(y=c(800,200),col=c("red","green"))+labs(title = paste("Anchoveta - Ct - Pesca Mixta -",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
a2
ggsave(filename=paste("a_cyr_MSE_",tit,".pdf",sep=""),plot=a2,width=12,height=8)

quartz()
s3<-ggplot(s_p_cyr2, aes(variable, value)) + geom_boxplot() + facet_grid(.~Str)+ylab("Proporción en Captura") +xlab("Años")+ geom_hline(y=c(0.9,0.5,0.1),col=c("red","green","blue"))+labs(title = paste("Sardina - pt inicial - Pesca Mixta",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
s3
ggsave(filename=paste("s_p_cyr_MSE_",tit,".pdf",sep=""),plot=s3,width=12,height=8)

quartz()
s4<-ggplot(s_p_cyr_mop2, aes(variable, value)) + geom_boxplot() + facet_grid(.~Str)+ylab("Proporción en Captura") +xlab("Años")+ geom_hline(y=c(0.9,0.5,0.1),col=c("red","green","blue"))+labs(title = paste("Sardina - pt MOP - Pesca Mixta",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
s4
ggsave(filename=paste("s_p_cyr_mop_MSE_",tit,".pdf",sep=""),plot=s4,width=12,height=8)

quartz()
s5<-ggplot(s_p_ryr_mop2, aes(variable, value)) + geom_boxplot() + facet_grid(.~Str)+ylab("Proporción de Biomasa") +xlab("Años")+ geom_hline(y=c(0.9,0.5,0.1),col=c("red","green","blue"))+labs(title = paste("Sardina - pt MOP - Pesca Mixta",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
s5
ggsave(filename=paste("s_p_ryr_mop_MSE_",tit,".pdf",sep=""),plot=s5,width=12,height=8)

quartz()
s6<-ggplot(s_fyr2, aes(variable, value)) + geom_boxplot() + facet_grid(.~Str)+ylab("Mort. Pesca") +xlab("Años")+ geom_hline(y=c(0.242,0.446,0.134),col=c("green","red","blue"))+labs(title = paste("Sardina - Ft MOP - Pesca Mixta",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))+ylim(c(0,2))
s6
ggsave(filename=paste("s_fyr_mop_MSE_",tit,".pdf",sep=""),plot=s6,width=12,height=8)

quartz()
a6<-ggplot(a_fyr2, aes(variable, value)) + geom_boxplot() + facet_grid(.~Str)+ylab("Mort. Pesca") +xlab("Años")+ geom_hline(y=c(0.55,1.04,0.134),col=c("green","red","blue"))+labs(title = paste("Anchoveta - Ft MOP - Pesca Mixta",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))+ylim(c(0,2))
a6
ggsave(filename=paste("a_fyr_mop_MSE_",tit,".pdf",sep=""),plot=a6,width=12,height=8)

quartz()
s7<-ggplot(s_syr2, aes(variable, value/1000)) + geom_boxplot() + facet_grid(.~Str)+ylab("Desovante (1000 t)") +xlab("Años")+labs(title = paste("Sardina - St MOP - Pesca Mixta",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
#+ geom_hline(y=c(0.242,0.446,0.134),col=c("green","red","blue"))
s7
ggsave(filename=paste("s_syr_mop_MSE_",tit,".pdf",sep=""),plot=s7,width=12,height=8)

quartz()
a7<-ggplot(a_syr2, aes(variable, value/1000)) + geom_boxplot() + facet_grid(.~Str)+ylab("Desovante (1000 t)") +xlab("Años")+labs(title = paste("Anchoveta - St MOP - Pesca Mixta",tit))+scale_x_discrete(breaks=c("2011","2015","2020"))
#+ geom_hline(y=c(0.242,0.446,0.134),col=c("green","red","blue"))
a7
ggsave(filename=paste("a_syr_mop_MSE_",tit,".pdf",sep=""),plot=a7,width=12,height=8)

#### EVALUA EL DESEMPEÑO DEL ESTIMADOR #####
a_byr.es=as.matrix(read.table("a_byr_mcmc_est",nrow=nr,fill=T))
s_byr.es=as.matrix(read.table("s_byr_mcmc_est",nrow=nr,fill=T))
a_byr.op=as.matrix(read.table("erin_byr_mcmc",nrow=nr,fill=T))
s_byr.op=as.matrix(read.table("sben_byr_mcmc",nrow=nr,fill=T))
a_syr.es=as.matrix(read.table("a_syr_mcmc_est",nrow=nr,fill=T))
s_syr.es=as.matrix(read.table("s_syr_mcmc_est",nrow=nr,fill=T))
a_syr.op=as.matrix(read.table("erin_syr_mcmc",nrow=nr,fill=T))
s_syr.op=as.matrix(read.table("sben_syr_mcmc",nrow=nr,fill=T))
a_fyr.es=as.matrix(read.table("a_mps_mcmc_est",nrow=nr,fill=T))
s_fyr.es=as.matrix(read.table("s_mps_mcmc_est",nrow=nr,fill=T))
a_fyr.op=as.matrix(read.table("erin_fyr_mcmc",nrow=nr,fill=T))
s_fyr.op=as.matrix(read.table("sben_fyr_mcmc",nrow=nr,fill=T))

a_Qbyr = 100*(a_byr.es-a_byr.op)/a_byr.op #hacer un data frame con
s_Qbyr = 100*(s_byr.es-s_byr.op)/s_byr.op #hacer un data frame con
a_Qsyr = 100*(a_syr.es-a_syr.op)/a_syr.op #hacer un data frame con
s_Qsyr = 100*(s_syr.es-s_syr.op)/s_syr.op #hacer un data frame con
a_Qfyr = 100*(a_fyr.es-a_fyr.op)/a_fyr.op #hacer un data frame con
s_Qfyr = 100*(s_fyr.es-s_fyr.op)/s_fyr.op #hacer un data frame con

nd<-length(a_byr.es[,1])
Strategy<-rep(c("AF60","AF40","BF60","BF40","CF60","CF40","DF40","DF60","F75"),nd/9)

#Error porcentual relativo
a_Qbyr <- data.frame(a_Qbyr)
s_Qbyr <- data.frame(s_Qbyr)
a_Qsyr <- data.frame(a_Qsyr)
s_Qsyr <- data.frame(s_Qsyr)
a_Qfyr <- data.frame(a_Qfyr)
s_Qfyr <- data.frame(s_Qfyr)

colnames(a_Qbyr)<-yrs
colnames(s_Qbyr)<-yrs
colnames(a_Qsyr)<-yrs
colnames(s_Qsyr)<-yrs
colnames(a_Qfyr)<-yrs
colnames(s_Qfyr)<-yrs

a_Qbyr$Str<-Strategy
s_Qbyr$Str<-Strategy
a_Qsyr$Str<-Strategy
s_Qsyr$Str<-Strategy
a_Qfyr$Str<-Strategy
s_Qfyr$Str<-Strategy

a_Qbyr2<-melt(a_Qbyr)
s_Qbyr2<-melt(s_Qbyr)
a_Qsyr2<-melt(a_Qsyr)
s_Qsyr2<-melt(s_Qsyr)
a_Qfyr2<-melt(a_Qfyr)
s_Qfyr2<-melt(s_Qfyr)

quartz()
ds1<-ggplot(s_Qbyr2,aes(value))+geom_histogram()+facet_grid(.~Str)+ylab("Frecuencia")+xlab("EPR (%) - Biomasa total")+xlim(c(-150,150))+labs(title = paste("Sardina - Bt - Pesca Mixta",tit))
+scale_x_discrete(breaks=c(-150,0,150))
ds1
ggsave(filename=paste("s_byr_Desemp_",tit,".pdf",sep=""),plot=ds1,width=12,height=8)

quartz()
da1<-ggplot(a_Qbyr2,aes(value))+geom_histogram()+facet_grid(.~Str)+ylab("Frecuencia")+xlab("EPR (%) - Biomasa total")+xlim(c(-150,150))+labs(title = paste("Anchoveta - Bt - Pesca Mixta -",tit))
+scale_x_discrete(breaks=c(-150,0,150))
da1
ggsave(filename=paste("a_byr_Desemp_",tit,".pdf",sep=""),plot=da1,width=12,height=8)

quartz()
ds2<-ggplot(s_Qsyr2,aes(value))+geom_histogram()+facet_grid(.~Str)+ylab("Frecuencia")+xlab("EPR (%) - Desovante")+xlim(c(-150,150))+labs(title = paste("Sardina - St - Pesca Mixta -",tit))
+scale_x_discrete(breaks=c(-150,0,150))
ds2
ggsave(filename=paste("s_syr_Desemp_",tit,".pdf",sep=""),plot=ds2,width=12,height=8)

quartz()
da2<-ggplot(a_Qsyr2,aes(value))+geom_histogram()+facet_grid(.~Str)+ylab("Frecuencia")+xlab("EPR (%) - Desovante")+xlim(c(-150,150))+labs(title = paste("Anchoveta - St - Pesca Mixta -",tit))
+scale_x_discrete(breaks=c(-150,0,150))
da2
ggsave(filename=paste("a_syr_Desemp_",tit,".pdf",sep=""),plot=da2,width=12,height=8)

quartz()
ds3<-ggplot(s_Qfyr2,aes(value))+geom_histogram()+facet_grid(.~Str)+ylab("Frecuencia")+xlab("EPR (%) - Mort. Pesca")+xlim(c(-150,150))+labs(title = paste("Sardina - Ft - Pesca Mixta -",tit))
+scale_x_discrete(breaks=c(-150,0,150))
ds3
ggsave(filename=paste("s_fyr_Desemp_",tit,".pdf",sep=""),plot=ds3,width=12,height=8)

quartz()
da3<-ggplot(a_Qfyr2,aes(value))+geom_histogram()+facet_grid(.~Str)+ylab("Frecuencia")+xlab("EPR (%) - Mort. Pesca")+xlim(c(-150,150))+labs(title = paste("Anchoveta - Ft - Pesca Mixta -",tit))
+scale_x_discrete(breaks=c(-150,0,150))
da3
ggsave(filename=paste("a_fyr_Desemp_",tit,".pdf",sep=""),plot=da3,width=12,height=8)




#########
addpoly <- function(yrvec,lower,upper,r,g,b,alpha1=0.05,alpha2=0.6){
	#agrega intervalos de incertidumbre
	good <- !is.na(lower) & !is.na(upper)
	polygon(x=c(yrvec[good],rev(yrvec[good])),
	        y=c(lower[good],rev(upper[good])),
	        border=NA,col=rgb(r,g,b,alpha1))
	lines(yrvec[good],lower[good],lty=3,col=rgb(r,g,b,alpha2))
	lines(yrvec[good],upper[good],lty=3,col=rgb(r,g,b,alpha2))
}

#Manipulación data
AF40b<-a_Qbyr[a_Qbyr$Str=="AF40",,]
AF40s<-a_Qsyr[a_Qsyr$Str=="AF40",,]
AF40f<-a_Qfyr[a_Qfyr$Str=="AF40",,]
AF60b<-a_Qbyr[a_Qbyr$Str=="AF60",,]
AF60s<-a_Qsyr[a_Qsyr$Str=="AF60",,]
AF60f<-a_Qfyr[a_Qfyr$Str=="AF60",,]

#Intervalo de Confianzaaa mu1,mu2, mu3 por separado
IC=0.90
IC2=0.75
IC3=0.50
intervals=TRUE
dat<-AF40b[,c(1:11)]
dat2<-AF40s[,c(1:11)]
dat3<-AF40f[,c(1:11)]
dat4<-AF60b[,c(1:11)]
dat5<-AF60s[,c(1:11)]
dat6<-AF60f[,c(1:11)]

quartz()
par(oma=c(1,1,1,1),mar=c(2,4,0,1))
layout(matrix(1:6,ncol=3,byrow=TRUE),widths=rep(c(1,1,1,1),2))
# Grafico1 
plot(yrs,yrs,type="n",ylim=c(-100,100),xlim=c(2011,2021),ylab="EPR [Biomasa] (%)",xlab="Año",cex.lab=1.2,cex.axis=1.2,axes=F)
axis(side=1,labels=F);axis(side=2,labels=T)
#Agrega Poligono
#IC=0.90
addpoly(yrvec=yrs,
        lower=apply(dat,2,quantile,probs=(1-IC)/2),
        upper=apply(dat,2,quantile,probs=1-(1-IC)/2),r=0,g=0,b=0)
#IC=0.75
addpoly(yrvec=yrs,
        lower=apply(dat,2,quantile,probs=(1-IC2)/2),
        upper=apply(dat,2,quantile,probs=1-(1-IC2)/2),r=0,g=0,b=0)
abline(h=0,lty=3,lwd=2)
lines(yrs,apply(dat,2,median),col=rgb(0,0,0,0.6),lwd=2)

#Grafico 2
plot(yrs,yrs,type="n",ylim=c(-100,100),xlim=c(2011,2021),ylab="EPR [Desovante] (%)",xlab="Año",axes=F,cex.axis=1.2,cex.lab=1.2)
axis(side=1,labels=F);axis(side=2,labels=T)
#Agrega Poligono
#IC=0.90
addpoly(yrvec=yrs,
        lower=apply(dat2,2,quantile,probs=(1-IC)/2),
        upper=apply(dat2,2,quantile,probs=1-(1-IC)/2),r=0,g=0,b=0)
#IC=0.75
addpoly(yrvec=yrs,
        lower=apply(dat2,2,quantile,probs=(1-IC2)/2),
        upper=apply(dat2,2,quantile,probs=1-(1-IC2)/2),r=0,g=0,b=0)
abline(h=0,lty=3,lwd=2)
lines(yrs,apply(dat2,2,median),col=rgb(0,0,0,0.6),lwd=2)

#Grafico 3
plot(yrs,yrs,type="n",ylim=c(-100,100),xlim=c(2011,2021),ylab="EPR [Mort. Pesca](%)",xlab="Año", axes=F, cex.axis=1.2, cex.lab=1.2)
axis(side=1,labels=F);axis(side=2,labels=T)
#Agrega Poligono
#IC=0.90
addpoly(yrvec=yrs,
        lower=apply(dat3,2,quantile,probs=(1-IC)/2),
        upper=apply(dat3,2,quantile,probs=1-(1-IC)/2),r=0,g=0,b=0)
#IC=0.75
addpoly(yrvec=yrs,
        lower=apply(dat3,2,quantile,probs=(1-IC2)/2),
        upper=apply(dat3,2,quantile,probs=1-(1-IC2)/2),r=0,g=0,b=0)
abline(h=0,lty=3,lwd=2)
lines(yrs,apply(dat3,2,median),col=rgb(0,0,0,0.6),lwd=2)

# 
plot(yrs,yrs,type="n",ylim=c(-100,100),xlim=c(2011,2021),ylab="EPR [Biomasa] (%)",xlab="Año",axes=F,cex.lab=1.2,cex.axis=1.2)
axis(side=1,labels=T);axis(side=2,labels=T)
#Agrega Poligono
#IC=0.90
addpoly(yrvec=yrs,
        lower=apply(dat4,2,quantile,probs=(1-IC)/2),
        upper=apply(dat4,2,quantile,probs=1-(1-IC)/2),r=0,g=0,b=0)
#IC=0.75
addpoly(yrvec=yrs,
        lower=apply(dat4,2,quantile,probs=(1-IC2)/2),
        upper=apply(dat4,2,quantile,probs=1-(1-IC2)/2),r=0,g=0,b=0)
abline(h=0,lty=3,lwd=2)
lines(yrs,apply(dat4,2,median),col=rgb(0,0,0,0.6),lwd=2)

#Grafico 2
plot(yrs,yrs,type="n",ylim=c(-100,100),xlim=c(2011,2021),ylab="EPR [Desovante] (%)",xlab="Año",axes=F,cex.axis=1.2,cex.lab=1.2)
axis(side=1,labels=T);axis(side=2,labels=T)
#Agrega Poligono
#IC=0.90
addpoly(yrvec=yrs,
        lower=apply(dat5,2,quantile,probs=(1-IC)/2),
        upper=apply(dat5,2,quantile,probs=1-(1-IC)/2),r=0,g=0,b=0)
#IC=0.75
addpoly(yrvec=yrs,
        lower=apply(dat5,2,quantile,probs=(1-IC2)/2),
        upper=apply(dat5,2,quantile,probs=1-(1-IC2)/2),r=0,g=0,b=0)
abline(h=0,lty=3,lwd=2)
lines(yrs,apply(dat5,2,median),col=rgb(0,0,0,0.6),lwd=2)

#Grafico 3
plot(yrs,yrs,type="n",ylim=c(-100,100),xlim=c(2011,2021),ylab="EPR [Mort. Pesca (%)",xlab="Año",axes=F,cex.lab=1.2,cex.axis=1.2)
axis(side=1,labels=T);axis(side=2,labels=T)

#Agrega Poligono
#IC=0.90
addpoly(yrvec=yrs,
        lower=apply(dat6,2,quantile,probs=(1-IC)/2),
        upper=apply(dat6,2,quantile,probs=1-(1-IC)/2),r=0,g=0,b=0)
#IC=0.75
addpoly(yrvec=yrs,
        lower=apply(dat6,2,quantile,probs=(1-IC2)/2),
        upper=apply(dat6,2,quantile,probs=1-(1-IC2)/2),r=0,g=0,b=0)
abline(h=0,lty=3,lwd=2)
lines(yrs,apply(dat6,2,median),col=rgb(0,0,0,0.6),lwd=2)
####






###############################################
jpeg(filename="Fig1s_spro.jpg",width=12,height=10,units="in",pointsize=12,quality=100,bg="white",res=300)
bwplot(value~factor(variable)|Str,data=s_cyr2,
strip=strip.custom(bg=grey(0.85)),
par.settings=list(plot.symbol=list(col=1, cex=0.3),
box.dot=list(cex=0.75), box.rectangle=list(col=1), box.umbrella=list(col=1)),
layout=(c(2,4)),ylab="St/So",ylim=c(0,4),
between = list(x = c(0, 0), y = 0),
panel = function(...) 
   { 
      panel.abline(h=1,lwd=2,col.line="red") 
      panel.bwplot(...)
   }
)
dev.off()


font.settings <- list( font = 1, cex = 1, fontfamily = "serif") 
my.theme <- list( 
  box.umbrella = list(col = "black"), 
  box.rectangle = list(fill= rep(c("black", "black"),2)), 
  box.dot = list(col = "black", pch = 3, cex=2), 
  plot.symbol   = list(cex = 1, col = 1, pch= 0), #outlier size and color 
  par.xlab.text = font.settings, 
  par.ylab.text = font.settings, 
  axis.text = font.settings, 
  par.sub=font.settings) 
quartz()
bwplot(value~factor(variable),data=s_spro2,groups=Str,box.width=1/7,
auto.key=list(points=F,rectangles=T,space="right",title="Strat",cex.title=1),
panel=panel.superpose,
ylab="St/So",
xlab="Year",
par.settings=my.theme,
panel.groups=function(x,y,...,group.number){
	panel.bwplot(x+(group.number-1.8)/7,y,...)
})

#Graficos alternativos no usados
iqr<-function(x,...){
	qs<-quantile(as.numeric(x),c(0.25,0.75),na.rm=T)
	names(qs)<-c("ymin","ymax")
	qs
}

#para tratar
iqr(a_Qsyr2$value)
tapply(a_Qsyr2$value,a_Qsyr2$variable,iqr)
quartz()
da14<-ggplot(a_Qsyr2,aes(x=variable,y=value/1000))+geom_line()+facet_grid(.~Str)+scale_color_gradient(low="darkgrey",high="red")

+ylab("Frecuencia")+xlab("Año")+labs(title = "Anchoveta - St - Pesca Mixta - Rprom")+stat_summary(fun.data=median_hilow,conf.int=0.5,geom='ribbon')
+scale_x_discrete(breaks=c("2011","2015","2020"))
+ylim(c(0,2))
da14
a_Qsyr2[1:14,]


#Lenfest Predator responses
#Mamiferos marinos (Sea Lion)
s_D=0.039+0.132 #Neira et al. (2004), año 1998
a_D=0.035+0.066
alpha=0.68
beta=0.85
rho=exp(4.44)
s_spro2$Rmm <- rho*(s_D)^(alpha)*(1-s_spro2$value)^beta
Resp<-s_spro2[s_spro2$value>0,,]
tapply(Resp$Rmm,Resp$Str,sum) 


