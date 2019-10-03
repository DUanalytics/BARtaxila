#basic functions in R
#----Various Functions in R----

# str()- Compactly display the internal structure of an R object. 
# names()- Names of elements within an object
# class()- Retrieves the internal class of an object/dataset.
# mode()- Get or set the type or storage mode of the dataset/object.
# length()- Retrieves the no. of elements in a dataset/object.
# dim()- Retrieve or set the dimension of the dataset/object.
# attributes()- Gives col & row names of the dataset/object.
# head()- Gives top 6 rows of the dataset.
# tail()- Gives bottom 6 rows of the dataset.
# View()- View dataset in seperate tab like excel.
# mean()- Average of all the numbers. 
# median()- The "middle" value in the list of numbers.
# quantile()- Gives quartiles of the dataset. 
# summary()- Gives the min, max & quartile values corresponding to each column of the dataset.


mtcars
?mtcars  #help of inbuilt dataset

mtcars #print dataset
View(mtcars) #View data in new tab
str(mtcars) #structure of dataset
dim(mtcars)#dimensions of dataset
class(mtcars)#class - DF here
attributes(mtcars) #col and rownames and other attributes of data
names(mtcars) #colnames
colnames(mtcars) #colnames
rownames(mtcars) #rownames

head(mtcars) #top 6 rows 
tail(mtcars) #bottom 6 rows
head(mtcars,n=3) #top 3 rows
dim(mtcars)  #dimensions of DF 32 rows, 11 columns
NROW(mtcars)  #no of rows
nrow(mtcars)  #no of rows
length(mtcars) #variables nos
mtcars$mpg  #one column of dataset (DF)
length(mtcars$mpg)  #length of the vector
summary(mtcars)  #default summary of dataset
ncol(mtcars) #matrix : no of cols
