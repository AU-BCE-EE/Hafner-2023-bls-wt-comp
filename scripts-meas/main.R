# Wind tunnel / bLS comparison based on measurements
# Bit of analysis

rm(list = ls())

source('functions.R')
source('packages.R')
source('load.R')
source('subset.R')
source('clean.R')
source('wide.R')
source('summary.R')
render('stats.Rmd', output_dir = '../output')
source('export.R')
source('export_check.R')
source('plot_big.R')
source('plot.R')
