#ggplot - Area

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

g1 <- ggplot(df, aes(x=mpg))
# Basic area plot
g1 + geom_area(stat = "bin")

# y axis as density value
g1 + geom_area(aes(y = ..density..), stat = "bin")

# Add mean line
g1 + geom_area(stat = "bin", fill = "lightblue")+ geom_vline(aes(xintercept=mean(mpg)), color="blue", linetype="dashed", size=1)

#bar & area
#bar
ggplot(df, aes(x = mpg, fill = am)) + geom_bar(stat = "bin", bins=10)
# Area plot
ggplot(df, aes(x = mpg, fill = am)) + geom_area(stat = "bin", bins=10) + scale_fill_brewer(palette="Dark2") 
