# Wind tunnel / bLS comparison
# Would like approach to estimate bLS emission from wind tunnel measurements
# But also interested in just comparing the two methods

rm(list = ls())

source('functions.R')
source('packages.R')
source('load.R')
source('subset.R')
source('add.R')
source('interp.R')
source('align.R')
knit('lin_mods.Rmd', output = '../logs/lin_mods.md')
render('gam_mods_comp.Rmd', output_file = '../logs/gam_mods_comp.pdf')
source('ALFAM2.R')
source('plots.R')
