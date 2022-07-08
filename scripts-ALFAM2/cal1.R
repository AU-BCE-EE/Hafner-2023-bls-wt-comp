# Fit ALFAM2 model to each individual plot

# List for holding output
modsa <- list()

# Starting par estimates
pars01 <- alfam2pars01
pars02 <- alfam2pars02

# Identify parameters to estimate through calibration
# These include some missing from par set 2
names.pars.cal   <- c('int.f0',
                      'int.r1', 
                      'int.r2', 
                      'wind.2m.r1', 
                      'int.r3', 
                      'air.temp.r3')

names.pars.fixed <- c('air.temp.r1', 
                      'man.dm.f0', 
                      'man.dm.r1', 
                      'man.ph.r1', 
                      'rain.rate.r2',
                      'man.ph.r3')

# Split pars into fixed and calibration
pars.cal <- pars01[names.pars.cal]

# Fixed pars from set 2, effectively DM and pH
fixed <- pars02[names.pars.fixed]

# Add a couple more parameters for calibration
pars.cal['wind.2m.r3'] <- 0

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed))
# Should be no NA in output
which(is.na(pr$e))

for (i in as.character(unique(idat$pmid))) {
  dd <- as.data.frame(subset(idat, pmid == i))

  if (dd$meas.tech2[1] == 'wt') {
    pp <- pars.cal[!grepl('rain', names(pars.cal))]
    pp <- pp[!grepl('wind.2m', names(pp))]
    ff <- fixed
    ff['wind.2m.r1'] <- pars02['wind.2m.r1']
  } else {
    pp <- pars.cal
  }

  cat('pmid ', i, '\n ')
  modsa[[i]] <- list()
  modsa[[i]][['mod']] <- m <- optim(par = pp, fn = function(par) 
                                     resCalcOptim(p = par, dat = dd, to = 'j', time.name = 'cta',
                                                  fixed = ff, app.name = 'tan.app', 
                                                  group = 'pmid', method = 'TAE', weights = dd$cta > 0.5),
                                   method = 'Nelder-Mead')

  Sys.time()
  
  # Get pars
  modsa[[i]][['coef']] <- pp <- c(m$par, ff)
  
  # Echo pars and other model info
  print(pp)
  print(m)
  
  ## Export pars
  #write.csv(pp, paste0('../output/pars_', i, '.csv'))
  
  # Run model for all observations using parameter estimates
  modsa[[i]][['pred']] <- pr <- ALFAM2mod(dd, app.name = 'tan.app', time.name = 'cta', 
                  group = 'pmid', pars = pp)
  
  Sys.time()

}
