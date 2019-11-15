#Clustering

#https://data-flair.training/blogs/clustering-in-r-tutorial/

#Author DataFlair
library(tidyverse)
library(cluster)
library(factoextra) #vis
library(gridExtra)
data('USArrests') 
df <- USArrests
df <- na.omit(df)  #Removing the missing values
df <- scale(df)
head(df)


kmeans2 <- kmeans(df, centers = 2, nstart = 25)
str(kmeans2)
fviz_cluster(kmeans2, data = df)


#------------
kmeans3 <- kmeans(df, centers = 3, nstart = 25)  #DataFlair
kmeans4 <- kmeans(df, centers = 4, nstart = 25)  
kmeans5 <- kmeans(df, centers = 5, nstart = 25)  
#Comparing the Plots
plot1 <- fviz_cluster(kmeans2, geom = "point", data = df) + ggtitle("k = 2")
plot2 <- fviz_cluster(kmeans3, geom = "point", data = df) + ggtitle("k = 3")
plot3 <- fviz_cluster(kmeans4, geom = "point", data = df) + ggtitle("k = 4")
plot4 <- fviz_cluster(kmeans5, geom = "point", data = df) + ggtitle("k = 5")
grid.arrange(plot1, plot2, plot3, plot4, nrow = 2)


#https://uc-r.github.io/kmeans_clustering
#output of kmeans
# cluster: A vector of integers (from 1:k) indicating the cluster to which each point is allocated.
# centers: A matrix of cluster centers.
# totss: The total sum of squares.
# withinss: Vector of within-cluster sum of squares, one component per cluster.
# tot.withinss: Total within-cluster sum of squares, i.e. sum(withinss).
# betweenss: The between-cluster sum of squares, i.e. $totss-tot.withinss$.
# size: The number of points in each cluster.

df %>%  as_tibble() %>%  mutate(cluster = kmeans2$cluster,         state = row.names(USArrests)) %>%  ggplot(aes(UrbanPop, Murder, color = factor(cluster), label = state)) +  geom_text()


#optimal no of clusters
set.seed(123)

# function to compute total within-cluster sum of square 
wss <- function(k) {
  kmeans(df, k, nstart = 10 )$tot.withinss
}
wss
# Compute and plot wss for k = 1 to k = 15
k.values <- 1:15

# extract wss for 2-15 clusters
(wss_values <- map_dbl(k.values, wss))

plot(k.values, wss_values,     type="b", pch = 19, frame = FALSE, xlab="Number of clusters K",   ylab="Total within-clusters sum of squares")

#Fortunately, this process to compute the “Elbow method” has been wrapped up in a single function (fviz_nbclust):
set.seed(123)
fviz_nbclust(df, kmeans, method = "wss")
#----------------------
# function to compute average silhouette for k clusters
avg_sil <- function(k) {
  km.res <- kmeans(df, centers = k, nstart = 25)
  ss <- silhouette(km.res$cluster, dist(df))
  mean(ss[, 3])
}

# Compute and plot wss for k = 2 to k = 15
k.values <- 2:15

# extract avg silhouette for 2-15 clusters
avg_sil_values <- map_dbl(k.values, avg_sil)

plot(k.values, avg_sil_values,
     type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of clusters K",
     ylab = "Average Silhouettes")

#Similar to the elbow method, this process to compute the “average silhoutte method” has been wrapped up in a single function (fviz_nbclust):
fviz_nbclust(df, kmeans, method = "silhouette")


#cluster Gap
#The gap statistic compares the total intracluster variation for different values of k with their expected values under null reference distribution of the data (i.e. a distribution with no obvious clustering). The reference dataset is generated using Monte Carlo simulations of the sampling process.  and generate values for the n points uniformly from the interval min to max.
# compute gap statistic
set.seed(123)
gap_stat <- clusGap(df, FUN = kmeans, nstart = 25,  K.max = 10, B = 50)
# Print the result
print(gap_stat, method = "firstmax")

#We can visualize the results with fviz_gap_stat which suggests four clusters as the optimal number of clusters.

fviz_gap_stat(gap_stat)


## Compute k-means clustering with k = 4
set.seed(123)
final <- kmeans(df, 4, nstart = 25)
print(final)
fviz_cluster(final, data = df)
USArrests %>%  mutate(Cluster = final$cluster) %>%   group_by(Cluster) %>%  summarise_all("mean")


#K-means clustering is a very simple and fast algorithm. Furthermore, it can efficiently deal with very large data sets. However, there are some weaknesses of the k-means approach.
#One potential disadvantage of K-means clustering is that it requires us to pre-specify the number of clusters. Hierarchical clustering is an alternative approach which does not require that we commit to a particular choice of clusters. Hierarchical clustering has an added advantage over K-means clustering in that it results in an attractive tree-based representation of the observations, called a dendrogram. 
#An additional disadvantage of K-means is that it’s sensitive to outliers and different results can occur if you change the ordering of your data. The Partitioning Around Medoids (PAM) clustering approach is less sensititive to outliers and provides a robust alternative to k-means to deal with these situations. 