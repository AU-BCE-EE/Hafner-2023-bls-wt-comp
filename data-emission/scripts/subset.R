
pdat$app.date <- as.character(pdat$app.start, format = '%Y-%m-%d')

pdat <- subset(pdat, proj == 'eGylle' & app.date %in% c('2021-08-11', '2021-08-20', '2022-01-05'))

# Drop non-eGylle obs from emis interval data
idat <- subset(idat, pmid %in% unique(pdat$pmid))


