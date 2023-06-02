# Summarizes measurements

isumm <- idat[, list(cta = max(cta), 
                     air.temp.mean = mean(air.temp), 
                     air.temp.min = min(air.temp), 
                     air.temp.max = max(air.temp), 
                     wind.2m.mean = mean(wind.2m), 
                     wind.2m.min = min(wind.2m), 
                     wind.2m.max = max(wind.2m), 
                     rain.cum = max(rain.cum), 
                     rain.cum.168 = max(rain.cum * (cta <= 168)), 
                     rain.cum.24 = max(rain.cum * (cta <= 24)), 
                     rain.cum.48 = max(rain.cum * (cta <= 48)), 
                     j.NH3.mean = mean(j.NH3),
                     j.NH3.min = min(j.NH3),
                     j.NH3.max = max(j.NH3),
                     e.cum.final = max(e.cum), 
                     e.cum.final.gaps = sum(e.int[!grepl('i', flag.int)]), 
                     e.rel.final = max(e.rel),
                     e.cum.168 = approx(cta, e.cum, xout = 168)$y,
                     e.rel.168 = approx(cta, e.rel, xout = 168)$y,
                     e.cum.168.sum = sum(e.int[cta <= 168]), 
                     e.cum.168.gaps = sum(e.int[cta <= 168 & !grepl('i', flag.int)]),
                     n.int.168 = length(e.int[cta <= 168]),
                     n.int.168.gaps = length(e.int[cta <= 168 & !grepl('i', flag.int)])
                     ), by = list(trial.nm, app.date, pmid, meas.tech, meas.tech2, aer, aer.grp)]

# Mean and sd of cumulative emission
esumm <- isumm[ , list(
                       pmid = paste(pmid, collapse = ', '),
                       e.rel.final = mean(e.rel.final), e.rel.final.n = length(e.rel.final), e.rel.final.sd = sd(e.rel.final),
                       e.rel.168 = mean(e.rel.168), e.rel.168.n = length(e.rel.168), e.rel.168.sd = sd(e.rel.168),
                       e.cum.final = mean(e.cum.final), e.cum.final.gaps = mean(e.cum.final.gaps), 
                       e.cum.168.sum = mean(e.cum.168.sum), e.cum.168.gaps = mean(e.cum.168.gaps),
                       n.int.168 = mean(n.int.168), n.int.168.gaps = mean(n.int.168.gaps)
                       ),
               by = list(trial.nm, app.date, meas.tech2, aer.grp)]

esumm$gapeffect <- 1 - esumm$e.cum.168.gaps / esumm$e.cum.168.sum
esumm$fgap <- 1 - esumm$n.int.168.gaps / esumm$n.int.168

isumm <- rounddf(as.data.frame(isumm), digits = 3, func = signif)
esumm <- rounddf(as.data.frame(esumm), 3, func = signif)

# Get plot keys for checking data externally
psumm <- pdat[, c('submitter', 'file', 'pmid', 'pid', 'meas.tech', 'trial.nm', 'app.date')]

# Select some cols from pdat to export
plotsumm <- pdat[, .(pmid, pid, submitter, file, proj, exper, app.date, meas.tech, meas.tech2, air.temp.24, air.temp.168, wind.2m.24, wind.2m.168, rain.12, rain.24, rain.48, rain.168, rain.tot)] 
