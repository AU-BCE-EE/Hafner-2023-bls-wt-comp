
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
dd <- subset(idat, cta <= 120)
dd$time.of.day <- as.numeric(as.character(as.POSIXct(dd$t.start), '%H')) + as.numeric(as.character(as.POSIXct(dd$t.start), '%M')) / 60
dd$day <- dd$cta %/% 24
db <- dd[dd$meas.tech == 'bLS', ]

ggplot(db, aes(time.of.day, air.temp, colour = app.date, group = pmid)) +
  geom_step() +
  #geom_point() +
  facet_wrap(~ paste('Day', day)) +
  theme_bw() +
  labs(x = 'Time of day (h)', y = expression('Air temp.'~(degree*C))) +
  theme(legend.position = 'top')
ggsave2x('../plots-meas/10_temp_vs_time', height = 6, width = 8)

ggplot(db, aes(time.of.day, wind.2m, colour = app.date, group = pmid)) +
  geom_step() +
  #geom_point() +
  facet_wrap(~ paste('Day', day)) +
  theme_bw() +
  labs(x = 'Time of day (h)', y = expression('Wind'~('m s'^'-1'))) +
  theme(legend.position = 'top')
ggsave2x('../plots-meas/11_wind_vs_time', height = 6, width = 8)


