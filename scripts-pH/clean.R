# Sort out dates and calculate means and sd

dat$date <- ymd(dat$Date)
dat$date.time <- ymd_hm(paste(dat$Date, dat$Time))
dat$covered <- ifelse(dat$Cover == 'yes', 'Covered', 'Not covered')
dat$exper <- dat$Experiment

apptime <- data.table(exper = c('21C', '21D', '22A'), 
                      app.start = c(ymd_hm('2021-08-11 16:30'), ymd_hm('2021-08-20 11:15'), ymd_hm('2022-01-05 14:15')),
                      app.date = c(ymd('2021-08-11'), ymd('2021-08-20'), ymd('2022-01-05')))

dat <- merge(dat, apptime)
dat$ct <- as.numeric(difftime(dat$date.time, dat$app.start, units = 'hours'))

# 
ds <- dat[, .(pH = mean(pH), s = sd(pH)), by = .(app.date, ct, date.time, covered)]

