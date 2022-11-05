# Single parameter set with wt/bLS pars

# List for holding output
modb <- list()

names.pars.fixed <- c('man.dm.f0', 
                      'man.dm.r1', 
                      'man.ph.r1', 
                      'man.ph.r3')

# Fixed pars from set 2, effectively DM and pH
fixed <- alfam2pars02[names.pars.fixed]


# Add a couple more parameters for calibration
pars.cal <- c(int.f0       =  2,
              bLS.r1       = -3.0,
              wt.r1        = -2.0,
              air.temp.r1  =  0.06,
              wind.wt.r1   =  0.3,
              wind.bLS.r1  =  0.3,
              int.r2       = -1.5,
              rain.rate.r2 =  1.0,
              bLS.r3       = -3.5,
              wt.r3        = -3.0,
              wind.wt.r3   =  0.8)#,
              #wind.bLS.r3  =  0.1,
              #air.temp.r3  =  0.01)

lower <- c(int.f0       =  0,
           bLS.r1       = -4,
           wt.r1        = -4,
           air.temp.r1  =  0,
           wind.wt.r1   =  0,
           wind.bLS.r1  =  0,
           int.r2       = -3,
           rain.rate.r2 =  0,
           bLS.r3       = -5,
           wt.r3        = -5,
           wind.wt.r3   =  0)

idat$wind.wt
table(idat$wt)
table(idat$meas.tech2)

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
                                   method = 'L-BFGS-B', lower = lower)
  
  # Get pars
  print(m)
}

modb[['coef']] <- pp <- c(m$par, ff)

# Echo pars and other model info
print(pp)
print(m)
sink('../logs/calb.txt')
  print(pp)
  print(m)
sink()

# Run model for all observations using parameter estimates
modb[['pred']] <- pr <- ALFAM2mod(dd, app.name = 'tan.app', time.name = 'cta', 
                group = 'pmid', pars = pp)

Sys.time()

#head(pr)
#head(d.pred2)
#pp <- c(pp, int.r1 = 0, int.r3 = 0)
#debug(alfam2)
