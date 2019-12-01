#waffle charts

library(ggplot2)
library(dplyr)
library(waffle)
#https://github.com/hrbrmstr/waffle
#https://towardsdatascience.com/three-key-charts-for-visualizing-proportion-data-4cf58c23d513

count <- mtcars %>%   group_by(cyl) %>%   summarise(n = n()) %>%  mutate(percent = round(n/sum(n)*100))
count
(case_counts <- count$percent)
names(case_counts) <- count$cyl
case_counts
waffle(case_counts)


#-------
library(waffle)
library(magrittr)
library(hrbrthemes)
library(ggplot2)
library(dplyr)
#remotes::install_github("hrbrmstr/waffle")
library(waffle) #theme waffle
#remotes::install_github("liamgilbey/ggwaffle")
library(ggwaffle)



ggplot(data = waffle_iron(mpg, aes_d(group = class)), aes(x, y, fill = group)) +  geom_waffle() +   coord_equal()

head(mpg)
waffle_iron(mpg, aes_d(group = class))
waffle_iron(mtcars, aes_d(group=cyl))

ggplot(data = waffle_iron(mpg, aes_d(group = class)), aes(x, y, fill = group)) +  geom_waffle() +   coord_equal()
ggplot(data = waffle_iron(mtcars, aes_d(group=cyl)), aes(x, y, fill = group)) +  geom_waffle() +   coord_equal()
df = mtcars
df$cyl = factor(df$cyl)
waffle_iron(df, aes_d(group=cyl))
df$cylinder = paste0('Cylinder',df$cyl)
ggplot(data = waffle_iron(df, aes_d(group=cylinder)), aes(x, y, fill = group)) +  geom_waffle() +   coord_equal() +  theme_ipsum_rc(grid="")


#--------------
waffledata = read.csv('data/waffledata.csv')
head(waffledata)
waffledata %>% group_by(Columns) %>% tally()
ggplot(data = waffle_iron(waffledata, aes_d(group=Columns)), aes(x, y, fill = group)) +  geom_waffle() +   coord_equal() 

ggplot(data = waffle_iron(waffledata, aes_d(group=Columns)), aes(x, y, fill = group)) + ggwaffle::geom_waffle(size = 1, colour = "red", aes(fill=factor(group))) 
?geom_waffle

