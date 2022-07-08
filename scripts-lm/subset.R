# Get eGylle experiments 

pdat <- subset(pdat, proj == 'eGylle')

# Drop non-eGylle obs from emis with merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

# Remove pre-application measurements
idat <- subset(idat, cta >= 0)

# Names for calibration
idat$e <- idat$e.cum
idat$j <- idat$j.NH3


