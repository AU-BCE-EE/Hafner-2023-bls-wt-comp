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
#parla <- subset(parla, par %in% names.pars.cal)

# Mod b pars
names.pars.cal <- names(pars.cal)
dtparsb <- data.frame(par = names(modb$coef), value = modb$coef)
dtparsb$cal <- dtparsb$par %in% names(pars.cal)

# Combined pars 02 and b
ps2 <- data.frame(par = names(alfam2pars02), value = alfam2pars02)
parcomp <- merge(ps2, dtparsb, by = 'par', suffixes = c('.ps2', '.calb'), all = TRUE)
parcompcal <- subset(parcomp, cal)
parcomp <- rounddf(parcomp, digits = 2)
parcomp <- parcomp[order(substr(parcomp$par, nchar(parcomp$par)-2, nchar(parcomp$par))), ]

# Bootstrap results for b
d.pars <- data.frame(row.names = names(pars.cal))
for(i in 1:length(modbboot)) {
    pp <- modbboot[[i]]$mod$par
    d.pars[, i] <- pp[rownames(d.pars)]
    names(d.pars)[i] <- i
}

dtparsbboot <- as.data.frame(t(d.pars))
dtparsbboot$iteration <- rownames(dtparsbboot)

# Reshape 
parlbb <- melt(dtparsbboot, id.vars = 'iteration', variable.name = 'par')

# Add wt/bLS column
parlbb$meas.tech <- ifelse(grepl('bLS', parlbb$par), 'bLS', ifelse(grepl('wt', parlbb$par), 'wt', 'all'))

# Get primary parameter
parlbb$ppar <- gsub('.+\\.([fr][0-3])$', '\\1', parlbb$par)
parlbb$var <- gsub('(.+)\\.([fr][0-3])$', '\\1', parlbb$par)
