
sink('../logs/calbboot.txt')
  print(Sys.time())
sink()

# Bootstrap
n <- 30
modbboot <- list()

pmid.bLS <- subset(pdat, meas.tech == 'bLS')$pmid
pmid.wt <- subset(pdat, meas.tech == 'Wind tunnel')$pmid

parsboot <- data.frame()

names.pars.fixed <- c('man.dm.f0', 
                      'man.dm.r1', 
                      'man.ph.r1', 
                      'man.ph.r3')

# Fixed pars from set 2, effectively DM and pH
fixed <- alfam2pars02[names.pars.fixed]


# List parameters for calibration
# Note that bLS wind speed and air temperature do not affect r3 presently
pars.cal <- c(int.f0       =  0.8,
              bLS.r1       = -2.8,
              wt.r1        = -1.9,
              air.temp.r1  =  0.03,
              wind.wt.r1   =  0.59,
              wind.bLS.r1  =  0.66,
              int.r2       = -1.4,
              rain.rate.r2 =  0.88,
              bLS.r3       = -4.0,
              wt.r3        = -3.2,
              wind.wt.r3   =  0.31,
              wind.bLS.r3  =  0.16,
              air.temp.r3  =  0.03)

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
           wind.wt.r3   =  0,
           wind.bLS.r3  =  0,
           air.temp.r3  =  0)

upper <- c(int.f0       =  1,
           bLS.r1       = -1,
           wt.r1        = -1,
           air.temp.r1  =  0.3,
           wind.wt.r1   =  0.5,
           wind.bLS.r1  =  0.5,
           int.r2       = -1,
           rain.rate.r2 =  0.3,
           bLS.r3       = -2,
           wt.r3        = -2,
           wind.wt.r3   =  0.3,
           wind.bLS.r3  =  0.3,
           air.temp.r3  =  0.3)

set.seed(123)

for (i in 1:n) {

  cat('Bootstrap iteration ', i, '\n')
  modbboot[[i]] <- list()

  # Sample pmid with replacement
  pb <- sample(pmid.bLS, length(pmid.bLS), replace = TRUE)
  pw <- sample(pmid.wt, length(pmid.wt), replace = TRUE)
  pmids <- c(pb, pw)
  dd <- data.frame()
  j <- 0
  for (p in pmids) {
    j <- j + 1
    ds <- as.data.frame(subset(idat, pmid == p))
    ds$key <- j
    dd <- rbind(dd, ds)
  }

  modbboot[[i]][['mod']] <- m <- optim(par = pars.cal, fn = function(par) 
                                     resCalcOptim(p = par, dat = dd, to = 'j', time.name = 'cta',
                                                  fixed = fixed, app.name = 'tan.app', 
                                                  group = 'key', method = 'TAE', weights = dd$bta >= 0 & !grepl('i', dd$flag.int)),
                                   method = 'L-BFGS-B', lower = lower, upper = upper)

  parsboot <- rbind(parsboot, t(as.data.frame(c(i = i, m$par))))

  # Echo pars and other model info
  print(m)
  sink('../logs/calbboot.txt', append = TRUE)
    cat('Bootstrap iteration ', i, '\n')
    print(pmids)
    print(m)
  sink()

}

sink('../logs/calbboot.txt', append = TRUE)
  print(Sys.time())
sink()
