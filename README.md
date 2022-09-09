# bLS emission from wind tunnel data
On estimating bLS emission from wind tunnel measurements.

# Note
This document is quite outdated!

# Approach
Simultaneous emission measurements made using a bLS method and wind tunnel were compared, and several related approaches were used to develop empirical models to try to estimate bLS results from wind tunnel measurements.
Results are in the `plots` directory, where emission measurement methods are compared graphically, and model predictions are compared to measurements.
All empirical models had the same general structure:

```
log10(j.bls / j.wt) = f(wind.2m, air.temp, . . .)
```

Transformations, interactions, and the type of model used differed.
For some variables, both wind tunnel and bLS values were included (wind speed, for example).

`j.wt` represents average flux measured by wind tunnel in a single measurement interval.
`j.bls` is the flux from bLS measurements, made in the exact same interval.
(In the scripts these are called `j.NH3.wt` etc.)

Because interval timing did not align in practice (and bLS measurements were made at a higher frequency), bLS measurements were interpolated to wind tunnel timing.
The original and wind tunnel-aligned values are compared in `plots/emis_aligned.png`.

Measurements were made in three field trials (two in August and one in Janurary), and these measurements were all combined for model development; any correlation between observations in the same trial (or from the same field plot) were ignored.

The ALFAM2 model was also applied to these field measurements.
For the wind tunnel results, the calculated average wind speed through the tunnels was taken as wind speed at 2 m (`wind.2m`).

# Results
Wind tunnel flux was not consistently higher or lower than bLS results, but did show much less variation between the three field trials, and perhaps somewhat less variation in flux within trials.

Emission predicted with the ALFAM2 model was not particularly close to bLS measurements, but could have been much worse (there are plenty of examples that are worse).
The wind tunnel comparison was poorer--probably not surprising given the wind speed substitution.

The empirical models for bLS emission showed some ability to reproduce patterns in flux (see `plots/flux_mod.png`) but the potential of the approach seems limited for at least two reasons.
First, summing flux estimates from the models to predict cumulative bLS emission shows large underestimation by most models (see `plots/emis_mods.png`). 
So the accuracy in total emission is poor.
The best performing model (3) actually does OK for the 11 August trial, but not well for the other two. 
Second, even the best model is far from simple--it has more than 100 coefficients.
Others are somewhat simpler but perform even worse.
Certainly it is possible that variations could do better.

# Other possibilities
If the ALFAM2 model structure really captured the processes that drive measured emission, it would be almost trivial to convert wind tunnel results to bLS.
But so far attempts to develop parameter sets for either wind tunnel or bLS measurements consistent for all three trials and accurate have failed.

Other structures for the empirical models may perform better.
This needs some thought and effort.

Minimizing error in cumulative emission predictions instead of flux may help.
But this isn't a trivial switch, because there is no reason to believe that the ratio of bLS-to-wind tunnel cumulative emission depends on current conditions.
By definition, it depends on history--how much was volatilized in earlier intervals.
However, it should be possible to try this approach using nonlinear regression (e.g., `nls.lm` function). 
