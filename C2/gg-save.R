#ggplot - save

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

sapply(df, class)

(g1 <- ggplot(data=df, aes(x=mpg)) + geom_histogram(bins=5))
ggsave(filename='graphs/hist1.pdf')

(g2 <- ggplot(data=df, aes(x=cyl)) + geom_bar())
ggsave(filename='graphs/bar1.pdf')

(g3 <- ggplot(data=df, aes(x=gear, fill=gear)) + geom_bar())

#save multiple plots in one PDF file
library(gridExtra)
graphList = list(g1, g2,g3)
arrangeGraphs <- gridExtra::marrangeGrob(graphList, nrow=1, ncol=1, top = quote(paste("Graphs made using R : by Dhiraj : ", "page", g, "of", npages)))
ggsave("graphs/multiplegraphs1.pdf", arrangeGraphs, width=4, height=2, units="in", scale=3)


#go to folder and see these files

#combine base and ggplot 
(gb1 <- barplot(table(df$cyl), col=1:3))
class(gb1)
(gb2 <- hist(df$mpg, col=1:5))
(gb3 <- pie(table(df$carb)))
(gb4 <- boxplot(df$hp))

ggplotify::as.ggplot(~barplot(1:10)) +  annotate("text", x = .6, y = .5, label = "Hello Base Plot", size = 5,   color = 'firebrick', angle=45)

ggplotify::as.ggplot(~ barplot(table(df$cyl), col=1:3)) +  annotate("text", x = .6, y = .5, label = "Hello Base Plot", size = 5,   color = 'firebrick', angle=45)

ggplotify::as.ggplot(~ barplot(table(df$cyl), col=1:3))
(gc1 <- ggplotify::as.ggplot(~ barplot(table(df$cyl), col=1:3)))
(gc2 <- ggplotify::as.ggplot(~ hist(df$mpg, col=1:5)))
(gc3 <- ggplotify::as.ggplot(~ pie(table(df$carb))))
(gc4 <- ggplotify::as.ggplot(~ boxplot(df$hp)))

library(gridExtra)
graphList = list(g1, g2,g3, gc1, gc2, gc3, gc4)
arrangeGraphs <- gridExtra::marrangeGrob(graphList, nrow=1, ncol=1, top = quote(paste("Graphs made using R : by Dhiraj : ", "page", g, "of", npages)))
ggsave("graphs/multiplegraphs2.pdf", arrangeGraphs, width=4, height=2, units="in", scale=3)

