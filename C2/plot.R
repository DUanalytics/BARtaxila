#base graphs in R using mtcars data set
#plots

mtcars
df = mtcars
#which columns are category type
names(df)
str(df)
#cyl, vs, am, gear, carb
catcols = c('cyl', 'vs', 'am', 'carb')
df[, catcols] = lapply(df[,catcols], factor)
str(df)
#see if the these columns are factor type ?

#plot
X=1:10
Y=11:20
plot(x=X, y=Y)
plot(x=X, y=Y, type='p') #points
plot(x=X, y=Y, type='p', pch=13) #points, plotting symbol=13
#see internet for different plotting symbols
plot(x=X, y=Y, type='p', cex=2) #points, double the size



plot(x=mtcars$wt, y=mtcars$mpg)
#Negative Relationship : wt increase, mpg reduces
?plot
#add more features
plot(x=df$wt, y=df$mpg, col=df$am)
plot(x=df$wt, y=df$mpg, col=df$cyl)
#3 colors wrt to each cyl : how to find which cylinder

plot(x=df$wt, y=df$mpg, col=df$cyl, cex=2)
plot(x=df$wt, y=df$mpg, col=df$cyl, cex=df$gear)
#using am and vs will not work for cex as they have 0 values also
plot(x=df$wt, y=df$mpg, col=df$cyl, cex=df$am) 

#formating plot
plot(x=df$wt, y=df$mpg, col=df$cyl, pch=df$gear, xlab='Weight', ylab='Mileage', main='Weight vs Mileage')
#legend for Cyl
table(df$cyl)
legend('topright',legend=c("Cyl4", "Cyl6", "Cyl8"), col=c('black','red','green'), pch=1)
#legend for Gears
table(df$gear)
legend('topleft',legend=c("Gear3", "Gear4", "Gear5"), pch=c(1,2,3))


# line, point and both
X1 = 1:10
Y1 = X1^2
plot(x=X1, y=Y1, type='p')
plot(x=X1, y=Y1, type='l', lty=2)
#https://www.datanovia.com/en/blog/line-types-in-r-the-ultimate-guide-for-r-base-plot-and-ggplot/
plot(x=X1, y=Y1, type='b', lty=2, lwd=3, col='red', cex=2)
#points & line : type=b;  linewidth=3; amplify twice, color-red
plot(x=X1, y=Y1, xlim=c(0,15), ylim=c(0,100))  #change the limits of x and y xaxis

#women dataset
women
plot(x=women$weight, y=women$height, pch=15, xlab='Weight', ylab='Height', col='red', cex=2, type='b')
title(main='Main Title', sub='Sub Title')
#see cheat sheet on base graphs

plot(women)  #picks up x and y automatically: first col is height, y is weight
abline(lm(women$weight ~ women$height), col='red', lty=2, lwd=4)   #this line is of prediction... 



#Links
#http://www.sthda.com/english/wiki/add-legends-to-plots-in-r-software-the-easiest-way


#end here
