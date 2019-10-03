#read / write Data - from/to File

#make sure you have a folder : data in your project directory
#like c1, c2, c3, c4, c5

mtcars  #inbuilt datasets
data()  #other datasets - opens in another tab

?write.csv
write.csv(x=mtcars, file='data/mtcars1.csv')
write.csv(x=mtcars, file='data/mtcars2.csv', row.names = F)
#save it data folder all csv files


#read--------------------

newmtcars1 = read.csv(file='data/mtcars1.csv')
head(newmtcars1)
newmtcars2 = read.csv(file='data/mtcars2.csv')
head(newmtcars2)
#no car names
newmtcars1A = read.csv(file='data/mtcars1.csv', row.names = 1)
head(newmtcars1A)
#with rownames


#webCSV---------
url1 = "https://raw.githubusercontent.com/DUanalytics/BARtaxila/master/data/taxilaUsers.csv"
taxila = read.csv(file=url1)
head(taxila)

#no saving to web directly

#googlesheets

url2 = "https://docs.google.com/spreadsheets/d/1Md_ro2t3M7nA9JMH1DsE12jfeX7qq-UPw6p8WQd6A2Y/edit#gid=216113907"
#url of gsheet
library(gsheet)

denco = as.data.frame(gsheet2tbl(url2))
head(denco)

#cannot store to public read only gsheets unless you setup google apps authentication

#other types can also be used
#eg excel, STATA, SAS 
#preferred CSV files only
