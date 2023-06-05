# Hafner-2022-bls-wt-comp
Data and analysis on wind tunnel and bLS measurement of ammonia volatilation from field-applied slurry, associated with research paper currently in progress.

# In progress
This a work in progress.
The paper has not yet been published.

# Maintainer
Sasha D. Hafner.
Contact information here: <https://au.dk/sasha.hafner@bce>.

# Published paper
The contents of this repo are presented in the following paper:

...


# Repository overview
This repo contains (nearly) all the data and data processing scripts needed to produce the results presented in the paper listed above.
The scripts are meant to run in R (<https://www.r-project.org/>) and require several add-on packages.
These packages are listed in multiple `packages.R` in `script-*` directories.
Versions of R and packages can be found in two `logs/R-versions-*.txt` files.
The ALFAM2 R package is from <github.com/sashahafner/ALFAM2> (and installation details can be found there), but all others are available on CRAN.

# Directory structure

## `data-emission`
Measurement data in `data` subdirectory.
These are downloaded from a specific release (based on tag) from ALFAM2-data repo on GitHub.
See `data-emission/scripts` for R scripts for downloading data.
`main.R` calls the others to do the complete dataload, subsetting, and save.

## `data-pH`
Measurement data on pH of surface of applied slurry.
Used by scripts in `scripts-pH`.

## `functions`
Functions used by various scripts.

## `logs`
Logs of R package versions, parameter values, and more to try to ensure reproducibility.

## `output`
Output summaries and similar files.
See section below on links to paper to locate sources of paper components.

## `plots-ALFAM2`
Plots produced by scripts in `scripts-ALFAM2`, on application of ALFAM2 model to emission trials.

## `plots-meas`
Plots of measured emission and weather, produced by scripts in `scripts-meas`.

## `plots-pH`
Plots of surface pH, produced by scripts in `scripts-pH`.

## `scripts-ALFAM2`
Scripts on application of ALFAM2 model to emission trials.
The script `main.R` calls all others.

## `scripts-meas`
Scripts for working with emission measurements and producing plots.
The script `main.R` calls all others.

## `scripts-pH`
Scripts for producing surface pH plots.
The script `main.R` calls all others.

## `Workspace-ALFAM2`
Copy of latest workspace created by running `scripts-ALFAM2/main.R`.
Saved simply because it can be convenient to avoid running lengthy model optimization, especially bootstrap analysis that can take hours.

# Links to published paper
This section give the sources of tables, figures, and some statistical results presented in the paper.

| Paper component          |  Repo source                             |  Repo scripts             |
|-----------------         |-----------------                         |---------------            |
|    Figure 3              | `plots-meas/01_flux_wind_meas.pdf`       | `scripts-meas/plot_big.R` |
|    Figure 4              | `plots-meas/30_emis_vs_AER.pdf`          | `scripts-meas/plot.R`     |
|    Figure 5              | `plots-ALFAM2/92_cum_emis_comp.pdf`      | `scripts-ALFAM2/plot.R`   |
|    Figure 6              | `plots-ALFAM2/54_flux_comp_sel_zoom.pdf` | `scripts-ALFAM2/plot.R`   |
|    Figure S2             | `plots-pH/40_surface_pH.pdf`             | `scripts-pH/plot.R`       |
|    Figure S3             | `plots-ALFAM2/60_error_comp.pdf`         | `scripts-ALFAM2/plot.R`   |
|    Figure S4             | `plots-ALFAM2/53_flux_comp_sel.pdf`      | `scripts-ALFAM2/plot.R`   |
|    Figure S5             | `plots-ALFAM2/80_r1.pdf`                 | `scripts-ALFAM2/plot.R`   |
|    Figure S6             | `plots-ALFAM2/81_r3.pdf`                 | `scripts-ALFAM2/plot.R`   |
|    Figure S7             | `plots-meas/40_late_flux.pdf`            | `scripts-meas/plot.R`     |
|Table S1 set X par. vals. | `output/parsb.csv`                       | `scripts-ALFAM2/export.R`  `scripts-ALFAM2/cal_b.R`|
|Table S1 set X std. err.  | `output/bootsumm.csv`                    | `scripts-ALFAM2/export.R` `scripts-ALFAM2/cal_b_boot.R` |


Table S1 set 2 part comes from the `alfam2pars02` object in v2.0 of the ALFAM2 package (here: <https://github.com/sashahafner/ALFAM2/releases/tag/v2.0>.  
Note that parameter set X (in manuscript) is called set b in the scripts.
Set a in the scripts is not mentioned in the manuscript.

Section 3.1 stats "Wind tunnel air exchange rate (AER) had a clear effect on measured emission, with a similar response in the two trials where it varied widely (p = 1·10-5 for AER effect, p = 0.99 for interaction based on an F test from a regression model)." come from results from `summary(m1)` or `drop1(m1, test = 'F')` (for main AER effect) and similar for `m2` (for interation) in `output/stats.pdf`, which is created by `scripts-meas/stats.Rmd`.

Section 2.3.2 info on gap filling ("...with filtered data removed...") is from `gapeffect` column in `output/emis_summ.csv`, which is generated by scripts `scripts-meas/summary.R` and `scripts-meas/export.R`.

Plot keys (pmid) in sections 2.3.1 and 2.3.2 come from `output/pmid_summ.csv`, which is just a column subset of `pdat` created in `scripts-meas/summary.R` and exported in `scripts-meas/export.R`.
More detailed information on pmid (linking to trials and conditions) is also in `output/emis_summ.csv` and `output/int_summ.csv` from `scripts-meas/export.R`.
