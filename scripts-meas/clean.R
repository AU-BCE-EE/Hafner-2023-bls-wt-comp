# Add fraction final emission at each time
# Recalc cum rain (sum started before application)

# Note: These updates idat *without assignment*. Not sure what I think of that.
idat[, e.rel2 := e.rel / max(e.rel), pmid]
idat[, rain.cum := cumsum(rain.rate * dt), pmid]

# Add trial keys and names for plots
tk <- c(`2021-08-11` = 'A', `2021-08-20` = 'B', `2022-01-05` = 'C')
pdat$trial <- tk[pdat$app.date]
pdat$trial.nm <- paste(pdat$trial, as.character(as.POSIXct(pdat$app.date), format = '%d %b'))

idat$trial <- tk[idat$app.date]
idat$trial.nm <- paste(idat$trial, as.character(as.POSIXct(idat$app.date), format = '%d %b'))

# Add AER classes
idat$aer <- 75 * idat$wind.2m
idat$aer[idat$meas.tech == 'bLS'] <- NA

idat$aer.grp[idat$meas.tech == 'Wind tunnel'] <- cut(idat$wind.2m[idat$meas.tech == 'Wind tunnel'], c(0, 0.3, 0.35, 1))
idat$aer.grp <- factor(idat$aer.grp, labels = c('Low 7 or 20', 'Medium 25', 'High 30 or 54'))
# Check with table()
#table(idat$wind.2m, idat$aer)
