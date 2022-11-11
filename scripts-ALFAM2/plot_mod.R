# Plots 

# Flux ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dfl$variable.nm <- factor(dfl$variable, levels = c('j.NH3', 'j.pred2', 'j.preda', 'j.predb'),
                         labels = c('Measured', 'ALFAM2\npar. set 2', 'ALFAM2\npar. set A', 'ALFAM2\npar. set X'))
dfl$trial.nm <- paste(dfl$trial, as.character(as.POSIXct(dfl$app.date), format = '%d %b'))

#dd <- subset(dfl, variable != 'j.pred2' & bta >= 0)
dd <- subset(dfl, bta >= -2)
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  coord_cartesian(xlim = c(0, 168), ylim =c(0, 5.5)) +
  #scale_colour_viridis_c(option = 'D') +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = expression(atop('Wind tunnel average velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/50_flux_comp', height = 5, width = 7)

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  coord_cartesian(xlim = c(0, 50), ylim =c(0, 5.5)) +
  #scale_colour_viridis_c(option = 'H') +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = expression(atop('Wind tunnel average velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/51_flux_comp_zoom', height = 5, width = 7)

dd <- subset(dfl, bta >= -2 & variable %in% c('j.predb', 'j.NH3'))
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]
x <- subset(dd, app.date == '2021-08-11')
head(x)
tail(x)
x <- subset(idat, app.date == '2021-08-11')
x <- subset(dfl, app.date == '2021-08-11')
x <- subset(dw, app.date == '2021-08-11')

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(app.date ~ variable.nm) +
  coord_cartesian(xlim = c(0, 168), ylim =c(0, 5.5)) +
  #scale_colour_viridis_c(option = 'D') +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = expression(atop('Wind tunnel ave. velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/52_flux_comp_B', height = 5, width = 5)

# Drop set A for paper
dd <- subset(dfl, bta >= -2 & variable != 'j.preda')
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  coord_cartesian(xlim = c(0, 168), ylim =c(0, 5.5)) +
  #scale_colour_viridis_c(option = 'D') +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = expression(atop('Wind tunnel average velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/53_flux_comp_sel', height = 5, width = 7)

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  coord_cartesian(xlim = c(0, 50), ylim =c(0, 5.5)) +
  #scale_colour_viridis_c(option = 'H') +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = expression(atop('Wind tunnel average velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/54_flux_comp_sel_zoom', height = 5, width = 7)


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
       colour = expression(atop('Wind tunnel average velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/55_flux_comp_ps2', height = 3, width = 7)


# Residuals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drl$variable.nm <- factor(drl$variable, levels = c('aerra', 'aerrb', 'aerr2'),
                         labels = c('ALFAM2\npar. set A', 'ALFAM2\npar. set X', 'ALFAM2\npar. set 2'))

drl$trial.nm <- paste(drl$trial, as.character(as.POSIXct(drl$app.date), format = '%d %b'))

#dd <- subset(drl, variable != 'aerr2')
dd <- subset(drl, bta > -2)
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_hline(yintercept = 0, lty = 1, colour = 'gray45') +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  coord_cartesian(xlim =c(0, 168)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('Error in NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = expression(atop('Wind tunnel average velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/60_error_comp', height = 4, width = 7)

ggplot(dw, aes(bta, value, group = pmid)) +
  geom_hline(yintercept = 0, lty = 1, colour = 'gray45') +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  coord_cartesian(xlim =c(0, 50)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('Error in NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = expression(atop('Wind tunnel average velocity'~(m~s^'-1'),' ')), lty = ' ') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/60_error_comp_zoom', height = 4, width = 7)


# Residuals par set 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drl$variable.nm <- factor(drl$variable, levels = c('aerra', 'aerrb', 'aerr2'),
                         labels = c('ALFAM2 par. set A', 'ALFAM2 par. set X', 'ALFAM2 par. set 2'))

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
                         labels = c('ALFAM2 par. set A', 'ALFAM2 par. set X', 'ALFAM2 par. set 2'))
dcl$trial.nm <- paste(dcl$trial, as.character(as.POSIXct(dcl$app.date), format = '%d %b'))

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
d.pred$trial.nm <- paste(d.pred$trial, as.character(as.POSIXct(d.pred$app.date), format = '%d %b'))
dd <- d.pred
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(bta, r1.predb, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_wrap(~ app.date) +
  coord_cartesian(xlim = c(0, 168)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression(italic('r')[1]~('h'^'-1'))) +
  theme(legend.position = 'none')
ggsave2x('../plots-ALFAM2/80_r1', height = 3, width = 7)

# 168 h cumulative emission meas and ALFAM2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
d.pred.168$trial.nm <- paste(d.pred.168$trial, as.character(as.POSIXct(d.pred.168$app.date), format = '%d %b'))
dd <- d.pred.168
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(er.predb, e.rel, group = pmid, shape = app.date)) +
  geom_abline(intercept = 0, slope = 1, lty = 1, col = 'gray45') +
  geom_abline(intercept = 0, slope = c(0.8, 1.2), lty = '11', col = 'gray75') +
  geom_point(aes(colour = wind.2m), size = 2, show.legend = FALSE) +
  geom_point(data = db, aes(size = meas.tech), colour = 'red') +
  scale_shape_manual(values = c(1, 6, 20)) +
  xlim(0, 0.75) + ylim(0, 0.65) +
  guides(shape = guide_legend(override.aes = list(colour = 'black', size = 2))) +
  theme_bw() +
  theme(legend.text = element_text(size=9), legend.title = element_text(size=9), legend.key.height = unit(0.3, 'cm'), legend.position = 'top') +
  guides(size = 'none') +
  labs(x = 'ALFAM2 par. set X', y = 'Measured', shape = 'Date', colour = expression('Wind tunnel'~(m~s^'-1')), size = '')
ggsave2x('../plots-ALFAM2/90_cum_emis_comp', height = 4.2, width = 4.0, scale = 1.1)


# 168 h cumulative emission meas and ALFAM2 par set 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- d.pred.168
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(er.pred2, e.rel, group = pmid, shape = app.date)) +
  geom_abline(intercept = 0, slope = 1, lty = 1, col = 'gray45') +
  geom_abline(intercept = 0, slope = c(0.8, 1.2), lty = '11', col = 'gray75') +
  geom_point(aes(colour = wind.2m), size = 2) +
  geom_point(data = db, aes(size = meas.tech), colour = 'red') +
  scale_shape_manual(values = c(1, 6, 20)) +
  xlim(0, 0.65) + ylim(0, 0.55) +
  theme_bw() +
  guides(shape = guide_legend(override.aes = list(colour = 'black', size = 2))) +
  theme_bw() +
  theme(legend.text = element_text(size=9), legend.title = element_text(size=9), legend.key.height = unit(0.3, 'cm')) +
  labs(x = 'ALFAM2 par. set 2', y = 'Measured', shape = 'Date', colour = expression('Wind tunnel'~(m~s^'-1')), size = '')
