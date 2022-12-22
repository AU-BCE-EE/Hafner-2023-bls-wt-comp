---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "21 December, 2022"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '2.10'
```

Parameter values.


```r
ALFAM2pars02
```

```
##            int.f0    app.mthd.os.f0    app.rate.ni.f0         man.dm.f0 
##       -0.60568338       -1.74351499       -0.01114900        0.39967070 
## man.source.pig.f0    app.mthd.cs.f0            int.r1    app.mthd.bc.r1 
##       -0.59202858       -7.63373787       -0.93921516        0.79352480 
##         man.dm.r1       air.temp.r1        wind.2m.r1    app.mthd.ts.r1 
##       -0.13988189        0.07354268        0.15026720       -0.45907135 
## ts.cereal.hght.r1         man.ph.r1            int.r2      rain.rate.r2 
##       -0.24471238        0.66500000       -1.79918546        0.39402156 
##            int.r3    app.mthd.bc.r3    app.mthd.cs.r3         man.ph.r3 
##       -3.22841225        0.56153956       -0.66647417        0.23800000 
## incorp.shallow.f4 incorp.shallow.r3    incorp.deep.f4    incorp.deep.r3 
##       -0.96496655       -0.58052689       -3.69494954       -1.26569562
```

# Add app.rate.ni

All application was by trailing hose (or manual)


```r
idat$app.rate.ni <- idat$app.rate
```

Run model 

With set 2 parameters


```r
d.pred2 <- alfam2(as.data.frame(idat), app.name = 'tan.app', time.name = 'cta', group = 'pmid')
```

```
## Default parameters (Set 2) are being used.
```

```
## Warning in alfam2(as.data.frame(idat), app.name = "tan.app", time.name = "cta", : Running with 12 parameters. Dropped 12 with no match.
## These secondary parameters have been dropped:
##   app.mthd.os.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   app.mthd.bc.r1
##   app.mthd.ts.r1
##   ts.cereal.hght.r1
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
## 
## These secondary parameters are being used:
##   int.f0
##   app.rate.ni.f0
##   man.dm.f0
##   int.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   man.ph.r3
```


