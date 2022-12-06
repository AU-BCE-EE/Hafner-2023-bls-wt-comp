# Wind tunnel / bLS comparison using ALFAM2 model fitting

rm(list = ls())

source('functions.R')
source('packages.R')
# Load workspace only to skip calibration
#source('load_workspace.R')
source('load.R')
source('clean.R')
knit('run_ALFAM2.Rmd', output = '../logs/run_ALFAM2.md')
source('cal_a.R')
source('cal_b.R')
source('cal_b_boot.R')
source('extract_pars.R')
source('extract_preds.R')
source('summary.R')
source('export.R')
source('plot_mod.R')
#source('save_workspace.R')
