
# Data prep

```r
adat <- subset(adat, !is.na(j.NH3.bls) & adat$cta >= 1)
adat[adat$j.NH3.bls <= 0, 'j.NH3.bls'] <- 1E-3
adat[adat$j.NH3.wt <= 0, 'j.NH3.wt'] <- 1E-3
adat$weights <- adat$j.NH3.wt
```

# Models for flux ratio


```r
mods <- list()
```



```r
i <- 1
mods[[i]] <- lm(log10(j.NH3.bls / j.NH3.wt) ~ wind.2m.wt + wind.2m.bls + air.temp.wt + rain.rate.bls + rain.cum.bls, 
           data = adat, weights = weights) 
```


```r
summary(mods[[i]])
```

```
## 
## Call:
## lm(formula = log10(j.NH3.bls/j.NH3.wt) ~ wind.2m.wt + wind.2m.bls + 
##     air.temp.wt + rain.rate.bls + rain.cum.bls, data = adat, 
##     weights = weights)
## 
## Weighted Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.94537 -0.01722  0.03050  0.11268  0.47165 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   -0.4395485  0.0194391 -22.612  < 2e-16 ***
## wind.2m.wt    -0.2009761  0.0276968  -7.256 5.09e-13 ***
## wind.2m.bls    0.1219302  0.0053084  22.969  < 2e-16 ***
## air.temp.wt    0.0073862  0.0008224   8.981  < 2e-16 ***
## rain.rate.bls -0.0282776  0.0436895  -0.647    0.518    
## rain.cum.bls  -0.0445322  0.0012203 -36.492  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.1341 on 2881 degrees of freedom
## Multiple R-squared:  0.4378,	Adjusted R-squared:  0.4368 
## F-statistic: 448.7 on 5 and 2881 DF,  p-value: < 2.2e-16
```

Try some interactions



```r
i <- i + 1
mods[[i]] <- lm(log10(j.NH3.bls / j.NH3.wt) ~ (wind.2m.wt + wind.2m.bls + air.temp.wt + rain.rate.bls + rain.cum.bls)*cta, 
           data = adat, weights = weights) 
```


```r
summary(mods[[i]])
```

```
## 
## Call:
## lm(formula = log10(j.NH3.bls/j.NH3.wt) ~ (wind.2m.wt + wind.2m.bls + 
##     air.temp.wt + rain.rate.bls + rain.cum.bls) * cta, data = adat, 
##     weights = weights)
## 
## Weighted Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.66314 -0.04303  0.01379  0.06160  0.40946 
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)       -8.962e-02  2.279e-02  -3.932 8.61e-05 ***
## wind.2m.wt        -3.800e-01  2.931e-02 -12.963  < 2e-16 ***
## wind.2m.bls        1.447e-01  6.115e-03  23.660  < 2e-16 ***
## air.temp.wt       -1.406e-02  9.334e-04 -15.063  < 2e-16 ***
## rain.rate.bls      1.940e-01  1.283e-01   1.512   0.1306    
## rain.cum.bls      -7.046e-02  2.240e-03 -31.451  < 2e-16 ***
## cta               -7.606e-03  4.172e-04 -18.231  < 2e-16 ***
## wind.2m.wt:cta     2.909e-03  4.894e-04   5.945 3.10e-09 ***
## wind.2m.bls:cta   -8.185e-04  8.368e-05  -9.782  < 2e-16 ***
## air.temp.wt:cta    6.713e-04  1.935e-05  34.693  < 2e-16 ***
## rain.rate.bls:cta -2.783e-03  1.241e-03  -2.242   0.0251 *  
## rain.cum.bls:cta   3.321e-04  1.896e-05  17.519  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.1097 on 2875 degrees of freedom
## Multiple R-squared:  0.6242,	Adjusted R-squared:  0.6227 
## F-statistic: 434.1 on 11 and 2875 DF,  p-value: < 2.2e-16
```

```r
coef(mods[[i]])
```

```
##       (Intercept)        wind.2m.wt       wind.2m.bls       air.temp.wt 
##     -0.0896239289     -0.3799595520      0.1446720941     -0.0140592985 
##     rain.rate.bls      rain.cum.bls               cta    wind.2m.wt:cta 
##      0.1940206637     -0.0704631452     -0.0076055673      0.0029092971 
##   wind.2m.bls:cta   air.temp.wt:cta rain.rate.bls:cta  rain.cum.bls:cta 
##     -0.0008185324      0.0006712581     -0.0027827026      0.0003320949
```


```r
i <- i + 1
mods[[i]] <- lm(log10(j.NH3.bls / j.NH3.wt) ~ (poly(wind.2m.wt, 4) + poly(wind.2m.bls, 4) + poly(air.temp.wt, 4) + poly(rain.rate.bls, 4) + poly(rain.cum.bls, 4))*poly(cta, 4), 
           data = adat, weights = weights) 
```


```r
summary(mods[[i]])
```

