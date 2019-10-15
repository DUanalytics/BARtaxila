#bar Plot in R
#count of categories
library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

lapply(df, class)

?barplot

cylinders = table(df$cyl)
barplot(height=cylinders)

barplot(height=table(df$am))
barplot(height=table(df$gear), col=1:3, main='No of cars of each gear type', xlab='Gear Type', ylab='Count of Cars')

barplot(height=table(df$carb), col=1:5, horiz = T)

#--------------------------
#simple Bar
# Simple Bar Plot
counts <- table(df$gear)
barplot(counts, main="Car Distribution",xlab="Number of Gears")
# Simple Horizontal Bar Plot with Added Labels
counts <- table(df$gear)
barplot(counts, main="Car Distribution", horiz=TRUE, names.arg=c("3 Gears", "4 Gears", "5 Gears"))

# Grouped Bar Plot -----
counts <- table(df$vs, df$gear)
barplot(counts, main="Car Distribution by Gears and VS",  xlab="Number of Gears", col=c("darkblue","red"),  legend = rownames(counts), beside=TRUE)

# Stacked Bar Plot with Colors and Legend ----
counts <- table(df$vs, df$gear)
barplot(counts, main="Car Distribution by Gears and VS", xlab="Number of Gears", col=c("darkblue","red"),  legend = rownames(counts))

# Fitting Labels------
par(las=2) # make label text perpendicular to axis
par(mar=c(5,8,4,2)) # increase y-axis margin.

counts <- table(df$gear)
barplot(counts, main="Car Distribution", horiz=TRUE, names.arg=c("3 Gears", "4 Gears", "5   Gears"), cex.names=0.8, col=levels(df$gear))

#pie
x = c(10,20,40,50)
pie(x)
xlabels = c('A','B','C','D')
pie(x, labels=xlabels)


#pie on mtcars
(cylinders = table(df$cyl))
pie(x=cylinders)
pie(x=cylinders, labels=c('4-Cyl','6-Cyl','8-Cyl'))
pie(x=cylinders, labels=paste(c('4-Cyl','6-Cyl','8-Cyl'),'\n', cylinders, ' cars', sep='-')) #'\n' wraps the output


#end
