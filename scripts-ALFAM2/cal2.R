# Single parameter set with wt/bLS pars

# Measurement method-specific weather
idat$wind.wt <- (idat$meas.tech2 == 'wt') * sqrt(idat$wind.2m)
idat$wind.bLS <- (idat$meas.tech2 == 'micro met') * sqrt(idat$wind.2m)
idat$air.temp.wt <- (idat$meas.tech2 == 'wt') * idat$air.temp
idat$air.temp.bLS <- (idat$meas.tech2 == 'micro met') * idat$air.temp
idat$wt <- idat$meas.tech == 'wt'

# List for holding output
modb <- list()

names.pars.fixed <- c('man.dm.f0', 
                      'man.dm.r1', 
                      'man.ph.r1', 
                      'man.ph.r3')

# Fixed pars from set 2, effectively DM and pH
fixed <- alfam2pars02[names.pars.fixed]

# Add a couple more parameters for calibration
pars.cal <- c(int.f0       =  0.6,
              int.r1       = -1.8,
              wt.r1        =  0.1,
              air.temp.r1  =  0.0,
              wind.wt.r1   =  0.5,
              wind.bLS.r1  =  0.1,
              int.r2       = -1.5,
              rain.rate.r2 =  0.7,
              int.r3       = -3.1,
              wt.r3        =  0.1,
              wind.wt.r3   =  0.5,
              #wind.bLS.r3  =  0.1,
              air.temp.r3  =  0.01)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed))
# Should be no NA in output
which(is.na(pr$e))

# Calibrate for wt and bLS
i <- 1
pp <- pars.cal
ff <- fixed
m <- list(par = pp, converge = 1)
# Use next line to repeat
while (m$converge == 1) {
  pp <- m$par
  dd <- as.data.frame(idat)
  modb <- list()
  modb[['mod']] <- m <- optim(par = pp, fn = function(par) 
                                     resCalcOptim(p = par, dat = dd, to = 'j', time.name = 'cta',
                                                  fixed = ff, app.name = 'tan.app', 
                                                  group = 'pmid', method = 'TAE', weights = dd$bta >= 0 & !grepl('i', dd$flag.int)),
                                   method = 'Nelder-Mead')
  
  # Get pars
  print(m)
}

modb[['coef']] <- pp <- c(m$par, ff)

# Echo pars and other model info
print(pp)
print(m)
sink('../logs/cal2.txt')
  print(pp)
  print(m)
sink()

# Run model for all observations using parameter estimates
modb[['pred']] <- pr <- ALFAM2mod(dd, app.name = 'tan.app', time.name = 'cta', 
                group = 'pmid', pars = pp)

Sys.time()
