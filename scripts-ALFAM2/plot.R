
# Subsets for plotting
# Remove interpolated values
dd <- d.pred
dd$j.NH3[grepl('i', dd$flag.int)] <- NA

ggplot(dd, aes(cta, rain.rate, group = factor(pmid), colour = meas.tech2)) + 
  geom_line(alpha = 0.7) + 
  facet_wrap(~ app.date)
ggsave('../plots-ALFAM2/rain.png', height = 5, width = 6)

ggplot(dd, aes(cta, er, group = factor(pmid), colour = meas.tech2)) + 
  geom_line(alpha = 0.7) + 
  geom_line(aes(y = er.pred1), lty = 3) + 
  facet_wrap(~ app.date)
ggsave('../plots-ALFAM2/emis_cal1_comp.png', height = 5, width = 6)

ggplot(dd, aes(cta, er, group = factor(pmid), colour = meas.tech2)) + 
  geom_line(alpha = 0.7) + 
  geom_line(aes(y = er.pred2), lty = 3) + 
  facet_wrap(~ app.date)
ggsave('../plots-ALFAM2/emis_cal2_comp.png', height = 5, width = 6)

ggplot(dd, aes(cta, j, group = factor(pmid), colour = meas.tech2)) + 
  geom_line() + 
  geom_line(aes(y = j.pred1), colour = 'gray25', alpha = 0.7, lty = '1111') + 
  theme_bw() +
  theme(legend.position = 'top') +
  facet_wrap(~ paste(pmid, 'ws:', round(wind.2m.48, 1), 'T:', round(air.temp.48, 0)))
ggsave('../plots-ALFAM2/flux_cal1_comp.png', height = 8, width = 8)

ggplot(dd, aes(cta, j, group = factor(pmid), colour = meas.tech2)) + 
  geom_line() + 
  geom_line(aes(y = j.pred2), colour = 'gray25', alpha = 0.7, lty = '1111') + 
  theme_bw() +
  theme(legend.position = 'top') +
  facet_wrap(~ paste(pmid, 'ws:', round(wind.2m.48, 1), 'T:', round(air.temp.48, 0)))
ggsave('../plots-ALFAM2/flux_cal2_comp.png', height = 8, width = 8)

ggplot(parl, aes(meas.tech, value, shape = meas.tech, colour = log10(wind.2m.72))) +
  geom_jitter(height = 0) +
  scale_colour_viridis_c() +
  geom_text(aes(label = pmid), size = 2, show.legend = FALSE) +
  facet_wrap(~ par, scale = 'free')
ggsave('../plots-ALFAM2/cal_pars.png', height = 6, width = 8)

ggplot(parl, aes(log10(wind.2m.72), value, shape = meas.tech, colour = meas.tech2)) +
  geom_jitter(height = 0) +
  facet_wrap(~ par, scale = 'free')
ggsave('../plots-ALFAM2/cal_pars_wind.png', height = 6, width = 8)

# Compare measurement methods
p1 <- ggplot(dd, aes(cta, j.NH3, group = pmid, colour = meas.tech)) +
             geom_step(lwd = 0.5, alpha = 0.7) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '', title = 'Measurements') +
             theme(legend.position = c(0.9, 0.7))

p2 <- ggplot(dd, aes(cta, j.pred1, group = pmid, colour = meas.tech)) +
             geom_step(lwd = 0.5, alpha = 0.7) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '', title = 'ALFAM2') +
             theme(legend.position = 'none')
m1 <- grid.arrange(p1, p2, ncol = 1)
ggsave('../plots-ALFAM2/flux_cal1_comp_mthd_mod.png', m1, height = 7, width = 7)


p1 <- ggplot(dd, aes(cta, j.NH3, group = pmid, colour = meas.tech)) +
             geom_step(lwd = 0.5, alpha = 0.7) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '', title = 'Measurements') +
             theme(legend.position = c(0.9, 0.7))
p2 <- ggplot(dd, aes(cta, j.pred2, group = pmid, colour = meas.tech)) +
             geom_step(lwd = 0.5, alpha = 0.7) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~(kg/h-ha)), colour = '', title = 'ALFAM2') +
             theme(legend.position = 'none')
m1 <- grid.arrange(p1, p2, ncol = 1)
ggsave('../plots-ALFAM2/flux_cal2_comp_mthd_mod.png', m1, height = 7, width = 7)




head(dd)

# Model
p1 <- ggplot(dd, aes(cta, j.pred2, group = pmid, colour = meas.tech)) +
             geom_step(aes(y = j.NH3), lwd = 0.5, alpha = 0.8, colour = 'gray65') +
             geom_step(lwd = 0.5, alpha = 0.8) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             scale_color_brewer(palette = "Set1") +
             #scale_colour_viridis_d() +
             labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), colour = 'Measurement method:') +
             theme(legend.position = 'top')
ggsave('../plots-ALFAM2/flux_ALFAM2.png', p1, height = 3, width = 7)

# Model r1
p1 <- ggplot(dd, aes(cta, r1.pred2, group = pmid, colour = meas.tech)) +
             geom_step(lwd = 0.5, alpha = 0.8) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             scale_color_brewer(palette = "Set1") +
             #scale_colour_viridis_d() +
             labs(x = 'Elapsed time (h)', y = expression('r'[1]~('h'^'-1')), colour = 'Measurement method:') +
             theme(legend.position = 'top')
ggsave('../plots-ALFAM2/r1_ALFAM2.png', p1, height = 3, width = 7)

p1 <- ggplot(dd, aes(cta, r3.pred2, group = pmid, colour = meas.tech)) +
             geom_step(lwd = 0.5, alpha = 0.8) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             scale_color_brewer(palette = "Set1") +
             #scale_colour_viridis_d() +
             labs(x = 'Elapsed time (h)', y = expression('r'[1]~('h'^'-1')), colour = 'Measurement method:') +
             theme(legend.position = 'top')
ggsave('../plots-ALFAM2/r3_ALFAM2.png', p1, height = 3, width = 7)


head(dd)
