# Get all parameter estimates

pnm <- unique(names(c(pars.cal, fixed, pp)))
pnm <- pnm[order(substr(pnm, nchar(pnm), nchar(pnm)))]

d.pars <- data.frame(row.names = pnm)

for(i in 1:length(mods)) {
    pp <- mods[[i]]$coef
    d.pars[, i] <- pp[rownames(d.pars)]
    names(d.pars)[i] <- names(mods)[i]
}

dtpars <- as.data.frame(t(d.pars))
dtpars$pmid <- rownames(dtpars)

parw <- merge(dtpars, pdat, by = 'pmid')

# Reshape 
parl <- melt(dtpars, id.vars = 'pmid', variable.name = 'par')
parl <- merge(pdat, parl, by = 'pmid')
parl <- subset(parl, par %in% names.pars.cal)

# Mod 2 pars
dtpars2 <- data.frame(par = names(mod2$coef), value = mod2$coef)
dtpars2$cal <- dtpars2$par %in% names(pars.cal)

# Combined
ps2 <- data.frame(par = names(alfam2pars02), value = alfam2pars02)
parcomp <- merge(ps2, dtpars2, by = 'par', suffixes = c('.ps2', '.cal2'), all.y = TRUE)
parcomp <- subset(parcomp, cal)
