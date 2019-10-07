#ggplot - Density Plot
#Continous Variables

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)


ggplot(df) + geom_density(aes(x = mpg, color = gear))


#area plot
ggplot(df) + geom_density(aes(x = mpg, fill = gear), alpha = 0.2)

ggplot(df) + geom_density(aes(x = mpg, fill = gear), alpha = 0.2) + facet_grid(am ~ vs)
