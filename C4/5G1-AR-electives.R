#AR on Electives

#sample columns for electives
#elective1, elective2, elective3, elective4, discipline
n=100
(subjects = c('Java','C++', 'PHP', 'DotNet','Python','R','MySql', 'Oracle')); length(subjects)

(elective1 = sample(x=subjects[1:2], size=n, replace=T, prob=c(.6,.4)))
(elective2 = sample(x=subjects[3:4], size=n, replace=T, prob=c(.6,.4)))
(elective3 = sample(x=subjects[5:6], size=n, replace=T, prob=c(.4,.6)))
(elective4 = sample(x=subjects[7:8], size=n, replace=T, prob=c(.5,.5)))
(finalgrades = sample(x=c('A','B','C'), size=n, replace=T, prob=c(.4,.4,.2)))

subjects = data.frame(elective1, elective2, elective3, elective4, finalgrades, stringsAsFactors = T)
summary(subjects)

require(arules)
require(arulesViz)

subjects_FI = eclat(subjects, parameter= list(support=.2))
inspect(subjects_FI)

subjects_rules1 = apriori(subjects, parameter= list(support=.1, confidence=.4, minlen=2),appearance = list(default = "lhs", rhs=c("finalgrades=A","finalgrades=B")))
inspect(subjects_rules1)

subjects_rules2 = apriori(subjects, parameter= list(support=.1, confidence=.4, minlen=2),appearance = list(default = "lhs", rhs=c("finalgrades=A")))
inspect(subjects_rules2)
