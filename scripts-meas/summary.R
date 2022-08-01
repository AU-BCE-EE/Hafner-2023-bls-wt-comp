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
                     e.rel = max(e.rel) 
                     ), list(app.date, pmid, meas.tech2)]

isumm <- rounddf(as.data.frame(isumm), digits = 3, func = signif)