ggsave2x('../plots-ALFAM2/91_cum_emis_comp_ps2', height = 2.5, width = 4.0, scale = 1.1)

# 168 h cumulative emission meas and ALFAM2 (par. set X and par set 2) ~~~~~~~~~~~~~~~~~
dd <- d.pred.168
# Reshape
dl <- melt(dd, id.vars = c('pmid', 'e.rel', 'app.date', 'wind.2m', 'meas.tech'), measure.vars = c('er.predb', 'er.pred2'))
dl$parset <- factor(dl$variable, levels = c('er.pred2', 'er.predb'), labels = c('Parameter set 2', 'Parameter set X'))
dw <- dl[dl$meas.tech == 'Wind tunnel', ]
db <- dl[dl$meas.tech == 'bLS', ]

ggplot(dw, aes(value, e.rel, group = pmid, shape = app.date)) +
  geom_abline(intercept = 0, slope = 1, lty = 1, col = 'gray45') +
  geom_abline(intercept = 0, slope = c(0.8, 1.2), lty = '11', col = 'gray75') +
  geom_point(aes(colour = wind.2m), size = 2) +
  geom_point(data = db, aes(size = meas.tech), colour = 'red') +
  scale_shape_manual(values = c(1, 6, 20)) +
  xlim(0, 0.65) + ylim(0, 0.55) +
  facet_wrap(~ parset) +
  theme_bw() +
  guides(shape = guide_legend(override.aes = list(colour = 'black', size = 2))) +
  theme_bw() +
  theme(legend.text = element_text(size=9), legend.title = element_text(size=9), legend.key.height = unit(0.3, 'cm')) +
  labs(x = expression('ALFAM2'~NH[3]~'loss (frac. applied TAN)'), y = expression('Measured'~NH[3]~'loss (frac. applied TAN)'), 
       shape = 'Date', colour = expression('Wind tunnel'~(m~s^'-1')), size = '')
ggsave2x('../plots-ALFAM2/92_cum_emis_comp', height = 2.5, width = 6.0, scale = 1.1)


# Check flux vs. wind/temperature ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dfl$variable.nm <- factor(dfl$variable, levels = c('j.NH3', 'j.preda', 'j.predb', 'j.pred2'),
                         labels = c('Measured', 'ALFAM2 par. set A', 'ALFAM2 par. set X', 'ALFAM2 par. set 2'))

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

# Next plot not very good
dw <- dd[dd$meas.tech == 'Wind tunnel' & dd$cta < 10, ]
ggplot(dw, aes(wind.2m, value)) +
  geom_point(aes(colour = variable.nm), alpha = 0.8) +
  facet_wrap(~ trial.nm, scale = 'fixed') +
  theme_bw() +
  labs(x = expression('Air temperature'~(degree*C)), y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '') +
  theme(legend.position = c(0.6, 0.1))
ggsave2x('../plots-ALFAM2/101_flux_air_vel_wt', height = 9, width = 7)

ggplot(db, aes(air.temp, value, group = pmid)) +
  geom_line(aes(group = ct), colour = 'black', lwd = 0.3, alpha = 0.8) +
  geom_path(aes(colour = variable.nm), alpha = 0.8) +
  facet_wrap(~ app.date, scale = 'free') +
  theme_bw() +
  scale_color_brewer(palette = 'Set1') + 
  labs(x = expression('Air temperature'~(degree*C)), y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/102_flux_temp_bLS', height = 4, width = 7)

ggplot(db, aes(wind.2m, value, group = pmid)) +
  geom_line(aes(group = ct), colour = 'black', lwd = 0.3, alpha = 0.8) +
  geom_path(aes(colour = variable.nm), alpha = 0.8) +
  facet_wrap(~ app.date, scale = 'free') +
  theme_bw() +
  scale_color_brewer(palette = 'Set1') +
  labs(x = expression('Wind speed'~(m~s^'-1')), y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '') +
  theme(legend.position = 'top')
ggsave2x('../plots-ALFAM2/103_flux_wind_bLS', height = 4, width = 7)


