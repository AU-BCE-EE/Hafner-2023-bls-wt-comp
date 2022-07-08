

for (i in unique(idat$pmid)) {
  idat[idat$pmid == i, ] <- interpm(idat[idat$pmid == i, ], 'ct', ys = c('air.temp', 'wind.2m'), rule = 2)
}
