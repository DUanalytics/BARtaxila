#Clustering
#grouping data based on distance

#--------

marks1 = c(10,12,20, 25, 67,75,80)
df1 = data.frame(marks1)
df1
row.names(df1) = c('A','B','C','D','E','F','G')
df1
k3 = kmeans(df1, centers=3)
k3
k3$cluster
cbind(df1, k3$cluster)
#
k2 = kmeans(df1, centers=2)
k2$cluster
cbind(df1, k2$cluster)
#
df1$marks2 = c(50,60, 70, 30, 50,30,60)
df1
sqrt((10-12)^2 + (50-60)^2) #10.19
k2B = kmeans(df1, centers = 2)
cbind(df1, k2B$cluster)

dist(df1)


#-----------------------
#kmeans-----
head(iris)
data = iris[,-5]
head(data)

irisk3 = kmeans(data, centers=3)
irisk3
(c=irisk3$cluster)
head(data)
data2 <- cbind(data, c, iris[,5])
head(data2)
data2

library(factoextra)
fviz_cluster(irisk3, data=data)

#hierarchical clustering
head(data)
distiris = dist(data)
distiris
hc = hclust(distiris)
plot(hc)  #individual points like org tree

hc3 <- cutree(hc, k=3)  # clusters 3
hc3  #which point goes to which cluster

#make 3 clusters
plot(hc)
rect.hclust(hc, k = 3, border = 2:4)

plot(hc)
rect.hclust(hc, k = 5, border = 2:6)


#heighr of h=5
plot(hc)
rect.hclust(hc, h = 5, border = 2:4)

#height of length 3
plot(hc)
rect.hclust(hc, h = 3, border = 2:4)
