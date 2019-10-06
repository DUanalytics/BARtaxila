#read / write Data : R to - from/to File (CSV, TXT, XLSX...)
#data can read into R from many file types : most common is CSV

#make sure you have a folder : data in your project directory
#like c1, c2, c3, c4, c5 , data

mtcars  #inbuilt datasets
data()  #other datasets - opens in another tab
CO2

?write.csv
write.csv(x=mtcars, file='data/mtcars1.csv')
write.csv(x=mtcars, file='data/mtcars2.csv', row.names = F)
#save it data folder all csv files

#excel : save to CSV  : explain
#one sheet at a time : excel to CSV : not full sheet
#read--------------------

newmtcars1 = read.csv(file='data/mtcars1.csv')
head(newmtcars1)
newmtcars2 = read.csv(file='data/mtcars2.csv')
head(newmtcars2) #no car names


#webCSV---------
#this csv file is part of repository in csv format you can see it here...
#https://github.com/DUanalytics/BARtaxila/blob/master/data/taxilaUsers.csv
url1 = "https://raw.githubusercontent.com/DUanalytics/BARtaxila/master/data/taxilaUsers.csv"
taxila = read.csv(file=url1)
head(taxila)

#no saving to web directly

#googlesheets
#make sure the google sheet is public sharing ON
#https://docs.google.com/spreadsheets/d/1Md_ro2t3M7nA9JMH1DsE12jfeX7qq-UPw6p8WQd6A2Y/edit#gid=216113907  # you can copy this url and open in browser to see data
url2 = "https://docs.google.com/spreadsheets/d/1Md_ro2t3M7nA9JMH1DsE12jfeX7qq-UPw6p8WQd6A2Y/edit#gid=216113907"
#url of gsheet
library(gsheet)  #install this library first
denco = as.data.frame(gsheet2tbl(url2))
options(scipen = 99)
head(denco)

#cannot store to public read only gsheets unless you setup google apps authentication

#Read from TextFile : deliimted by space
?read.table
faculties = read.table(file='data/textData.txt', sep='',header=T)
#sepearator is space, columnames is first row
faculties

#create text file from R Studio and add few rows and columns
#last row should end with enter key 
student = read.table(file='data/student.txt', header=T)
student

#other types can also be used #eg excel, STATA, SAS 
#preferred CSV files only

#summary
mtcars
# using data folder
write.csv(x=mtcars, file='data/mtcars5a.csv',row.names = F)
data5a = read.csv(file='data/mtcars5a.csv')
head(data5a)
#Without using data folder
women
write.csv(x=women, file='women5b.csv', row.names = F)
data5b = read.csv(file='women5b.csv')
head(data5b)
#end here