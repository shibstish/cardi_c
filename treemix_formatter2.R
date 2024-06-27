library(dartR)
library(adegenet)

# For use after removing missing data and sites in high LD (bash scripts/on Kamiak) and pre-formatting/merging the files with scripts in ipynb (treemix_formatter/merger)
# The point of this code: to add an outgroup (if missing) and to put into the proper file-type for Treemix

df = read.csv('Ccordi_4tm.txt') # read in the file. 

df2 <- df[ ,c(5:51)] # select only the columns with data; columns 1-4 are CHROM/POS/REF/ALT

outgroup <- rep(0.0, nrow(df2)) # create the outgroup; if you already have an outgroup, hash this out

df2 <- cbind(outgroup, df2) # add the outgroup to the dataframe

df2 <- apply(df2, MARGIN = 2,  FUN = as.numeric) # For some reason the columns were not numeric (?), so this is fixing that. MARGIN argument tells R to iterate over the columns; 1 would iterate over the rows



tf2 <- t(df2) # transpose the dataframe so that individuals are rows and SNPs are columns

## serial conversions to get it into a treemix object
# Create a population array to feed into new("genlight", ...); this is the grouping parameter

pops = c("outgroup",rep("M3", 7), rep("M1",10), rep('A2',8), rep('M2',7), rep('A3',9), rep('A1',6)) #population names; replace with appropriate names
#reg = c("outgroup", rep('West',10), rep('East',7), rep('Central',8), rep('Central',7), rep('East',9), rep('West',6)) #regions
#band = c("outgroup", rep("montane",10), rep("montane", 7), rep("alpine", 8), rep("montane", 7), rep("alpine", 9), rep("alpine", 6)) #elevation band

x1 <- new("genlight", tf2, ploidy = 2,  pop = pops)
# make sure the new genlight object is compliant
# each compliance check and the results of that check will be printed to the console. 
gl.compliance(x1)

# if all goes well, you can now convert to a treemix file.
gl2treemix(x1, outfile = "Ccordi_4treemix.gz", outpath = "TreeMix/")

