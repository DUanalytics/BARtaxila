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
ggsave("graphs/multiplegraphs.pdf", arrangeGraphs, width=4, height=2, units="in", scale=3)


#go to folder and see these files
