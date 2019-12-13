#Quality
#https://cran.r-project.org/web/packages/clickR/clickR.pdf
#library(HH)
library(clickR)

check_quality(airquality$Ozone) #For one variable
lapply(airquality, check_quality) #For a data.frame
lapply(mtcars, check_quality)
lapply(airquality, check_quality, output=TRUE) #For a data.frame, one row per variable


cluster_var(iris)
cluster_var(mtcars)

descriptive(iris)
descriptive(iris, by="Species")
df = mtcars
df[,c('gear','cyl')] = lapply(df[,c('gear','cyl')], factor)

descriptive(df, by='gear')

#extreme_values(df$mpg, n = 3)
report(df)

#Data frame in wide format
df1 <- data.frame(id = 1:4, age = c(20, 30, 30, 35), score1 = c(2,2,3,4),  score2 = c(2,1,3,1), score3 = c(1,1,0,1))
df1
#Data frame in long format
forge(df1, affixes= c("1", "2", "3"))
#Data frame in wide format with two repeated measured variables
df2 <- data.frame(df1, var1 = c(15, 20, 16, 19), var3 = c(12, 15, 15, 17))
df2
#Missing times are filled with NAs
forge(df2, affixes = c("1", "2", "3"))
#Use of parameter force.fixed
df3 <- df2[, -7]
df3
forge(df3, affixes=c("1", "2", "3"))
forge(df3, affixes=c("1", "2", "3"), force.fixed = c("var1"))


data(infert)
head(infert)
GK_assoc(infert$education, infert$case)
GK_assoc(infert$case, infert$education) #Not the same

ipboxplot(Sepal.Length ~ Species, data=iris)
ipboxplot(mpg ~ gear, data=mtcars)

#clickR::kurtosis(x=df$mpg)

make_csv_table(x=df, file='data/mtcars6', info='footer')

make_word_table(x=df, file='data/mtcarsword', info = NULL, use.rownames = TRUE)

mine.plot(airquality) #Displays missing data
mine.plot(airquality, what="x>mean(x)+2*sd(x) | x<mean(x)-2*sd(x)") #Shows extreme values

#moda(x=df$wt)

mtapply(mtcars, mtcars$gear, mean)
mtapply(mtcars, c(mtcars$cyl), mean)

nice_names(dat=df)
names(df)
d <- data.frame('Variable 1'=NA, '% Response'=NA, ' Variable 3'=NA,check.names=FALSE)
d
names(d)
names(nice_names(d))  #remove blanks in col names

peek(iris)
peek(mtcars)
#prop_may(x=df$cyl, ignore.na = TRUE)

report(iris) #Report of descriptive statistics
lm1 <- lm(Petal.Length ~ Sepal.Width + Species, data=iris)
report(lm1) #Report of model

report(iris)
(reporTable<-report(iris, by="Species"))
class(reporTable)

report(x=df$cyl)


lm1 = lm(mpg ~ wt + hp, data=df)
report(lm1)
rob.ci(x=lm1, level = 0.95, maxit = 200, R = 2000)

#scale_01(x=df)

df$mpg %<NA% df$hp
6 %<NA% 7
6 %<NA% NA
5 %<NA% 8
