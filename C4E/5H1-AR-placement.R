#AR on Placement Data

#Load Libraries 
library(arules)
library(arulesViz)
library(ggplot2)
library(dplyr)
library(xlsx)
library(scales)
library(gsheet)
options(digits=2)

glink ="https://docs.google.com/spreadsheets/d/1TL6uKWH7Iss1fr29jB51PvfAHVyalL_MbmF4s5zRcUE/edit#gid=1345871940"

data = as.data.frame(gsheet2tbl(glink))
head(data)

summary(data)
sapply(data, class)

#Discterize-----
#convert to category: cgpa, placementtest, salary numeric values
head(data[, c('cgpa', 'placementtest', 'salary')])
data$CGPA <- discretize(data$cgpa, method='fixed', breaks=c(0,5,8,10), labels=c('Poor','Average','Good'))
data$placementGrade <- discretize(data$placementtest, method='frequency', labels=c('Low','Medium','High'))
data$salLevel <- discretize(data$salary, method='fixed', breaks=c(0,5,8,20), labels=c('Low','Medium','High'))
head(data[, c('cgpa','CGPA','placementtest', 'placementGrade', 'salary', 'salLevel')])
head(data)
str(data)
data2 <- data %>% select(-c('rollno','cgpa','placementtest', 'salary'))
names(data2)
sapply(data2, class)
data2 <- lapply(data2, as.factor)
class(data2)
data2 <- data %>% filter(OO == 'N' & HS == 'N') %>% select(-c(rollno, cgpa, salary,OO, HS, placementtest))
sapply(data2, class)  #check all to be category
class(data2)
data2 <- data2 %>%  mutate_if(sapply(data2, is.character), as.factor)
#data ready for AR

#Visualisation------
ggplot(data2, aes(x=sdiscipline, fill=select)) + geom_bar(stat='count', position=position_stack()) + geom_text(stat='count', aes(label=..count..), position=position_stack(), size=rel(3), vjust=1) + ggtitle('Selection Status for Placement Drive') + facet_grid( ~ scampus, scales = 'free') + coord_flip()


#-------
#convert to transaction format
data3 <- as(data2, 'transactions')

#frequent itemsets
fset1 <- eclat(data3, parameter= list(support=.04), control=list( verbose=F))
fset1
inspect(fset1[1:10])

#write.xlsx(as(fset1[1:50],'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'fset1', append=T)

fset1b <- eclat(data3, parameter= list(support=.04, minlen=4, maxlen=6), control=list( verbose=F))
fset1b
inspect(fset1b[1:4])
#write.xlsx(as(fset1b,'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'fset1b', append=T)

#itemfrequency  & plot
itemFrequency(data3)
#write.xlsx(t(itemFrequency(placementData3)), 'data/placement.xlsx',row.names = F, sheetName = 'itemfreq1', append = T)

itemFrequencyPlot(data3, type = "absolute", topN=10, main='Item Frequency(Absolute) Plot : top 10 items')
itemFrequencyPlot(data3, type = "relative", topN=10, main='Item Frequency(Relative) Plot : top 10 items')
select.placed <- data3[data3 %ain% "select=Placed"]
select.placed
inspect(select.placed)
itemFrequencyPlot(select.placed, topN=5)
## plot with the averages of the population plotted as a line (for first 72 variables/items)
itemFrequencyPlot(x=select.placed,population = data3, topN=7, main='Dotted Line- Population Proportion; Bars- for Placed Students ')
itemFrequencyPlot(select.placed,  population = data3, support = 0.12, lift = TRUE, horiz = F, topN=7, popLwd=2)
#The lift ratio is gives how many times an item is more frequent in x than in population.
#Only display items which have a support of at least support.

#create Rules
apriori(data3, parameter= list(support=.15, confidence=.6, minlen=2, maxlen=6))

rules1 <- apriori(data3, parameter= list(support=.15, confidence=.6, minlen=2, maxlen=6), control=list( verbose=F))

summary(rules1)
inspect(rules1[1:5])
labels(rules1[1:5])
rules1
#write.xlsx(as(rules1[1:50], 'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'rules1', append = T)
inspect(sort(rules1, by='confidence')[1:5])
inspect(sort(rules1, by='lift')[1:5])
inspect(sort(rules1, by='support')[1:5])
as(sort(rules1, by='lift')[1:10], 'data.frame')

#subset rules
inspect(rules1)
rules1S1 <- subset(rules1, subset = lhs %pin% c("techskills=") & rhs %in% "select=Placed")
inspect(rules1S1[1:5])
#write.xlsx(as(rules1S1, 'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'rules1S1', append = T)

rules1S2 <- subset(rules1, subset = lhs %pin% c("techskills=") | lhs %in% c('comskills=Good') & rhs %in% "select=Placed" & confidence > .8 & lift > 1 )
inspect(rules1S2) #sometimes there may no rules 
#write.xlsx(as(rules1S2, 'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'rules1S2', append = T)

#save rules
dfRules = data.frame(  lhs = labels(lhs(rules1)),  rhs = labels(rhs(rules1)),   rules1@quality)
head(dfRules); dim(dfRules)
#write.xlsx(dfRules[1:20,], 'data/placement.xlsx',row.names = F, sheetName = 'dfRules', append = T)

