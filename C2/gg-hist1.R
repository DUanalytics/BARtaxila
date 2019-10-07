#ggplot - Histogram Plot
#Continous Variables
df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)


#width of bin : each mpg value : 10, 11,...
ggplot(df,aes(x=mpg)) +  stat_bin(binwidth=1) + ylim(c(0, 12)) +    stat_bin(binwidth=1, geom="text", aes(label=..count..), vjust=-1.5) 
#width of each bin : 5 mpg ie: 10-15,15-20 ..
ggplot(df,aes(x=mpg)) +  stat_bin(binwidth=5)  +stat_bin(binwidth=5, geom="text", aes(label=..count..), vjust=-1.5) 

#color of bar as per count
ggplot(data=df, aes(mpg)) +  geom_histogram(breaks=seq(10, 50, by=5),  col="red",  aes(fill=..count..)) +  scale_fill_gradient("Count", low="green", high="red") + stat_bin(geom='text', aes(label=..count..), breaks=seq(10, 50, by=5)) +  geom_histogram(aes(y =..density..), breaks=seq(10, 50, by = 5),  col="red", fill="green", alpha=.2) + geom_density(col=2)


#regression line
ggplot(df, aes(wt, mpg)) +geom_count() + geom_smooth(method="lm", se=F)


#
# overlap density and histogram: scale of density and count is different
ggplot(df, aes(x = mpg)) +  geom_histogram(aes(y = ..density..),    binwidth = 5, color = "grey30", fill = "white") +  geom_density(alpha = .2, fill = "antiquewhite3") + stat_bin(geom='text', aes(label=..count..), binwidth = 5)


#histogram and density
#base
hist(df$mpg, freq=F)
lines(density(df$mpg))

#gg
ggplot(df) + geom_histogram(aes(x = mpg))
ggplot(df) + geom_histogram(aes(x = mpg), binwidth = 5, fill = "grey", color = "black")
#hist with density y scale
gd1 <- ggplot(df) + geom_histogram(aes(x = mpg, y=..density..), binwidth = 5, fill = "grey", color = "black")
gd1
#density
gd1 + geom_density(aes(x = mpg), color = "red") 
#rug
gd1 + geom_rug(aes(x = mpg, y = 0, color=carb), position = position_jitter(height = 0))
                            