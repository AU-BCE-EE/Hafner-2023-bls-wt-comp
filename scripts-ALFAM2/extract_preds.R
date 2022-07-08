# Extract ALFAM2 predictions

d.pred <- data.frame()

for(i in 1:length(modsa)) {
    dd <- modsa[[i]]$pred
    dd$par.set <- names(modsa)[i]
    d.pred <- rbind(d.pred, dd)
}

# Annoying cta/ct issue--should change this in alfam2()
names(d.pred)[names(d.pred) == 'ct'] <- 'cta'
names(d.pred)[-1:-2] <- paste0(names(d.pred)[-1:-2], '.preda')
idat$er <- idat$e.rel
d.pred <- merge(idat, d.pred, by = c('pmid', 'cta'))

# Get predictions from single par set modb
d.predb <- modb$pred
##d.predb$par.set <- 'B - all'

names(d.predb)[names(d.predb) == 'ct'] <- 'cta'
names(d.predb)[-1:-2] <- paste0(names(d.predb)[-1:-2], '.predb')
d.pred <- merge(d.pred, d.predb, by = c('pmid', 'cta'))

# Add in predictions with par set 2
names(d.pred2)[names(d.pred2) == 'ct'] <- 'cta'

names(d.pred2)[-1:-2] <- paste0(names(d.pred2)[-1:-2], '.pred2')
d.pred <- merge(d.pred, d.pred2, by = c('pmid', 'cta'))

# Calculate emission rate residuals
d.pred$aerra <- d.pred$j.preda - d.pred$j.NH3
d.pred$aerrb <- d.pred$j.predb - d.pred$j.NH3
d.pred$aerr2 <- d.pred$j.pred2 - d.pred$j.NH3

d.pred[, ecrela := er.preda / max(er.preda), pmid]
d.pred[, ecrelb := er.predb / max(er.predb), pmid]
d.pred[, ecrel2 := er.pred2 / max(er.pred2), pmid]

# Get final emission
d.pred[, cta.max := max(cta), pmid]
d.pred.final <- subset(d.pred, cta == cta.max)

# Reshape for plots
# Flux
dfl <- melt(d.pred, id.vars = c('app.date', 'pmid', 'cta', 'meas.tech', 'wind.2m', 'flag.int'),
            measure.vars = c('j.preda', 'j.predb', 'j.pred2', 'j.NH3'))

# Residuals
drl <- melt(d.pred, id.vars = c('app.date', 'pmid', 'cta', 'meas.tech', 'wind.2m', 'flag.int'),
            measure.vars = c('aerra', 'aerrb', 'aerr2'))

# Relative (of cumulative) emission
dcl <- melt(d.pred, id.vars = c('app.date', 'pmid', 'cta', 'meas.tech', 'wind.2m', 'flag.int'),
            measure.vars = c('ecrela', 'ecrelb', 'ecrel2'))

