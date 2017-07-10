#GLOBAL_SECTION
library(ggplot2)
library(lattice)
library(reshape)
library(RColorBrewer)
#DATA_SECTION
setwd("~/ADMwork/MOSAN/Mixed/DataMix")
dir()
dat = read.csv("ctpinitial.csv")
names(dat)
yr = seq(2001,2011,1)
an = dat[,c(2,5,8)]
an = melt(an)
an$YY <- rep(yr,3)
an$YY <- as.factor(an$YY)

#PROCEDURE_SECTION
yr = seq(2001,2011,1)
#Anchovy
ggplot(data=an,aes(x=YY,y=value,fill=variable))+geom_bar(stat="identity",position=position_dodge(),colour="black")



an = dat[,c(9,12,14)]
an = melt(an)
an$YY <- rep(yr,3)
an$YY <- as.factor(an$YY)
#Artesanal
aAr =dat[,c(3,6,)]

#PROCEDURE_SECTION
yr = seq(2001,2011,1)
#Anchovy
ggplot(data=an,aes(x=YY,y=value,fill=variable))+geom_bar(stat="identity",position=position_dodge(),colour="black")




color.palet="Dark2"
barchart(value~factor(YY)|variable,data=an,col=brewer.pal(3,color.palet),
                 layout=c(3,1),
                 ylab="Captura (ton)",xlab="Año",
                 auto.key=list(points=F,rectangles=F,space="right",col=brewer.pal(3,color.palet)),
                 scales=list(x=list(rot=0)),main="Anchoveta")
#trellis.device(color=F) 
prop.mean <- aggregate(list(C = Pejegallo, CT = Ctotal), list(Year = Year, Mes = Mes, Zona = Zon),sum.na)
jpeg(paste(getwd(),"/Figuras/fig8_act.jpeg",sep=""), width = 1440, height = 960, pointsize = 120, quality = 300)     
trellis.par.set(list(fontsize = list(text = 30)))                               
barchart(C/CT ~ factor(Mes) | factor(Year), data=prop.mean, col=brewer.pal(3,color.palet), ylim=c(0,1.05),
         groups = factor(Zona), layout = c(3,1),
         ylab = "Captura de Pejegallo (%)", xlab = "Mes",
         auto.key = list(points = F, rectangles = F, space = "right", col=brewer.pal(3,color.palet)),
         scales = list(x = list(rot = 0)), main="Figura 8-Act/ Inf. Avance")
dev.off()


A=dat$aQfin/dat$sQfin
B=dat$aDtot/dat$sDtot
x<-seq(0,1200,200)

#Relacion cuota-desembarque
plot(dat$sQfin[10],dat$aQfin[10],xlim=c(0,1200),ylim=c(0,1200))
points(dat$sQfin[10],dat$aQfin[10],pch=19)
points(dat$sDtot[10],dat$aDtot[10],pch=2,col=2)
text(dat$sQfin[10]+50,dat$aQfin[10]+50,"Q2010")
text(dat$sDtot[10]+50,dat$aDtot[10]+50,"L2010",col=2)
y<-A[10]*x
lines(x,y,col=1)
points(dat$sQfin[1],dat$aQfin[1],pch=19)
points(dat$sDtot[1],dat$aDtot[1],pch=2,col=2)
text(dat$sQfin[1]+50,dat$aQfin[1]+50,"Q2001")
text(dat$sDtot[1]+50,dat$aDtot[1]+50,"L2001",col=2)
y<-A[1]*x
lines(x,y,col=1)
points(dat$sQfin[6],dat$aQfin[6],pch=19)
points(dat$sDtot[6],dat$aDtot[6],pch=2,col=2)
text(dat$sQfin[6]+50,dat$aQfin[6]+50,"Q2007")
text(dat$sDtot[6]+50,dat$aDtot[6]+50,"L2007",col=2)
y<-A[6]*x
lines(x,y,col=1)
points(dat$sQfin[6],dat$aQfin[6],pch=19)
points(dat$sDtot[6],dat$aDtot[6],pch=2,col=2)
text(dat$sQfin[6]+50,dat$aQfin[6]+50,"Q2007")
text(dat$sDtot[6]+50,dat$aDtot[6]+50,"L2007",col=2)
y<-A[6]*x
lines(x,y,col=1)

