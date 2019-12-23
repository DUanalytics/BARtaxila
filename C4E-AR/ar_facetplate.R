#AR - DMBA - R


link ="https://docs.google.com/spreadsheets/d/1Lt07TTh5jzbnDMgKYoQ0XLAIa-nZyNFep_Hm-owHJtU/edit#gid=1194909796"

library(gsheet)
library(arules)

fp.df = as.data.frame(gsheet2tbl(link))
head(fp.df)

fp.mat <- as.matrix(fp.df[,-1])
head(fp.mat)

fp.trans <- as(fp.mat, 'transactions')
fp.trans
arules::inspect(fp.trans)
LIST(fp.trans)

rules <- apriori(fp.trans, parameter = list(supp =.2, conf=.5, target='rules'))
arules::inspect(head(sort(rules, by='lift')))
