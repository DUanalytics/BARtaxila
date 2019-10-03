#Data Manipulation 
#reshape - melt, cast

library(reshape2)

df = mtcars
head(df)
df$name = abbreviate(rownames(df))
head(df)
#want data like this
#name, category, value
dfmelt <- melt(df, id.vars = 'name', variable.name = 'category', value.name = 'value')
head(dfmelt)
dfmelt
dim(dfmelt)
#11 * 32  - values - 352

#reverse : long data to wide data : dcast
dfwide <- dcast(formula=name ~ category, data = dfmelt, value.var = 'value')
head(dfwide)
head(mtcars)
#same as original ex rownames

#useful in doing group by summary and graphs

library(dplyr)
dfmelt %>% group_by(category) %>% summarise(mean(value))
dfmelt %>% filter(category %in% c('cyl','carb')) %>%  group_by(category) %>% summarise(mean(value))
