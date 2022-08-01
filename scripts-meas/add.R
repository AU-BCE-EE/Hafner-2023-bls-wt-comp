# Add fraction final emission at each time

# NTS: This updates idat *without assignment*. Not sure what I think of that.
idat[, e.rel2 := e.rel / max(e.rel), pmid]