```
## 
## Call:
## lm(formula = log10(j.NH3.bls/j.NH3.wt) ~ (poly(wind.2m.wt, 4) + 
##     poly(wind.2m.bls, 4) + poly(air.temp.wt, 4) + poly(rain.rate.bls, 
##     4) + poly(rain.cum.bls, 4)) * poly(cta, 4), data = adat, 
##     weights = weights)
## 
## Weighted Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.40461 -0.02616  0.00649  0.03925  0.35124 
## 
## Coefficients:
##                                         Estimate Std. Error t value Pr(>|t|)
## (Intercept)                           -4.114e+01  1.049e+01  -3.922 9.01e-05
## poly(wind.2m.wt, 4)1                  -9.413e-01  2.762e-01  -3.407 0.000666
## poly(wind.2m.wt, 4)2                  -1.625e-01  4.262e-01  -0.381 0.703072
## poly(wind.2m.wt, 4)3                   6.663e-01  4.155e-01   1.604 0.108906
## poly(wind.2m.wt, 4)4                  -1.777e-03  5.467e-01  -0.003 0.997406
## poly(wind.2m.bls, 4)1                  3.572e+01  3.952e+00   9.038  < 2e-16
## poly(wind.2m.bls, 4)2                  1.403e-01  5.430e+00   0.026 0.979388
## poly(wind.2m.bls, 4)3                  2.088e+01  3.664e+00   5.700 1.32e-08
## poly(wind.2m.bls, 4)4                  2.449e+00  1.745e+00   1.403 0.160701
## poly(air.temp.wt, 4)1                  3.705e+00  2.925e+00   1.267 0.205432
## poly(air.temp.wt, 4)2                  1.367e+01  2.756e+00   4.959 7.52e-07
## poly(air.temp.wt, 4)3                 -7.649e-01  1.663e+00  -0.460 0.645673
## poly(air.temp.wt, 4)4                  1.544e+01  1.963e+00   7.862 5.36e-15
## poly(rain.rate.bls, 4)1               -1.528e+04  5.784e+03  -2.641 0.008310
## poly(rain.rate.bls, 4)2               -1.318e+04  4.991e+03  -2.642 0.008299
## poly(rain.rate.bls, 4)3               -4.184e+03  1.611e+03  -2.597 0.009448
## poly(rain.rate.bls, 4)4               -7.753e+02  3.220e+02  -2.408 0.016103
## poly(rain.cum.bls, 4)1                -1.593e+03  5.238e+02  -3.041 0.002378
## poly(rain.cum.bls, 4)2                -1.250e+03  3.998e+02  -3.127 0.001786
## poly(rain.cum.bls, 4)3                -5.987e+02  1.447e+02  -4.139 3.60e-05
## poly(rain.cum.bls, 4)4                -1.289e+02  3.015e+01  -4.276 1.97e-05
## poly(cta, 4)1                         -1.051e+03  1.050e+03  -1.001 0.317066
## poly(cta, 4)2                         -2.537e+03  8.389e+02  -3.025 0.002513
## poly(cta, 4)3                         -8.525e+02  6.250e+02  -1.364 0.172668
## poly(cta, 4)4                         -3.402e+02  3.197e+02  -1.064 0.287324
## poly(wind.2m.wt, 4)1:poly(cta, 4)1     4.462e+01  1.448e+01   3.082 0.002073
## poly(wind.2m.wt, 4)2:poly(cta, 4)1     1.572e+01  2.531e+01   0.621 0.534703
## poly(wind.2m.wt, 4)3:poly(cta, 4)1     4.322e+01  3.099e+01   1.395 0.163269
## poly(wind.2m.wt, 4)4:poly(cta, 4)1     2.912e+00  4.112e+01   0.071 0.943545
## poly(wind.2m.wt, 4)1:poly(cta, 4)2    -3.164e+01  1.393e+01  -2.271 0.023229
## poly(wind.2m.wt, 4)2:poly(cta, 4)2     1.301e+01  2.656e+01   0.490 0.624250
## poly(wind.2m.wt, 4)3:poly(cta, 4)2     1.975e+00  3.636e+01   0.054 0.956683
## poly(wind.2m.wt, 4)4:poly(cta, 4)2    -1.977e+01  4.813e+01  -0.411 0.681238
## poly(wind.2m.wt, 4)1:poly(cta, 4)3     2.633e+01  1.372e+01   1.919 0.055097
## poly(wind.2m.wt, 4)2:poly(cta, 4)3    -2.882e+01  2.561e+01  -1.126 0.260393
## poly(wind.2m.wt, 4)3:poly(cta, 4)3    -1.788e+00  3.403e+01  -0.053 0.958094
## poly(wind.2m.wt, 4)4:poly(cta, 4)3    -4.531e+01  4.478e+01  -1.012 0.311695
## poly(wind.2m.wt, 4)1:poly(cta, 4)4    -2.095e+01  1.098e+01  -1.908 0.056510
## poly(wind.2m.wt, 4)2:poly(cta, 4)4     1.634e+01  1.721e+01   0.949 0.342671
## poly(wind.2m.wt, 4)3:poly(cta, 4)4    -2.407e+00  1.765e+01  -0.136 0.891526
## poly(wind.2m.wt, 4)4:poly(cta, 4)4    -2.258e+01  2.289e+01  -0.987 0.323815
## poly(wind.2m.bls, 4)1:poly(cta, 4)1    8.824e+02  2.791e+02   3.162 0.001585
## poly(wind.2m.bls, 4)2:poly(cta, 4)1   -2.127e+03  3.564e+02  -5.969 2.69e-09
## poly(wind.2m.bls, 4)3:poly(cta, 4)1   -3.653e+02  2.094e+02  -1.745 0.081101
## poly(wind.2m.bls, 4)4:poly(cta, 4)1   -6.726e+02  9.685e+01  -6.945 4.70e-12
## poly(wind.2m.bls, 4)1:poly(cta, 4)2    1.276e+03  2.987e+02   4.272 2.00e-05
## poly(wind.2m.bls, 4)2:poly(cta, 4)2   -7.432e+02  2.982e+02  -2.492 0.012766
## poly(wind.2m.bls, 4)3:poly(cta, 4)2    7.424e+02  2.304e+02   3.223 0.001285
## poly(wind.2m.bls, 4)4:poly(cta, 4)2   -1.862e+02  7.013e+01  -2.655 0.007982
## poly(wind.2m.bls, 4)1:poly(cta, 4)3    8.604e+02  1.992e+02   4.319 1.62e-05
## poly(wind.2m.bls, 4)2:poly(cta, 4)3    9.418e+01  2.226e+02   0.423 0.672199
## poly(wind.2m.bls, 4)3:poly(cta, 4)3    7.986e+02  1.737e+02   4.598 4.45e-06
## poly(wind.2m.bls, 4)4:poly(cta, 4)3    1.229e+02  5.645e+01   2.177 0.029581
## poly(wind.2m.bls, 4)1:poly(cta, 4)4    1.072e+02  8.229e+01   1.303 0.192771
## poly(wind.2m.bls, 4)2:poly(cta, 4)4   -5.000e+02  1.103e+02  -4.533 6.05e-06
## poly(wind.2m.bls, 4)3:poly(cta, 4)4   -1.995e+02  6.975e+01  -2.860 0.004266
## poly(wind.2m.bls, 4)4:poly(cta, 4)4    4.092e+00  2.810e+01   0.146 0.884235
## poly(air.temp.wt, 4)1:poly(cta, 4)1   -5.464e+02  2.267e+02  -2.410 0.015999
## poly(air.temp.wt, 4)2:poly(cta, 4)1    1.686e+03  2.295e+02   7.347 2.64e-13
## poly(air.temp.wt, 4)3:poly(cta, 4)1    7.169e+01  1.292e+02   0.555 0.579038
## poly(air.temp.wt, 4)4:poly(cta, 4)1    7.723e+02  1.528e+02   5.054 4.60e-07
## poly(air.temp.wt, 4)1:poly(cta, 4)2   -8.624e+02  2.242e+02  -3.846 0.000123
## poly(air.temp.wt, 4)2:poly(cta, 4)2    1.876e+03  2.263e+02   8.291  < 2e-16
## poly(air.temp.wt, 4)3:poly(cta, 4)2    1.177e+02  1.320e+02   0.892 0.372323
## poly(air.temp.wt, 4)4:poly(cta, 4)2    6.486e+02  1.579e+02   4.108 4.11e-05
## poly(air.temp.wt, 4)1:poly(cta, 4)3   -6.698e+02  1.520e+02  -4.407 1.09e-05
## poly(air.temp.wt, 4)2:poly(cta, 4)3    1.493e+03  1.582e+02   9.436  < 2e-16
## poly(air.temp.wt, 4)3:poly(cta, 4)3    6.646e+00  9.892e+01   0.067 0.946443
## poly(air.temp.wt, 4)4:poly(cta, 4)3    4.377e+02  1.156e+02   3.785 0.000157
## poly(air.temp.wt, 4)1:poly(cta, 4)4    4.929e+01  8.275e+01   0.596 0.551456
## poly(air.temp.wt, 4)2:poly(cta, 4)4    5.462e+02  6.232e+01   8.764  < 2e-16
## poly(air.temp.wt, 4)3:poly(cta, 4)4   -3.129e+01  4.444e+01  -0.704 0.481403
## poly(air.temp.wt, 4)4:poly(cta, 4)4    1.576e+02  4.873e+01   3.233 0.001238
## poly(rain.rate.bls, 4)1:poly(cta, 4)1 -1.137e+06  5.790e+05  -1.965 0.049558
## poly(rain.rate.bls, 4)2:poly(cta, 4)1 -9.750e+05  5.040e+05  -1.934 0.053159
## poly(rain.rate.bls, 4)3:poly(cta, 4)1 -3.063e+05  1.667e+05  -1.838 0.066237
## poly(rain.rate.bls, 4)4:poly(cta, 4)1 -5.727e+04  3.419e+04  -1.675 0.094092
## poly(rain.rate.bls, 4)1:poly(cta, 4)2 -1.074e+06  4.922e+05  -2.183 0.029153
## poly(rain.rate.bls, 4)2:poly(cta, 4)2 -9.194e+05  4.249e+05  -2.164 0.030570
## poly(rain.rate.bls, 4)3:poly(cta, 4)2 -2.819e+05  1.374e+05  -2.051 0.040320
## poly(rain.rate.bls, 4)4:poly(cta, 4)2 -4.847e+04  2.755e+04  -1.759 0.078670
## poly(rain.rate.bls, 4)1:poly(cta, 4)3 -6.235e+05  3.652e+05  -1.707 0.087845
## poly(rain.rate.bls, 4)2:poly(cta, 4)3 -5.304e+05  3.177e+05  -1.669 0.095157
## poly(rain.rate.bls, 4)3:poly(cta, 4)3 -1.612e+05  1.051e+05  -1.534 0.125061
## poly(rain.rate.bls, 4)4:poly(cta, 4)3 -2.788e+04  2.159e+04  -1.291 0.196694
## poly(rain.rate.bls, 4)1:poly(cta, 4)4 -1.444e+05  1.909e+05  -0.756 0.449448
## poly(rain.rate.bls, 4)2:poly(cta, 4)4 -1.115e+05  1.651e+05  -0.675 0.499460
## poly(rain.rate.bls, 4)3:poly(cta, 4)4 -1.724e+04  5.380e+04  -0.321 0.748605
## poly(rain.rate.bls, 4)4:poly(cta, 4)4  4.694e+03  1.099e+04   0.427 0.669339
## poly(rain.cum.bls, 4)1:poly(cta, 4)1   1.080e+05  3.558e+04   3.034 0.002433
## poly(rain.cum.bls, 4)2:poly(cta, 4)1   9.294e+04  2.666e+04   3.486 0.000497
## poly(rain.cum.bls, 4)3:poly(cta, 4)1   3.123e+04  1.044e+04   2.990 0.002810
## poly(rain.cum.bls, 4)4:poly(cta, 4)1   8.614e+03  1.858e+03   4.637 3.70e-06
## poly(rain.cum.bls, 4)1:poly(cta, 4)2  -6.976e+04  2.467e+04  -2.827 0.004730
## poly(rain.cum.bls, 4)2:poly(cta, 4)2  -5.295e+04  1.890e+04  -2.801 0.005123
## poly(rain.cum.bls, 4)3:poly(cta, 4)2  -3.095e+04  6.747e+03  -4.587 4.69e-06
## poly(rain.cum.bls, 4)4:poly(cta, 4)2  -4.981e+03  1.249e+03  -3.989 6.82e-05
## poly(rain.cum.bls, 4)1:poly(cta, 4)3   3.037e+04  1.079e+04   2.814 0.004933
## poly(rain.cum.bls, 4)2:poly(cta, 4)3   2.911e+04  8.040e+03   3.620 0.000300
## poly(rain.cum.bls, 4)3:poly(cta, 4)3   5.730e+03  3.212e+03   1.784 0.074545
## poly(rain.cum.bls, 4)4:poly(cta, 4)3   2.731e+03  5.633e+02   4.849 1.31e-06
## poly(rain.cum.bls, 4)1:poly(cta, 4)4  -6.283e+03  2.846e+03  -2.208 0.027354
## poly(rain.cum.bls, 4)2:poly(cta, 4)4  -3.562e+03  2.279e+03  -1.563 0.118151
## poly(rain.cum.bls, 4)3:poly(cta, 4)4  -4.638e+03  7.799e+02  -5.946 3.09e-09
## poly(rain.cum.bls, 4)4:poly(cta, 4)4  -1.746e+03  1.427e+02 -12.235  < 2e-16
##                                          
## (Intercept)                           ***
## poly(wind.2m.wt, 4)1                  ***
## poly(wind.2m.wt, 4)2                     
## poly(wind.2m.wt, 4)3                     
## poly(wind.2m.wt, 4)4                     
## poly(wind.2m.bls, 4)1                 ***
## poly(wind.2m.bls, 4)2                    
## poly(wind.2m.bls, 4)3                 ***
## poly(wind.2m.bls, 4)4                    
## poly(air.temp.wt, 4)1                    
## poly(air.temp.wt, 4)2                 ***
## poly(air.temp.wt, 4)3                    
## poly(air.temp.wt, 4)4                 ***
## poly(rain.rate.bls, 4)1               ** 
## poly(rain.rate.bls, 4)2               ** 
## poly(rain.rate.bls, 4)3               ** 
## poly(rain.rate.bls, 4)4               *  
## poly(rain.cum.bls, 4)1                ** 
## poly(rain.cum.bls, 4)2                ** 
## poly(rain.cum.bls, 4)3                ***
## poly(rain.cum.bls, 4)4                ***
## poly(cta, 4)1                            
## poly(cta, 4)2                         ** 
## poly(cta, 4)3                            
## poly(cta, 4)4                            
## poly(wind.2m.wt, 4)1:poly(cta, 4)1    ** 
## poly(wind.2m.wt, 4)2:poly(cta, 4)1       
## poly(wind.2m.wt, 4)3:poly(cta, 4)1       
## poly(wind.2m.wt, 4)4:poly(cta, 4)1       
## poly(wind.2m.wt, 4)1:poly(cta, 4)2    *  
## poly(wind.2m.wt, 4)2:poly(cta, 4)2       
## poly(wind.2m.wt, 4)3:poly(cta, 4)2       
## poly(wind.2m.wt, 4)4:poly(cta, 4)2       
## poly(wind.2m.wt, 4)1:poly(cta, 4)3    .  
## poly(wind.2m.wt, 4)2:poly(cta, 4)3       
## poly(wind.2m.wt, 4)3:poly(cta, 4)3       
## poly(wind.2m.wt, 4)4:poly(cta, 4)3       
## poly(wind.2m.wt, 4)1:poly(cta, 4)4    .  
## poly(wind.2m.wt, 4)2:poly(cta, 4)4       
## poly(wind.2m.wt, 4)3:poly(cta, 4)4       
## poly(wind.2m.wt, 4)4:poly(cta, 4)4       
## poly(wind.2m.bls, 4)1:poly(cta, 4)1   ** 
## poly(wind.2m.bls, 4)2:poly(cta, 4)1   ***
## poly(wind.2m.bls, 4)3:poly(cta, 4)1   .  
## poly(wind.2m.bls, 4)4:poly(cta, 4)1   ***
## poly(wind.2m.bls, 4)1:poly(cta, 4)2   ***
## poly(wind.2m.bls, 4)2:poly(cta, 4)2   *  
## poly(wind.2m.bls, 4)3:poly(cta, 4)2   ** 
## poly(wind.2m.bls, 4)4:poly(cta, 4)2   ** 
## poly(wind.2m.bls, 4)1:poly(cta, 4)3   ***
## poly(wind.2m.bls, 4)2:poly(cta, 4)3      
## poly(wind.2m.bls, 4)3:poly(cta, 4)3   ***
## poly(wind.2m.bls, 4)4:poly(cta, 4)3   *  
## poly(wind.2m.bls, 4)1:poly(cta, 4)4      
## poly(wind.2m.bls, 4)2:poly(cta, 4)4   ***
## poly(wind.2m.bls, 4)3:poly(cta, 4)4   ** 
## poly(wind.2m.bls, 4)4:poly(cta, 4)4      
## poly(air.temp.wt, 4)1:poly(cta, 4)1   *  
## poly(air.temp.wt, 4)2:poly(cta, 4)1   ***
## poly(air.temp.wt, 4)3:poly(cta, 4)1      
## poly(air.temp.wt, 4)4:poly(cta, 4)1   ***
## poly(air.temp.wt, 4)1:poly(cta, 4)2   ***
## poly(air.temp.wt, 4)2:poly(cta, 4)2   ***
## poly(air.temp.wt, 4)3:poly(cta, 4)2      
## poly(air.temp.wt, 4)4:poly(cta, 4)2   ***
## poly(air.temp.wt, 4)1:poly(cta, 4)3   ***
## poly(air.temp.wt, 4)2:poly(cta, 4)3   ***
## poly(air.temp.wt, 4)3:poly(cta, 4)3      
## poly(air.temp.wt, 4)4:poly(cta, 4)3   ***
## poly(air.temp.wt, 4)1:poly(cta, 4)4      
## poly(air.temp.wt, 4)2:poly(cta, 4)4   ***
## poly(air.temp.wt, 4)3:poly(cta, 4)4      
## poly(air.temp.wt, 4)4:poly(cta, 4)4   ** 
## poly(rain.rate.bls, 4)1:poly(cta, 4)1 *  
## poly(rain.rate.bls, 4)2:poly(cta, 4)1 .  
## poly(rain.rate.bls, 4)3:poly(cta, 4)1 .  
## poly(rain.rate.bls, 4)4:poly(cta, 4)1 .  
## poly(rain.rate.bls, 4)1:poly(cta, 4)2 *  
## poly(rain.rate.bls, 4)2:poly(cta, 4)2 *  
## poly(rain.rate.bls, 4)3:poly(cta, 4)2 *  
## poly(rain.rate.bls, 4)4:poly(cta, 4)2 .  
## poly(rain.rate.bls, 4)1:poly(cta, 4)3 .  
## poly(rain.rate.bls, 4)2:poly(cta, 4)3 .  
## poly(rain.rate.bls, 4)3:poly(cta, 4)3    
## poly(rain.rate.bls, 4)4:poly(cta, 4)3    
## poly(rain.rate.bls, 4)1:poly(cta, 4)4    
## poly(rain.rate.bls, 4)2:poly(cta, 4)4    
## poly(rain.rate.bls, 4)3:poly(cta, 4)4    
## poly(rain.rate.bls, 4)4:poly(cta, 4)4    
## poly(rain.cum.bls, 4)1:poly(cta, 4)1  ** 
## poly(rain.cum.bls, 4)2:poly(cta, 4)1  ***
## poly(rain.cum.bls, 4)3:poly(cta, 4)1  ** 
## poly(rain.cum.bls, 4)4:poly(cta, 4)1  ***
## poly(rain.cum.bls, 4)1:poly(cta, 4)2  ** 
## poly(rain.cum.bls, 4)2:poly(cta, 4)2  ** 
## poly(rain.cum.bls, 4)3:poly(cta, 4)2  ***
## poly(rain.cum.bls, 4)4:poly(cta, 4)2  ***
## poly(rain.cum.bls, 4)1:poly(cta, 4)3  ** 
## poly(rain.cum.bls, 4)2:poly(cta, 4)3  ***
## poly(rain.cum.bls, 4)3:poly(cta, 4)3  .  
## poly(rain.cum.bls, 4)4:poly(cta, 4)3  ***
## poly(rain.cum.bls, 4)1:poly(cta, 4)4  *  
## poly(rain.cum.bls, 4)2:poly(cta, 4)4     
## poly(rain.cum.bls, 4)3:poly(cta, 4)4  ***
## poly(rain.cum.bls, 4)4:poly(cta, 4)4  ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.06732 on 2782 degrees of freedom
## Multiple R-squared:  0.8632,	Adjusted R-squared:  0.858 
## F-statistic: 168.7 on 104 and 2782 DF,  p-value: < 2.2e-16
```

