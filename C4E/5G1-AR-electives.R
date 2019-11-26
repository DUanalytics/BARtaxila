#AR on Electives
library(arules)
library(dplyr)
#sample columns for electives
#elective1, elective2, elective3, elective4, discipline
n=100
(subjectslist = c('Java','C++', 'PHP', 'DotNet','Python','R','MySql', 'Oracle')); length(subjectslist)

(elective1 = sample(x=subjectslist[1:2], size=n, replace=T, prob=c(.6,.4)))
(elective2 = sample(x=subjectslist[3:4], size=n, replace=T, prob=c(.6,.4)))
(elective3 = sample(x=subjectslist[5:6], size=n, replace=T, prob=c(.4,.6)))
(elective4 = sample(x=subjectslist[7:8], size=n, replace=T, prob=c(.5,.5)))
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


#TRUE FALSE method (Transaction type)
subjectslist
set.seed(1); (java = sample(c(T,F), size=n, replace=T))
set.seed(2); (cpp = sample(c(T,F), size=n, replace=T))
set.seed(3); (php = sample(c(T,F), size=n, replace=T))
set.seed(4); (dotnet = sample(c(T,F), size=n, replace=T))
set.seed(5); (python = sample(c(T,F), size=n, replace=T))
set.seed(6); (rpgm = sample(c(T,F), size=n, replace=T))
set.seed(7); (mysql = sample(c(T,F), size=n, replace=T))
set.seed(8); (oracle = sample(c(T,F), size=n, replace=T))
electiveChoice = data.frame(java, cpp, php, dotnet, python, rpgm, mysql, oracle, stringsAsFactors = T)
head(electiveChoice)

#EDA----
table(electiveChoice)
table(electiveChoice$php, electiveChoice$oracle)
prop.table(table(electiveChoice$dotnet, electiveChoice$oracle))
electiveChoice %>% filter(dotnet == T) %>% count()
electiveChoice %>% filter(oracle == T) %>% count()
electiveChoice %>% filter(dotnet == T & oracle == T) %>% count()
20/100 #support
20/44 #confidence
nrow(electiveChoice)
20/100 / ((44/100) * (46/100))  #lift 
inspect(elective_rules1[1:4])

pairs(electiveChoice)

#frequent items set ------
elective_FI = eclat(electiveChoice, parameter= list(support=.2))
inspect(elective_FI[1:4])

#rules------
elective_rules1 = apriori(electiveChoice, parameter= list(support=.1, confidence=.4, minlen=2),appearance = list(default = "lhs", rhs=c("oracle")))
inspect(elective_rules1[1:4])

elective_rules2 = apriori(electiveChoice, parameter= list(support=.1, confidence=.4, minlen=2))
inspect(elective_rules2)
subset2A = subset(elective_rules2, subset=lhs %in% 'python' & rhs %in% 'rpgm' )
inspect(subset2A)
inspect(sort (subset2A, by="lift", decreasing=TRUE))
inspect(subset(elective_rules2, subset=lhs %in% c('python','rpgm') ))
inspect(subset(elective_rules2, subset=lhs %ain% c('python','rpgm') ))
inspect(subset(elective_rules2, subset=rhs %in% 'python' & confidence > .5))
inspect(subset(elective_rules2, subset=lhs %pin% c('py') ))


