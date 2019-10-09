#ggplot - GUI
library(dplyr)
library(ggplot2)
df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

sapply(df, class)

library(esquisse)
library(ggplot2)

ggplot(data = df) +  aes(x = factor(cyl)) +  geom_bar(fill = "#0c4c8a") +  theme_minimal()


esquisse::esquisser()
library(ggplot2)

ggplot(data = df) + aes(x = hp, y = mpg) +  geom_point(color = "#0c4c8a") +   geom_smooth(span = 0.75) +  theme_minimal()

ggplot(data = df) +  aes(x = hp, y = mpg, color = factor(am), size = carb) +  geom_point() +  geom_smooth(span = 0.96) +  scale_color_discrete(c('red','blue')) +  theme_minimal()


#https://cran.r-project.org/web/packages/esquisse/index.html
#https://cran.r-project.org/web/packages/esquisse/esquisse.pdf
