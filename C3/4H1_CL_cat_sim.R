


#----- Dummy Data -----#
# the data will be sterile clean in order to not get distracted with other issues that might arise
library(dplyr)
# ensuring reproducibility for sampling
set.seed(40)
# generating random variable set
# specifying ordered factors, strings will be converted to factors when using data.frame()
# customer ids come first, we will generate 200 customer ids from 1 to 200
id.s <- c(1:200) %>%  factor()
budget.s <- sample(c("small", "med", "large"), 200, replace = T) %>%  factor(levels=c("small", "med", "large"),  ordered = TRUE)
origins.s <- sample(c("x", "y", "z"), 200, replace = T, prob = c(0.7, 0.15, 0.15))
area.s <- sample(c("area1", "area2", "area3", "area4"), 200,  replace = T,   prob = c(0.3, 0.1, 0.5, 0.2))
source.s <- sample(c("facebook", "email", "link", "app"), 200, replace = T, prob = c(0.1,0.2, 0.3, 0.4))
## day of week - probabilities are mocking the demand curve
dow.s <- sample(c("mon", "tue", "wed", "thu", "fri", "sat", "sun"), 200, replace = T,   prob = c(0.1, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2)) %>%  factor(levels=c("mon", "tue", "wed", "thu", "fri", "sat", "sun"), ordered = TRUE)
# dish 
dish.s <- sample(c("delicious", "the one you don't like", "pizza"), 200, replace = T)

# by default, data.frame() will convert all the strings to factors
synthetic.customers <- data.frame(id.s, budget.s, origins.s, area.s, source.s, dow.s, dish.s)
head(synthetic.customers)

#----- Dissimilarity Matrix -----#
library(cluster) 
# to perform different types of hierarchical clustering
# package functions used: daisy(), diana(), clusplot()
gower.dist <- daisy(synthetic.customers[ ,2:7], metric = c("gower"))
# class(gower.dist) 
## dissimilarity , dist

# The main input for the code below is dissimilarity (distance matrix)
# After dissimilarity matrix was calculated, the further steps will be the same for all data types
# I prefer to look at the dendrogram and fine the most appealing one first - in this case, I was looking for a more balanced one - to further continue with assessment
#------------ DIVISIVE CLUSTERING ------------#
divisive.clust <- diana(as.matrix(gower.dist),  diss = TRUE, keep.diss = TRUE)
plot(divisive.clust, main = "Divisive")

#------------ AGGLOMERATIVE CLUSTERING ------------#
# I am looking for the most balanced approach
# Complete linkages is the approach that best fits this demand - I will leave only this one here, don't want to get it cluttered
# complete
aggl.clust.c <- hclust(gower.dist, method = "complete")
plot(aggl.clust.c, main = "Agglomerative, complete linkages")
