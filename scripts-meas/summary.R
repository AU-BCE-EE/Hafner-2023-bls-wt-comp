# Summarizes measurements

table(idat$flag)

isumm <- idat[, list(cta = max(cta), 
                     air.temp.mean = mean(air.temp), 
                     air.temp.min = min(air.temp), 
                     air.temp.max = max(air.temp), 
                     wind.2m.mean = mean(wind.2m), 
                     wind.2m.min = min(wind.2m), 
                     wind.2m.max = max(wind.2m), 
                     rain.cum = max(rain.cum), 
                     rain.cum.48 = max(rain.cum * (cta <= 48)), 
                     j.NH3.mean = mean(j.NH3),
                     j.NH3.min = min(j.NH3),
                     j.NH3.max = max(j.NH3),
                     e.cum.final = max(e.cum), 
                     e.cum.final.nogaps = sum(e.int[!grepl('i', flag.int)]), 
                     e.rel.final = max(e.rel),
                     e.cum.168 = approx(cta, e.cum, xout = 168)$y,
                     e.rel.168 = approx(cta, e.rel, xout = 168)$y,
                     e.cum.168.sum = sum(e.int[cta <= 168]), 
                     e.cum.168.nogaps = sum(e.int[cta <= 168 & !grepl('i', flag.int)]),
                     n.int.168 = length(e.int[cta <= 168]),
                     n.int.168.nogaps = length(e.int[cta <= 168 & !grepl('i', flag.int)])
                     ), by = list(trial.nm, app.date, pmid, meas.tech, meas.tech2, aer, aer.grp)]

# Mean and sd of cumulative emission
esumm <- isumm[ , list(
                       e.rel.final = mean(e.rel.final), e.rel.final.n = length(e.rel.final), e.rel.final.sd = sd(e.rel.final),
                       e.rel.168 = mean(e.rel.168), e.rel.168.n = length(e.rel.168), e.rel.168.sd = sd(e.rel.168),
                       e.cum.final = mean(e.cum.final), e.cum.final.nogaps = mean(e.cum.final.nogaps), 
                       e.cum.168.sum = mean(e.cum.168.sum), e.cum.168.nogaps = mean(e.cum.168.nogaps),
                       n.int.168 = mean(n.int.168), n.int.168.nogaps = mean(n.int.168.nogaps)
                       ),
               by = list(trial.nm, app.date, meas.tech2, aer.grp)]


isumm <- rounddf(as.data.frame(isumm), digits = 3, func = signif)
esumm <- rounddf(as.data.frame(esumm), 3, func = signif)

# Get plot keys for checking data externally
psumm <- pdat[, c('submitter', 'file', 'pmid', 'pid', 'meas.tech', 'trial.nm', 'app.date')]
