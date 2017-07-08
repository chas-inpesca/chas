
	convertmatrixs<-function(x)
	{
	dimnames(x) <- list(c("1993", "1995", "1997", "1999", "2000", "2001", "2004", "2005",
                       "2006", "2007","2008","2009", "2010","2011","2012","2013","2014"),c("3", "3.5", "4", "4.5","5","5.5","6","6.5","7","7.5","8","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15","15.5","16","16.5","17","17.5","18","18.5","19"))
    nm <- dim(x)
    tmp1 <- array(as.matrix(x),nm[2]*nm[1],1)
    tmp2 <- as.numeric(as.character(rep(dimnames(x)[[2]],each=nm[1])))
    tmp3 <- as.numeric(as.character(rep(dimnames(x)[[1]],nm[2])))
    x <- data.frame(list(N = tmp1, Ages = tmp2, Year = tmp3))	
	x
	}
	


