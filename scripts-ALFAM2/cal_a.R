# Fit ALFAM2 model to each individual plot

# List for holding output
modsa <- list()

### Starting par estimates
##pars01 <- alfam2pars01
##pars02 <- alfam2pars02
##
### Identify parameters to estimate through calibration
### These include some missing from par set 2
##names.pars.cal   <- c('int.f0',
##                      'int.r1', 
##                      'int.r2', 
##                      'air.temp.r1',
##                      'wind.2m.r1', 
##                      'int.r3', 
##                      'air.temp.r3')

names.pars.fixed <- c('man.dm.f0', 
                      'man.dm.r1', 
                      'man.ph.r1', 
                      'rain.rate.r2',
                      'man.ph.r3')

### Split pars into fixed and calibration
##pars.cal <- pars01[names.pars.cal]

# Fixed pars from set 2, effectively DM and pH
fixed <- pars02[names.pars.fixed]

### Add a couple more parameters for calibration
##pars.cal['wind.2m.r3'] <- 0

pars.cal <- c(int.f0       =  0.8,
              int.r1       = -1,
              int.r2       = -1,
              int.r3       = -3,
              air.temp.r1  =  0.05,
              wind.2m.r1   =  0.5,
              wind.2m.r3   =  0.01,
              air.temp.r3  =  0.02)

lower <- c(int.f0       = -2,
           int.r1       = -2,
           int.r2       = -3,
           int.r3       = -4,
           air.temp.r1  =  0,
           wind.2m.r1   =  0,
           wind.2m.r3   =  0,
           air.temp.r3  =  0)

upper <- c(int.f0       = 1,
           int.r1       = -0.5,
           int.r2       = -0.5,
           int.r3       = -1,
           air.temp.r1  =  0.3,
           wind.2m.r1   =  0.6,
           wind.2m.r3   =  0.3,
           air.temp.r3  =  0.3)

 

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed))
# Should be no NA in output
which(is.na(pr$e))

for (i in as.character(unique(idat$pmid))) {
  dd <- as.data.frame(subset(idat, pmid == i))

  if (dd$meas.tech2[1] == 'wt') {
    pp <- pars.cal[!grepl('rain|wind.2m', names(pars.cal))]
    ll <- lower[!grepl('rain|wind.2m', names(lower))]
    uu <- upper[!grepl('rain|wind.2m', names(upper))]
  } else {
    pp <- pars.cal
    ll <- lower
    uu <- upper
  }

  cat('pmid ', i, '\n ')
  modsa[[i]] <- list()
  modsa[[i]][['mod']] <- m <- optim(par = pp, fn = function(par) 
                                     resCalcOptim(p = par, dat = dd, to = 'j', time.name = 'cta',
                                                  fixed = fixed, app.name = 'tan.app', 
                                                  group = 'pmid', method = 'TAE', weights = dd$bta >= 0),
                                   method = 'L-BFGS-B', lower = ll, upper = uu)

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
