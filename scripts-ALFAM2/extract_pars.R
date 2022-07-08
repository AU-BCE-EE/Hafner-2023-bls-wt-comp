# Get all parameter estimates
# A and B pars are not combined

# All par names
pnm <- unique(names(c(pars.cal, fixed, pp)))
pnm <- pnm[order(substr(pnm, nchar(pnm), nchar(pnm)))]

d.pars <- data.frame(row.names = pnm)

# A mods first
for(i in 1:length(modsa)) {
    pp <- modsa[[i]]$coef
    d.pars[, i] <- pp[rownames(d.pars)]
    names(d.pars)[i] <- names(modsa)[i]
}

dtparsa <- as.data.frame(t(d.pars))
dtparsa$pmid <- rownames(dtparsa)

parwa <- merge(dtparsa, pdat, by = 'pmid')

# Reshape 
parla <- melt(dtparsa, id.vars = 'pmid', variable.name = 'par')
parla <- merge(pdat, parla, by = 'pmid')
parla <- subset(parla, par %in% names.pars.cal)

# Mod b pars
dtparsb <- data.frame(par = names(modb$coef), value = modb$coef)
dtparsb$cal <- dtparsb$par %in% names(pars.cal)

# Combined
ps2 <- data.frame(par = names(alfam2pars02), value = alfam2pars02)
parcomp <- merge(ps2, dtparsb, by = 'par', suffixes = c('.ps2', '.calb'), all.y = TRUE)
parcomp <- subset(parcomp, cal)
