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



#useful in statistical analysis

