
dd <- subset(idat, cta <= 15 & app.date == '2021-08-20')
dd$j.NH3[grepl('i', dd$flag.int)] <- NA

# Compare measurement methods
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]
pf1 <- ggplot(dw, aes(cta, j.NH3, group = pmid)) +
       geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
       geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
       coord_cartesian(xlim =c(0, 11.5)) +
       theme_bw() +
       labs(x = '', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
            colour = 'Wind tunnel\nave. velocity (m/s):', lty = ' ') +
       theme(legend.position = 'none')

     names(idat)
pe1 <- ggplot(dw, aes(cta, e.rel2, group = pmid)) +
       geom_line(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
       geom_line(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
       coord_cartesian(xlim =c(0, 11.5)) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emis.'~('frac. final'))) +
       theme(legend.position = 'none')

mat <- matrix(c(1, 
                1,
                1,
                1,
                1,
                2,
                2,
                2,
                2),
                ncol = 1)

pfw <- grid.arrange(pf1, pe1, layout_matrix = mat)
ggsave2x('../plots-meas/10_remis2', plot = pfw, height = 4, width = 3.3, scale = 1.2)

# Weather versus time of day
# First get time of day and day of trial for plots
dd <- idat
dd$time.of.day <- as.numeric(as.character(as.POSIXct(dd$t.start), '%H')) + as.numeric(as.character(as.POSIXct(dd$t.start), '%M')) / 60
dd$t.start <- as.POSIXct(dd$t.start)
dd$day <- as.Date(dd$t.start) - as.Date(dd$app.date)

db <- dd[dd$meas.tech == 'bLS', ]
dw <- dd[dd$meas.tech == 'Wind tunnel', ]

ggplot(db, aes(time.of.day, air.temp, colour = trial.nm, group = pmid)) +
  geom_step() +
  #geom_point() +
  facet_wrap(~ day) +
  theme_bw() +
  labs(x = 'Time of day (h)', y = expression('Air temp.'~(degree*C))) +
  theme(legend.position = 'top')
ggsave('../plots-meas/10_temp_vs_time.png', height = 6, width = 8)

ggplot(db, aes(time.of.day, wind.2m, colour = trial.nm, group = pmid)) +
  geom_step() +
  #geom_point() +
  facet_wrap(~ day) +
  theme_bw() +
  labs(x = 'Time of day (h)', y = expression('Wind'~('m s'^'-1'))) +
  theme(legend.position = 'top')
ggsave('../plots-meas/11_wind_vs_time.png', height = 6, width = 8)

ggplot(db, aes(cta, rain.cum, group = pmid)) +
       geom_line(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
       facet_wrap(~ trial.nm) +
       theme_bw() +
       labs(x = 'Elapsed time (h)', y = 'Total rain (mm)') +
       theme(legend.position = 'top')
ggsave('../plots-meas/12_rain_vs_time.png', height = 6, width = 8)

dd <- subset(dd, cta < 72)
ggplot(dd, aes(wind.2m, j.NH3, colour = cta, group = pmid)) +
  geom_path() +
  geom_point() +
  facet_grid(meas.tech ~ trial.nm) +
  theme_bw() +
  labs(x = expression('Wind'~('m s'^'-1')), y = expression('Flux'~('kg N h'^'-1'~ha^'-1'))) +
  theme(legend.position = 'top')
ggsave('../plots-meas/20_flux_vs_wind.png', height = 6, width = 8)

ggplot(dd, aes(air.temp, j.NH3, colour = cta, group = pmid)) +
  geom_path() +
  geom_point() +
  facet_grid(meas.tech ~ trial.nm) +
  theme_bw() +
  labs(x = expression('Air temp.'~(degree*C)), y = expression('Flux'~('kg N h'^'-1'~ha^'-1'))) +
  theme(legend.position = 'top')
ggsave('../plots-meas/21_flux_vs_temp.png', height = 6, width = 8)

# Emission versus AER
ggplot(isumm, aes(aer, e.rel.final, colour = app.date, shape = app.date)) +
  geom_hline(data = subset(isumm, meas.tech == 'bLS'), aes(yintercept = e.rel.final, colour = app.date), lty = 2) +
  geom_point(cex = 2) +
  scale_color_brewer(palette = 'Set1') + 
  labs(x = expression('Air exchange rate'~('min'^'-1')), y = expression('168 h emission'~('frac. applied TAN')), colour = '', shape = '') +
  theme_bw() +
  theme(legend.position = 'top')
ggsave2x('../plots-meas/30_emis_vs_AER', height = 4, width = 3.6)

# Late time flux plot to think about r3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- subset(idat, cta > 0.75 * dt)
# Remove interpolated values
dd$j.NH3[grepl('i', dd$flag.int)] <- NA

# Compare measurement methods
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]
ggplot(dw, aes(cta, j.NH3, group = pmid)) +
       geom_step(aes(colour = aer), lwd = 0.5, alpha = 0.8, direction = 'vh') +
       geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red', direction = 'vh') +
       facet_wrap(~ app.date, ncol = 1) +
       coord_cartesian(xlim = c(48, 200), ylim = c(0, 0.4)) +
       coord_cartesian(xlim = c(48, 200), ylim = c(0, 0.4)) +
       theme_bw() +
       labs(x = 'Elapsed time (h)', y = expression('Flux'~('kg N h'^'-1'~ha^'-1')), 
            colour = expression(atop('AER'~(min^'-1'),' ')), lty = ' ') +
       theme(legend.position = 'top')
ggsave2x('../plots-meas/40_late_flux', height = 4, width = 4.6)


