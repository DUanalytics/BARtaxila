#Histogram in R

women
women$height
?hist

#histogram
hist(women$height, freq=TRUE)  #3 women between 58 and 60
#no of breaks auto calculated.

hist(women$height, breaks=10)
hist(women$height, breaks=4, col=1:4)
#recycle colors if required

#histogram2
set.seed(123)
x = rnorm(100,50,100)
hist(x)

#density
hist(x, freq=FALSE, col=1:5)  #y axis - density
#.004 * 100 % = .4% values between 0-50 and so 
lines(density(x))  #line curve : is it normal : almost normal

#density plot : shape of data
plot(density(x), col='red')

#mtcars
hist(mtcars$mpg)
hist(mtcars$hp)

#end - histogram-----
