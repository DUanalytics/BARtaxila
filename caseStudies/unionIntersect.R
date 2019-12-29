#union

library(dplyr)
#Create two data frames

df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Oven", 3), rep("Television", 3)))
df2 = data.frame(CustomerId = c(4:7), Product = c(rep("Television", 2), rep("Air conditioner", 2)))
df1
df2

#  union two dataframes  without duplicates
union(df1,df2)

#  union two dataframes  with duplicates
union_all(df1,df2)

#  intersect two dataframes  
intersect(df1,df2)

#  difference of two dataframes  
setdiff(df1,df2)
