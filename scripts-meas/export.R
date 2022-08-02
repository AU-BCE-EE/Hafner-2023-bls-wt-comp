
isumm <- rounddf(as.data.frame(isumm), digits = 3, func = signif)
write.csv(isumm, '../output/int_summ.csv', row.names = FALSE)