#rule1 X->Y with confidence cf1;  rule2 X' -> Y with confidence cf2 where X' is a subset of X
#rule1 is said to be redundant if rule2 has a higher confidence than rule1 i.e cf2 > cf1 (where X' is a subset of X)
inspect(sort(rules1, by='support')[1:5])
#library(rJava)
#redundant rules
rules1
#is.redundant(rules1)
sum(is.redundant(rules1))
rules1[!is.redundant(rules1)]
inspect(rules1[!is.redundant(rules1)][1:5])
NRrules = rules1[!is.redundant(rules1)]
NRrules  #redundant
inspect(NRrules[1:5])

#write.xlsx(as(NRrules[1:50],'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'NRrules', append = T)

inspect(subset(NRrules, subset = rhs %in% 'select=Placed'))
inspect(subset(NRrules, subset = rhs %in% 'select=NotPlaced'))
inspect(subset(NRrules, subset = rhs %pin% 'Placed'))
inspect(subset(NRrules, subset = rhs %in% 'salLevel=Medium'))
inspect(subset(NRrules, subset = items %in% c('placementGrade=High')))
inspect(subset(NRrules, subset = lhs %ain% c("techskills=Average")))
inspect(subset(NRrules, subset = items %in% c("CGPA=Good") & items %in% c("itskills=Good")))
inspect(subset(NRrules, subset = lhs %pin% c('CGPA=Good') & rhs %pin% c('Placed')))

#Plot Placed Rules

#visualising Placed Rules (RHS)
placedrules <- subset(NRrules, subset = rhs %in% 'select=Placed')
placedrules ; length(placedrules)
rulesgraph = placedrules[seq(1,length(placedrules),2)]
inspect(rulesgraph)
plot(rulesgraph, pch=24, bg='black', lwd=2, cex=1) # plot of 3 measures 
plot(rulesgraph, pch=24, cex=2, measure = c("support", "lift"), shading = "confidence")
plot(rulesgraph, pch=24, measure = c("confidence", "lift"), shading = "support")
plot(rulesgraph, pch=24, method = "two-key plot", cex=3)
#plot(placedrules[20:32], method = "matrix", measure = "lift")#not here
#plot(placedrules[20:32], method = "matrix3D", measure = "lift") #error
plot(rulesgraph, method = "grouped")
plot(rulesgraph, method = "grouped", control = list(k = 50))
plot(rulesgraph, method="graph", control=list(type="items"))
plot(rulesgraph, method="paracoord", control=list(reorder=TRUE))
plot(rulesgraph, method="grouped")
onerule = rulesgraph[10]
inspect(onerule)
plot(onerule, method = "doubledecker", data = data3)
plot(onerule, method="paracoord", control=list(reorder=TRUE))
plot(onerule, method="graph", control=list(type="items"))
inspect(rulesgraph[1:10])


#Create Rules for RHS=Placed only------------
#rhs=Placed------
placedrules <- apriori (data=data3, parameter=list (supp=0.2,conf = 0.7), appearance = list (default="lhs",rhs="select=Placed"), control = list (verbose=F)) 
placedrules
inspect(placedrules)
#rhs=NotPlaced------
notplacedrules <- apriori (data=data3, parameter=list (supp=0.05,conf = 0.4), appearance = list (default="lhs",rhs="select=NotPlaced"), control = list (verbose=F)) 
notplacedrules
inspect(notplacedrules)
#interestMeasure(notplacedrules, c("support", "chiSquare", "confidence", "conviction", "cosine", "coverage", "leverage", "lift", "oddsRatio"), sPlacement3)
#write.xlsx(as(placedrules,'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'placedrules', append = T)
#write.xlsx(as(notplacedrules,'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'notplacedrules', append = T)

rules5a <- DATAFRAME(placedrules, separate = TRUE, setStart = '', itemSep = ' + ', setEnd = '')
#write.xlsx(as(rules5a ,'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'rules5a ', append = T)
rules5b <- DATAFRAME(notplacedrules, separate = TRUE, setStart = '', itemSep = ' + ', setEnd = '')
#write.xlsx(as(rules5b ,'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'rules5b ', append = T)


#visualisation
plot(notplacedrules, jitter=1)
plot(notplacedrules[1:5], method="graph", control=list(type="items"))
plot(notplacedrules[1:5], method="paracoord", control=list(reorder=TRUE))
plot(notplacedrules[1:5], method="grouped", control=list(k=50))
plot(notplacedrules[1:5], method="matrix", measure=c("confidence"))
#plot(notplacedrules[1:5], method="matrix3D")
#visualise-----
#subset of rules with Placed Students
placedT <- subset(data3 , items %in% "select=Placed")
itemFrequencyPlot(placedT, topN = 25, population = data3, cex.names=.8, type='absolute')
#dotted lines show for full poplulation, bars for current subset
itemFrequencyPlot(placedT, topN = 25, population = data3, lift=TRUE, cex.names=.8)
#positive, neutral or negative correlation


labels(notplacedrules)
labels(placedrules)

#length of rules-----
#rhs=NotPlaced with 5 parameters
ruleslength <- apriori (data=data3, parameter=list (supp=0.05,conf = 0.6,minlen=5), appearance = list (default="lhs",rhs="select=NotPlaced")) 
inspect(ruleslength)
labels(ruleslength)
#write.xlsx(as(ruleslength ,'data.frame'), 'data/placement.xlsx',row.names = F, sheetName = 'ruleslength ', append = T)
DATAFRAME(ruleslength, separate = TRUE, setStart = '', itemSep = ' + ', setEnd = '')

#try on Groceries data set
#end here---
