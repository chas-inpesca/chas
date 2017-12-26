setwd("/Users/marteaga/Documents/MSECHAS/chas/docs/AjustQuota/DataMix")
library(lattice)
library(plyr)
library(dplyr)

ca <- read.csv("catchmix2.csv")
names(ca)

canual <- ddply(ca,.(YY),summarise,sum(anchoveta),sum(sardina))
colnames(canual)<-c("YY","anchoveta","sardina")
plot(canual$YY,canual$anchoveta/canual$sardina,ylab="Anchoveta/Sardina",xlab="A�os",pch=19,type="b",main="Ratio catch (1991-2016)")
abline(h=1,lty=2)
box(lwd=2)

plot(ca$sardina,ca$anchoveta,pch=19,cex=0.3,type="p",lty=2,lwd=0.5,ylab="Landings anchoveta (t)",xlab="Landings sardina (t)", main="Period 1991-2016")
abline(a=0,b=1,col=2,lwd=2)

xyplot(anchoveta~sardina|as.factor(YY),data=ca, panel=function(x,y){panel.xyplot(x,y)})
xyplot(anchoveta~sardina|as.factor(Region),data=ca, panel=function(x,y){panel.xyplot(x,y)})
xyplot(anchoveta~sardina|as.factor(ZZ),data=ca, panel=function(x,y){panel.xyplot(x,y)})

par(mfrow=c(1,3))
ca.norte <- ca[ca$ZZ=="Norte",,]
plot(ca.norte$sardina,ca.norte$anchoveta,pch=19,cex=0.3,type="b",lty=2,lwd=0.5,ylab="Desembarque anchoveta (t)",xlab="Desembarque sardina (t)",main="Zona Norte")
abline(a=0,b=1,col=2,lwd=2)
ca.centro <- ca[ca$ZZ=="Centro",,]
plot(ca.centro$sardina,ca.centro$anchoveta,pch=19,cex=0.3,type="b",lty=2,lwd=0.5,ylab="Desembarque anchoveta (t)",xlab="Desembarque sardina (t)",main="Zona Centro")
abline(a=0,b=1,col=2,lwd=2)
ca.sur <- ca[ca$ZZ=="Sur",,]
plot(ca.sur$sardina,ca.sur$anchoveta,pch=19,cex=0.3,type="b",lty=2,lwd=0.5,ylab="Desembarque anchoveta (t)",xlab="Desembarque sardina (t)",main="Zona Sur")
abline(a=0,b=1,col=2,lwd=2)


#Intercepto y pendiente comun
m1 <- glm(anchoveta~as.factor(YY)+sardina,data=ca,family=gaussian(link="identity"))
summary(m1)
anova(aov(m1))
par(mfrow=c(1,2))
termplot(m1,terms=1,se=T)
termplot(m1,terms=2,se=T)


#pendientes e intercepto variables
m3 <- glm(anchoveta~as.factor(YY)*sardina,data=ca,family=gaussian(link="identity"))
summary(m3)
anova(aov(m3))
coef(m3)
termplot(m3,terms=1,se=T)
termplot(m3,terms=2,se=T)

#pendientes e intercepto comun
m2 <- glm(anchoveta~sardina+as.factor(YY):sardina,data=ca,family=gaussian(link="identity"))
summary(m2)
anova(aov(m2))
termplot(m2,terms=1,se=T)


library(nlme)
#random effects para la pendiente e intercepto de cada año
# random=~1+sardina|year
m2 <- lme(anchoveta~sardina,random=~1+sardina|as.factor(YY),data=ca)
summary(m2)
#extrae los efectos aleatorios (como cada año se desvia del estimado global)
ranef(m2)
summary(ranef(m2))
plot(ca$sardina,fitted(m2),type="l",xlab="Captura sardina",ylab="Captura anchoveta",main="Modelo Mixto: Años como factor aleatorio")
points(ca$sardina,ca$anchoveta,cex=0.3)
plot(m2, form = resid(., type = "p") ~ fitted(.) | as.factor(YY), abline = 0,pch=10)
plot(m2,as.factor(YY)~resid(.),abline=0)

mezc<-groupedData(anchoveta~sardina|as.factor(YY),data=ca,order.groups=F,FUN=min,labels=list(x="Sardina",y="Anchoveta"),units=list(x="(t)",y="(t)"))

m3 <- lme(anchoveta~sardina,random=~1+sardina|as.factor(YY),data=mezc)
summary(m3)
plot(augPred(m3),lty=1,csi=0.3,pch=1,lwd=2,col="black",brg="white")

#Las capturas son directamente proporcional
#Solo la pendiente es diferente
m4 <- lme(anchoveta~sardina,random=~-1+sardina|as.factor(YY),data=mezc)
summary(m4)
out<-ranef(m4)
rate<-(coef(m4)[2])
rate2<-c(0.576,0.704,1.256,1.726,1.447,0.603,0.662,0.915,1.182,0.663,0.525,0.808,1.095,1.112,1.828,0.977,2.018,0.485,
0.511,0.248,0.130,0.095,0.182,0.101,0.166,0.195)

intervals(m4,level=0.95)
plot(ca$sardina,fitted(m4),type="l",xlab="Captura sardina",ylab="Captura anchoveta")
points(ca$sardina,ca$anchoveta,cex=0.3)
abline(a=0,b=1,col=2)
plot(augPred(m4),lty=1,csi=0.3,pch=1,lwd=2,col="black",brg="white")

plot(canual$YY,canual$anchoveta/canual$sardina,ylab="Anchoveta/Sardina",xlab="Years",pch=19,type="b",main="Ratio catch (1991-2016)")
points(canual$YY,rate2,type="b",col="blue")
abline(h=1,lty=2)
box(lwd=2)

rate1<-canual$anchoveta/canual$sardina
Year<-seq(1991,2016,1)

tb1 <- cbind(Year,rate1,rate2)
tb1

# RAZON DE CAPTURAS

