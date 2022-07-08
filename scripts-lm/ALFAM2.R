# Make ALFAM2 predictions

# Prepare predictor variables
idat$app.mthd <- idat$app.method
idat$app.rate.ni <- idat$app.rate

# Make stacked data frame for plotting
a2dat <- idat
a2dat$mod <- 'Measured'

preds <- alfam2(dat = idat, time.name = 'cta', group = 'pmid', app.name = 'tan.app')
dd <- idat
dd[, c('e.int', 'e.cum', 'e.rel', 'j.NH3')] <- preds[, c('e.int', 'e', 'er', 'j')]
dd$mod <- 'ALFAM2 pars 2'

a2dat <- rbind(a2dat, dd)

preds <- alfam2(dat = idat, pars = alfam2pars01, time.name = 'cta', group = 'pmid', app.name = 'tan.app')
dd <- idat
dd[, c('e.int', 'e.cum', 'e.rel', 'j.NH3')] <- preds[, c('e.int', 'e', 'er', 'j')]
dd$mod <- 'ALFAM2 pars 1'

a2dat <- rbind(a2dat, dd)

