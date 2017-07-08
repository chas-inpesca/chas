plot.N <- function (modelo, what = "y", zona = NULL, cohorte = 3, years = NULL, ages = NULL, axes = TRUE,
                   same.limits = TRUE, div = 1, log = FALSE, base = 10, main = "",
                   xlab = "", ylab = "", cex.main = 1.2, cex.lab = 1, cex.strip = 0.8,
                   cex.axis = 0.8, las = (what == "b"), tck = c(1, what == "b")/2,
                   tick.number = 10, lty.grid = 1, col.grid = "white", pch = 16,
                   cex.points = 1, col.points = "black",abline=c(v=11.5), col=c("red"),lty=black, ratio.bars = 3, col.bars = "red",
                   plot = TRUE, ...)
{
    panel.bar <- function(x, y, ...)
        {
          panel.abline(h = pretty(y, tick.number), lty = lty.grid,col =col.grid)
          panel.barchart(x, y, ...)
        }
    panel.bubble <- function(x, y, ...)
        {
        panel.abline(v = pretty(x, tick.number), h = pretty(y,tick.number), lty = lty.grid, col = col.grid)
        panel.xyplot(x, y, ...)
        }


    nm <- dim(variable)
    tmp1 <- array(as.matrix(variable),nm[2]*nm[1],1)
    tmp2 <- as.numeric(as.character(rep(dimnames(variable)[[2]],each=nm[1])))
    tmp3 <- as.numeric(as.character(rep(dimnames(variable)[[1]],nm[2])))
    x <- data.frame(list(N = tmp1, Ages = tmp2, Year = tmp3))

    require(grid, quietly = TRUE, warn.conflicts = FALSE)
    require(lattice, quietly = TRUE, warn.conflicts = FALSE)

    if (trellis.par.get()$background$col == "#909090")
    {
        for (d in dev.list()) dev.off()
        trellis.device(color = FALSE)
    }

    main <- rep(main, length.out = 2)
    xlab <- rep(xlab, length.out = 2)
    ylab <- rep(ylab, length.out = 2)
    las <- rep(las, length.out = 2)
    mymain <- list(label = main[1], cex = cex.main)
    myxlab <- list(label = xlab[1], cex = cex.lab)
    myylab <- list(label = ylab[1], cex = cex.lab)
    myrot <- switch(as.character(las[1]), "0" = list(x = list(rot = 0),
        y = list(rot = 90)), "1" = list(x = list(rot = 0), y = list(rot = 0)),
        "2" = list(x = list(rot = 90), y = list(rot = 0)), "3" = list(x = list(rot = 90),
            y = list(rot = 90)))

        relation <- if (same.limits)
                      {"same"}
                else
                     { "free"}

    myscales <- c(list(draw = axes, relation = relation, cex = cex.axis,
        tck = tck, tick.number = tick.number), myrot)
    mystrip <- list(cex = cex.strip)
    printed <- FALSE
    fixed.ylim <- FALSE

    if (what == "y")
            {
            graph <- xyplot(N ~ Ages | factor(Year), data = x, panel = panel.bar,
                    horizontal = FALSE, as.table = TRUE, main = mymain,
                    xlab = myxlab, ylab = myylab, par.strip.text = mystrip,
                    scales = myscales, box.ratio = ratio.bars, col = col.bars,...)
            }
    if (what == "b")
            {
            graph <- xyplot(Year ~ Ages, data = x, panel = panel.bubble,
                    main = mymain, xlab = myxlab, ylab = myylab, scales = myscales,
                    pch = pch, cex = cex.points* sqrt(x$N/mean(x$N,na.rm=T)),...)
            graph$y.limits <- rev(graph$y.limits)
            fixed.ylim <- TRUE
            }
    if (!log && !fixed.ylim)
            {
            if (is.list(graph$y.limits))
                    graph$y.limits <- lapply(graph$y.limits,
                    function(y)
                        {
                        y[1] <- 0
                        return(y)
                        })
            else graph$y.limits[1] <- 0
            }
    if (plot)
            {
            if (!printed)
                    print(graph)
                    invisible(x)
            }
    else
            {
            invisible(graph)
            }

}