```r
coef(mods[[i]])
```

```
##                           (Intercept)                  poly(wind.2m.wt, 4)1 
##                         -4.114397e+01                         -9.412547e-01 
##                  poly(wind.2m.wt, 4)2                  poly(wind.2m.wt, 4)3 
##                         -1.624785e-01                          6.663357e-01 
##                  poly(wind.2m.wt, 4)4                 poly(wind.2m.bls, 4)1 
##                         -1.777353e-03                          3.571800e+01 
##                 poly(wind.2m.bls, 4)2                 poly(wind.2m.bls, 4)3 
##                          1.403077e-01                          2.088228e+01 
##                 poly(wind.2m.bls, 4)4                 poly(air.temp.wt, 4)1 
##                          2.448984e+00                          3.705008e+00 
##                 poly(air.temp.wt, 4)2                 poly(air.temp.wt, 4)3 
##                          1.366565e+01                         -7.648917e-01 
##                 poly(air.temp.wt, 4)4               poly(rain.rate.bls, 4)1 
##                          1.543625e+01                         -1.527534e+04 
##               poly(rain.rate.bls, 4)2               poly(rain.rate.bls, 4)3 
##                         -1.318449e+04                         -4.184469e+03 
##               poly(rain.rate.bls, 4)4                poly(rain.cum.bls, 4)1 
##                         -7.753370e+02                         -1.593142e+03 
##                poly(rain.cum.bls, 4)2                poly(rain.cum.bls, 4)3 
##                         -1.250107e+03                         -5.987000e+02 
##                poly(rain.cum.bls, 4)4                         poly(cta, 4)1 
##                         -1.289242e+02                         -1.050527e+03 
##                         poly(cta, 4)2                         poly(cta, 4)3 
##                         -2.537302e+03                         -8.525494e+02 
##                         poly(cta, 4)4    poly(wind.2m.wt, 4)1:poly(cta, 4)1 
##                         -3.402360e+02                          4.462180e+01 
##    poly(wind.2m.wt, 4)2:poly(cta, 4)1    poly(wind.2m.wt, 4)3:poly(cta, 4)1 
##                          1.571741e+01                          4.321761e+01 
##    poly(wind.2m.wt, 4)4:poly(cta, 4)1    poly(wind.2m.wt, 4)1:poly(cta, 4)2 
##                          2.912460e+00                         -3.164477e+01 
##    poly(wind.2m.wt, 4)2:poly(cta, 4)2    poly(wind.2m.wt, 4)3:poly(cta, 4)2 
##                          1.300973e+01                          1.975206e+00 
##    poly(wind.2m.wt, 4)4:poly(cta, 4)2    poly(wind.2m.wt, 4)1:poly(cta, 4)3 
##                         -1.977132e+01                          2.633075e+01 
##    poly(wind.2m.wt, 4)2:poly(cta, 4)3    poly(wind.2m.wt, 4)3:poly(cta, 4)3 
##                         -2.882365e+01                         -1.788255e+00 
##    poly(wind.2m.wt, 4)4:poly(cta, 4)3    poly(wind.2m.wt, 4)1:poly(cta, 4)4 
##                         -4.531103e+01                         -2.094521e+01 
##    poly(wind.2m.wt, 4)2:poly(cta, 4)4    poly(wind.2m.wt, 4)3:poly(cta, 4)4 
##                          1.633765e+01                         -2.407208e+00 
##    poly(wind.2m.wt, 4)4:poly(cta, 4)4   poly(wind.2m.bls, 4)1:poly(cta, 4)1 
##                         -2.258379e+01                          8.823907e+02 
##   poly(wind.2m.bls, 4)2:poly(cta, 4)1   poly(wind.2m.bls, 4)3:poly(cta, 4)1 
##                         -2.127264e+03                         -3.653226e+02 
##   poly(wind.2m.bls, 4)4:poly(cta, 4)1   poly(wind.2m.bls, 4)1:poly(cta, 4)2 
##                         -6.725576e+02                          1.276245e+03 
##   poly(wind.2m.bls, 4)2:poly(cta, 4)2   poly(wind.2m.bls, 4)3:poly(cta, 4)2 
##                         -7.431708e+02                          7.423804e+02 
##   poly(wind.2m.bls, 4)4:poly(cta, 4)2   poly(wind.2m.bls, 4)1:poly(cta, 4)3 
##                         -1.861645e+02                          8.604173e+02 
##   poly(wind.2m.bls, 4)2:poly(cta, 4)3   poly(wind.2m.bls, 4)3:poly(cta, 4)3 
##                          9.417853e+01                          7.986483e+02 
##   poly(wind.2m.bls, 4)4:poly(cta, 4)3   poly(wind.2m.bls, 4)1:poly(cta, 4)4 
##                          1.228779e+02                          1.072028e+02 
##   poly(wind.2m.bls, 4)2:poly(cta, 4)4   poly(wind.2m.bls, 4)3:poly(cta, 4)4 
##                         -5.000164e+02                         -1.995109e+02 
##   poly(wind.2m.bls, 4)4:poly(cta, 4)4   poly(air.temp.wt, 4)1:poly(cta, 4)1 
##                          4.092264e+00                         -5.463505e+02 
##   poly(air.temp.wt, 4)2:poly(cta, 4)1   poly(air.temp.wt, 4)3:poly(cta, 4)1 
##                          1.685981e+03                          7.169391e+01 
##   poly(air.temp.wt, 4)4:poly(cta, 4)1   poly(air.temp.wt, 4)1:poly(cta, 4)2 
##                          7.722591e+02                         -8.623938e+02 
##   poly(air.temp.wt, 4)2:poly(cta, 4)2   poly(air.temp.wt, 4)3:poly(cta, 4)2 
##                          1.876404e+03                          1.177384e+02 
##   poly(air.temp.wt, 4)4:poly(cta, 4)2   poly(air.temp.wt, 4)1:poly(cta, 4)3 
##                          6.486191e+02                         -6.697521e+02 
##   poly(air.temp.wt, 4)2:poly(cta, 4)3   poly(air.temp.wt, 4)3:poly(cta, 4)3 
##                          1.492659e+03                          6.645641e+00 
##   poly(air.temp.wt, 4)4:poly(cta, 4)3   poly(air.temp.wt, 4)1:poly(cta, 4)4 
##                          4.377006e+02                          4.928956e+01 
##   poly(air.temp.wt, 4)2:poly(cta, 4)4   poly(air.temp.wt, 4)3:poly(cta, 4)4 
##                          5.461870e+02                         -3.129460e+01 
##   poly(air.temp.wt, 4)4:poly(cta, 4)4 poly(rain.rate.bls, 4)1:poly(cta, 4)1 
##                          1.575672e+02                         -1.137485e+06 
## poly(rain.rate.bls, 4)2:poly(cta, 4)1 poly(rain.rate.bls, 4)3:poly(cta, 4)1 
##                         -9.750061e+05                         -3.063253e+05 
## poly(rain.rate.bls, 4)4:poly(cta, 4)1 poly(rain.rate.bls, 4)1:poly(cta, 4)2 
##                         -5.726541e+04                         -1.074147e+06 
## poly(rain.rate.bls, 4)2:poly(cta, 4)2 poly(rain.rate.bls, 4)3:poly(cta, 4)2 
##                         -9.193562e+05                         -2.819033e+05 
## poly(rain.rate.bls, 4)4:poly(cta, 4)2 poly(rain.rate.bls, 4)1:poly(cta, 4)3 
##                         -4.846934e+04                         -6.234972e+05 
## poly(rain.rate.bls, 4)2:poly(cta, 4)3 poly(rain.rate.bls, 4)3:poly(cta, 4)3 
##                         -5.303970e+05                         -1.611835e+05 
## poly(rain.rate.bls, 4)4:poly(cta, 4)3 poly(rain.rate.bls, 4)1:poly(cta, 4)4 
##                         -2.788044e+04                         -1.444314e+05 
## poly(rain.rate.bls, 4)2:poly(cta, 4)4 poly(rain.rate.bls, 4)3:poly(cta, 4)4 
##                         -1.114955e+05                         -1.724483e+04 
## poly(rain.rate.bls, 4)4:poly(cta, 4)4  poly(rain.cum.bls, 4)1:poly(cta, 4)1 
##                          4.693943e+03                          1.079638e+05 
##  poly(rain.cum.bls, 4)2:poly(cta, 4)1  poly(rain.cum.bls, 4)3:poly(cta, 4)1 
##                          9.294062e+04                          3.122780e+04 
##  poly(rain.cum.bls, 4)4:poly(cta, 4)1  poly(rain.cum.bls, 4)1:poly(cta, 4)2 
##                          8.613664e+03                         -6.975879e+04 
##  poly(rain.cum.bls, 4)2:poly(cta, 4)2  poly(rain.cum.bls, 4)3:poly(cta, 4)2 
##                         -5.295243e+04                         -3.094900e+04 
##  poly(rain.cum.bls, 4)4:poly(cta, 4)2  poly(rain.cum.bls, 4)1:poly(cta, 4)3 
##                         -4.980843e+03                          3.037254e+04 
##  poly(rain.cum.bls, 4)2:poly(cta, 4)3  poly(rain.cum.bls, 4)3:poly(cta, 4)3 
##                          2.910548e+04                          5.730498e+03 
##  poly(rain.cum.bls, 4)4:poly(cta, 4)3  poly(rain.cum.bls, 4)1:poly(cta, 4)4 
##                          2.731219e+03                         -6.282817e+03 
##  poly(rain.cum.bls, 4)2:poly(cta, 4)4  poly(rain.cum.bls, 4)3:poly(cta, 4)4 
##                         -3.561904e+03                         -4.637579e+03 
##  poly(rain.cum.bls, 4)4:poly(cta, 4)4 
##                         -1.745989e+03
```



