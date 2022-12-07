# Hafner-2022-bls-wt-comp
Data and analysis on wind tunnel and bLS measurement of ammonia volatilation from field-applied slurry, associated with research paper currently in progress.

# Maintainer
Sasha D. Hafner.
Contact information here: <https://pure.au.dk/portal/en/persons/sasha-d-hafner(1a9c8309-91c7-44b3-8de9-da66643f7902).html>.

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
See section below on links to paper to located sources of paper components.

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
This section give the sources of tables, figures, etc. in the paper.


...
