
#Proporciones
#quartz()
op <- par(no.readonly=TRUE)
ps.options(horizontal = FALSE, bg="white",onefile = FALSE, paper = "special")
postscript("Fig_1.eps",height = 8, width = 10) #tamaño es en pulgadas
plot(san$years,san$prop,type="b",ylim=c(0,1),xlab="Años",ylab="Proporción de sardina común",axes=F,cex.axis=1.2,cex.lab=1.6)
axis(side=1,labels=T)
axis(side=2,labels=T)
abline(h=0.5,lty=2)
abline(h=0.75,lty=2,lwd=0.5)
abline(h=0.25,lty=2,lwd=0.5)
pcap <- san$s_obs_catch/san$t_obs_catch
lines(san$years,pcap,col=1,type="b",pch=15)
legend(1990,0.95,legend=c("Prop. reclutas","Prop. capturas"),pch=c(1,15),lty=c(1,1))
#dev.off()

san$prop<-san$s_biom/(san$biomass)
pcap<-san$s_obs_catch/san$t_obs_catch
#postscript("Fig_2.eps",height = 8, width = 10) #tamaño es en pulgadas
plot(san$prop,pcap,type="b",ylim=c(0,1),xlim=c(0,1),xlab="Proporción Biomasa - sardina",ylab="Proporción Captura - sardina",axes=F,cex=1.2,cex.axis=1.2,cex.lab=1.6)
axis(side=1,labels=T)
axis(side=2,labels=T)
m0 <- lm(pcap~san$prop-1)
abline(m0)
#x1 <- san$prop
#x2 <- san$prop^2
#x3 <- san$prop^3
#m1 <- lm(pcap~x1+x2+x3-1)
#lines(san$prop,fitted(m1),col=3)
x <- seq(0,1,0.01)
#pest<- m1$coeff[1]*x+m1$coeff[2]*x^2+m1$coeff[3]*x^3
#lines(x,pest,lty=2,lwd=2)
pest2<-2.5*x-4.5*x^2+3*x^3
lines(x,pest2,col=1,lwd=2)
abline(v=0.5,lty=2,col=1,lwd=0.5)
abline(v=0.75,lty=2,col=2,lwd=0.5)
abline(v=0.25,lty=2,col=2,lwd=0.5)
abline(h=0.5,lty=2,col=1,lwd=0.5)
abline(h=0.75,lty=2,col=2,lwd=0.5)
abline(h=0.25,lty=2,col=2,lwd=0.5)
legend(0,1,legend=c("Observado","lineal","Modelo Operante"),lty=c(NA,1,2,1),col=c(1,1,1),pch=c(1,NA,NA),lwd=c(1,1,2))
#dev.off()


plot(san$years,san$prop,ylim=c(0,1),ylab="Proporción Reclutas",xlab="Años",type="b",lwd=2)
lines(san$years,pcap)
tindex<-seq(1,24,1)
yrs<-san$years
rprop<-san$prop
mod1<-nls(rprop~0.5+Amp*cos(pi*yrs*nabla+phi),start=list(Amp=1,nabla=0.5,phi=10))
summary(mod1)
plot(yrs,pcap,ylim=c(0,1))
lines(yrs,fitted(mod1))
pyr<-seq(2010,2030,1)
y<-0.5+0.07687*cos(pi*pyr*0.451+320.19)
plot(pyr,y,ylim=c(0,1),type="l",lwd=2)
epsilon<-rnorm(21,0,0.13)
lines(pyr,y+epsilon,col=2)

####################################
#quartz()
ages=seq(0.5,4.5,1)
plot(ages,san$s_sel_reclas,type="b",ylim=c(0,1),ylab="Selectividad",axes=F)
axis(side=1,labels=T)
axis(side=2,labels=T)
nobs_reclas<-dim(san$s_sel_reclas)[1]
for(i in 1:(nobs_reclas-1)){
	points(ages,san$s_sel_reclas[i+1,],type="b")
}
points(ages,san$a_sel_reclas[6,],type="b",col=2)
for(i in 1:(nobs_reclas-1)){
	points(ages,san$a_sel_reclas[i+1,],type="b",col=2)
}


#No aplica
#.plotSelecYearly(san,"reclas","sardina")
#.plotSelecYearly(san,"reclas","anchoveta")






#Deteccion acustica
x <- seq(0,1,length=100)
y <- dbeta(x,10,2)
plot(x,y,type="l",ylab="Probabilidad",xlab="q RECLAS")


plot(san$s_Fmort,san$a_Fmort,type="b",ylim=c(0,4),xlim=c(0,4))

Effort <- c(11766, 18229, 19211, 14963, 21864,
11677, 21571, 20234, 24157, 47916,
36697, 21028, 17278, 27588, 24740,
26717, 30957, 21803, 29990, 35029,
28767)
Ftot <- san$s_Fmort + san$a_Fmort
plot(Effort,san$t_obs_catch,type="b",lty=2)
points(Effort,san$a_Fmort,type="b",lty=3,pch=2)
plot(san$years,(Effort/max(Effort)),type="b",lwd=2,ylim=c(0,1))
points(san$years,san$s_Fmort/max(san$s_Fmort),type="b",lty=3,pch=2,col="blue")
points(san$years,san$a_Fmort/max(san$a_Fmort),type="b",lty=4,pch=3,col=2)
points(san$years,Ftot/max(Ftot),lwd=2,type="b",lty=5,pch=4)


points(san$years,san$s_Fmort/max(san$s_Fmort),type="b",lty=3,pch=2,col="blue")
points(san$years,san$a_Fmort/max(san$a_Fmort),type="b",lty=4,pch=3,col=2)
plot(san$years,Ftot/max(Ftot),lwd=2,type="b",lty=5,pch=4)


s_rt <- san$s_natage[,1]
a_rt <- san$a_natage[,1]
plot(san$years,s_rt,type="l")
lines(san$years,a_rt,col=4)
plot(san$years,s_rt/san$a_natage[,1])
abline(h=1,col=2)

plot(s_rt,san$s_obs_catch,type="l")
points(san$a_natage[,1],san$a_obs_catch,type="l",col=2)

i<-seq(1,length(san$s_ssb)-1,1)
ii<-seq(2,length(san$s_ssb),1)
plot(san$s_ssb[i],s_rt[ii],type="p",col=4,ylim=c(0,400000))
lines(sort(san$s_ssb[i]),sort(san$s_predR),col=4)
points(san$a_ssb[i],a_rt[ii],type="b",col=2)
lines(san$a_ssb[i],san$a_predR,col=2)
abline(h=mean(s_rt),col=2)
abline(h=mean(a_rt),col=4)



summary(m0)
summary(m1)



x <- rnorm(100,0.5,0.15)
pes<-2.5*x-4.5*x^2+3*x^3
plot(sort(x),sort(pes),ylim=c(0,1),xlim=c(0,1),type="l",ylab="Prop.Cap.sardina",xlab="Prop.Recl.sardina",cex.lab=1.4,cex.axis=1.4)
y<-2.5*x-4.5*x^2+3*x^3+rnorm(100,0,sd=0.09802)
points(x,y)




plot(ages,san$s_sel_pelaces,type="b",ylim=c(0,1))
points(ages,san$a_sel_pelaces,type="b",col=2)

plot(ages,san$s_sel_f[1,],type="b",ylim=c(0,1))
for(i in 1:(san$nyr-1)){
	points(ages,san$s_sel_f[i+1,],type="b")
}
for(i in 1:(san$nyr)){
	points(ages,san$a_sel_f[i,],type="b",col=2)
}
names(san)
#dev.off()