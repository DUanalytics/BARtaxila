#ggplot - legend

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

p <- ggplot(df, aes(x=wt, y=mpg, color=gear)) + geom_point(size=2)
p
#position
p + theme(legend.position="top")
p + theme(legend.position="bottom")
p + theme(legend.position="none") # Remove legend
