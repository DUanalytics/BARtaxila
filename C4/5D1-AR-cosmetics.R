#AR on cosmetics

#https://storm.cis.fordham.edu/~yli/documents/CISC4631Spring15/AssociationHomework.pdf
https://storm.cis.fordham.edu/~yli/documents/CISC4631Spring17/Weka_LabTwo.pdf
https://github.com/bkrai/Top-10-Machine-Learning-Methods-With-R/blob/master/AssociationRules

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

quality(rules2)
options(scipen=2)
rules2A <- round(quality(rules2),2)
rules2A
inspect(rules2)
