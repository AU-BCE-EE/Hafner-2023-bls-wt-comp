# Add some variables

idat$app.date <- as.Date(idat$app.start)

idat <- idat[order(idat$pmid, idat$cta), ]
idat$e.prev <- idat$e.cum - idat$e.int
idat$j.norm <- idat$j.NH3 / idat$tan.app
idat$j.norm[idat$j.norm <= 0] <- 1E-6


