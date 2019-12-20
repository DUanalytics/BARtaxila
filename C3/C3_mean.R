#Means

#simple mean
grades <-  c(95,72,87,66)
mean(grades)

#weighted
grades <-  c(95,72,87,66)
weights <- c(1/2,1/4,1/8,1/8)

weighted.mean(x=grades, w=weights)


#missing values
grades1 <-  c(95,72,87,66, NA)
mean(grades1)
mean(grades1, na.rm=T)

#trim means
grades2 <- c(1,1,8,8,9,8,10,9,9,4)
mean(grades2)
length(grades2)

#trim x % values from each side
grades2
mean(grades2, trim=0)
mean(grades2, trim=.1)
mean(grades2[2:10-1])
mean(grades2, trim=.2)
mean(grades2[3:8])

mean(grades2, trim=.3)
mean(grades2, trim=.5)

?mean
