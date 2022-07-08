
# Flux ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dfl$variable.nm <- factor(dfl$variable, levels = c('j.pred1', 'j.NH3', 'j.pred2'),
                         labels = c('ALFAM2 cal. A', 'Measured', 'ALFAM2 cal. B'))
dd <- dfl
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(cta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  xlim(0, 120) +
  theme_bw() +
  labs(x = '', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
  theme(legend.position = 'none')
ggsave('../plots-ALFAM2/50_flux_comp.pdf', height = 4, width = 7)


# Residuals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drl$variable.nm <- factor(drl$variable, levels = c('aerr1', 'aerr2'),
                         labels = c('ALFAM2 cal. A', 'ALFAM2 cal. B'))
dd <- drl
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(cta, value, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  xlim(0, 120) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('Error in NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = '', lty = '') +
  theme(legend.position = 'none')
ggsave('../plots-ALFAM2/60_error_comp.pdf', height = 4, width = 7)

# Early emission contribution ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dcl$variable.nm <- factor(dcl$variable, levels = c('ecrel1', 'ecrel2'),
                         labels = c('ALFAM2 cal. A', 'ALFAM2 cal. B'))
dd <- subset(dcl, cta <= 11.5)
dd$j.NH3[grepl('i', dd$flag.int)] <- NA
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(cta, value, group = pmid)) +
  geom_line(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_line(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_grid(variable.nm ~ app.date) +
  coord_cartesian(xlim =c(0, 11.5)) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emis.'~('frac. final')), 
       colour = '', lty = '') +
  theme(legend.position = 'none')
ggsave('../plots-ALFAM2/70_remis_comp.pdf', height = 4, width = 7)

# r1 par ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- d.pred
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(cta, r1.pred2, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_wrap(~ app.date) +
  xlim(0, 120) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression(italic('r')[1]~('h'^'-1'))) +
  theme(legend.position = 'none')
ggsave('../plots-ALFAM2/80_r1.pdf', height = 3, width = 7)

# Final cumulative emission meas and ALFAM2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- d.pred.final
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(dw, aes(er.pred2, e.rel, group = pmid)) +
  geom_abline(intercept = 0, slope = 1, lty = 1, col = 'gray45') +
  geom_point(aes(colour = wind.2m), size = 2) +
  geom_point(data = db, colour = 'red', size = 2) +
  facet_wrap(~ app.date) +
  theme_bw() +
  labs(x = expression('ALFAM2 cal. B NH'[3]~'emis.'~('frac. final')), 
       y = expression('Meas. NH'[3]~'emis.'~('frac. final'))) +
  theme(legend.position = 'none')
ggsave('../plots-ALFAM2/90_cum_emis_comp.pdf', height = 3, width = 7)


