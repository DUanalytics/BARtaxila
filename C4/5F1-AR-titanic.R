#AR - Titanic Data set


load("data/titanic.raw.rdata")
titanic_r <- titanic.raw

titanic_r[1:3,]
table(titanic_r$Age,titanic_r$Survived)
require(arules)

class(titanic_r)
head(titanic_r)
rule <- apriori(titanic_r[2:4], parameter=list(minlen=2, supp=0.001, conf=0.001),  appearance = list(default = "lhs", rhs=c("Survived=Yes","Survived=No")))
rule
inspect(rule)

require('arulesViz')
sort.rule <- sort(rule, by="lift")
plot(sort.rule, method="graph", control=list(nodeCol="red", edgeCol="blue"))

#-------
rule1 <- apriori(titanic_r[2:4],  parameter=list(minlen=2, supp=0.001, conf=0.001), appearance = list(lhs=c("Age=Child","Age=Adult"), rhs=c("Survived=Yes")))
inspect(rule1)
sort.rule1 <- sort(rule1, by="lift")
inspect(sort.rule1)
plot(sort.rule1)

plot(sort.rule1, method="graph", control=list(nodeCol="red", edgeCol="blue"))

plot(sort.rule1, method="grouped", control=list(col=2))


#http://rstudio-pubs-static.s3.amazonaws.com/422248_eddf9a24935d4c6486e79087db598467.html
