#clustering - mixed data type
#https://www.r-bloggers.com/clustering-mixed-data-types-in-r/


#the publicly available “College” dataset found in the ISLR package will be used, which has various statistics of US Colleges from 1995 (N = 777). To highlight the challenge of handling mixed data types, variables that are both categorical and continuous will be used and are listed below:
##Continuous
#Acceptance rate
#Out of school tuition
#Number of new students enrolled
##Categorical
#Whether a college is public/private
#Whether a college is elite, defined as having more than 50% of new students who graduated in the top 10% of their high school class

set.seed(1680) # for reproducibility

library(dplyr) # for data cleaning
library(ISLR) # for college dataset
library(cluster) # for gower similarity and pam
library(Rtsne) # for t-SNE plot
library(ggplot2) # for visualization

head(College)
#Before clustering can begin, some data cleaning must be done:
#Acceptance rate is created by diving the number of acceptances by the number of applications
#isElite is created by labeling colleges with more than 50% of their new students who were in the top 10% of their high school class as elite
college_clean <- College %>%  mutate(name = row.names(.), accept_rate = Accept/Apps,  isElite = cut(Top10perc,  breaks = c(0, 50, 100), labels = c("Not Elite", "Elite"), include.lowest = TRUE)) %>% mutate(isElite = factor(isElite)) %>% select(name, accept_rate, Outstate, Enroll, Grad.Rate, Private, isElite)

glimpse(college_clean)

#------
# Remove college name before clustering

gower_dist <- daisy(college_clean[, -1],  metric = "gower",type = list(logratio = 3))
gower_dist
# Check attributes to ensure the correct methods are being used
# (I = interval, N = nominal)
# Note that despite logratio being called, 
# the type remains coded as "I"

summary(gower_dist)


gower_mat <- as.matrix(gower_dist)

# Output most similar pair

college_clean[which(gower_mat == min(gower_mat[gower_mat != min(gower_mat)]), arr.ind = TRUE)[1, ], ]

# Output most dissimilar pair

college_clean[  which(gower_mat == max(gower_mat[gower_mat != max(gower_mat)]),arr.ind = TRUE)[1, ], ]
