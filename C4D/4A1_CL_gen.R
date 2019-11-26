#Clustering - grouping data
#based on similarities
#distance between two points
library(ggplot2)
library(dplyr)

dist(c(60,50))
#-----------
sub1 = c(60, 50, 90, 80, 82)
dist(sub1)
#-------------
library(distances) #library
distances(sub1)
d1 = distances(sub1)
distance_matrix(d1, indices = NULL)
#searches for the data point furthest from a set of query points
max_distance_search(d1)
# Columns in this matrix indicate queries, and rows are ordered by distances from the query.
#1 is farthest from 3rd, 2nd also from 3rd, 3rd from 2nd, 4th from 2nd, 5th from 2nd
#---------------
d1
sub1 #data points
sub1[c(1,4)] #1st and 4th data indices
nearest_neighbor_search(distances=d1, k=1, query_indices = c(1,4))
#1 nearest neigbour of indices 1 & 4 
#60 is closed to 60, 80 is closest to 80 (itself)
#--------------
nearest_neighbor_search(distances=d1, k=2, query_indices = c(1,4))
#2 nearest neigbour of indices 1 & 4 
#60 is closest to 60 &50 ; 80 is closest to 80 & 82
#---------------
nearest_neighbor_search(distances=d1, k=3, query_indices = c(1,4))
#3 nearest neigbour of indices 1 & 4 
sub1
#60 is closest to 60,50,80 ; 80 is closest to 80,82,90
#------------------------
nearest_neighbor_search(distances=d1, k=2)
#2 nearest points of each indices
nearest_neighbor_search(distances=d1, k=3)
#3 nearest points of each indices
#-------------------

#group data into 2 parts

# Euclidean distances in only one dimension
#df with 2 columns x  &  y
my_data_points <- data.frame(x = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), y = c(10, 9, 8, 7, 6, 6, 7, 8, 9, 10))
my_data_points

# Euclidean distances in only one dimension
(my_distances2x <- distances(my_data_points, dist_variables = "x"))
(my_distances2y <- distances(my_data_points, dist_variables = "y"))

# Euclidean distances
(my_distances1 <- distances(my_data_points))

#euclidean distance
# 5 students with marks in 2 subjects x & y
x = c(60, 50, 90, 80, 82)
y = c(65, 75, 80, 76, 50)
(marks = data.frame(x, y))
#one subject
dist(marks$x)
dist(marks)  #how is this calculated
#distance of 2nd student marks with 1st
marks[1:2,]
(s21 = sqrt((60-50)^2 + (65-75)^2))
dist(marks) # 14.14
marks[3:4,]
(s34 = sqrt((90-80)^2 + (80-76)^2))
(s43 = sqrt((80-90)^2 + (76-80)^2))  #same
dist(marks) # 10.77
#now we know how distances are calculated : this method is euclidean
#there are other methods - Cosine, Jacquard...
#----------
library(fields)  #another package
marks
rdist(marks)

#now lets scale that data
x1 = c(60, 50, 90, 80, 82)
y1 = c(400, 300, 200, 450, 170)
marks1 = data.frame(x1, y1)
dist(marks1)
#marks of y1 may have more effect when calculating distances, hence scale data
(marks1scaled = scale(marks1)) # z scale : -3 to +3
dist(marks1scaled)

#lets perform clustering with / without scaling

k1 = kmeans(marks1, centers=2)
k1$cluster
k1$centers
cbind(marks1, cluster=k1$cluster)

k1S = kmeans(marks1scaled, centers=2)
k1S$cluster
cbind(marks1scaled, cluster=k1S$cluster)
#see the difference in grouping of 3rd row
cbind(marks1, marks1scaled, C1=k1$cluster,C1S=k1S$cluster)
plot(marks1$x1, marks1$y1, pch=16, fill=k1$cluster,cex=2)
g1 <- ggplot(marks1, aes(x=x1, y=y1, color=k1$cluster)) + geom_point() + geom_point(size=5) 
g1
(centers1 = as.data.frame(k1$centers))  #ggplot needs Df
g1 + geom_point(data= centers1, aes(x=x1, y=y1, color=k1$cluster), size=52, alpha=.3, show.legend = F)

#links
#https://cran.r-project.org/web/packages/distances/distances.pdf
#http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r