# Add fraction final emission at each time
# Recalc cum rain (sum started before application)

# Note: These updates idat *without assignment*. Not sure what I think of that.
idat[, e.rel2 := e.rel / max(e.rel), pmid]
idat[, rain.cum := cumsum(rain.rate * dt), pmid]
