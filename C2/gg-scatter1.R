#ggplot - Scatter Plot
#Continuous Variables : Single or Pair

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

sapply(df, class)

plot(df$wt, df$mpg)

plot(df$wt, df$mpg, col='red', cex=2)
plot(df$wt, df$mpg, col='red', cex=2, pch=24)
?plot



#ggplot
library(ggplot2)
ggplot(df, aes(x = drat, y = mpg)) +   geom_point()

ggplot(df, aes(x = mpg, y = drat)) + geom_point(aes(color = gear))

ggplot(df, aes(x = wt, y = mpg)) +  geom_point(aes(color = gear)) +  stat_smooth(method = "lm",  col = "#C42126",  se = FALSE,   size = 1)
ggplot(df, aes(x = wt, y = mpg)) +  geom_point(aes(fill = cyl), shape=23) +  stat_smooth(aes(group=gear, color=gear), method = "lm",  col = "#C42126",  se = FALSE,   size = 1)

ggplot(df, aes(x = wt, y = mpg)) +  geom_point(aes(fill = cyl), shape=23) +  stat_smooth(aes(group=gear, color=gear), method = "lm",  col = "#C42126",  se = FALSE,   size = 1) + facet_grid(. ~ gear)

ggplot(df, aes(x = wt, y = mpg, fill=gear)) +  geom_point(shape=25, size=4) 
