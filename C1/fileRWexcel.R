#Import Export from/ to excel

#using excel requires additional libraries and java configuration.
#it may not work in some Laptops

library(rJava)  # install
#set this path to your java file: you will find the version of Java in location : C:\Program Files\Java
#note \\ in path : C:\Program Files\Java\jre1.8.0_221
#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_221')

library(xlsx)  #install.packages('xlsx')

mtcars
?write.xlsx
#write.xlsx(x, file, sheetName="Sheet1", col.names=TRUE, row.names=TRUE, append=FALSE, showNA=TRUE, password=NULL)

#make sure you have data folder in your repository
write.xlsx(x=mtcars, file='data/RtoExcel.xlsx', sheetName='mtcars', col.names=T, row.names=F)

dir(path='./data')  #see the files in data folder

?read.xlsx
#read data from Excel sheet if you know sheetname
data1 <- read.xlsx(file='data/RtoExcel.xlsx', sheetName='mtcars')
head(data1)
#read data from Excel sheet if you don't sheet name, but index
data2 <- read.xlsx(file='data/RtoExcel.xlsx', sheetIndex=1)
head(data2)

?write.xlsx
#store another data into the sheet. Excel file should be closed at this stage
write.xlsx(x=women, file='data/RtoExcel.xlsx', sheetName='women', col.names=T, row.names=F, append=T)
data3 <- read.xlsx(file='./data/RtoExcel.xlsx', sheetName='women')
head(data3)


#there are more features of this library : explore
#end here...