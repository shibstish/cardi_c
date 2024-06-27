library(magrittr)
library(vegan)
library(ade4)
# read in the Fst file; modify path as needed
f <- read.csv("pairwise_Fsts.csv")

# read in the environmental variables file (we will come back to this); modify path as needed
env.data <- read.csv("climaticVariables.csv")

# formatting the data; linearizing fst

x <- data.frame(pops = character(),A1=numeric(), A2 = numeric(), A3 = numeric(), M1 = numeric(), M2 = numeric())

for (i in 1:nrow(f)){
  for (j in 2:ncol(f)){
    x[i,j] <- f[i,j]/(1-f[i,j])
  }
}
x$pops <- NULL
rownames(x) <- c("A2", "A3", "M1", "M2", "M3")

x2 <- na.omit(data.frame(unlist(x)))

# put everything in a big data frame
m=as.matrix(x)
names=append(colnames(m),'M3')
xy <- as.data.frame(t(combn(names, 2)))
xy$fst = NA
count=0
lim=0
for(j in 1:ncol(m)){
  lim=lim+1
  for(i in lim:nrow(m)){
    count=count+1
    xy[count,]$fst=m[i,j] 
  }}

# environmental data!
#JB: not coercing to dataframe
temp_dist <- dist(env.data$Trange, method = "euclidean")
precip_dist <- dist(env.data$Precip, method = "euclidean")
vpd_dist <- dist(env.data$VPDrange, method = "euclidean")
solar_dist <- dist(env.data$SolarRad, method = "euclidean")
ele_dist <- dist(env.data$elevation, method = "euclidean")

xy$temp_dist = as.vector(unlist(temp_dist))
xy$precip_dist = as.vector(unlist(precip_dist))
xy$vpd_dist = as.vector(unlist(vpd_dist))
xy$solar_dist = as.vector(unlist(solar_dist))
xy$ele_dist = as.vector(unlist(ele_dist))

numbers=xy[,3:ncol(xy)]
xy$mahalanobis <- mahalanobis(numbers, colMeans(numbers), cov(numbers))

#This test is structured to mirror the isolation by distance analysis
#this is therefore a mantel test
#force mahalanobis into distance matrix
D=matrix(nrow=5,ncol=5)
rownames(D) <- c("A2", "A3", "M1", "M2", "M3")
colnames(D) = c("A1","A2", "A3", "M1", "M2")
D[,1]=xy[1:5,]$mahalanobis
D[2:5,2]=xy[6:9,]$mahalanobis
D[3:5,3]=xy[10:12,]$mahalanobis
D[4:5,4]=xy[13:14,]$mahalanobis
D[5,5]=xy[15,]$mahalanobis

#mantel test
mantel(xdis = D, ydis = x, method = "spearman",      permutations = 9999, na.rm = TRUE) 

#correlations of all env. variables, if one is curious
library(corrplot)
newnums=(xy[,3:ncol(xy)])
corrplot(newnums, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)

