rm(list=ls())
library(PBSadmb)
library(Hmisc)
library(lattice)
library(survival)
library(Formula)
library(ggplot2)
# LECTURA REPORTE
M8 <- readRep("chas", suffix = c(".rep"))
# vectores

rescap<-    M8$residualcaptura
rescpue<-   M8$residualcpue
resreclas<- M8$residualreclas
respela<-   M8$residualpelaces
abun<-      M8$Numerodepecesenelstock
BR<-        M8$Reclutamiento
Fanual<-    M8$Mortalidadporpesca  
surv_obs<-  M8$SurveyObs
surv_est<-  M8$SurveyEstReclas
surv_est2<-  M8$SurveyEstReclas2
surv_est3<-  M8$SurveyEstReclas3
surv_est4<-  M8$SurveyEstReclas4
surv_obspel<- M8$SurveyObsPelaces
surv_estpel<- M8$SurveyEstPelaces
surv_estpel2<- M8$SurveyEstPelaces2
surv_estpel3<- M8$SurveyEstPelaces3
surv_estpel4<- M8$SurveyEstPelaces4
age<-       M8$edad
ysurv<-     M8$yrsurv
yfish<-     M8$yrfish
cpue_obs<-  M8$DatosobservadosCPUE
cpue_est<-  M8$DatospredichosCPUE
cpue_est2<-  M8$DatospredichosCPUE2
cpue_est3<-  M8$DatospredichosCPUE3
cpue_est4<-  M8$DatospredichosCPUE4
Y_obs<-     M8$Capturaobservada 
Y_est<-     M8$Capturapredicha
Y_estp<-     M8$Capturapredichap
Y_estpsq<-     M8$Capturapredichapsq
Y_estpsq2<-     M8$Capturapredichapsq2
Y_est2<-     M8$Capturapredicha2
Y_est3<-     M8$Capturapredicha3
Y_est4<-     M8$Capturapredicha4
Fy<-        M8$Mortalidadporpescaanual
bt<-        M8$Biomasatotal
bt2<-        M8$Biomasatotal2
bt3<-        M8$Biomasatotal3
bt4<-        M8$Biomasatotal4
ba<-        M8$Biomasaadulta 
bd<-        M8$Biomasadesovante
bdp<-        M8$Biomasadesovantep
bdpsq<-        M8$Biomasadesovantepsq
bdpsq2<-        M8$Biomasadesovantepsq2
bd2<-        M8$Biomasadesovante2
bd3<-        M8$Biomasadesovante3
bd4<-        M8$Biomasadesovante4
RPR<-       M8$potencialreproductivo
RPR2<-       M8$potencialreproductivo2
RPR3<-       M8$potencialreproductivo3
RPR4<-       M8$potencialreproductivo4
ResPesq<-   M8$Residualesproporcionpesqueria 
ResRec<-    M8$Residualesproporcionreclas
ResPel<-    M8$Residualesproporcionpelaces  
Pobs<-      M8$Propobservada 
Pest<-      M8$Proppredicha
Pobsr<-     M8$Propobservadar 
Pestr<-     M8$Proppredichar
Pobsp<-     M8$Propobservadap 
Pestp<-     M8$Proppredichap
f<-         M8$FuncionObjetivo
selr<-      M8$selectividadreclas 
selp<-      M8$selectividadpelaces
selpesq<-   M8$selectividadpesquerias
bmsy<-   M8$msy
fmsy<-   M8$f

yfish<- c(1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016)
ycpue<- c(1991,1992,1993,1994,1995,1996,1997,1998,1999,2000)
ysurv<- c(2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016)
ysurvpel<- c(2003,2005,2006,2007,2009,2010,2011,2012,2013,2014,2015,2016)
yfishp<- c(1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022)


###################GRAFICO QQ-PLOT
x11()
par(mfrow=c(4,2))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
qqnorm(rescap,main = "Capturas",cex.main=1,ylab="Residual predicho",xlab="Residual teórico");
qqnorm(rescpue,main = "CPUE",cex.main=1,ylab="Residual predicho",xlab="Residual teórico");
qqnorm(resreclas,main = "Reclas",cex.main=1,ylab="Residual predicho",xlab="Residual teórico");
qqnorm(respela,main = "Pelaces",cex.main=1,ylab="Residual predicho",xlab="Residual teórico");
qqnorm(ResPesq,main = "Composición Pesquería",cex.main=1,ylab="Residual predicho",xlab="Residual teórico");
qqnorm(ResRec,main = "Composición Reclas",cex.main=1,ylab="Residual predicho",xlab="Residual teórico");
qqnorm(ResPel,main = "Composición Pelaces",cex.main=1,ylab="Residual predicho",xlab="Residual teórico");

