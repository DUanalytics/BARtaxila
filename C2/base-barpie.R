#bar Plot in R
#count of categories
?barplot

cylinders = table(mtcars$cyl)
barplot(height=cylinders)

barplot(height=table(mtcars$am))
barplot(height=table(mtcars$gear), col=1:3, main='No of cars of each gear type', xlab='Gear Type', ylab='Count of Cars')

barplot(height=table(mtcars$carb), col=1:5, horiz = T)

#--------------------------

#pie
x = c(10,20,40,50)
pie(x)
xlabels = c('A','B','C','D')
pie(x, labels=xlabels)

#pie on mtcars
(cylinders = table(mtcars$cyl))
pie(x=cylinders)
pie(x=cylinders, labels=c('4-Cyl','6-Cyl','8-Cyl'))
pie(x=cylinders, labels=paste(c('4-Cyl','6-Cyl','8-Cyl'),'\n', cylinders, ' cars', sep='-')) #'\n' wraps the output


#end