```r
i <- i + 1
mods[[i]] <- gam(log10(j.NH3.bls / j.NH3.wt) ~ s(wind.2m.wt) + s(wind.2m.bls) + s(air.temp.wt) + s(rain.rate.bls) + s(rain.cum.bls) + s(cta), 
           data = adat, weights = weights) 
```


```r
summary(mods[[i]])
```

```
## 
## Call: gam(formula = log10(j.NH3.bls/j.NH3.wt) ~ s(wind.2m.wt) + s(wind.2m.bls) + 
##     s(air.temp.wt) + s(rain.rate.bls) + s(rain.cum.bls) + s(cta), 
##     data = adat, weights = weights)
## Deviance Residuals:
##       Min        1Q    Median        3Q       Max 
## -0.599861 -0.038103  0.006305  0.058399  0.530876 
## 
## (Dispersion Parameter for gaussian family taken to be 0.0102)
## 
##     Null Deviance: 92.1395 on 2886 degrees of freedom
## Residual Deviance: 29.3045 on 2862 degrees of freedom
## AIC: 2651.577 
## 
## Number of Local Scoring Iterations: NA 
## 
## Anova for Parametric Effects
##                    Df  Sum Sq Mean Sq  F value    Pr(>F)    
## s(wind.2m.wt)       1  0.6434  0.6434   62.833 3.195e-15 ***
## s(wind.2m.bls)      1 12.6210 12.6210 1232.617 < 2.2e-16 ***
## s(air.temp.wt)      1  3.3289  3.3289  325.109 < 2.2e-16 ***
## s(rain.rate.bls)    1  0.4930  0.4930   48.144 4.878e-12 ***
## s(rain.cum.bls)     1 23.0349 23.0349 2249.688 < 2.2e-16 ***
## s(cta)              1  2.6957  2.6957  263.277 < 2.2e-16 ***
## Residuals        2862 29.3045  0.0102                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Anova for Nonparametric Effects
##                  Npar Df Npar F     Pr(F)    
## (Intercept)                                  
## s(wind.2m.wt)          3   2.60   0.05073 .  
## s(wind.2m.bls)         3  59.24 < 2.2e-16 ***
## s(air.temp.wt)         3  71.92 < 2.2e-16 ***
## s(rain.rate.bls)       3  25.70  2.22e-16 ***
## s(rain.cum.bls)        3 386.58 < 2.2e-16 ***
## s(cta)                 3 136.93 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
coef(mods[[i]])
```

