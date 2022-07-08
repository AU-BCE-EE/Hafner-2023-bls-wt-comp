# Get eGylle experiments 

pdat$app.date <- as.character(pdat$app.start, format = '%Y-%m-%d')

pdat <- subset(pdat, proj == 'eGylle' & app.date %in% c('2021-08-11', '2021-08-20', '2022-01-05'))

# Drop non-eGylle obs from emis with merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

# Remove pre-application measurements
idat <- subset(idat, cta >= 0)
