
library(dplyr)

mydata2 <- iris
mydata2 %>%  rowwise() %>% mutate(row_max= max(Sepal.Length:Petal.Width))


#ntile The ntile() function is used to divide the data into N bins. 
mydata1 <- mtcars
mutate(mydata1, quantile_rank = ntile(mydata1$mpg,4))
mutate(mydata1, decile_rank = ntile(mydata1$mpg,10))
mutate(mydata1, percentile_rank = ntile(mydata1$mpg,100))
mutate(mydata1, perc_rank = ntile(mydata1$mpg,100))  %>% arrange(mpg)

?rowwise
#https://www.r-bloggers.com/useful-dplyr-functions-wexamples/