# Subsets for plotting
# Drop 
dd <- subset(idat, cta > 0.75 * dt)
# Remove interpolated values
dd$j.NH3[grepl('i', dd$flag.int)] <- NA

# Compare measurement methods
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]
pf1 <- ggplot(dw, aes(cta, j.NH3, group = pmid)) +
       #geom_vline(xintercept = 24 * 1:5, lty = 2) +
       geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8, direction = 'vh') +
       geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red', direction = 'vh') +
       facet_wrap(~ app.date) +
       coord_cartesian(xlim =c(0, 168)) +
       theme_bw() +
       labs(x = '', y = expression('Flux'~('kg N h'^'-1'~ha^'-1')), 
            colour = expression('Wind tunnel average velocity'~(m~s^'-1')), lty = ' ') +
       theme(legend.position = 'top',
             axis.title.x=element_blank(),
             axis.text.x=element_blank(),
             axis.ticks.x=element_blank())

pe1 <- ggplot(dw, aes(cta, e.rel, group = pmid)) +
       geom_line(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
       geom_line(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
       facet_wrap(~ app.date) +
       coord_cartesian(xlim =c(0, 168)) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Emis.'~('frac. TAN')), 
            colour = expression('Wind tunnel average velocity'~(m~s^'-1')), lty = ' ') +
       theme(legend.position = 'none',
             axis.title.x=element_blank(),
             axis.text.x=element_blank(),
             axis.ticks.x=element_blank())

pws <- ggplot(db, aes(cta, wind.2m, group = pmid)) +
       geom_line() +
       facet_wrap(~ app.date) +
       coord_cartesian(xlim =c(0, 168)) +
       ylim(0, 5.5) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Wind'~('m s'^'-1'))) +
       theme(legend.position = 'top',
             axis.title.x=element_blank(),
             axis.text.x=element_blank(),
             axis.ticks.x=element_blank())

pat <- ggplot(db, aes(cta, air.temp, group = pmid)) +
       geom_line() +
       facet_wrap(~ app.date) +
       coord_cartesian(xlim =c(0, 168)) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Air temp.'~(degree*C))) +
       theme(legend.position = 'top',
             axis.title.x=element_blank(),
             axis.text.x=element_blank(),
             axis.ticks.x=element_blank())

prr <- ggplot(db, aes(cta, rain.rate, group = pmid)) +
       geom_line(colour = 'gray45') +
       facet_wrap(~ app.date) +
       coord_cartesian(xlim =c(0, 168)) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = 'Elapsed time (h)', y = expression('Rain'~('mm h'^'-1'))) +
       theme(legend.position = 'top')


# Note that ggave (so ggsave2x) won't work
pdf('../plots-meas/01_flux_wind_meas.pdf', height = 8, width = 7)
  grid::grid.draw(rbind(ggplotGrob(pf1), ggplotGrob(pe1), ggplotGrob(pws), ggplotGrob(pat), ggplotGrob(prr)))
dev.off()

png('../plots-meas/01_flux_wind_meas.png', height = 8, width = 7, units = 'in', res = 600)
  grid::grid.draw(rbind(ggplotGrob(pf1), ggplotGrob(pe1), ggplotGrob(pws), ggplotGrob(pat), ggplotGrob(prr)))
dev.off()

ymax <- 10

# Repeat but zooming in over time
# Compare measurement methods
dw <- dd[dd$meas.tech == 'Wind tunnel', ]
db <- dd[dd$meas.tech == 'bLS', ]

x <- subset(db, app.date == '2021-08-20')

pf1 <- ggplot(dw, aes(cta, j.NH3, group = pmid)) +
       #geom_vline(xintercept = 24 * 1:5, lty = 2) +
       geom_step(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8, direction = 'vh') +
       geom_step(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red', direction = 'vh') +
       facet_wrap(~ app.date) +
       xlim(0, ymax) +
       theme_bw() +
       labs(x = '', y = expression('Flux'~('kg N h'^'-1'~ha^'-1')), 
            colour = expression('Wind tunnel average velocity'~(m~s^'-1')), lty = ' ') +
       theme(legend.position = 'top')
pf1

pe1 <- ggplot(dw, aes(cta, e.rel, group = pmid)) +
       geom_line(aes(colour = wind.2m), lwd = 0.5, alpha = 0.8) +
       geom_line(data = db, aes(lty = meas.tech), lwd = 0.5, alpha = 0.8, colour = 'red') +
       facet_wrap(~ app.date) +
       xlim(0, ymax) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Emis.'~('frac. TAN')), 
            colour = expression('Wind tunnel average velocity'~(m~s^'-1')), lty = ' ') +
       theme(legend.position = 'none')

pws <- ggplot(db, aes(cta, wind.2m, group = pmid)) +
       geom_line() +
       facet_wrap(~ app.date) +
       xlim(0, ymax) +
       ylim(0, 5.5) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Wind'~('m s'^'-1'))) +
       theme(legend.position = 'top')

pat <- ggplot(db, aes(cta, air.temp, group = pmid)) +
       geom_line() +
       facet_wrap(~ app.date) +
       xlim(0, ymax) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = '', y = expression('Air temp.'~(degree*C))) +
       theme(legend.position = 'top')

prr <- ggplot(db, aes(cta, rain.rate, group = pmid)) +
       geom_line(colour = 'gray45') +
       facet_wrap(~ app.date) +
       xlim(0, ymax) +
       theme_bw() +
       theme(strip.background = element_blank(), strip.text.x = element_blank()) +
       labs(x = 'Elapsed time (h)', y = expression('Rain'~('mm h'^'-1'))) +
       theme(legend.position = 'top')


# Note that ggave (so ggsave2x) won't work
pdf('../plots-meas/02_flux_wind_meas_zoom.pdf', height = 8, width = 7)
  grid::grid.draw(rbind(ggplotGrob(pf1), ggplotGrob(pe1), ggplotGrob(pws), ggplotGrob(pat), ggplotGrob(prr)))
dev.off()

png('../plots-meas/02_flux_wind_meas_zoom.png', height = 8, width = 7, units = 'in', res = 600)
  grid::grid.draw(rbind(ggplotGrob(pf1), ggplotGrob(pe1), ggplotGrob(pws), ggplotGrob(pat), ggplotGrob(prr)))
dev.off()


