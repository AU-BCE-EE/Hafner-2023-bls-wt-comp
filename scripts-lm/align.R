# Align wind tunnel and bLS by calculating bLS averages matching wind tunnel times

cn <- c('pmid', 'app.date', 'ct', 'cta', 'dt',
        'tan.app', 'man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain', 'rain.rate', 'rain.cum',
        'j.NH3', 'e.int', 'e.cum', 'e.prev', 'e.rel')
adat <- subset(idat, meas.tech2 == 'wt')[, cn]

# Get unique interval times
blsint <- unique(adat[, c('app.date', 'cta', 'dt')])
blsint <- blsint[order(blsint$app.date, blsint$cta), ]
# And get beginning of each interval in cta units
blsint$ctb <- blsint$cta - blsint$dt

# Fill in interpolated/averaged bLS data row-by-row
blsint <- blsint
for (i in 1:nrow(blsint)) {
  # bLS subset
  dd <- subset(idat, meas.tech == 'bLS' & app.date == blsint[i, 'app.date'])

  # Interpolate bLS emission
  blsint[i, 'e.cum'] <- approx(x = dd$cta, y = dd$e.cum, xout = blsint[i, 'cta'])$y
  blsint[i, 'e.rel'] <- approx(x = dd$cta, y = dd$e.rel, xout = blsint[i, 'cta'])$y
  blsint[i, 'e.int'] <- approx(x = dd$cta, y = dd$e.cum, xout = blsint[i, 'cta'])$y - 
                          approx(x = dd$cta, y = dd$e.cum, xout = blsint[i, 'ctb'])$y
  if (blsint[i, 'ctb'] <= 0) {
    blsint[i, 'e.int'] <- blsint[i, 'e.cum']
  }
  blsint[i, 'e.prev'] <- blsint[i, 'e.cum'] - blsint[i, 'e.int']

  # Weather
  dw <- subset(dd, cta > blsint[i, 'ctb'] & cta <= blsint[i, 'cta'])
  blsint[i, 'wind.2m'] <- sum(dw$wind.2m * dw$dt) / sum(dw$dt)
  blsint[i, 'air.temp'] <- sum(dw$air.temp * dw$dt) / sum(dw$dt)

  # Rain is tricky, so interpolate total here to avoid missing any
  blsint[i, 'rain.cum'] <- approx(x = dd$cta, y = dd$rain.cum, xout = blsint[i, 'cta'])$y
  blsint[i, 'rain'] <- approx(x = dd$cta, y = dd$rain.cum, xout = blsint[i, 'cta'])$y - 
                          approx(x = dd$cta, y = dd$rain.cum, xout = blsint[i, 'ctb'])$y
  if (blsint[i, 'ctb'] <= 0) {
    blsint[i, 'rain'] <- blsint[i, 'rain.cum']
  }

  blsint[i, 'rain.rate'] <- blsint[i, 'rain'] / blsint[i, 'dt']

  blsint[i, 'pmid'] <- dd$pmid[1]

}

blsint$j.NH3 <- blsint$e.int / blsint$dt 

# Merge in
adat <- merge(adat, blsint, by = c('app.date', 'cta'), all.x = TRUE, suffixes = c('.wt', '.bls'))
adat <- adat[order(adat$pmid.wt, adat$cta), ]
