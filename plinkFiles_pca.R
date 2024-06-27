pca=read.table("Ccordi.maf5.pca.eigenvec")
pca <- pca[, 2:8]
colnames(pca) <- c("ind", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6")
population <- c(rep("M3", 7), rep("M1", 10), rep("A2", 8), rep("M2", 7), rep("A3", 9), rep("A1", 6))
population <- as.factor(population)
pca$pops <- population

library(plotly)
library(viridisLite)

pca.val=read.table("Ccordi.maf5.pca.eigenval")

total <- sum(pca.val)

one = 100*round(pca.val[1,]/total,4)
two = 100*round(pca.val[2,]/total,4)
three = 100*round(pca.val[3,]/total,4)
oneand = paste(one, "%")
twoand = paste(two, "%")
threeand = paste(three, "%")

twoD2 <- ggplot(pca, aes(x=PC1, y=PC2)) + 
  theme_bw() +
  geom_point(aes(color=population)) +
  xlab(paste("[PC1: ",oneand,"]")) +
  ylab(paste("[PC2: ",twoand,"]")) +
  scale_colour_manual(values=c('darkmagenta','forestgreen','blue3','deeppink','chartreuse1','turquoise3'))

twoD3 <- ggplot(pca, aes(x=PC1, y=PC3)) + 
  theme_bw() +
  geom_point(aes(color=population)) +
  xlab(paste("[PC1: ",oneand,"]")) +
  ylab(paste("[PC3: ",threeand,"]")) +
  scale_colour_manual(values=c('darkmagenta','forestgreen','blue3','deeppink','chartreuse1','turquoise3'))

twoD23 <- ggplot(pca, aes(x=PC2, y=PC3)) + 
  theme_bw() +
  geom_point(aes(color=population)) +
  xlab(paste("[PC2: ",twoand,"]")) +
  ylab(paste("[PC3: ",threeand,"]")) +
  scale_colour_manual(values=c('darkmagenta','forestgreen','blue3','deeppink','chartreuse1','turquoise3'))



fig3 <- plot_ly(pca, x = ~PC1, y = ~PC2, z = ~PC3, color = ~population, size =2, colors = c('darkmagenta','forestgreen','blue3','deeppink','chartreuse1','turquoise3'))
fig3 <- fig3 %>% add_markers()
fig3 <- fig3 %>% layout(scene = list(xaxis = list(title = paste('PC1 ',oneand)),
                                     yaxis = list(title = paste('PC2 ',twoand)),
                                     zaxis = list(title = paste('PC3' ,threeand))))
#show 3D plot
fig3
