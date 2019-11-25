#AR on placement Data

#sample columns for placement
#select, gender, CGPA, comskills, itskills
n=100
(select = sample(x=c('Placed', 'NotPlaced'), size=n, replace=T, prob=c(.6,.4)))
(gender = sample(x=c('M', 'F'), size=n, replace=T, prob=c(.6,.4)))
(grade = sample(x=c('A','B','C'), size=n, replace=T, prob=c(.3,.5,.2)))
table(grade)
(comskills = sample(x=c('Good','Sat','Poor'), size=n, replace=T, prob=c(.3,.5,.2)))
table(comskills)
(itskills = sample(x=c('Advanced','Basic','No'), size=n, replace=T, prob=c(.4,.4,.2)))
table(itskills)


placement = data.frame(select, gender, grade, comskills, itskills, stringsAsFactors = T)
summary(placement)

require(arules)
require(arulesViz)

placement_FI = eclat(placement, parameter= list(support=.2))
inspect(placement_FI)

placement_rules1 = apriori(placement, parameter= list(support=.1, confidence=.6, minlen=2),appearance = list(default = "lhs", rhs=c("select=Placed","select=NotPlaced")))
inspect(placement_rules)

placement_rules2 = apriori(placement, parameter= list(support=.1, confidence=.6, minlen=2),appearance = list(default = "lhs", rhs=c("select=Placed")))
inspect(placement_rules2)
