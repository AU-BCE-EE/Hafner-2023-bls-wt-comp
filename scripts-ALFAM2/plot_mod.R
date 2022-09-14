# Plots 

# Flux ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dfl$variable.nm <- factor(dfl$variable, levels = c('j.NH3', 'j.preda', 'j.predb', 'j.pred2'),
                         labels = c('Measured', 'ALFAM2\ncal. A', 'ALFAM2\ncal. B', 'ALFAM2\npar. set 2'))
dfl$trial.nm <- paste(dfl$trial, as.character(as.POSIXct(dfl$app.date), format = '%b %d'))

#dd <- subset(dfl, variable != 'j.pred2' & bta >= 0)
dd <- subset(dfl, bta >= -2)
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ trial.nm) +
  coord_cartesian(xlim = c(0, 168), ylim =c(0, 7.5)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/50_flux_comp', height = 5, width = 7)

# Flux par set 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- subset(dfl, variable %in% c('j.NH3', 'j.pred2'))
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ trial.nm) +
  coord_cartesian(xlim = c(0, 168)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/51_flux_comp_ps2', height = 3, width = 7)


# Residuals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drl$variable.nm <- factor(drl$variable, levels = c('aerra', 'aerrb', 'aerr2'),
                         labels = c('ALFAM2\ncal. A', 'ALFAM2\ncal. B', 'ALFAM2\npar. set 2'))

drl$trial.nm <- paste(drl$trial, as.character(as.POSIXct(drl$app.date), format = '%b %d'))

#dd <- subset(drl, variable != 'aerr2')
dd <- subset(drl, bta > -2)
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_hline(yintercept = 0, lty = 1, colour = 'gray45') +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ trial.nm) +
  coord_cartesian(xlim =c(0, 168)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('Error in NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/60_error_comp', height = 4, width = 7)

# Residuals par set 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drl$variable.nm <- factor(drl$variable, levels = c('aerra', 'aerrb', 'aerr2'),
                         labels = c('ALFAM2 cal. A', 'ALFAM2 cal. B', 'ALFAM2 par. set 2'))

dd <- drl
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ trial.nm) +
  xlim(0, 168) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('Error in NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '', lty = '') +
  theme(legend.position = 'none')
ggsave2x('../plots-ALFAM2/61_error_comp_ps2', height = 3, width = 7)

# Early emission contribution ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dcl$variable.nm <- factor(dcl$variable, levels = c('ecrela', 'ecrelb', 'ecrel2'),
                         labels = c('ALFAM2 cal. A', 'ALFAM2 cal. B', 'ALFAM2 par. set 2'))

dd <- subset(dcl, variable != 'ecrel2' & bta <= 11.5)
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_line(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_line(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ trial.nm) +
  coord_cartesian(xlim =c(0, 11.5)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emis.'~('frac. final')), 
       colour = '', lty = '') +
  theme(legend.position = 'none')
ggsave2x('../plots-ALFAM2/70_remis_comp', height = 4, width = 7)

# r1 par ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
d.pred$trial.nm <- paste(d.pred$trial, as.character(as.POSIXct(d.pred$app.date), format = '%b %d'))
dd <- d.pred
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, r1.predb, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_wrap(~ trial.nm) +
  coord_cartesian(xlim = c(0, 168)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression(italic('r')[1]~('h'^'-1'))) +
  theme(legend.position = 'none')
ggsave2x('../plots-ALFAM2/80_r1', height = 3, width = 7)

# 168 h cumulative emission meas and ALFAM2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
d.pred.168$trial.nm <- paste(d.pred.168$trial, as.character(as.POSIXct(d.pred.168$app.date), format = '%b %d'))
dd <- d.pred.168
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(er.predb, e.rel, group = pmid, shape = trial.nm)) +
  geom_abline(intercept = 0, slope = 1, lty = 1, col = 'gray45') +
  geom_abline(intercept = 0, slope = c(0.8, 1.2), lty = '11', col = 'gray75') +
  geom_point(aes(colour = wind.2m), size = 2) +
  geom_point(data = db, aes(size = meas.tech), colour = 'red') +
  scale_shape_manual(values = c(1, 6, 20)) +
  xlim(0, 0.75) + ylim(0, 0.75) +
  guides(shape = guide_legend(override.aes = list(colour = 'black', size = 2))) +
  theme_bw() +
  theme(legend.text = element_text(size=9), legend.title = element_text(size=9), legend.key.height = unit(0.3, 'cm')) +
  labs(x = 'ALFAM2 cal. B', y = 'Measured', shape = 'Date', colour = 'Wind tun. (m/s)', size = '')
