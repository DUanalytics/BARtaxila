#box Plot
#used for continuous values to depict 5 number summary

mtcars
summary(mtcars$mpg)
quantile(mtcars$mpg)

#box plot with line showing mean of mpg 
boxplot(x=mtcars$mpg)
abline(h=mean(mtcars$mpg))

#box plot with lines showing quantile values of mpg 
boxplot(x=mtcars$mpg, col='green')
abline(h=quantile(mtcars$mpg))  

quantile(mtcars$mpg)
qvalues = c(10, 20, 30)
#box plot with lines showing user defined points
boxplot(x=mtcars$mpg, col='yellow')
abline(h=qvalues, col=1:3)  
#specifying col 1 to 3 : maps to R colours

