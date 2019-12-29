#split

g <- airquality$Month
g
l <- split(airquality, g)
l
l <- lapply(l, transform, Oz.Z = scale(Ozone))
l
aq2 <- unsplit(l, g)

head(aq2)

with(aq2, tapply(Oz.Z,  Month, sd, na.rm = TRUE))


### Split a matrix into a list by columns
ma <- cbind(x = 1:10, y = (-4:5)^2)
ma
class(ma)
split(ma, col(ma))
?split

split(1:10, 1:2)
split(as.matrix(mtcars),col(mtcars))
split(as.matrix(iris), col(iris))
