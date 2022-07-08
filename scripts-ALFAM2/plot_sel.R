# Subsets for plotting
# Remove interpolated values
dd <- d.pred
dd$j.NH3[grepl('i', dd$flag.int)] <- NA

# Compare measurement methods
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]
pf1 <- ggplot(dw, aes(cta, j.NH3, group = pmid)) +
       geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
       geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
       facet_wrap(~ app.date) +
       xlim(0, 120) +
       theme_bw() +
       labs(x = '', y = expression('NH'[3]~'flux'~('kg N h'^'-1'~ha^'-1')), 
            colour = 'Wind tunnel ave. velocity (m/s):', lty = ' ') +
       theme(legend.position = 'top')
ggsave('../plots-ALFAM2/01_flux_meas.png', pf1, height = 3, width = 7)

pe1 <- ggplot(dw, aes(cta, er, group = pmid)) +
       geom_line(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
       geom_line(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
       facet_wrap(~ app.date) +
       xlim(0, 120) +
       theme_bw() +
       labs(x = 'Elapsed time (h)', y = expression('NH'[3]~'emission'~('kg N ha'^'-1')), 
            colour = 'Wind tunnel ave. velocity (m/s):', lty = ' ') +
       theme(legend.position = 'top')
ggsave('../plots-ALFAM2/02_emis_meas.png', pe1, height = 3, width = 7)

pws <- ggplot(db, aes(cta, wind.2m, group = pmid)) +
       geom_line() +
       facet_wrap(~ app.date) +
       xlim(0, 120) +
       ylim(0, 5.5) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Wind speed'~('m s'^'-1'))) +
       theme(legend.position = 'top')

pat <- ggplot(db, aes(cta, air.temp, group = pmid)) +
       geom_line() +
       facet_wrap(~ app.date) +
       xlim(0, 120) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Air temperature'~(degrees*C))) +
       theme(legend.position = 'top')

prr <- ggplot(db, aes(cta, rain.rate, group = pmid)) +
       geom_line(colour = 'gray45') +
       facet_wrap(~ app.date) +
       xlim(0, 120) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = 'Elapsed time (h)', y = expression('Rainfall rate'~('mm h'^'-1'))) +
       theme(legend.position = 'top')

mat <- matrix(c(1, 
                1,
                1,
                1,
                1,
                2,
                2,
                2,
                3,
                3,
                3,
                4,
                4,
                4),
                ncol = 1)
pfw <- grid.arrange(pf1, pws, pat, prr, layout_matrix = mat)
ggsave('../plots-ALFAM2/03_flux_wind_meas.png', pfw, height = 8, width = 7)
ggsave('../plots-ALFAM2/03_flux_wind_meas.pdf', pfw, height = 8, width = 7)

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
