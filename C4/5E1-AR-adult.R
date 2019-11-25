#AR - 
#https://rdrr.io/cran/arules/man/Adult.html
library(arules)

#Data in transcation Format
data("AdultUCI")
head(AdultUCI)
names(AdultUCI)

#The AdultUCI data set contains the questionnaire data of the “Adult” database (originally called the “Census Income” Database) formatted as a data.frame. The Adult data set contains the data already prepared and coerced to transactions for use with arules.
summary(AdultUCI)
#--------------------------
#data in transcation format
data("Adult")
head(Adult)
inspect(Adult[1:3])

#Using the association rules we see for example that
# (1) if a person earns more than $50000 he is very likely to be a married man with large number of years of education;
# (2) single parents, younger than 25 years, who studied less than 10 years, and were never-married make less than $50000.

#verify this
options(digits=2)
frequentItems = eclat(Adult, parameter= list(support=.2))
inspect(frequentItems[1:5])
adultRules1 = apriori(Adult, parameter= list(support=.4, confidence=.8, minlen=2))
inspect(adultRules1[1:5])

#https://mathematicaforprediction.wordpress.com/2014/03/30/classification-and-association-rules-for-census-income-data/