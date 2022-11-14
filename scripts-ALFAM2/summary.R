# Bootstrap results

bootsumm <- aggregate2(parlbb, 'value', by = 'par', FUN = list(mean = mean, s = sd))
