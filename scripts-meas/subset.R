# Get eGylle experiments 

pdat$app.date <- as.character(pdat$app.start, format = '%Y-%m-%d')

pdat <- subset(pdat, proj == 'eGylle' & app.date %in% c('2021-08-11', '2021-08-20', '2022-01-05'))

# Add trial keys and names for plots
tk <- c(`2021-08-11` = 'A', `2021-08-20` = 'B', `2022-01-05` = 'C')
pdat$trial <- tk[pdat$app.date]
pdat$trial.nm <- paste(pdat$trial, as.character(as.POSIXct(pdat$app.date), format = '%d %b'))

# Drop non-eGylle obs from emis with merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

# Remove pre-application measurements
# Note that this does not remove the first interval, which may have underestiamted flux because it started before application
# First interval is removed in plot_big.R
idat <- subset(idat, cta >= 0)
