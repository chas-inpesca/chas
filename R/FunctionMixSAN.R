# MIXAN Funciones

#Selectividad
.plotSelecYearly <- function( repObj,type=NULL,spp=NULL)
{
	#plot the selectivity curves (3d plots)
	with(repObj, {

		#par(mgp=c(3, 3, 5))
		plot.sel<-function(x, y, z, ...)
		{
			#z=exp(A$log_sel)*3
			#x=A$yr
			#y=A$age
			z <- z/max(z)
			z0 <- 0#min(z) - 20
			z <- rbind(z0, cbind(z0, z, z0), z0)
			x <- c(min(x) - 1e-10, x, max(x) + 1e-10)
			y <- c(min(y) - 1e-10, y, max(y) + 1e-10)
			clr=colorRampPalette(c("honeydew","lawngreen"))
			nbcol=50
			iclr=clr(nbcol)
			nrz <- nrow(z)
			ncz <- ncol(z)
			zfacet <- z[-1, -1]+z[-1, -ncz]+z[-nrz, -1]+z[-nrz, -ncz]
			facetcol <- cut(zfacet, nbcol)
			fill <- matrix(iclr[facetcol],nr=nrow(z)-1,nc=ncol(z)-1)
			fill[ , i2 <- c(1,ncol(fill))] <- "white"
			fill[i1 <- c(1,nrow(fill)) , ] <- "white"

			par(bg = "transparent")
			persp(x, y, z, theta = 45, phi = 25, col = fill, expand=5, 
				shade=0.25,ltheta=45 , scale = FALSE, axes = TRUE, d=1,  
				xlab="Años",ylab="Edad",zlab="Selectividad", 
				ticktype="simple", ...)
			
			#require(lattice)
			#wireframe(z, drap=TRUE, col=fill)
		}
		
		if(type=="flota")
		{
			if(spp=="sardina")
			{
				ix=1:dim(s_sel_f)[1]
				selspp=s_sel_f
			}
			if(spp=="anchoveta")
			{
				ix=1:dim(a_sel_f)[1]
				selspp=a_sel_f
			}
		}
		if(type=="reclas")
		{
			if(spp=="sardina")
			{
				ix=1:dim(s_sel_reclas)[1]
				selspp=s_sel_reclas
			}
			if(spp=="anchoveta")
			{
				ix=1:dim(a_sel_reclas)[1]
				selspp=a_sel_reclas
			}
			
		}

		
		#for(k in 1:ngear){
			
			plot.sel(ix, 1:5, selspp,main=paste(spp,",",type))
			#file.name=paste(prefix, "Fig9",letters[k],".eps", sep="")
			#if(savefigs) dev.copy2eps(file=file.name, height=8, width=8)
		#}
		
	})
}

.plotReclutas	<- function( repObj,spp=NULL )
{
	#plot age-a recruits.
	with(repObj, {
		xx = years
		if(spp=="sardina")
		{
			yy = s_natage[,1]/1000
			yy=yy			
		}
		if(spp=="anchoveta")
		{
			yy = a_natage[,1]/1000
			yy=yy						
		}
		
		yrange=c(0, max(yy, na.rm=T))
		par(lend=1)
		plot(xx, yy, type="n", axes=FALSE, ylim=yrange, 
			xlab="Año", main=paste(spp), 
			ylab=paste("Edad", 0, " reclutas (miles de millones)", sep=""))
		
		lines(xx, yy, type="h",lwd=15)
		
		#add 0.25, 0.5 and 0.75 quantile lines
		qtl = quantile(yy, prob=c(0.25, 0.5, 0.75))
		abline(h=qtl,lty=c(2,1,3), col="grey")
		axis( side=1 )
		axis( side=2, las=1 )
		box()
	})
}

.plotSR	<- function( repObj,spp=NULL )
{
	with(repObj, {
		if(spp=="sardina")
		{
		xx = s_ssb[1:(length(years)-1)]/1000
		yy = s_natage[2:length(years),1]/1000
		yy2= s_predR/1000
		}
		if(spp=="anchoveta")
		{
		xx = a_ssb[1:(length(years)-1)]/1000
		yy = a_natage[2:length(years),1]/1000
		yy2= a_predR/1000
		}
		
		#plot(xx, yy, type="n",ylim=c(0, max(yy, ro)),xlim=c(0, max(xx,bo)),
		plot(xx, yy, type="n",ylim=c(0, max(yy*1.2)),xlim=c(0, max(xx*1.2)), 
			xlab="Biomasa desovante (miles t)", 
			ylab=paste("Edad-",0," reclutas (miles de millones)", sep=""), 
			main=paste(spp))
			
		lines(xx, yy,lty=2,col="grey")
		points(xx, yy,pch=19)
		lines(sort(xx),sort(yy2))
		
		points(xx[1],yy[1], pch=20, col="green")
		points(xx[length(xx)], yy[length(xx)], pch=20, col=2)
		
		#st=seq(0, max(sbt, bo), length=100)
		#if(rectype==1)
		#{
			#Beverton-Holt
		#	rrt=kappa*ro*st/(bo+(kappa-1)*st)*exp(-0.5*tau^2)  
		#}
		#if(rectype==2)
		#{
		#	#Ricker
		#	rrt=kappa*ro*st*exp(-log(kappa)*st/bo)/bo *exp(-0.5*tau^2) 
		#}
		#lines(st, rrt)
		#ro=ro*exp(-0.5*tau^2)
		#points(bo, ro, pch="O", col=2)
		#points(bo, ro, pch="+", col=2)
	})
}