plot.ca <- function (model, fit = TRUE, series = NULL,
    years = NULL, ages = NULL, axes = TRUE, same.limits = TRUE,
    log = FALSE, base = 10, eps.log = 1e-05, main = "", xlab = "",
    ylab = "", cex.main = 1.2, cex.lab = 1, cex.strip = 0.8,
    cex.axis = 0.8, las = !fit, tck = c(1, fit)/2, tick.number = 5,
    lty.grid = 3, col.grid = "grey", pch = 16, cex.points = 0.8,
    col.points = "black", lty.lines = 1, lwd.lines = 2,
    col.lines = c("red"), plot = TRUE,...)
{

   panel.bubble <- function(x, y, ...) {
        panel.abline(v = pretty(x, tick.number), h = pretty(y,
            tick.number), lty = lty.grid, col = col.grid)
        panel.xyplot(x, y, ...)
    }

   panel.fit <- function(x, y, col.points, col.lines,
        ...) {
        panel.abline(v = pretty(x, tick.number), lty = lty.grid,
            col = col.grid)
        panel.superpose.2(x, y, col.symbol = col.points,
            col.line = col.lines, ...)
    }

    relation <- if (same.limits)
        "same"
    else  "free"

    las <- as.numeric(las)


    nmobs <- dim(modelo$Pobs)
    tmp1 <- array(as.matrix(modelo$Pobs),nmobs[2]*nmobs[1],1)
    tmp2 <- as.numeric(as.character(rep(dimnames(modelo$Pobs)[[2]],each=nmobs[1])))
    tmp3 <- as.numeric(as.character(rep(dimnames(modelo$Pobs)[[1]],nmobs[2])))
    tmp4 <- rep("Obs",nmobs[2]*nmobs[1])
    x1 <- data.frame(list(P = tmp1, Ages = tmp2, Year = tmp3, ObsFit = tmp4))

    nm <- dim(modelo$Pest)
    tmp11 <- array(as.matrix(modelo$Pest),nm[2]*nm[1],1)
    tmp21 <- as.numeric(as.character(rep(dimnames(modelo$Pest)[[2]],each=nm[1])))
    tmp31 <- as.numeric(as.character(rep(dimnames(modelo$Pest)[[1]],nm[2])))
    tmp41 <- rep("Fit",nm[2]*nm[1])
    x2 <- data.frame(list(P = tmp11, Ages = tmp21, Year = tmp31, ObsFit = tmp41))

    x <- rbind(x1,x2)

   if (log)  x$P <- log(x$P + eps.log, base = base)


    require(grid, quietly = TRUE, warn.conflicts = FALSE)
    require(lattice, quietly = TRUE, warn.conflicts = FALSE)
    if (trellis.par.get()$background$col == "#909090") {
        for (d in dev.list()) dev.off()
        trellis.device(color = FALSE)
    }


    col.points <- rep(col.points, length.out = 1)
    col.lines <- rep(col.lines, length.out = 1)
    mymain <- list(label = main, cex = cex.main)
    myxlab <- list(label = xlab, cex = cex.lab)
    myylab <- list(label = ylab, cex = cex.lab)

    myrot <- switch(as.character(las), "0" = list(x = list(rot = 0),
        y = list(rot = 90)), "1" = list(x = list(rot = 0), y = list(rot = 0)),
        "2" = list(x = list(rot = 90), y = list(rot = 0)), "3" = list(x = list(rot = 90),
            y = list(rot = 90)))

    myscales <- c(list(draw = axes, relation = relation, cex = cex.axis,
        tck = tck, tick.number = tick.number), myrot)
    mystrip <- list(cex = cex.strip)

    fixed.ylim <- FALSE

    if (!fit) {
        x <- x[x$ObsFit == "Obs", ]
        col.points <- ifelse(x$P == 0, "transparent", col.points)
        mycex <- cex.points * sqrt(x$P/mean(x$P)) + 800/1000
        graph <- xyplot(Year ~ Ages |"Captura Comercial",
            data = x, panel = panel.bubble, main = mymain,
            xlab = myxlab, ylab = myylab, par.strip.text = mystrip,
            scales = myscales, pch = pch, cex = mycex, col = col.points,
            ...)
        graph$y.limits <- rev(graph$y.limits)
        fixed.ylim <- TRUE
    }



    if (fit) {
        col.points <- ifelse(x$P == 0, "transparent", col.points)
        graph <- xyplot(P ~ Ages | factor(Year), groups = ObsFit,
            data = x, panel = panel.fit, type = c("p", "l"),
            as.table = TRUE, main = mymain, xlab = myxlab, ylab = myylab,
            par.strip.text = mystrip, scales = myscales, pch = pch,
            cex = cex.points, col.points = "black",
            lty = lty.lines, lwd = lwd.lines, col.lines = col.lines,
            ...)
    }

    if (!log && !fixed.ylim) {
        if (is.list(graph$y.limits))
            graph$y.limits <- lapply(graph$y.limits, function(y) {
                y[1] <- 0
                return(y)
            })
        else graph$y.limits[1] <- 0
    }
    if (plot) {
        print(graph)
        invisible(x)
    }
    else {
        invisible(graph)
    }
}

