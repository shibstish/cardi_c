library(adegenet)
library(ade4)
library(vcfR)
#install.packages("hierfstat")
library(hierfstat)
x <- read.vcfR("Ccordi.maf5.vcf")
y <- vcfR2genind(x)
pops <- as.factor(c(rep("M3", 7), rep("M1", 10), rep("A2", 8), rep("M2", 7), rep("A3", 9), rep("A1", 6)))
z <- genind2hierfstat(y,pop=pops)

basic <- basic.stats(y)

overall_fst <- wc(y)

pairwise_fst <- pairwise.neifst(z,diploid=TRUE)
rownames(fst) <- c("M3", "M1", "A2", "M2", "A3", "A1")
colnames(fst) <- c("M3", "M1", "A2", "M2", "A3", "A1")

write.csv(fst, "pairwise_fst.csv")