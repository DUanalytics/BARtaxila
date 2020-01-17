#mtcars...
#pickup 5 sample values from each category of Manual & Auto cars and then find mean of each variable
library(dplyr)
library(ggplot2)
library(reshape2)

df1 = mtcars
table(df1$am)
names(df1)
catcols = c('cyl','vs','am','gear','carb')

df1[,catcols] = lapply(df1[,catcols], factor)
str(df1)

#5 rows of each data
df1a <- df1 %>% group_by(am) %>% sample_n(5)
df1b <- df1a %>% group_by(am) %>% summarise_if(is.numeric, mean, na.rm=T)
head(df1b)

df1a %>% group_by(am)  %>% summary

df1b %>% reshape2::melt(id.vars='am') %>% ggplot(., aes(x=factor(am), y=value, fill=factor(am))) + geom_bar(stat='identity') + geom_text(aes(label=value)) + facet_wrap(. ~ variable, scale='free') + labs(title='Mean Values of Variables : Categories : am=0 & 1')


#https://www.guru99.com/r-bar-chart-histogram.html
#https://rkabacoff.github.io/datavis/Bivariate.html
xtabs(formula = am ~ cyl + gear + carb + vs, data=df1, length)



#3 rows of each gear type
df2a <- df1 %>% group_by(gear) %>% sample_n(3)
head(df2a)
df2b <- df2a %>% group_by(gear) %>% summarise_if(is.numeric, mean, na.rm=T)
df2b %>% reshape2::melt(id.vars='gear') %>% ggplot(., aes(x=factor(gear), y=round(value,1), fill=factor(gear))) + geom_bar(stat='identity') + geom_text(aes(label=round(value,1))) + facet_wrap(. ~ variable, scale='free') + labs(title='Mean Values of Variables : Categories : Gears - 3,4,5')
#this is for am and gear.. similarly do it for other variables.... understand each step esp reshape...and then ggplot aes, text labels.


glimpse(df1)
plot(df1)



library(purrr)
library(tidyr)
library(ggplot2)

mtcars %>%  keep(is.numeric) %>%    gather() %>%   ggplot(aes(value)) +
  facet_wrap(~ key, scales = "free") +  geom_histogram()


#https://www.r-bloggers.com/plot-some-variables-against-many-others-with-tidyr-and-ggplot2/

library(tidyr)
mtcars %>% gather() %>% head()
#This gives us a key column with the variable names and a value column with their corresponding values. This works well if we only want to plot each variable by itself (e.g., to get univariate information).

#visualising multivariate information, with a particular focus on one or two variables. We’ll start with the bivariate case. Within gather(), we’ll first drop our variable of interest (say mpg) as follows:
  
mtcars %>% gather(-mpg, key = "var", value = "value") %>% head()
#mpg column with the values of mpg repeated for each variable in the var column. The value column contains the values corresponding to the variable in the var column. 

mtcars %>%  gather(-mpg, key = "var", value = "value") %>% ggplot(aes(x = value, y = mpg)) +  geom_point() +   facet_wrap(~ var, scales = "free") + theme_bw()
# scatter plot of every variable against mpg. 
#Extracting more than one variable
mtcars %>%   gather(-mpg, -hp, key = "var", value = "value") %>%   head()
mtcars %>%   gather(-mpg, -hp, key = "var", value = "value") %>%   ggplot(aes(x = value, y = mpg, color = hp)) +   geom_point() +   facet_wrap(~ var, scales = "free") +   theme_bw()
# change the point shape by cyl:
mtcars %>%   gather(-mpg, -hp, -cyl, key = "var", value = "value") %>%    head()
mtcars %>%   gather(-mpg, -hp, -cyl, key = "var", value = "value") %>%   ggplot(aes(x = value, y = mpg, color = hp, shape = factor(cyl))) + geom_point() +   facet_wrap(~ var, scales = "free") +   theme_bw()

mtcars %>%   gather(-mpg, key = "var", value = "value") %>%   ggplot(aes(x = value, y = mpg)) +   geom_point() +   stat_smooth() +   facet_wrap(~ var, scales = "free") +   theme_bw()



#xtab
DF <- as.data.frame(UCBAdmissions)
## Now 'DF' is a data frame with a grid of the factors and the counts
## in variable 'Freq'.
DF
## Nice for taking margins ...
xtabs(Freq ~ Gender + Admit, DF)
## And for testing independence ...
summary(xtabs(Freq ~ ., DF))

DN <- DF
DN
DN[cbind(6:9, c(1:2,4,1))] <- NA
DN
# 'na.fail' should fail :
tools::assertError(  xtabs(Freq ~ Gender + Admit, DN, na.action=na.fail))
xtabs(Freq ~ Gender + Admit, DN)
xtabs(Freq ~ Gender + Admit, DN, na.action = na.pass)
## The Female:Rejected combination has NA 'Freq' (and NA prints 'invisibly' as "")
xtabs(Freq ~ Gender + Admit, DN, addNA = TRUE) # ==> count NAs

## Create a nice display for the warp break data.
warpbreaks
warpbreaks$replicate <- rep_len(1:9, 54)
ftable(xtabs(breaks ~ wool + tension + replicate, data = warpbreaks))

ftable(gear ~ cyl, data=mtcars)
ftable(gear + am ~ cyl, data=mtcars)
ftable(gear + am ~ cyl + vs, data=mtcars)
ftable(gear + am ~ cyl + vs + carb, data=mtcars)

xtabs(gear ~ cyl, data=mtcars) #incorrect
xtabs(gear + am ~ cyl, data=mtcars) #incorrect
xtabs(~ gear + cyl, data=mtcars)
xtabs(~ gear + cyl + am, data=mtcars)
xtabs(mpg ~ gear + am, data=mtcars)
?xtabs
#On the left hand side, one may optionally give a vector or a matrix of counts; in the latter case, the columns are interpreted as corresponding to the levels of a variable. 
xtabs(cbind(gear,am) ~ cyl, data=mtcars)


ftable(xtabs(cbind(gear,am) ~ cyl, data=mtcars))

ftable(gear + am ~ cyl + vs, data=mtcars)
ftable(gear + am ~ cyl + vs + carb, data=mtcars)

table(mtcars$gear, mtcars$am, mtcars$cyl)
library(gmodels)
CrossTable(mtcars$gear, mtcars$cyl)
CrossTable(mtcars$gear, mtcars$cyl)
