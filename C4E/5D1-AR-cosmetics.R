#AR on cosmetics

#https://storm.cis.fordham.edu/~yli/documents/CISC4631Spring15/AssociationHomework.pdf
#https://storm.cis.fordham.edu/~yli/documents/CISC4631Spring17/Weka_LabTwo.pdf
#https://github.com/bkrai/Top-10-Machine-Learning-Methods-With-R/blob/master/AssociationRules

items = c('Foundation', 'Bag', 'Blush', 'Nail.Polish', 'Brushes', 'Concealer', 'Eyebrow.Pencils', 'Lip.Liner', 'Mascara', 'Eye.shadow', 'Lip.Gloss', 'Lipstic','Eyeliner')  
length(items)
data = sample(c('Y','N'), size=100 * length(items), replace=T, prob=c(.4,.6) )
m1 = matrix(data, ncol=length(items))  
m1
dim(m1)
colnames(m1)= items
head(m1)
str(m1)
cosmetics = as.data.frame(apply(m1,2,factor))
str(cosmetics)
head(cosmetics)
summary(cosmetics)
class(cosmetics)

library(arules)
library(arulesViz)

#----
rules1 = apriori(cosmetics)
summary(rules1)  
inspect(rules1[1:5])    

rules2 = apriori(cosmetics, parameter=list(minlen=2, maxlen=3, supp=.2))
summary(rules2)  
inspect(rules2[1:5])    

rules3 = apriori(cosmetics, appearance=list(rhs=c('Foundation=Y'), default='lhs'))
inspect(rules3)

#visualise
plot(rules2)
plot(rules2, method='grouped')
plot(rules2, method='graph', control=list(type='items'))
plot(rules2,method="two-key plot")
#uses support and confidence on x and y-axis respectively. It uses order for coloring. The order is the number of items in the rule.
plot(rules2[1:5], method = "graph",  engine = "htmlwidget")
inspect(head(rules2, n=5, by="lift"))
subRules2B <- head(rules2, n=5, by="lift")
plot(subRules2B, method="paracoord")

inspect(rules2[1:5])
quality(rules2)
options(scipen=2)
rules2A <- round(quality(rules2),2)
rules2A
inspect(rules2)
inspect(sort(rules2, by = "lift")[1:5])

subset(rules2, items %in% "Blush")
#-----------
transData = as(cosmetics,'transactions')
inspect(transData)
itemFrequency(transData)
itemFrequencyPlot(transData)
itemFrequencyPlot(transData, topN=5)
itemFrequencyPlot(transData, topN=5, type='absolute')

frequentsets=eclat(transData,parameter=list(support=0.01,maxlen=10))
frequentsets
inspect(frequentsets[1:5])
rules5 = apriori(transData, parameter=list(support=.2))
inspect(rules5)
dfrules5 <- as(rules5, 'data.frame')
head(dfrules5)
inspect(transData[1:3])
image(transData[1:3])
#subset(transData, Items %in% c('Blush') )
  

#transData from Df
head(cosmetics[1:5])
items
set.seed(101)
transID = sample(1:500, 1000, replace=T)  #let there be duplicates
item = sample(items, size=1000, replace=T)

#http://www.learnbymarketing.com/1043/working-with-arules-transactions-and-read-transactions/
orders <- data.frame(transID, item)
head(orders)
write.csv(orders, file = "data/my_basket.csv", row.names = F)
order_trans <- read.transactions(file = "data/my_basket.csv",  format = "single",  sep = ",",  cols=c("transID","item"),  rm.duplicates = T, header=T)
inspect(order_trans)
itemFrequencyPlot(order_trans, topN=10)
itemFrequencyPlot(order_trans, topN=10, type='absolute')

eclat(order_trans)
freqItems = eclat(order_trans, parameter=list(support=0.01,maxlen=10))
inspect(freqItems)

rules8 = apriori(order_trans, parameter=list(support=.0025))
inspect(rules8)
plot(rules8)
plot(rules8, method='grouped')
plot(rules8, method='graph', control=list(type='items'))
plot(rules8,method="two-key plot")
#uses support and confidence on x and y-axis respectively. It uses order for coloring. The order is the number of items in the rule.
plot(rules8[1:5], method = "graph",  engine = "htmlwidget")
inspect(head(rules8, n=5, by="lift"))
subRules8B <- head(rules8, n=5, by="lift")
plot(subRules8B, method="paracoord")
