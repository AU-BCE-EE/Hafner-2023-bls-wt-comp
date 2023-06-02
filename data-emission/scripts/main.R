# Download latest ALFAM2 data, subset to this study, and save copy

rm(list = ls())

# Set release tag for download
ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/'
rtag <- 'v2.22'

# Alternative below to get particular commit (if not yet in release)
#ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/bf608a10d324444627acf35f0aadeaced5f008c9/'
#rtag <- ''

source('packages.R')
source('load.R')
source('subset.R')
source('export.R')
