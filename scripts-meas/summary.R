# Summarizes measurements

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
                     e.rel.final = max(e.rel),
                     e.cum.168 = approx(cta, e.cum, xout = 168)$y,
                     e.rel.168 = approx(cta, e.rel, xout = 168)$y
                     ), by = list(app.date, pmid, meas.tech, meas.tech2, aer, aer.grp)]


# Mean and sd of cumulative emission
esumm <- isumm[ , list(e.rel.final = mean(e.rel.final), e.rel.final.n = length(e.rel.final), e.rel.final.sd = sd(e.rel.final)),
               by = list(app.date, meas.tech2, aer.grp)]
