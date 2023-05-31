
p <- paste0(ghpath, rtag)
idat <- fread(paste0(p, '/data-output/03/ALFAM2_interval.csv.gz'))
pdat <- fread(paste0(p, '/data-output/03/ALFAM2_plot.csv.gz'))

# Get file with data version number
download.file(paste0(p, '/data-output/03/data_version.txt'), destfile = '../logs/data_version.txt')
