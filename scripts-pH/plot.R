
ds$ymin <- ds$pH - ds$s
ds$ymax <- ds$pH + ds$s

ggplot(ds, aes(ct, pH, colour = covered)) + 
  geom_ribbon(aes(ymin = ymin, ymax = ymax, fill = covered), alpha = 0.2, colour = 'white') +
  geom_line() +
  geom_point() +
  facet_wrap(~ app.date) +
  coord_cartesian(xlim = c(0, 125), ylim = c(7, 9.2)) +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Time after application (h)', y = 'Surface pH', colour = '') +
  guides(fill = 'none')
ggsave2x('../plots-pH/40_surface_pH', height = 3, width = 7)