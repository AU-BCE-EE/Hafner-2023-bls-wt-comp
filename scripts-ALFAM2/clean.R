# Get eGylle experiments 

idat$pmid <- as.character(idat$pmid)
pdat$pmid <- as.character(pdat$pmid)

pdat$app.date <- as.character(pdat$app.start, format = '%Y-%m-%d')

pdat <- subset(pdat, proj == 'eGylle' & app.date %in% c('2021-08-11', '2021-08-20', '2022-01-05'))

# Trial keys
tk <- c(`2021-08-11` = 'A', `2021-08-20` = 'B', `2022-01-05` = 'C')
pdat$trial <- tk[pdat$app.date]

# Drop non-eGylle obs from emis with merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

# Remove pre-application measurements
idat <- subset(idat, cta > 0.75 * dt)

# Names for calibration
idat$e <- idat$e.cum
idat$j <- idat$j.NH3

# Create wind tunnel and bLS dummy variables
idat$wt <- idat$meas.tech2 == 'wt' 
idat$bLS <- idat$meas.tech2 == 'micro met'

# Measurement method-specific weather
idat$wind.wt <- (idat$meas.tech2 == 'wt') * sqrt(idat$wind.2m)
idat$wind.bLS <- (idat$meas.tech2 == 'micro met') * sqrt(idat$wind.2m)
idat$air.temp.wt <- (idat$meas.tech2 == 'wt') * idat$air.temp
idat$air.temp.bLS <- (idat$meas.tech2 == 'micro met') * idat$air.temp

# Add AER
idat$aer <- 75 * idat$wind.2m

# Create version of idat for using flatout option
# Note there is no incorporation and no dummy variables here
idatf <- idat
idatf$`__add.row` <- FALSE
idatf$`__f4` <- 1
idatf$`__group` <- idatf$pmid