```
##      (Intercept)    s(wind.2m.wt)   s(wind.2m.bls)   s(air.temp.wt) 
##     -0.438422282     -0.237323046      0.131388432      0.004447821 
## s(rain.rate.bls)  s(rain.cum.bls)           s(cta) 
##      0.094977395     -0.054862864      0.002254635
```



```r
i <- i + 1
mods[[i]] <- lm(log10(j.NH3.bls / j.NH3.wt) ~ (wind.2m.wt + wind.2m.bls + air.temp.wt + rain.rate.bls + rain.cum.bls + e.prev.wt)*cta, 
           data = adat, weights = weights) 
```


```r
summary(mods[[i]])
```

```
## 
## Call:
## lm(formula = log10(j.NH3.bls/j.NH3.wt) ~ (wind.2m.wt + wind.2m.bls + 
##     air.temp.wt + rain.rate.bls + rain.cum.bls + e.prev.wt) * 
##     cta, data = adat, weights = weights)
## 
## Weighted Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.61445 -0.04129  0.01694  0.05958  0.50691 
## 
## Coefficients:
##                     Estimate Std. Error t value Pr(>|t|)    
## (Intercept)       -1.422e-01  2.408e-02  -5.904 3.96e-09 ***
## wind.2m.wt        -4.188e-01  2.982e-02 -14.045  < 2e-16 ***
## wind.2m.bls        1.606e-01  6.626e-03  24.245  < 2e-16 ***
## air.temp.wt       -1.557e-02  9.630e-04 -16.172  < 2e-16 ***
## rain.rate.bls      4.692e-02  1.300e-01   0.361 0.718192    
## rain.cum.bls      -6.969e-02  2.234e-03 -31.194  < 2e-16 ***
## e.prev.wt          3.561e-03  6.658e-04   5.349 9.56e-08 ***
## cta               -6.826e-03  6.176e-04 -11.053  < 2e-16 ***
## wind.2m.wt:cta     4.412e-03  7.027e-04   6.278 3.95e-10 ***
## wind.2m.bls:cta   -8.371e-04  8.537e-05  -9.805  < 2e-16 ***
## air.temp.wt:cta    7.250e-04  2.974e-05  24.377  < 2e-16 ***
## rain.rate.bls:cta -1.396e-03  1.254e-03  -1.113 0.265597    
## rain.cum.bls:cta   3.543e-04  1.926e-05  18.401  < 2e-16 ***
## e.prev.wt:cta     -8.670e-05  2.416e-05  -3.588 0.000338 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.109 on 2873 degrees of freedom
## Multiple R-squared:  0.6295,	Adjusted R-squared:  0.6278 
## F-statistic: 375.5 on 13 and 2873 DF,  p-value: < 2.2e-16
```

