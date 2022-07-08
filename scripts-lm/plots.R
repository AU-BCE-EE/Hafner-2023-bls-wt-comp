
idat$meas.tech <- factor(idat$meas.tech, levels = c('Wind tunnel', 'bLS'))

# Compare measurement methods
ggplot(idat, aes(cta, j.NH3, group = pmid, colour = meas.tech)) +
  geom_step() +
  facet_wrap(~ app.date) +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/flux_comp_method.png', height = 4, width = 6)

ggplot(idat, aes(cta, j.NH3, group = pmid, colour = meas.tech)) +
  geom_step() +
  facet_wrap(~ app.date) +
  xlim(0, 50) +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/flux_comp_method_50h.png', height = 4, width = 6)

ggplot(adat, aes(cta, j.NH3.wt, group = pmid.wt)) +
  geom_step(colour = 'red') +
  geom_step(aes(y = j.NH3.bls), colour = 'blue') +
  facet_wrap(~ app.date) +
  xlim(0, 50) +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/a_flux_comp_method_50h.png', height = 4, width = 6)

idat$wind.lab <- idat$wind.2m
idat$wind.lab[idat$meas.tech == 'bLS'] <- NA
ggplot(idat, aes(cta, e.cum, group = pmid, colour = wind.lab, lty = meas.tech)) +
  geom_line() +
  facet_wrap(~ app.date, scale = 'free') +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emission'~(kg/ha)), colour = 'Wind speed', lty = '') +
  scale_color_viridis_c() +
  theme(legend.position = 'top')
ggsave('../plots-lm/emis_comp_method.png', height = 4, width = 6)

# Check bLS interpolation
ggplot(idat, aes(cta, e.cum, group = pmid, colour = meas.tech)) + 
  geom_line() +
  geom_line(data = adat, aes(cta, e.cum.bls, group = pmid.wt), colour = 'gray45') +
  facet_wrap(~ app.date) +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emission'~(kg/ha)), colour = '', lty = '') +
  theme(legend.position = 'none')
ggsave('../plots-lm/emis_aligned.png', height = 3, width = 6)

# Look at model predictions
ggplot(mdat, aes(cta, j.NH3.bls, group = interaction(pmid.wt, mod), colour = mod)) +
  geom_step(aes(y = j.NH3.wt), colour = 'gray65') +
  geom_step(alpha = 0.3) +
  facet_wrap(~ app.date, scale = 'free') +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/flux_mod.png', height = 4, width = 8)

ggplot(mdat, aes(cta, e.cum.bls, group = interaction(pmid.wt, mod), colour = mod)) +
  geom_line(aes(y = e.cum.wt), colour = 'gray75') +
  geom_line(alpha = 0.3) +
  facet_wrap(~ app.date, scale = 'free') +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emission'~(kg/ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/emis_mod.png', height = 4, width = 8)

ggplot(ds1, aes(cta, j.NH3, group = pmid, colour = meas.tech2)) +
  geom_step(alpha = 0.6) +
  geom_step(aes(cta, j.NH3.pred1), colour = 'gray55', lty = '11') +
  facet_grid(meas.tech ~ app.date, scale = 'fixed') +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/flux_gam.png', height = 4, width = 8)

# ALFAM2 predictions
ggplot(a2dat, aes(cta, e.cum, group = interaction(pmid, mod), colour = mod)) +
  geom_line() +
  facet_grid(meas.tech ~ app.date, scale = 'free') +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emission'~(kg/ha)), colour = 'Wind speed', lty = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/emis_ALFAM2.png', height = 4, width = 6)

ggplot(a2dat, aes(cta, j.NH3, group = interaction(pmid, mod), colour = mod)) +
  geom_step(alpha = 0.6) +
  facet_grid(meas.tech ~ app.date, scale = 'free') +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/flux_ALFAM2.png', height = 4, width = 8)

ggplot(a2dat, aes(cta, j.NH3, group = interaction(pmid, mod), colour = mod)) +
  geom_step(alpha = 0.6) +
  facet_grid(meas.tech ~ app.date, scale = 'free') +
  xlim(0, 50) +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '') +
  theme(legend.position = 'top')
ggsave('../plots-lm/flux_ALFAM2_50h.png', height = 4, width = 8)
