
idat <- fread('https://github.com/sashahafner/ALFAM2-data/raw/dev/data-output/03/ALFAM2_interval.csv.gz')
pdat <- fread('https://github.com/sashahafner/ALFAM2-data/raw/dev/data-output/03/ALFAM2_plot.csv.gz')

idat$pmid <- as.character(idat$pmid)
pdat$pmid <- as.character(pdat$pmid)
