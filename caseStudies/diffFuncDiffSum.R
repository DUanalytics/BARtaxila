#Different Functions for different columns

library(dplyr, warn.conflicts = F)

library(tidyverse)

df <- tribble(
  ~category,   ~x,  ~y,  ~z,
  #----------------------
  'a',      4,   6,   8,
  'a',      7,   3,   0,
  'a',      7,   9,   0,
  'b',      2,   8,   8,
  'b',      5,   1,   8,
  'b',      8,   0,   1,
  'c',      2,   1,   1,
  'c',      3,   8,   0,
  'c',      1,   9,   1
)
df
df %>% group_by(category) %>% summarize(  x=mean(x),  y=median(y),z=first(z))

df %>%   group_by(category) %>%  summarize_at(vars(x, y), list(min, max))

library(purrr)  #little complicated to understand
list(c("x"), c("y")) %>%   map2(lst(min = min, max = max), ~ df %>% group_by(category) %>% summarise_at(.x, .y)) %>%   reduce(inner_join)
#fist you select some column to apply function in a list, you map them to a list of same length with the different functions you want and it will apply respectively in .x and .y in summarize_at. At then end, you combine the result in a data.frame by joining (reduce apply a function on a list)

df %>%  group_by(category) %>%   summarise_all(list(mean, median, first))

df %>%  group_by(category) %>% summarise_all(list(~min(.), ~max(.)))
df %>%  group_by(category) %>% summarise_all(list(MIN2= min, MAX2 = max))
df %>%  group_by(category) %>% summarise_all(list(med = median))
df %>%  group_by(category) %>% summarise_all(list(Q3 = quantile), probs = c(0.75))
df %>%  summarise_at(vars(x:z), mean, na.rm = TRUE)
df %>%  summarise_if(is.numeric, mean, na.rm = TRUE)
df %>%  summarise_at(c("x", "y"), mean, na.rm = TRUE)
df %>%  group_by(category) %>% summarise_at(c("x", "y"), mean, na.rm = TRUE)



#----
# if there is only one unnamed function, the names of the input variables are used to name the created columns
# if there is only one unnamed variable, the names of the functions are used to name the created columns.
# otherwise in the most general case, the created names are created by concatenating the names of the input variables and the names of the functions.

#https://dplyr.tidyverse.org/reference/summarise_all.html


#---
mydata = mtcars
summarise(mydata, mpg_mean=mean(mpg),mpg_median=median(mpg))
summarise_at(mydata, vars(mpg, hp), funs(n(), mean, median))
mydata %>% summarise_at(vars(mpg, hp), funs(n(), mean, median))
summarise_if(mydata, is.numeric, funs(n(),mean,median))
summarise_all(mydata,funs(n(),mean,median))

mydata2 <- iris
summarise_all(mydata2["Species"], funs(nlevels(.), nmiss=sum(is.na(.))))

mydata2 <-iris # windows function in R using Dplyr mydata2 %>% select(Species,Sepal.Length) %>%

iris %>% group_by(Species) %>%  filter(min_rank(desc(Sepal.Length))<=5)
#What are the top 5 sepal lengths based on the species?
#another rank function called ‘dense_rank()

head(mutate(mydata2, sepal_length_width_ratio=Sepal.Length/Sepal.Width))
head(mutate_all(mydata2[,-5], funs("percent"= ./100)))
head(mutate_at(mydata2, vars(Sepal.Length,Sepal.Width), funs(Rank=min_rank(desc(.)))))


# grouping column after summarise columns
names(mtcars)
mtcars %>% group_by(gear) %>% summarise_at(3:4, mean)
# grouping columns before summarise columns
mtcars %>% group_by(cyl) %>% summarise_at(3:4, mean)
# actual third & fourth columns
names(mtcars)[3:4]

mtcars %>% group_by(cyl) %>% summarise_at(.vars = colnames(.)[3:4], mean)

mtcars %>% group_by(cyl) %>% summarise_at(.vars = names(.)[3:4] , mean)

mtcars %>% mutate_all(as.numeric)

mydata1 <- mtcars
mydata1 %>% rename_all(~gsub("_", ".", .x))  #replace all _ with .
mydata1 %>% summarise_all(n_distinct)

mydata1 %>% rename(mileage = mpg)  #all columns after renaming
mydata1 %>% select(mileage = mpg)  #only 1 column
mydata1 %>% rename(mileage = mpg, HorsePower = hp)  #all columns after renaming

library(stringr)
names(mydata1)
mydata1 %>% rename_at(vars(starts_with("d")), funs(str_replace(., "d", "Data")))

mydata1 %>% rename_if(is.numeric, funs(str_replace(., "d", "Number")))

mydata2 = mydata[,1:4]
names(mydata2)
mydata2 <- mydata2 %>% `colnames<-`(c("Mileage 1", "cyl inder 2", "displ-3", "HP?4"))
head(mydata2)
library(janitor)
mydata2 %>%   clean_names() %>% head()
gsub("[[:punct:]]","",make.names(names(mydata2)))
#http://www.rebeccabarter.com/blog/2019-01-23_scoped-verbs/


mydata1 %>% select(-starts_with("m"), -starts_with("d")) %>% head()
mydata1 %>% select(c(mpg, cyl)) %>% head()
mydata1 %>% select(-c(mpg, cyl)) %>% head()
mydata1 %>% select(1:2) %>% head()
mydata1 %>% select(seq(1,11,2)) %>% head()
mydata1 %>% select(1:5) %>% head()
mydata1 %>% select(-(1:5)) %>% head()
mydata1 %>% select(1:5,10) %>% head()

mydata1 %>% mutate(carname = row.names(.)) %>% head()

mydata1 %>% distinct() %>% nrow()
mydata1 %>% distinct(cyl) %>% nrow()
mydata1 %>% distinct(cyl, .keep_all = T)
mydata1 %>% distinct(cyl,gear, .keep_all = T)
mydata1 %>% pull(mpg)
mydata1 %>% select(contains("isp")) %>% head()
mydata %>%  select(gear, everything()) %>% head()



mydata1 %>%  summarise_at(vars(mpg),function(x) { sum((x - mean(x)) / sd(x)) })
# Sort by ascending age and print top 10
mydata1 %>%  arrange(mpg) %>% head()
mydata1 %>%  arrange(desc(mpg)) %>% head()
# Sort by descending age and print top 10
mydata1 %>%  mutate_if(is.numeric,funs(new = (. * 1000))) %>%  head()

df=mtcars
# Create ID variable which will be used as the primary key
df <- df %>%
  mutate(ID = seq(1:nrow(df))) %>%
  select(ID, everything())
df
# Create two tables (purposely overlap to facilitate joins)
table_1 <- df[1:25 , ] %>%  select(ID, mpg, hp)
table_2 <- df[12:32 , ] %>%  select(ID, wt, gear)

# Left join joins rows from table 2 to table 1 (the direction is implicit in the argument order)
left_join(table_1, table_2, by = "ID")

# Right join joins rows from table 1 to table 2
right_join(table_1, table_2, by = "ID")

# Inner join joins and retains only complete cases
inner_join(table_1, table_2, by = "ID")

# Full join joins and retains all values
full_join(table_1, table_2, by = "ID")
