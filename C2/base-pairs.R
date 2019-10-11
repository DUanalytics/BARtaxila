#Pairs Plot
#shows correlation between variables

#correlation plot
cor(women$height,women$weight)
pairs(women)
#is the relation between height and women + or - : Positive

#mtcars
numCols = c('mpg','wt','hp','disp')
df=mtcars
head(df[,numCols])
cor(df[,numCols])
pairs(df[,numCols])
options(digits=2)  #limit no of digits of decimal to 2 places
cor(df[,numCols])
pairs(df[, numCols])


pairs(df[ , numCols],  col = "red",  # Change color
      pch = 18,              # Change shape of points
      labels = numCols,      # Change labels of diagonal
      main = "This is a nice pairs plot in R")  

#useful in statistical analysis


#https://statisticsglobe.com/r-pairs-plot-example/
