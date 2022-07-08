# Wind tunnel / bLS comparison using ALFAM2 model fitting

rm(list = ls())

source('functions.R')
source('packages.R')
source('load.R')
source('subset.R')
source('cal.R')
source('cal2.R')
source('extract_pars.R')
source('extract_preds.R')
source('rel_emis.R')
source('export.R')
source('plot_mod.R')
source('plot.R')
source('plot_sel.R')

# 217.47
# 215.98 w cta > 2

head(d.pred)
