#Dendogram

#install.packages("ggdendro")
library(ggplot2)
library(ggdendro)
theme_set(theme_bw())

hc <- hclust(dist(USArrests), "ave")  # hierarchical clustering
hc

# plot

ggdendrogram(hc, rotate = TRUE, size = 2)
ggdendrogram(hc, rotate = TRUE, size = 2, leaf_labels = T)
ggdendrogram(hc, rotate = TRUE, size = 2, leaf_labels = F)
ggdendrogram(hc, rotate = TRUE, size = 2, segments = T)

ggdendrogram(hc, rotate = TRUE, size = 5, labels=T)
?ggdendrogram
