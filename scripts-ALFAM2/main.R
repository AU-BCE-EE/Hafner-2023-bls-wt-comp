# Wind tunnel / bLS comparison using ALFAM2 model fitting

rm(list = ls())

source('functions.R')
source('packages.R')
source('load.R')
source('subset.R')
knit('run_ALFAM2.Rmd', output = '../logs/rum_ALFAM2.md')
source('cal1.R')
source('cal2.R')
source('extract_pars.R')
source('extract_preds.R')
source('export.R')
source('plot_mod.R')
