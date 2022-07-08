# Extract ALFAM2 predictions

d.pred <- data.frame()

for(i in 1:length(mods)) {
    dd <- mods[[i]]$pred
    dd$par.set <- names(mods)[i]
    d.pred <- rbind(d.pred, dd)
}

# Annoying cta/ct issue--should change this in alfam2()
names(d.pred)[names(d.pred) == 'ct'] <- 'cta'
names(d.pred)[-1:-2] <- paste0(names(d.pred)[-1:-2], '.pred1')
idat$er <- idat$e.rel
d.pred <- merge(idat, d.pred, by = c('pmid', 'cta'))

# Get predictions from single par set mod2
d.pred2 <- mod2$pred
d.pred2$par.set <- '2 - all'

names(d.pred2)[names(d.pred2) == 'ct'] <- 'cta'
names(d.pred2)[-1:-2] <- paste0(names(d.pred2)[-1:-2], '.pred2')
d.pred <- merge(d.pred, d.pred2, by = c('pmid', 'cta'))

# Calculate emission rate residuals
d.pred$aerr1 <- d.pred$j.pred1 - d.pred$j.NH3
d.pred$aerr2 <- d.pred$j.pred2 - d.pred$j.NH3

d.pred[, ecrel1 := er.pred1 / max(er.pred1), pmid]
d.pred[, ecrel2 := er.pred2 / max(er.pred2), pmid]

# Get final emission
d.pred[, cta.max := max(cta), pmid]
d.pred.final <- subset(d.pred, cta == cta.max)

# Reshape for plots
# Flux
dfl <- melt(d.pred, id.vars = c('app.date', 'pmid', 'cta', 'meas.tech', 'wind.2m', 'flag.int'),
            measure.vars = c('j.pred1', 'j.pred2', 'j.NH3'))

# Residuals
drl <- melt(d.pred, id.vars = c('app.date', 'pmid', 'cta', 'meas.tech', 'wind.2m', 'flag.int'),
            measure.vars = c('aerr1', 'aerr2'))

# Relative (of cumulative) emission
dcl <- melt(d.pred, id.vars = c('app.date', 'pmid', 'cta', 'meas.tech', 'wind.2m', 'flag.int'),
            measure.vars = c('ecrel1', 'ecrel2'))

