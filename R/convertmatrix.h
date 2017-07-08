
	convertmatrix<-function(x)
	{
	dimnames(x) <- list(c("1991","1992", "1993", "1994", "1995", "1996", "1997", "1998",
                       "1999", "2000", "2001", "2002", "2003", "2004", "2005",
                       "2006", "2007","2008","2009", "2010","2011","2012","2013","2014","2015","2016"),c("0","1","2","3"))
    nm <- dim(x)
    tmp1 <- array(as.matrix(x),nm[2]*nm[1],1)
    tmp2 <- as.numeric(as.character(rep(dimnames(x)[[2]],each=nm[1])))
    tmp3 <- as.numeric(as.character(rep(dimnames(x)[[1]],nm[2])))
    x <- data.frame(list(N = tmp1, Ages = tmp2, Year = tmp3))	
	x
	}
	


