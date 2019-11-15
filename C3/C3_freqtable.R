# Frequency Distribution

#Discrete Cat Data
(attend = c('A','P','P','A','P','A'))
table(attend)
cbind(table(attend))  # A & P on left side

#Discrete Numeric Data

color=c('Blue','Green','Magenta','Green','Black','Blue','Black')
x2 = table(color)
x2
x2a = cbind(x2)
x2a
hist(x2a)  # not relevant 
barplot(x2a)  # not good
barplot(x2a, beside=T)  # Better
unique(color) ; length(unique(color))
barplot(x2a, beside=T, col=rainbow(length(unique(color))))
pie(x2a)

#Continuous Data 
set.seed(1234)
x3 = runif(100,0,150)  # 0 to 150 marks range, 100 values 
x3
x3 = ceiling(x3)  #round to higher value
x3
range(x3)
# Divide range into step of 15 ie 10 levels
breaks = seq(0,150,by=15)
breaks
length(breaks)
x3
#x3[1] = 60; x3[2] = 75
x3.cut = cut(x3, breaks)
x3.cut
table(x3.cut)
cbind(table(x3.cut))  #see it vertically

#give intervals a character values a, b..
(x3.cut = cut(x3, breaks, labels=letters[1:10]))
#(x3.cut = cut(x3, breaks, labels=letters[1:length(breaks)-1]))
x3.cut

(x3a = table(x3.cut))
(x3b = cbind(x3a))

#extract from histogram
h1=hist(x3b)
h1$breaks
h1$counts
h1$mids

#plot these freq Table: which is better
hist(x3b)
pie(x3b)
barplot(x3b, beside=T)
barplot(x3b, beside=T, names.arg =rownames(x3b))
plot(x3b)


# and so..on like previous eg

library(fdth)
?fdth
set.seed(1234)
(x4 = trunc(rnorm(n=100, mean=50, sd=15)))
tb <- fdt(x4)
tb
plot(tb)
plot(tb, type='fh')    # Absolute frequency histogram
plot(tb, type='rfh')   # Relative frequency histogram
plot(tb, type='rfph')  # Relative frequency (%) histogram
plot(tb, type='cdh')   # Cumulative density histogram
plot(tb, type='cfh')   # Cumulative frequency histogram
plot(tb, type='cfph')  # Cumulative frequency (%) histogram

# Polygons
plot(tb, type='fp')    # Absolute frequency polygon
plot(tb, type='rfp')   # Relative frequency polygon
plot(tb, type='rfpp')  # Relative frequency (%) polygon
plot(tb, type='cdp')   # Cumulative density polygon
plot(tb, type='cfp')   # Cumulative frequency polygon
plot(tb, type='cfpp')  # Cumulative frequency (%) polygon

# Density
plot(tb,   type='d')     # Density

# Summary
tb

summary(tb)  # the same
summary(tb,  format=TRUE)
summary(tb,  format=TRUE, pattern='%05.2f')  # regular expression
#col - column no
summary(tb,  col=c(1:2, 4, 6), format=TRUE, pattern='%05.2f')
print(tb,  col=c(1:2, 4, 6))
print(tb, col=c(1:2, 4, 6),   format=TRUE,pattern='%05.2f')


#iris
plot(fdt(iris,   k=5),   col=rainbow(5))
summary(fdt(state.x77),   col=c(1:2, 4, 6),   format=TRUE)

plot(fdt(state.x77))

# Very big
summary(fdt(volcano,  right=TRUE),col=c(1:2, 4, 6),  round=3, format=TRUE,pattern='%05.1f')
#too many columns
#plot(fdt(volcano,  right=TRUE))