####################GRAFICO RESIDUALES 
par(mfrow=c(2,2))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="r",yaxs="r")
plot(yfish,rescap,type="p",tcl=-0.25,cex.axis=0.7,xlab = "Años", ylab = "Residual Captura",lab=c(10, 10, 15),cex=1.5)
abline(h = 0,col="skyblue");
plot(ycpue,rescpue,type="p",tcl=-0.25,cex.axis=0.7, xlab = "Años", ylab = "Residual CPUE",lab=c(10, 10, 15),cex=1.5)
abline(h = 0,col="skyblue");
plot(ysurv,resreclas,type="p",tcl=-0.25,cex.axis=0.7, xlab = "Años", ylab = "Residual Reclas",lab=c(10, 10, 15),cex=1.5)
abline(h = 0,col="skyblue");
plot(ysurvpel,respela,type="p",tcl=-0.25,cex.axis=0.7, xlab = "Años", ylab = "Residual Pelaces",lab=c(10, 10, 15),cex=1.5)
abline(h = 0,col="skyblue");

####################RESIDUAL COMPOSICIÓN PESQUERÍA
dimnames(ResPesq) <- list(c("1991","1992", "1993", "1994", "1995", "1996", "1997", "1998",
                       "1999", "2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008", "2009", "2010", "2011", "2012", "2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))
powr = 1 # tamaño a los bubbles

x <- as.numeric(dimnames(ResPesq)[[2]]); xlim <- range(x) + c(-.5,.5);
y <- as.numeric(dimnames(ResPesq)[[1]]); ylim <- range(y) + c(-1,1);
#expandGraph(mgp=c(2,.5,0),las=1)
x11()
par(mfrow=c(1,1)) 
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="r",yaxs="r")
plotBubbles(ResPesq,xval=x,yval=y,powr=powr,cex.axis=0.7,size=0.25,xlim=xlim,ylim=ylim,xlab="Longitud (cms)",ylab="Años Pesquería",cex.lab=0.8,clrs=c("black","red","blue"),main="",hide0=TRUE,lab=c(10, 10, 15),cex=1,cpro=0, lwd=1.5,frange=1.5, prettyaxis=TRUE)

#####################RESIDUAL COMPOSICIÓN RECLAS
dimnames(ResRec) <- list(c("2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008", "2009", "2010", "2011", "2012", "2013", "2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))
powr = 1 #tamaño a los bubbles
x <- as.numeric(dimnames(ResRec)[[2]]); xlim <- range(x) + c(-.5,.5);
y <- as.numeric(dimnames(ResRec)[[1]]); ylim <- range(y) + c(-1,1);
#expandGraph(mgp=c(2,.5,0),las=1)
x11()
par(mfrow=c(1,1))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="r",yaxs="r")
plotBubbles(ResRec,xval=x,yval=y,powr=powr,cex.axis=0.7,size=0.25,xlim=xlim,ylim=ylim,xlab="Longitud (cms)",ylab="Años Crucero Reclas",cex.lab=0.8,clrs=c("black","red","blue"),main="",hide0=TRUE,lab=c(10, 10, 15),cex=1,cpro=0, lwd=1.5,frange=1.5, prettyaxis=TRUE)

#################RESIDUAL COMPOSICIÓN PELACES
dimnames(ResPel) <- list(c("2003", "2005", "2006", "2007", "2009", "2010", "2011", "2012", "2013", "2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))
powr = 1 #tamaño a los bubbles
x <- as.numeric(dimnames(ResPel)[[2]]); xlim <- range(x) + c(-.5,.5);
y <- as.numeric(dimnames(ResPel)[[1]]); ylim <- range(y) + c(-1,1);
#expandGraph(mgp=c(2,.5,0),las=1)
x11()
par(mfrow=c(1,1))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="r",yaxs="r")
plotBubbles(ResPel,xval=x,yval=y,powr=powr,cex.axis=0.7,size=0.25,xlim=xlim,ylim=ylim,xlab="Longitud (cms)",ylab="Años Crucero Pelaces",cex.lab=0.8,clrs=c("black","red","blue"),main="",hide0=TRUE,lab=c(10, 10, 15),cex=1,cpro=0, lwd=1.5,frange=1.5, prettyaxis=TRUE)

##################COMPOSICIONES POR EDAD PESQUERÍA
source('../R/figures.r')
variable <-  M8$Propobservada
dimnames(variable) <- list(c("1991","1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))
# plotea la estructura de tamaños
x11()
plot.N(variable, ratio.bars = 10, col.bars = "white","y",tick.number = 4,  ylab = "Proporción", xlab = "Longitud (cms)",cex.lab=0.9,tcl=-0.25,cex.axis=0.7)

################### COMPOSICIONES POR EDAD RECLAS
source('figures.r')
variable <-  M8$Propobservadar
dimnames(variable) <- list(c("2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))

# plotea la estructura de tamaños
x11()
plot.N(variable, ratio.bars = 10, col.bars = "grey", "y",tick.number = 4, ylab = "Proporción", xlab = "Longitud (cms)",cex.lab=0.9,tcl=-0.25,cex.axis=0.7)

################### COMPOSICIONES POR EDAD PELACES
source('figures.r')
variable <-  M8$Propobservadap
dimnames(variable) <- list(c("2003", "2005", "2006", "2007", "2009", "2010", "2011", "2012", "2013", "2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))

# plotea la estructura de tamaños
x11()
plot.N(variable, ratio.bars = 10, col.bars = "grey", "y",tick.number = 4, ylab = "Proporción", xlab = "Longitud (cms)",cex.lab=0.9,tcl=-0.25,cex.axis=0.7)

################### AJUSTES DE COMPOSICION PESQUERÍA
Pest  <-  M8$Proppredicha
dimnames(Pest) <-     list(c("1991","1992", "1993", "1994", "1995", "1996", "1997", "1998",
                       "1999", "2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))
powr = 1 # tamaño a los bubbles

Pobs  <-  M8$Propobservada
dimnames(Pobs) <-     list(c("1991","1992", "1993", "1994", "1995", "1996", "1997", "1998",
                       "1999", "2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))

modelo <- list(Pobs = Pobs, Pest = Pest)
x11()  
plot.ca(modelo, col.lines = c("black"),cex.lab=0.9,tcl=-0.25,cex.axis=0.7,lty.grid = 0,lty.lines = 1,tick.number = 3, lwd.lines = 2,pch = 1,col.bars="blue",xlab="Longitud (cms)",ylab="Proporción",ratio.bars = 10, col.bars = "white",)

##################### AJUSTES DE COMPOSICION RECLAS
Pestr  <-  M8$Proppredichar
dimnames(Pestr) <- list(c("2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))

Pobsr  <-  M8$Propobservadar
dimnames(Pobsr) <- list(c("2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))

modelo <- list(Pobsr = Pobsr, Pestr = Pestr)
x11()  ## puntos son datos y linea ajuste
plot.ca(modelo, col.lines = c("red"),lty.grid = 0, col.grid = "red",tick.number = 4, pch = 1, cex.points = 1,
col.points = "red", lty.lines = 1,cex.lab=0.9,tcl=-0.25,cex.axis=0.7, lwd.lines = 2, xlab = "Longitud (cms)", ylab = "Proporción Reclas")

######################## AJUSTES DE COMPOSICION PELACES
Pestp  <-  M8$Proppredichap
dimnames(Pestp) <- list(c("2003","2005", "2006","2007","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))

Pobsp  <-  M8$Propobservadap
dimnames(Pobsp) <- list(c("2003","2005", "2006","2007","2009","2010","2011","2012","2013","2014","2015","2016"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))

modelo <- list(Pobsp = Pobsp, Pestp = Pestp)
x11()  ## puntos son datos y linea ajuste
plot.ca(modelo, col.lines = c("red"),lty.grid = 0, col.grid = "red",tick.number = 4, pch = 1, cex.points = 1,
col.points = "red", lty.lines = 1,cex.lab=0.9,tcl=-0.25,cex.axis=0.7, lwd.lines = 2, xlab = "Longitud (cms)", ylab = "Proporción Pelaces")


#################INDICES OBSERVADOS
x11()
par(mfrow=c(2,2))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="r",yaxs="r")
plot(ysurv,surv_obs,type="h",tcl=-0.25,lwd=8,xlab="Años",cex.lab=0.9,cex.axis=0.7,ylim=c(0,5000000),ylab="Crucero Reclas (ton)",lab=c(10, 10, 20),cex=1);
plot(ysurvpel,surv_obspel,type="h",tcl=-0.25,lwd=8,cex.lab=0.9,xlab="Años",cex.axis=0.7,ylim=c(0,2500000),ylab="Crucero Pelaces (ton)",lab=c(10, 10, 20),cex=1);
plot(ycpue,cpue_obs,type="o",lwd=1.5,tcl=-0.25,xlab="Años",cex.axis=0.8,cex.lab=0.9,ylim=c(1,4.5),ylab="CPUE (t/vcp)",lab=c(10, 10, 20), cex=1);
plot(yfish,Y_obs,type="s",lwd=1.5,xlab="Años",tcl=-0.25,cex.axis=0.7,cex.lab=0.9, ylim=c(0,1000000),ylab="Capturas (ton)",lab=c(10, 10, 25), cex=1);

###################SELECTIVIDAD 
source("convertmatrix.h")
require (lattice)
selpesq <- convertmatrix(selpesq)
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
xyplot(N ~ Ages | factor(Year) , data =selpesq, type = "l", ylab=" Selectividad Pesquería", xlab="Edad",lab=c(5, 5, 5),
tcl=-5.55,cex.axis=0.001,cex.lab=0.1, col="black", lwd=2, as.table=TRUE,strip = strip.custom(bg ="grey"))

###################CAPTURAS, RENDIMIENTOS, ACUSTICA Y F (CASO BASE)###
x11()
par(mfrow=c(2,2))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(yfish,Y_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico", ylim=c(0,1000000),ylab="Capturas (ton)",lab=c(10, 10, 10), cex=1.5);
lines(yfish,Y_est,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,col="black",ylim=c(0,1000000),cex=1.5);
plot(ycpue,cpue_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",ylim=c(0,6),ylab="CPUE (t/vcp)",lab=c(10, 10, 10), cex=1.5);
lines(ycpue,cpue_est,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",col="black",lab=c(10, 10, 10), cex=1.5);
plot(ysurv,surv_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",ylim=c(0,5000000),ylab="Crucero Reclas (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurv,surv_est,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",col="black",ylim=c(0,4500000),cex=1.5);   
plot(ysurvpel,surv_obspel,type="p",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",ylim=c(0,2500000),ylab="Crucero Pelaces (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurvpel,surv_estpel,type="l",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",col="black",ylim=c(0,2500000),cex=1.5);   

###################CAPTURAS, RENDIMIENTOS, ACUSTICA Y F (CASO BASE 2)###
x11()
par(mfrow=c(2,2))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(yfish,Y_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico", ylim=c(0,1000000),ylab="Capturas (ton)",lab=c(10, 10, 10), cex=1.5);
lines(yfish,Y_est2,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,col="black",ylim=c(0,1000000),cex=1.5);
plot(ycpue,cpue_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",ylim=c(0,6),ylab="CPUE (t/vcp)",lab=c(10, 10, 10), cex=1.5);
lines(ycpue,cpue_est2,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",col="black",lab=c(10, 10, 10), cex=1.5);
plot(ysurv,surv_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",ylim=c(0,5000000),ylab="Crucero Reclas (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurv,surv_est2,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",col="black",ylim=c(0,4500000),cex=1.5);   
plot(ysurvpel,surv_obspel,type="p",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",ylim=c(0,2500000),ylab="Crucero Pelaces (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurvpel,surv_estpel2,type="l",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",col="black",ylim=c(0,2500000),cex=1.5);   

###################CAPTURAS, RENDIMIENTOS, ACUSTICA Y F (CASO BASE 3)###
x11()
par(mfrow=c(2,2))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(yfish,Y_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico", ylim=c(0,1000000),ylab="Capturas (ton)",lab=c(10, 10, 10), cex=1.5);
lines(yfish,Y_est3,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,col="black",ylim=c(0,1000000),cex=1.5);
plot(ycpue,cpue_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",ylim=c(0,6),ylab="CPUE (t/vcp)",lab=c(10, 10, 10), cex=1.5);
lines(ycpue,cpue_est3,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",col="black",lab=c(10, 10, 10), cex=1.5);
plot(ysurv,surv_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",ylim=c(0,5000000),ylab="Crucero Reclas (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurv,surv_est3,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",col="black",ylim=c(0,4500000),cex=1.5);   
plot(ysurvpel,surv_obspel,type="p",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",ylim=c(0,2500000),ylab="Crucero Pelaces (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurvpel,surv_estpel3,type="l",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",col="black",ylim=c(0,2500000),cex=1.5);   

###################CAPTURAS, RENDIMIENTOS, ACUSTICA Y F (CASO BASE 4)###
x11()
par(mfrow=c(2,2))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(yfish,Y_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico", ylim=c(0,1000000),ylab="Capturas (ton)",lab=c(10, 10, 10), cex=1.5);
lines(yfish,Y_est4,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,col="black",ylim=c(0,1000000),cex=1.5);
plot(ycpue,cpue_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",ylim=c(0,6),ylab="CPUE (t/vcp)",lab=c(10, 10, 10), cex=1.5);
lines(ycpue,cpue_est4,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",col="black",lab=c(10, 10, 10), cex=1.5);
plot(ysurv,surv_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",ylim=c(0,5000000),ylab="Crucero Reclas (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurv,surv_est4,type="l",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años",col="black",ylim=c(0,4500000),cex=1.5);   
plot(ysurvpel,surv_obspel,type="p",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",ylim=c(0,2500000),ylab="Crucero Pelaces (ton)",lab=c(10, 10, 10),cex=1.5);
lines(ysurvpel,surv_estpel4,type="l",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",col="black",ylim=c(0,2500000),cex=1.5);   

#RECLUTAMIENTOS
BRpromedio<-mean(BR)
BRpromedio9107<- 125333182.4#desde el archivo report
BRpromedio0816<-266884033.3#desde el archivo report

par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(yfish,BR,type="o",cex=2,lty=1,xlab="Años",cex.lab=1,tcl=-0.25,cex.axis=0.8,ylim=c(0,425500000), lwd=1.9, ylab="Reclutamiento (num)",lab=c(10, 10, 20));
abline(h =BRpromedio,xlim=c(1991,2007),lty=2,lwd=1.5,col="black");
text(1991,1995, "Rec promedio", col = "black", adj = c(-2, -14.5))
abline(h =BRpromedio9107, lty=2,lwd=1,col="gray60");
text(1991,1995, "Rec 1991-2007", col = "gray60", adj = c(-2.8, -9))
abline(h=BRpromedio0816, lty=2,lwd=1,col="green");
text(1991,1995, "Rec 2008-2016", col = "green", adj = c(-0.5, -22))
legend(1993,385500000,cex=1,legend=c("Reclutamiento estimado"),lty=c(1),lwd=c(1.75),col=c("black"),bty="n")

#BIOMASAS 
x11()
par(mfrow=c(3,1))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(yfish,bt,type="l",lty=1,xlab="Años",cex.lab=1.3,tcl=-0.25,cex.axis=1,ylim=c(0,4500000), lwd=1.5, ylab="Biomasa total (ton)",lab=c(15, 15, 10));
lines(yfish,bt2,type="l",lty=2,xlab="Años",cex.lab=1.2,tcl=-0.25,cex.axis=1,ylim=c(0,2500000), lwd=1, ylab="Biomasa (toneladas)",lab=c(15, 15, 10));
lines(yfish,bt3,type="l",lty=3,xlab="Años",cex.lab=1,tcl=-0.25,cex.axis=1,ylim=c(0,2500000), lwd=1, ylab="Biomasa (toneladas)",lab=c(15, 15, 10));
lines(yfish,bt4,type="l",lty=4,xlab="Años",cex.lab=1,tcl=-0.25,cex.axis=1,ylim=c(0,2500000), lwd=1, ylab="Biomasa (toneladas)",lab=c(15, 15, 10));
legend(1999,4799000,cex=1.3,legend=c("caso base","caso 2","caso 3","caso 4"),lty=c(1,2,3,4),lwd=c(1,1,1,1),col=c("black","black","black","black"),bty="n")

plot(yfish,bd,type="l",lty=1,xlab="Años",cex.lab=1.3,tcl=-0.25,cex.axis=1,ylim=c(0,1800000), lwd=1.5, ylab="Biomasa desovante (ton)",lab=c(15, 15, 10));
lines(yfish,bd2,type="l",lty=2,lwd=1,col="black",cex.lab=1.2,tcl=-0.25,cex.axis=1,pch=c(20),xlab="Años", ylim=c(0,1000000), ylab="Biomasa desovante(ton)",lab=c(10, 10, 10));
lines(yfish,bd3,type="l",lty=3,lwd=1,col="black",cex.lab=1,tcl=-0.25,cex.axis=1,pch=c(20),xlab="Años", ylim=c(0,1000000), ylab="Biomasa desovante(ton)",lab=c(10, 10, 10));
lines(yfish,bd4,type="l",lty=4,lwd=1,col="black",cex.lab=1.2,tcl=-0.25,cex.axis=1,pch=c(20),xlab="Años", ylim=c(0,1000000), ylab="Biomasa desovante (ton)",lab=c(10, 10, 10));
legend(2000,1800000,cex=1.3,legend=c("caso base","caso 2","caso 3","caso 4"),lty=c(1,2,3,4),lwd=c(1,1,1,1),col=c("black","black","black","black"),bty="n")

plot(yfish,RPR,type="l",lty=1,xlab="Años",cex.lab=1.3,tcl=-0.25,cex.axis=1,ylim=c(0,1.5), lwd=1.5, ylab="RPR",lab=c(15, 15, 10));
lines(yfish,RPR2,type="l",lty=2,lwd=1,col="black",cex.lab=1.2,tcl=-0.5,cex.axis=1,pch=c(20),xlab="Años", ylim=c(0,1), ylab="RPR",lab=c(10, 10, 10));
lines(yfish,RPR3,type="l",lty=3,lwd=1,col="black",cex.lab=1,tcl=-0.5,cex.axis=1,pch=c(20),xlab="Años", ylim=c(0,1), ylab="RPR",lab=c(10, 10, 10));
lines(yfish,RPR4,type="l",lty=4,lwd=1,col="black",cex.lab=1,tcl=-0.5,cex.axis=1,pch=c(20),xlab="Años", ylim=c(0,1), ylab="RPR",lab=c(15, 15, 15));
legend(1998.5,1.6,cex=1.3,legend=c("caso base","caso 2","caso 3","caso 4"),lty=c(1,2,3,4),lwd=c(1,1,1,1),col=c("black","black","black","black"),bty="n")

###############DIAGRAMA DE FASES SARDINA COMUN#######################
So<-1287610
#BIOMASA EN MSY
Bmrs<-0.55*So
Bmrs
Bcolapso<-0.275*So
Bcolapso
BcolapsoMSY<-Bcolapso/Bmrs
BcolapsoMSY
#F EN MSY
Fmrs<-0.49177
#SERIES DIAGRAMA
B<-bd/Bmrs
F<-Fy/Fmrs

x11()
par(mfrow=c(1,1))
par(mar=c(3.5,3.5,2,1),mgp=c(2,0.7,0),xaxt="t");
plot(B,F,type="l",lty=1,lwd=1.5,col="black",pch=c(20),tck=-0.015,xlab="B/Bmrs",xlim=c(0,3.5),ylim=c(0,3.5),ylab="F/Fmrs",lab=c(5, 5, 10));
rect(-1,1,1,11,lty=1,lwd=1.7,col =c("gray"))
rect(1,1,11,11,lty=1,lwd=1.7,col =c("beige"))
rect(1,-1,10,1,lty=1,lwd=1.7,col =c("beige"))
rect(-1,-1,1,1,lty=1,lwd=1.7,col =c("gray"))
lines(bmsy,fmsy,type="p",col="grey",pch=c(35),cex=0.4);
lines(B,F,type="o",lty=1,lwd=2,col="black",pch=c(21),xlab="B/Bmrs",xlim=c(0,4),ylim=c(0,6),ylab="F/Fmrs",lab=c(5, 5, 10));
legend(1.45,0.95,legend=c("2016"),bty="n",cex=0.8)
legend(0.5,2.5,legend=c("1991"),bty="n",cex=0.5)
legend(0.2,0.83,legend=c("1995"),bty="n",cex=0.5)#################
legend(0.9,2,legend=c("2011"),bty="n",cex=0.5) 
abline(v =0.5, lty=2,lwd=2,col="red");
abline(v =0.9, lty=2,lwd=1,col="green");
abline(v =1.35, lty=2,lwd=1,col="green");
abline(h =1.1, lty=2,lwd=1,col="green");
abline(h =0.35, lty=2,lwd=1,col="green");
legend(1.9,0.3,legend=c("Subexplotación"),bty="n",cex=0.9) 
legend(0.35,0.8,legend=c("Sobre"),bty="n",cex=0.7)
legend(0.35,0.7,legend=c("explotación"),bty="n",cex=0.7)
legend(0.8,.8,legend=c("Plena explotación"),bty="n",cex=1.3)
legend(-0.35,0.7,legend=c("Colapso"),bty="n",cex=1.2) 
legend(1.5,2.5,legend=c("Sobrepesca"),bty="n",cex=1.5) 

#####################BIOMASAS Y CAPTURAS PROYECTADOS
x11()
par(mfrow=c(2,1))
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(yfishp,bdp,type="l",lty=1,xlab="Años",cex.lab=0.9,tcl=-0.25,cex.axis=0.7,ylim=c(0,2000000), lwd=1.5, ylab="Biomasa desovante (ton)",lab=c(15, 15, 10));
lines(yfishp,bdpsq,type="l",lty=2,xlab="Años",cex.lab=0.8,tcl=-0.25,cex.axis=0.7,ylim=c(0,1500000), lwd=1, ylab="Biomasa desovante (ton)",lab=c(15, 15, 10));
lines(yfishp,bdpsq2,type="l",lty=3,xlab="Años",cex.lab=0.8,tcl=-0.25,cex.axis=0.7,ylim=c(0,1500000), lwd=1, ylab="Biomasa desovante (ton)",lab=c(15, 15, 10));
legend(1995,1850000,legend=c("Fmrs","F40","Fsq"),lty=c(1,2,3),lwd=c(1,1,1),col=c("black"),bty="n")
abline(h=Bmrs,v = 2016,lty=2,col="green");
abline(h=Bcolapso,v = 2016,lty=2,col="red");
legend(1998,1030000,legend=c("Brms"),col=c("green"),bty="n")
legend(2010,660000,legend=c("Blim"),col=c("red"),bty="n")

plot(yfishp,Y_estp,type="l",lty=1,xlab="Años",cex.lab=0.9,tcl=-0.25,cex.axis=0.7,ylim=c(0,1200000), lwd=1.5, ylab="Capturas (ton)",lab=c(15, 15, 10));
lines(yfishp,Y_estpsq,type="l",lty=2,lwd=1,col="black",cex.lab=0.8,tcl=-0.25,cex.axis=0.7,pch=c(20),xlab="Años", ylim=c(0,1), ylab="RPR",lab=c(10, 10, 10));
lines(yfishp,Y_estpsq2,type="l",lty=3,lwd=1,col="black",cex.lab=0.8,tcl=-0.25,cex.axis=0.7,pch=c(20),xlab="Años", ylim=c(0,1), ylab="RPR",lab=c(10, 10, 10));
legend(1995,1200000,legend=c("Fmrs","F40","Fsq"),lty=c(1,2,3),lwd=c(1,1,1),col=c("black"),bty="n")
abline(h=mean(Y_obs),v = 2016,lty=2,col="red");


mean(Y_obs)
#####################GRAFICAS DESVIACIÓN DE VARIABLES DE ESTADO##############################################
ruta<-file.choose()
datos<-read.table(ruta,header=T,sep=",",dec=".")
datos
dim(datos)
attach(datos)
sard_std<-datos # read.csv("sard_desv.csv", header=T,sep="",dec=".",na.strings = "NA", colClasses = NA)
names(sard_std) # variables que posee la base
attach(sard_std) # Forma de extrar variables de los datos

Bt_std<- subset(sard_std,name=="totbiom")
Bd_std<- subset(sard_std,name=="ssbiom")
R_std<-  subset(sard_std,name=="rec_dev")
F_std<-  subset(sard_std,name=="Fmort")
RPR<-  subset(sard_std,name=="RPR")
captura_std<- subset(sard_std,name=="pred_catch")
cpue_std<- subset(sard_std,name=="pred_cpue")
reclas_std<- subset(sard_std,name=="pred_surv")
pelaces_std<- subset(sard_std,name=="pred_survpel")

#year <- seq(2011,2020,by=1)
media1<- Bt_std$value
error1<- Bt_std$error
sup1<-   media1+error1
inf1<-   media1-error1
yfish<-  c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data1 <- data.frame(list(year = yfish, media = media1,error=error1,  sup=sup1, inf=inf1))

#year <- seq(2011,2020,by=1)
media3<- Bd_std$value
error3<- Bd_std$error
sup3<-   media3+error3
inf3<-   media3-error3
yfish<-  c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data3 <- data.frame(list(year = yfish, media = media3,error=error3,  sup=sup3, inf=inf3))

#year <- seq(2011,2020,by=1)
media4<- R_std$value
error4<- R_std$error
sup4<-   media4+error4
inf4<-   media4-error4
yfish<-  c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data4 <- data.frame(list(year = yfish, media = media4,error=error4,  sup=sup4, inf=inf4))

#year <- seq(2011,2020,by=1)
media5<- F_std$value
error5<- F_std$error
sup5<-   media5+error5
inf5<-   media5-error5
yfish<-  c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data5 <- data.frame(list(year = yfish, media = media5,error=error5,  sup=sup5, inf=inf5))

#year <- seq(2011,2020,by=1)
media8<- RPR$value
error8<- RPR$error
sup8<-   media8+error8
inf8<-   media8-error8
yfish<-  c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data8 <- data.frame(list(year = yfish, media = media8,error=error8,sup=sup8, inf=inf8))

#captura
media10<- captura_std$value
error10<- captura_std$error
sup10<-   media10+error10
inf10<-   media10-error10
yfish<-  c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data10 <- data.frame(list(year = yfish, media = media10,error=error10,sup=sup10, inf=inf10))

#cpue
media11<- cpue_std$value
error11<- cpue_std$error
sup11<-   media11+error11
inf11<-   media11-error11
yfish<-  c(1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000)
Data11 <- data.frame(list(year = yfish, media = media11,error=error11,sup=sup11, inf=inf11))

#reclas
media12<- reclas_std$value
error12<- reclas_std$error
sup12<-   media12+error12
inf12<-   media12-error12
yfish<-  c(2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data12 <- data.frame(list(year = yfish, media = media12,error=error12,sup=sup12, inf=inf12))

#pelaces
media13<- pelaces_std$value
error13<- pelaces_std$error
sup13<-   media13+error13
inf13<-   media13-error13
yfish<-  c(2003, 2005, 2006, 2007, 2009, 2010, 2011, 2012,2013,2014,2015,2016)
Data13 <- data.frame(list(year = yfish, media = media13,error=error13,sup=sup13, inf=inf13))

#########################BIOMASA TOTAL Y DESOVANTE
x11()
options(scipen = 10)
par(mfrow=c(2,1))

par(mar=c(3,7,2,1),mgp=c(4,0.5,0),xaxs="i",yaxs="i");
plot(Data1[,1],Data1[,2],las=1,ylim=c(0,3500000),cex.lab=0.9,tcl=-0.25,cex.axis=0.65,lab=c(15, 5, 15),type="l",lwd=2,ylab="Biomasa Total (ton)")
x1=c(Data1[,1],Data1[length(Data1[,1]):1,1])
y1=c(Data1[,4],Data1[length(Data1[,1]):1,5])
polygon(x1,y1,col="grey",lty=1,border="white",lwd=1)
points(Data1[,1],Data1[,2],ylim=c(0,2.5e6),type="l",lty=2,lwd=1)

Bcolapso
Bmrs

par(mar=c(3,7,2,1),mgp=c(4,0.5,0),xaxs="i",yaxs="i");
plot(Data3[,1],Data3[,2],las=1,ylim=c(0,1500000),cex.lab=0.9,tcl=-0.25,cex.axis=0.65,lab=c(15, 5, 15),
type="l",lwd=2,
xlab="Año", ylab="Biomasa Desovante (ton)")
x3=c(Data3[,1],Data3[length(Data3[,1]):1,1])
y3=c(Data3[,4],Data3[length(Data3[,1]):1,5])
polygon(x3,y3,col="grey",lty=1,border="white",lwd=1)
points(Data3[,1],Data3[,2],ylim=c(0,10e6),type="l",lty=2,lwd=1)
abline(h=Bmrs,lty=2,col="green");
abline(h=Bcolapso,lty=2,col="red");
legend(1999,900000,legend=c("Brms"),cex=0.8, col=c("green"),bty="n")
legend(1999,540125,legend=c("Blim"),cex=0.8, col=c("red"),bty="n")

###############################INDICADORES
x11()
par(mfrow=c(2,2))
par(mar=c(3,4.9,2,0),mgp=c(3.7,1,0),xaxs="i",yaxs="i");
plot(Data10[,1],Data10[,2],las=1,ylim=c(0,1e6),cex=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lab=c(10, 5, 10),type="l",lwd=2,ylab="Capturas (ton)")
x1=c(Data10[,1],Data10[length(Data10[,1]):1,1])
y1=c(Data10[,4],Data10[length(Data10[,1]):1,5])
polygon(x1,y1,col="lightblue",lty=1,border="white",lwd=1)
points(Data10[,1],Data10[,2],ylim=c(0,1e6),type="l",lty=2,lwd=1)
lines(yfish,Y_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico", ylim=c(0,1000000),ylab="Capturas (ton)",lab=c(10, 10, 10), cex=1.5);

par(mar=c(3,4.9,2,1),mgp=c(2.8,1,0),xaxs="i",yaxs="i");
plot(Data11[,1],Data11[,2],las=1,ylim=c(0,6),cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lab=c(10, 5, 20),type="l",lwd=2,ylab="CPUE(ton/vcp)")
x1=c(Data11[,1],Data11[length(Data11[,1]):1,1])
y1=c(Data11[,4],Data11[length(Data11[,1]):1,5])
polygon(x1,y1,col="lightblue",lty=1,border="white",lwd=1)
points(Data11[,1],Data11[,2],ylim=c(0,1e6),type="l",lty=2,lwd=1)
lines(ycpue,cpue_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Año biológico",ylim=c(0,6),ylab="CPUE (t/vcp)",lab=c(10, 10, 10), cex=1.5);

par(mar=c(3,4.9,2,0.95),mgp=c(3.9,1,0),xaxs="i",yaxs="i");
plot(Data12[,1],Data12[,2],las=1,ylim=c(0,5e6),cex=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lab=c(10, 5, 10),type="l",lwd=2,xlab="Años",ylab="Biomasa Reclas (ton)")
x1=c(Data12[,1],Data12[length(Data12[,1]):1,1])
y1=c(Data12[,4],Data12[length(Data12[,1]):1,5])
polygon(x1,y1,col="lightblue",lty=1,border="white",lwd=1)
points(Data12[,1],Data12[,2],ylim=c(0,5e6),type="l",lty=2,lwd=1)
lines(ysurv,surv_obs,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años", ylim=c(0,5000000),ylab="Capturas (ton)",lab=c(10, 10, 10), cex=1.5);

par(mar=c(3,4.9,2,0.99),mgp=c(4,1,0),xaxs="i",yaxs="i");
plot(Data13[,1],Data13[,2],las=1,ylim=c(0,3e6),cex=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lab=c(10, 5, 10),type="l",lwd=2,xlab="Años",ylab="Biomasa Pelaces (ton)")
x1=c(Data13[,1],Data13[length(Data13[,1]):1,1])
y1=c(Data13[,4],Data13[length(Data13[,1]):1,5])
polygon(x1,y1,col="lightblue",lty=1,border="white",lwd=1)
points(Data13[,1],Data13[,2],ylim=c(0,3e6),type="l",lty=2,lwd=1)
lines(ysurvpel,surv_obspel,type="p",lwd=1.5,cex.lab=0.9,tcl=-0.25,cex.axis=0.8,xlab="Años", ylim=c(0,3000000),ylab="Capturas (ton)",lab=c(10, 10, 10), cex=1.5);


#plot(ysurvpel,surv_obspel,type="p",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",ylim=c(0,2500000),ylab="Crucero Pelaces (ton)",lab=c(10, 10, 10),cex=1.5);
#lines(ysurvpel,surv_estpel,type="l",cex.lab=0.9,tcl=-0.25,cex.axis=0.8,lwd=1.5,xlab="Años",col="black",ylim=c(0,2500000),cex=1.5);   

########################RPR VIRGINAL y F
x11()
options(scipen = 10)
par(mfrow=c(2,1))

par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(Data8[,1],Data8[,2],las=1,ylim=c(0,1.1),cex.lab=0.9,tcl=-0.25,cex.axis=0.7,lab=c(15, 5, 10),
type="l",lwd=2,
xlab="Año", ylab="RPR virginal")
x8=c(Data8[,1],Data8[length(Data8[,1]):1,1])
y8=c(Data8[,4],Data8[length(Data8[,1]):1,5])
polygon(x8,y8,col="grey",lty=1,border="white")
points(Data8[,1],Data8[,2],ylim=c(0,10e6),type="l",lty=1,lwd=0.8)
abline(h =0.55,lty=2,col="green");
abline(h =0.275,lty=2,col="red");
legend(1999,0.68,legend=c("Brms"),col=c("green"),cex=0.72,bty="n")
legend(1999,0.40,legend=c("Blim"),col=c("red"),cex=0.72,bty="n")
#
par(mar=c(3.5,3.5,1,1),mgp=c(2,0.7,0),xaxs="i",yaxs="i");
plot(Data5[,1],Data5[,2],las=1,ylim=c(0,5),cex.lab=0.9,tcl=-0.25,cex.axis=0.7,lab=c(15, 5, 10),
type="l",lwd=2,
xlab="Año", ylab="Mortalidad por Pesca (año-1)")
x5=c(Data5[,1],Data5[length(Data5[,1]):1,1])
y5=c(Data5[,4],Data5[length(Data5[,1]):1,5])
polygon(x5,y5,col="grey",lty=1,border="white")
points(Data5[,1],Data5[,2],ylim=c(0,3),type="l",lty=1,lwd=0.8)
abline(h =0.96,lty=2,col="skyblue");
abline(h =0.49177,lty=2,col="green");
legend(1999,1.55,legend=c("M"),col=c("green"),cex=0.72,bty="n")
legend(1999,0.7,legend=c("Frms"),col=c("green"),cex=0.72,bty="n")
