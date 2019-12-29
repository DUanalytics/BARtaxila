#split apply combine
#https://ramnathv.github.io/pycon2014-r/explore/sac.html

library(dplyr)

df = mtcars

df %>% filter(hp > 100) %>% tally()

aggregate(formula = mpg ~ cyl + vs, data = mtcars, FUN = mean, subset = (hp >= 100))

#data to be in matrix
apply(df, 1, sum)
apply(df, 2, sum)

#lapply applies a function to each element of a list
my_list <- list(a = 1:10, b = 2:20)
my_list
lapply(my_list, mean)
df_list <- split(as.matrix(df),col(df))
lapply(df_list, mean)
#sapply is a more user friendly version of lapply and will return a list of matrix where appropriate. 
sapply(df_list, mean)

#mapply Its more or less a multivariate version of sapply
list_1 <- list(a = c(1:10), b = c(11:20))
list_1
list_2 <- list(c = c(21:30), d = c(31:40))
list_2
mapply(sum, list_1$a, list_1$b, list_2$c, list_2$d)

iris_list = split(as.matrix(iris[,-5]),col(iris[,-5]))
mapply(sum, df_list$`1`, df_list$`2`) #length should be sampe
mapply(sum, iris_list$`2`, iris_list$`3`)

#by
by(iris[, 1:2], iris[, "Species"], sum)


#Split-Apply-Combine: II
#Recall that the core idea behind the split-apply-combine strategy is to
#split up the original data (this can be any format includng data.frames, lists, arrays, matrics, vectors),
#apply existing or custom functions to it, and
#combine the results in the same or different format.
#https://ramnathv.github.io/pycon2014-r/explore/sac2.html

library(plyr)
resultB <- ddply(subset(df, hp >= 100), .(cyl, vs), summarize, mileage = sum(mpg)
)
resultB
resultC <- ddply(df, .(gear), summarize, HP = sum(hp))
resultC
df
df %>%  group_by(gear) %>%  dplyr::summarize(HP = sum(hp)) %>%  arrange(desc(HP)) %>%  head(5)


library(data.table)
df_DT <- data.table(df)
df_DT[,list(HP = sum(hp)),"gear"][ head(order(-HP), 5),]



#plyr
split(df, list(df$gear, df$am))

sum1 <- dlply(df, .(gear, am), sum)
sum1
ldply(sum1)

#dlply takes a data frame and returns a list, and ldply does the opposite: It takes a list and returns a data frame.
#a*ply(.data, .margins, .fun, ..., .progress = "none")
#d*ply(.data, .variables, .fun, ..., .progress = "none")
#l*ply(.data, .fun, ..., .progress = "none")

adply(df, 1:2, function(x) x/100)
ddply(df, 1:2, function(x) x/100)
ldply(df, function(x) x/100)

#Arrays are sliced by dimension in to lower-d pieces: a*ply().
#Data frames are subsetted by combinations of variables: d*ply().
#Each element in a list is a piece: l*ply()
#.margins = 1: Slice up into rows.
#.margins = 2: Slice up into columns.
#.margins = c(1,2): Slice up into individual cells
#.(var1) will split the data frame into groups defined by the value of the var1 variable.If you use multiple variables, .(a, b, c), the groups will be formed by the interaction of the variables, and output will be labelled with all three variables.
#use functions of variables: .(round(a)), .(a * b). : .(product = a * b).