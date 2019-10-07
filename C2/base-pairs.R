#Pairs Plot
#shows correlation between variables

#correlation plot
cor(women$height,women$weight)
pairs(women)
#is the relation between height and women + or - : Positive

#mtcars
numCols = c('mpg','wt','hp','disp')
head(mtcars[numCols])
cor(mtcars[numCols])
pairs(mtcars[numcols])
options(digits=2)  #limit no of digits of decimal to 2 places
cor(mtcars[numCols])
pairs(mtcars[numcols])



#useful in statistical analysis
