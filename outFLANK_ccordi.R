library(vcfR)
library(OutFLANK)

obj.vcfR <- read.vcfR("Ccordi.maf5.vcf.gz")

geno <- extract.gt(obj.vcfR)

position <- getPOS(obj.vcfR)
chromosome <- getCHROM(obj.vcfR)

G <- matrix(NA, nrow = nrow(geno), ncol = ncol(geno))

G[geno %in% c("0/0", "0|0")] <- 0
G[geno  %in% c("0/1", "1/0", "1|0", "0|1")] <- 1
G[geno %in% c("1/1", "1|1")] <- 2

table(as.vector(G))

pops <- c(rep("M3", 7), rep("M1", 10), rep("A2", 8), rep("M2", 7), rep("A3", 9), rep("A1", 6))


my_fst <- MakeDiploidFSTMat(t(G), locusNames = position, popNames = pops)
head(my_fst)

plot(my_fst$He, my_fst$FST)


plot(my_fst$FST, my_fst$FSTNoCorr)
abline(0,1)


out_trim <- OutFLANK(my_fst, NumberOfSamples=47, qthreshold = 0.05, Hmin = 0.1)
str(out_trim)

head(out_trim$results)

OutFLANKResultsPlotter(out_trim, withOutliers = TRUE,
                       NoCorr = TRUE, Hmin = 0.1, binwidth = 0.001, Zoom =
                         FALSE, RightZoomFraction = 0.05, titletext = NULL)

OutFLANKResultsPlotter(out_trim , withOutliers = TRUE,
                       NoCorr = TRUE, Hmin = 0.1, binwidth = 0.001, Zoom =
                         TRUE, RightZoomFraction = 0.15, titletext = NULL)

hist(out_trim$results$pvaluesRightTail)

P1 <- pOutlierFinderChiSqNoCorr(my_fst, Fstbar = out_trim$FSTNoCorrbar, 
                                dfInferred = out_trim$dfInferred, qthreshold = 0.05, Hmin=0.1)
head(P1)


my_out <- P1$OutlierFlag==TRUE
options(scipen = 8)
plot(P1$He, P1$FST, pch=19, col=rgb(0,0,0,0.1))
points(P1$He[my_out], P1$FST[my_out], col="blue")

plot(jitter(P1$LocusName[P1$He>0.1]), P1$FST[P1$He>0.1],
     xlab="Position", ylab="FST", col=rgb(0,0,0,0.2))
points(jitter(P1$LocusName[my_out]), P1$FST[my_out], col="magenta", pch=20)  

plotting <- P1[P1$He>0.1, ]
plot_out <- plotting$OutlierFlag==TRUE
library(tidyverse)

ggplot(plotting, aes(LocusName, FST))+
  geom_jitter(aes(plotting$LocusName[plot_out], plotting$FST[plot_out]), fill = "magenta")