ggsave2x('../plots-ALFAM2/90_cum_emis_comp', height = 2.7, width = 4.0, scale = 1.1)


# 168 h cumulative emission meas and ALFAM2 par set 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- d.pred.168
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(er.pred2, e.rel, group = pmid, shape = trial.nm)) +
  geom_abline(intercept = 0, slope = 1, lty = 1, col = 'gray45') +
  geom_abline(intercept = 0, slope = c(0.8, 1.2), lty = '11', col = 'gray75') +
  geom_point(aes(colour = wind.2m), size = 2) +
  geom_point(data = db, aes(size = meas.tech), colour = 'red') +
  scale_shape_manual(values = c(1, 6, 20)) +
  xlim(0, 0.65) + ylim(0, 0.65) +
  theme_bw() +
  guides(shape = guide_legend(override.aes = list(colour = 'black', size = 2))) +
  theme_bw() +
  theme(legend.text = element_text(size=9), legend.title = element_text(size=9), legend.key.height = unit(0.3, 'cm')) +
  labs(x = 'ALFAM2 par. set 2', y = 'Measured', shape = 'Date', colour = 'Wind tun. (m/s)', size = '')
ggsave2x('../plots-ALFAM2/91_cum_emis_comp_ps2', height = 2.5, width = 4.0, scale = 1.1)

#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dfl$variable.nm <- factor(dfl$variable, levels = c('j.NH3', 'j.preda', 'j.predb', 'j.pred2'),
                         labels = c('Measured', 'ALFAM2 cal. A', 'ALFAM2 cal. B', 'ALFAM2 par. set 2'))

dd <- subset(dfl, !variable %in% c('j.preda', 'j.pred2') & bta >= 0)
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(air.temp, value, group = pmid)) +
  geom_line(aes(group = ct), colour = 'black', lwd = 0.3, alpha = 0.8) +
  geom_path(aes(colour = variable.nm), alpha = 0.8) +
  facet_wrap(~ paste(trial.nm, pmid), scale = 'fixed') +
  theme_bw() +
  labs(x = expression('Air temperature'~(degree*C)), y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '') +
  theme(legend.position = c(0.6, 0.1))
ggsave2x('../plots-ALFAM2/100_flux_temp_wt', height = 9, width = 7)

ggplot(db, aes(air.temp, value, group = pmid)) +
  geom_line(aes(group = ct), colour = 'black', lwd = 0.3, alpha = 0.8) +
  geom_path(aes(colour = variable.nm), alpha = 0.8) +
  facet_wrap(~ paste(trial.nm, pmid), scale = 'free') +
  theme_bw() +
  labs(x = expression('Air temperature'~(degree*C)), y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/101_flux_temp_bLS', height = 4, width = 7)

ggplot(db, aes(wind.2m, value, group = pmid)) +
  geom_line(aes(group = ct), colour = 'black', lwd = 0.3, alpha = 0.8) +
  geom_path(aes(colour = variable.nm), alpha = 0.8) +
  facet_wrap(~ paste(trial.nm, pmid), scale = 'free') +
  theme_bw() +
  labs(x = expression('Wind speed'~(m~s^'-1')), y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/102_flux_wind_bLS', height = 4, width = 7)


