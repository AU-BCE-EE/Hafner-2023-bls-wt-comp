


pm2 <- ggplot(dw, aes(cta, j.pred2, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_wrap(~ app.date) +
  xlim(0, 120) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
  theme(legend.position = 'none')

mat <- matrix(c(1, 
                1,
                1,
                1,
                1,
                2,
                2,
                2),
                ncol = 1)

pmf <- grid.arrange(pm1, pm2, layout_matrix = mat)
ggsave('../plots-ALFAM2/100_flux_wind_meas.pdf', pmf, height = 4, width = 7)

ggplot(dw, aes(cta, j.pred2, group = pmid)) +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_wrap(~ app.date) +
  xlim(0, 120) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
  theme(legend.position = 'top')
ggsave('../plots-ALFAM2/11_flux_ALFAM2-2.png', height = 3, width = 7)

p2 <- ggplot(dw, aes(cta, aerr2, group = pmid)) +
      geom_hline(yintercept = 0, lty = 2, colour = 'gray55') +
      geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
      geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
      facet_wrap(~ app.date) +
      xlim(0, 120) +
      theme_bw() +
      labs(x = 'Elapsed time (h)', y = expression('Error in NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
           colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
      theme(legend.position = 'top')
ggsave('../plots-ALFAM2/13_flux_resid2.png', p2, height = 3, width = 7)


ggplot(dw, aes(cta, aerr1, group = pmid)) +
  geom_hline(yintercept = 0, lty = 2, colour = 'gray55') +
  geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
  geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
  facet_wrap(~ app.date) +
  xlim(0, 120) +
  theme_bw() +
  labs(x = 'Elapsed time (h)', y = expression('Error in NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
       colour = 'Wind tunnel ave. velocity (m/s):', lty = '') +
  theme(legend.position = 'top')
ggsave('../plots-ALFAM2/12_flux_resid1.png', height = 3, width = 7)


# Model r1
p1 <- ggplot(dw, aes(cta, r1.pred2, group = pmid)) +
      geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
      geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
      facet_wrap(~ app.date) +
      xlim(0, 120) +
      theme_bw() +
      labs(x = 'Elapsed time (h)', y = expression('r'[1]~('h'^'-1')), colour = 'Measurement method:') +
      theme(legend.position = 'top')
ggsave('../plots-ALFAM2/14_r1_ALFAM2.png', p1, height = 3, width = 7)

p1 <- ggplot(dd, aes(cta, r3.pred2, group = pmid, colour = meas.tech)) +
             geom_step(lwd = 0.5, alpha = 0.8) +
             facet_wrap(~ app.date) +
             xlim(0, 120) +
             theme_bw() +
             scale_color_brewer(palette = "Set1") +
             #scale_colour_viridis_d() +
             labs(x = 'Elapsed time (h)', y = expression('r'[1]~('h'^'-1')), colour = 'Measurement method:') +
             theme(legend.position = 'top')
ggsave('../plots-ALFAM2/15_r3_ALFAM2.png', p1, height = 3, width = 7)


