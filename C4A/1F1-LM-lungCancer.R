

#https://www.youtube.com/watch?v=66z_MRwtFJM
#https://statslectures.com/r-scripts-datasets

url = 'https://raw.githubusercontent.com/DUanalytics/datasets/master/csv/lungcancer.csv'
lungcancer = read.csv(url, header = T)
head(lungcancer)

summary(lungcancer)
names(lungcancer)
head(lungcancer)
#model relation ship Age and LungCap
plot(x=lungcancer$Age, y=lungcancer$LungCap)

m1 <- lm(LungCap ~ Age, data = lungcancer)
summary(m1)