```r
coef(mods[[i]])
```

```
##       (Intercept)        wind.2m.wt       wind.2m.bls       air.temp.wt 
##     -1.421869e-01     -4.188302e-01      1.606332e-01     -1.557314e-02 
##     rain.rate.bls      rain.cum.bls         e.prev.wt               cta 
##      4.691814e-02     -6.968854e-02      3.560923e-03     -6.826282e-03 
##    wind.2m.wt:cta   wind.2m.bls:cta   air.temp.wt:cta rain.rate.bls:cta 
##      4.411609e-03     -8.370644e-04      7.249948e-04     -1.395874e-03 
##  rain.cum.bls:cta     e.prev.wt:cta 
##      3.543269e-04     -8.670329e-05
```



# Get predictions


```r
mdat <- adat
mdat$mod <- 'Measured'
for (i in 1:length(mods)) {

  dd <- adat
  dd[, 'j.NH3.bls'] <- 10^predict(mods[[i]], newdata = dd) * dd$j.NH3.wt

  for (j in unique(dd$pmid.wt)) {
    dd[dd$pmid.wt == j, 'e.cum.bls'] <- cumsum(dd[dd$pmid.wt == j, 'j.NH3.bls'] * dd[dd$pmid.wt == j, 'dt.bls'])
  }

  dd$mod <- paste('Model', i)
  mdat <- rbind(mdat, dd)

}
tail(mdat)
```

