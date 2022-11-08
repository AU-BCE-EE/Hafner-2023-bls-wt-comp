# Download latest ALFAM2 data, subset to this study, and save copy

rm(list = ls())

# Set release tag for download
rtag <- 'v2.11'

source('packages.R')
source('load.R')
source('subset.R')
source('export.R')
