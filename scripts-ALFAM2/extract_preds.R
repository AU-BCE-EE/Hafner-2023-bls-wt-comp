# Extract ALFAM2 predictions

d.pred <- data.frame()

for(i in 1:length(modsa)) {
    dd <- modsa[[i]]$pred
    dd$par.set <- names(modsa)[i]
    d.pred <- rbind(d.pred, dd)
}

names(d.pred)[! names(d.pred) %in% c('pmid', 'cta')] <- paste0(names(d.pred)[! names(d.pred) %in% c('pmid', 'cta')], '.preda')
idat$er <- idat$e.rel
d.pred <- merge(idat, d.pred, by = c('pmid', 'cta'))

# Get predictions from single par set modb
d.predb <- modb$pred
##d.predb$par.set <- 'B - all'

names(d.predb)[! names(d.predb) %in% c('pmid', 'cta')] <- paste0(names(d.predb)[! names(d.predb) %in% c('pmid', 'cta')], '.predb')
d.pred <- merge(d.pred, d.predb, by = c('pmid', 'cta'))
head(d.pred)

# Add in predictions with par set 2
names(d.pred2)[! names(d.pred2) %in% c('pmid', 'cta')] <- paste0(names(d.pred2)[! names(d.pred2) %in% c('pmid', 'cta')], '.pred2')
d.pred <- merge(d.pred, d.pred2, by = c('pmid', 'cta'))

# Calculate emission rate residuals
d.pred$aerra <- d.pred$j.preda - d.pred$j.NH3
d.pred$aerrb <- d.pred$j.predb - d.pred$j.NH3
d.pred$aerr2 <- d.pred$j.pred2 - d.pred$j.NH3

head(d.pred)
d.pred[, ecrela := er.preda / max(er.preda), pmid]
d.pred[, ecrelb := er.predb / max(er.predb), pmid]
d.pred[, ecrel2 := er.pred2 / max(er.pred2), pmid]

# Get final emission
d.pred[, cta.max := max(cta), pmid]
d.pred.final <- subset(d.pred, cta == cta.max)

# Get 168 hr emission
d.pred[, cta.168 := cta[abs(cta - 168) == min(abs(cta - 168))], pmid]
d.pred.168 <- subset(d.pred, cta == cta.168)

# Reshape for plots
# Flux
dfl <- melt(d.pred, id.vars = c('trial', 'app.date', 'pmid', 'ct', 'cta', 'bta', 'meas.tech', 'wind.2m', 'aer', 'air.temp', 'flag.int'),
            measure.vars = c('j.preda', 'j.predb', 'j.pred2', 'j.NH3'))

# Residuals
drl <- melt(d.pred, id.vars = c('trial', 'app.date', 'pmid', 'ct', 'cta', 'bta', 'meas.tech', 'wind.2m', 'aer', 'air.temp', 'flag.int'),
            measure.vars = c('aerra', 'aerrb', 'aerr2'))

# Relative (of cumulative) emission
dcl <- melt(d.pred, id.vars = c('trial', 'app.date', 'pmid', 'ct', 'cta', 'bta', 'meas.tech', 'wind.2m', 'aer', 'air.temp', 'flag.int'),
            measure.vars = c('ecrela', 'ecrelb', 'ecrel2'))

