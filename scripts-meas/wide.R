# Go to wide format with interpolation in order to directly compare measurement methods

# Get select cols for micro met only
bdatw <- idat[meas.tech2 == 'micro met', c('app.date', 'pmid', 'cta', 'wind.2m', 'j.NH3', 'e.cum')]
names(bdatw)[5:6] <- paste0(names(bdatw)[5:6], '.bLS')

idatw <- data.table()
for (i in unique(bdatw[, app.date])) {

  wdat <- idat[app.date == i & meas.tech2 == 'wt']
  bdat <- bdatw[app.date == i]

  for (j in unique(wdat[, pmid])) {
    dd <- wdat[pmid == j]
    e.cum <- approx(dd$cta, dd$e.cum, xout = bdat$cta)$y
    e.cum[is.na(e.cum)] <- 0
    j.NH3 <- diff(c(0, e.cum)) / diff(c(0, bdat$cta))
    cdat <- cbind(bdat, data.table(aer = dd$aer[1], wind.2m.wt = dd$wind.2m, e.cum.wt = e.cum, j.NH3.wt = j.NH3))
    idatw <- rbind(idatw, cdat)
  }

}

idatw[, `:=` (wind.r = wind.2m / wind.2m.wt, j.r = j.NH3.bLS / j.NH3.wt)]

dd <- idatw[cta <= 24 & is.finite(j.r)]
#ggplot(dd, aes(log10(wind.r), log10(j.r), colour = factor(aer), group = factor(j.NH3.wt))) +
ggplot(dd, aes(log10(wind.r), log10(j.r), colour = factor(aer))) +
  geom_point() +
#  geom_line() +
  geom_path() +
  geom_smooth(se = FALSE, aes(group = factor(aer))) +
  facet_wrap(~ app.date)

ggplot(dd, aes(wind.r, j.r, colour = factor(aer))) +
  geom_hline(yintercept = 1) +
  geom_point() +
#  geom_line() +
  geom_path() +
  geom_smooth(se = FALSE, aes(group = factor(aer))) +
  facet_wrap(~ app.date)

dd <- idatw[cta <= 6 & is.finite(j.r)]
#ggplot(dd, aes(log10(wind.r), log10(j.r), colour = factor(aer), group = factor(j.NH3.wt))) +
ggplot(dd, aes(log10(wind.r), log10(j.r), colour = factor(aer))) +
  geom_point() +
#  geom_line() +
  geom_path() +
  geom_smooth(se = FALSE, aes(group = factor(aer))) +
  facet_wrap(~ app.date)

ggplot(dd, aes(wind.r, j.r, colour = factor(aer))) +
  geom_hline(yintercept = 1) +
  geom_point() +
#  geom_line() +
  geom_path() +
  geom_smooth(se = FALSE, aes(group = factor(aer))) +
  facet_wrap(~ app.date)
