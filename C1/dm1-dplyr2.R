#dplyr - mtcars - Advanced

df1 = mtcars # make a copy and do analysis on df
head(df1)
str(df)
#what ways we can have summary

# convert relevant cols to factor (can be ordered also)
factorcols = c('cyl','vs', 'am', 'gear', 'carb')

library(dplyr)

df1 %>% mutate_all(funs(x+3))

df1 %>% mutate_at(is.numeric, funs(mean))

df1 %>% tibble::add_column(carSer=1:32)
df1 %>% count(gear)
df1 %>% count(gear, sort=T)
df1 %>% add_count(gear) #add another column of its gear count



?add_count
