# Export a subset for checking emission calculations
# NTS: we may eventually delete this

p1904 <- subset(idat, pmid == 1904 & ct < 24)[, c('pmid', 't.start', 't.end', 'ct', 'cta', 'j.NH3', 'e.int', 'e.cum')]
write.csv(p1904, '../output/p1904.csv', row.names = FALSE)