```
##         app.date    cta pmid.wt     ct dt.wt tan.app man.dm man.ph air.temp.wt
## 24725 2022-01-05 200.97    1921 200.68  1.73  94.428   4.47    7.9         7.8
## 24855 2022-01-05 202.70    1921 202.41  1.73  94.428   4.47    7.9         8.3
## 24875 2022-01-05 204.42    1921 204.14  1.73  94.428   4.47    7.9         8.5
## 24995 2022-01-05 206.15    1921 205.87  1.73  94.428   4.47    7.9         8.3
## 25045 2022-01-05 207.88    1921 207.60  1.73  94.428   4.47    7.9         8.4
## 25165 2022-01-05 209.62    1921 209.33  1.73  94.428   4.47    7.9         8.3
##       wind.2m.wt rain.wt rain.rate.wt rain.cum.wt j.NH3.wt e.int.wt e.cum.wt
## 24725       0.72       0            0           0 0.040794 0.070573   36.044
## 24855       0.72       0            0           0 0.041372 0.071573   36.115
## 24875       0.72       0            0           0 0.039449 0.068247   36.184
## 24995       0.72       0            0           0 0.038413 0.066454   36.250
## 25045       0.72       0            0           0 0.037994 0.065729   36.316
## 25165       0.72       0            0           0 0.036822 0.063701   36.379
##       e.prev.wt e.rel.wt dt.bls    ctb e.cum.bls e.rel.bls e.int.bls e.prev.bls
## 24725  35.97343  0.38171   1.73 199.24  9.802945 0.1874230   0.03542   12.82668
## 24855  36.04343  0.38246   1.73 200.97  9.820338 0.1879424   0.03634   12.86210
## 24875  36.11575  0.38319   1.73 202.69  9.837590 0.1884280   0.03314   12.89826
## 24995  36.18355  0.38389   1.73 204.42  9.853241 0.1888384   0.02820   12.93140
## 25045  36.25027  0.38459   1.73 206.15  9.869310 0.1892820   0.03052   12.95960
## 25165  36.31530  0.38526   1.73 207.89  9.885143 0.1896400   0.02476   12.99024
##       wind.2m.bls air.temp.bls rain.cum.bls rain.bls rain.rate.bls pmid.bls
## 24725    5.652533       7.8000         18.2        0             0     1924
## 24855    6.085025       8.5750         18.2        0             0     1924
## 24875    6.979067       8.5000         18.2        0             0     1924
## 24995    7.231175       8.2875         18.2        0             0     1924
## 25045    6.907367       8.3500         18.2        0             0     1924
## 25165    5.434375       7.8625         18.2        0             0     1924
##         j.NH3.bls  weights     mod
## 24725 0.008597359 0.040794 Model 5
## 24855 0.010053561 0.041372 Model 5
## 24875 0.009972634 0.039449 Model 5
## 24995 0.009046426 0.038413 Model 5
## 25045 0.009288531 0.037994 Model 5
## 25165 0.009152379 0.036822 Model 5
```