.plotBiomasa	<- function( repObj, leyenda=FALSE )
{
	#plot total biomasa total 
	with(repObj, {
		xx=years
        yy=cbind(biomass[1:length(xx)]/1000, s_biom[1:length(xx)]/1000,a_biom[1:length(xx)]/1000)
		#yy1=cbind(s_biom[1:length(xx)]/1000, s_ssb[1:length(xx)]/1000)
		#yy2=cbind(a_biom[1:length(xx)]/1000, a_ssb[1:length(xx)]/1000)

		yrange=c(0, 1.2*max(yy, na.rm=TRUE))
		
		matplot(xx, yy, type="n",axes=FALSE,
				xlab="Año", ylab="Biomasa (1000 t)",main="", 
				ylim=yrange)
		
		matlines(xx,yy,
			type="l", col="black",
			ylim=c(0,max(yy,na.rm=T)))
		#matlines(xx,yy1,col="black",type="b",pch=c(1,2),lty=c(1,2))
		#matlines(xx,yy2,col="black",type="b",pch=c(3,4),lty=c(1,2))

		axis( side=1 )
		axis( side=2, las=1 )
		box()
		
		if ( leyenda )
		{
			mfg <- par( "mfg" )
			if ( mfg[1]==1 && mfg[2]==1 )
			legend( "top",legend=c( "Total","Sardina","Anchoveta"),
				bty='n',lty=c(1,2,3),lwd=c(1,1,1),pch=c(-1,-1,-1),ncol=1 )
		}
	})	
}

.plotDesovante	<- function( repObj, leyenda=FALSE )
{
	#plot total biomasa total 
	with(repObj, {
		xx=years
        yy=cbind(ssb[1:length(xx)]/1000, s_ssb[1:length(xx)]/1000,a_ssb[1:length(xx)]/1000)
		#yy1=cbind(s_biom[1:length(xx)]/1000, s_ssb[1:length(xx)]/1000)
		#yy2=cbind(a_biom[1:length(xx)]/1000, a_ssb[1:length(xx)]/1000)

		yrange=c(0, 1.2*max(yy, na.rm=TRUE))
		
		matplot(xx, yy, type="n",axes=FALSE,
				xlab="Año", ylab="Biomasa desovante (1000 t)",main="", 
				ylim=yrange)
		
		matlines(xx,yy,
			type="l", col="black",
			ylim=c(0,max(yy,na.rm=T)))
		#matlines(xx,yy1,col="black",type="b",pch=c(1,2),lty=c(1,2))
		#matlines(xx,yy2,col="black",type="b",pch=c(3,4),lty=c(1,2))

		axis( side=1 )
		axis( side=2, las=1 )
		box()
		
		if ( leyenda )
		{
			mfg <- par( "mfg" )
			if ( mfg[1]==1 && mfg[2]==1 )
			legend( "top",legend=c( "Desovante","Sardina","Anchoveta"),
				bty='n',lty=c(1,2,3),lwd=c(1,1,1),pch=c(-1,-1,-1),ncol=1 )
		}
	})	
}

.plotCatage <- function(repObj,type=NULL,spp=NULL)
  {
  	tallas <- seq(3,19,0.5)
    with(repObj,
         {
           if (type=='Captura')
             {
             	if(spp=="Sardina")
             	{
	               obs <- repObj$s_obs_p_len_fish
    	           pre <- repObj$s_pred_p_len_fish 
    	           yrs <- seq(repObj$styr+1,repObj$endyr,1)            		
             	}
             	if(spp=="Anchoveta")
             	{
	               obs <- repObj$a_obs_p_len_fish
    	           pre <- repObj$a_pred_p_len_fish
    	           yrs <- seq(repObj$styr+1,repObj$endyr,1)             		            
             	}
             }
           if (type=='Reclas')
             {
             	if(spp=="Sardina")
             	{
	               obs <- repObj$s_obs_p_len_rec
    	           pre <- repObj$s_pred_p_len_rec
    	           yrs <- repObj$yrs_rec             		
             	}
             	if(spp=="Anchoveta")
             	{
	               obs <- repObj$a_obs_p_len_rec
    	           pre <- repObj$a_pred_p_len_rec
    	           yrs <- repObj$yrs_rec             		            
             	}
             }
           if (type=='Pelaces')
             {
            	if(spp=="Sardina")
             	{
	               obs <- repObj$s_obs_p_len_pel
    	           pre <- repObj$s_pred_p_len_pel
    	           yrs <- repObj$yrs_pel            		
             	}
             	if(spp=="Anchoveta")
             	{
	               obs <- repObj$a_obs_p_len_pel
    	           pre <- repObj$a_pred_p_len_pel
    	           yrs <- repObj$yrs_pel
             	}
              }
           colnames(obs) <- colnames(pre) <- tallas
           rownames(obs) <- rownames(pre) <- yrs
           obs <- rbind(cbind(melt(obs),type='obs'),cbind(melt(pre),type='pre'))
           colnames(obs) <- c('year','talla','value','type')
           obs <- subset(obs,value>0)
           g <- xyplot(value ~ talla | factor(year), groups = type, data = obs,
           auto.key=list(columns=2,text=c("Observado", "Ajustado"),lines=T, points=F, rectangles=F, lty=c(1,1), lwd=1, cex = 0.8),
              par.settings=simpleTheme(col=c('salmon', 'steelblue'),
              lwd=c(3,2), pch=c(10,17)), type=c('h','l'), xlab="Talla",
              ylab="Proporcion a la Talla", 
              main = paste(type,spp,sep=" "),
              lty=c(1,1), cex.lab=1.3, cex.axis=1, as.table=T,
              scales=list(x=list(rot=0, cex=0.6),y=list(cex=0.6)),
              distribute.type=TRUE)
           print(g)
         })
  }

