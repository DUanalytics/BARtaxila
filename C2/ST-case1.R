#case - Visualisation

#libraries
library(dplyr)
library(ggplot2)

#MBA students from 2 year course, each has 2 sections; two Genders, 
#Profile of Students
n=200
(rollno = 101:(100+n))
(gender = sample(c('M','F'), size=n, replace=T, prob=c(.6, .4)))
(batch = sample(c('Year1','Year2'), size=n, replace=T, prob=c(.6, .4)))
(section = sample(c('SecA','SecB'), size=n, replace=T, prob=c(.5, .5)))
(ugcourse = sample(c('BTECH','BCOM','BA', "OTHERS"), size=n, replace=T, prob=c(.2, .3, .2, .3)))
(ugscore = round(rnorm(100, mean=63, sd=10),0))

students = data.frame(rollno, gender, batch, section, ugcourse, ugscore)

students %>% group_by(batch) %>% tally() #s1
students %>% group_by(batch, gender) %>% tally() #s2
students %>% group_by(batch, section) %>% tally() #s3
students %>% group_by(batch, section, gender) %>% tally() #s4
students %>% group_by(batch, ugcourse) %>% tally() #s5
(s6 <- students %>% group_by(batch, section, gender, ugcourse) %>% summarise(meanUGscore = mean(ugscore, na.rm=T))) #s6



#data1
#Survey was conducted to take view of Student as to level of the knowledge they had on Data Analytics
ratings = c('Excellent','VeryGood', 'Good','Satisfactory', 'Poor')
rev(ratings)
(fratings = factor(x=ratings, ordered=T, levels=rev(ratings)))
(klevels1 = sample(fratings, size=n, replace=T, prob=c(.02, .1, .2,.48,.2)))
table(klevels1)

#Qs asked as to how many wanted to learn Data Analytics so that a central programme could be conducted
(learnDA = sample(c('Yes','No', 'Maybe'), size=n, replace=T, prob=c(.6, .1,.3)))

#A online quiz was conducted to assess the knowledge, it was planned that same/similar test be conducted if the training was conducted to see the improvement: prior-test results were as follows
(prob1 = c(.2, .395, rep(.075,4), rep(.025,4),0.005)); sum(prob1); length(prob1)
(priorTest = sample(x=0:10, size=n, replace=T, prob=prob1))
table(priorTest)

#should the course be conducted if it is important for MBA Students ?????

#Half way through Qs was asked and similar quiz test was conducted with a feedback to know student satisfaction
(prob2 = c(.05, .09, rep(.09,4), rep(.1,4),0.1)); sum(prob2); length(prob2)
(midTest = sample(x=0:10, size=n, replace=T, prob=prob2))
table(midTest)

#End of the course quiz and feedback was collected
(prob3 = c(.0005, .005, rep(.05,4), rep(.14,4),0.2345)); sum(prob3); length(prob3)
(endTest = sample(x=0:10, size=n, replace=T, prob=prob3))
table(endTest)
#ratings of knowledge 
fratings
(klevels2 = sample(fratings, size=n, replace=T, prob=c(.3, .3, .24,.15,.01)))
table(klevels2)

#how does institution and student feel about the program
dscourse = data.frame(rollno, klevels1, klevels2, learnDA, priorTest, midTest, endTest)
head(dscourse)

#more analysis - gender wise
#end ----------------------------------------------------
#graphs
students
str(students)
dscourse
studentsDScourse = merge(students, dscourse)  #merge two data
head(studentsDScourse)
str(studentsDScourse)

#visualise the profile
#baseplot
(g1a <- barplot(table(students$batch), col=1:2))
(g1b <- pie(table(students$batch), col=1:2))
(g1c <- pie(table(studentsDScourse$learnDA), col=1:3, main='Choice for doing Data Analytics Course'))
(g1d <- hist(studentDScourse$priorTest))
(g1e <- hist(studentDScourse$priorTest, breaks=5, col=1:5))


#ggplot

(g2a <- ggplot(students, aes(x=batch, fill=section)) + stat_count( geom = "bar") + geom_text(stat='count', aes(label=..count..), vjust=-1, position = 'stack')  +  ggtitle("Number of Students : Year | Section" ))

(g2b <- ggplot(students, aes(x=ugcourse, fill=gender)) + stat_count( geom = "bar", show.legend = T) + facet_grid(batch ~ section) +  ggtitle("Number of Students : UG Course(Prior) | Section" ) + geom_text(stat='count', aes(label=..count..), vjust=0, position = 'stack'))

(g2c <- ggplot(students, aes(x=ugcourse, fill=gender)) + stat_count( geom = "bar", show.legend = T, position=position_dodge2(.8, preserve = "single")) + facet_grid(batch ~ section) + geom_text(stat='count', aes(label=..count..), vjust=-1, position = position_dodge2(.8)))

head(s6)
(g2d <- ggplot(s6, aes(x=ugcourse, fill=gender, y=meanUGscore)) + geom_bar(stat='identity', position=position_dodge2(.7, preserve = "single")) + facet_grid(batch ~ section) + ggtitle('Mean UG Score : Year - Section | Gender wise') + geom_text(aes(label=round(meanUGscore,0), y=meanUGscore), vjust=-1, position = position_dodge2(.8)))
#mean UG Scores : Year - Section | Gender wise

#Stage-1 : Before Course
bc =c('learnDA', 'klevels1', 'priorTest')
profile = c('batch','section','gender','ugcourse')
head(studentsDScourse[,c('rollno', profile, bc)])
(g2a <- ggplot(studentsDScourse, aes(x=klevels1, fill=learnDA)) + stat_count( geom = "bar",position=position_dodge2(.7, preserve = "single")) + geom_text(stat='count', aes(label=..count..), vjust=-1, position= position_dodge2(.7, preserve = 'single')) +  facet_grid(batch ~ section) + ggtitle('Students with Different Knowledge Levels Wanting to Learning Data Analyitcs \n Knowledge Levels vs Count | Batch vs Sections')  + ylim(c(0,20))  + guides(ylab='Count') + labs(fill='Student Choice') + xlab("Knowledge Levels"))

(g2b <- ggplot(studentsDScourse, aes(x=klevels1, fill=learnDA)) + stat_count( geom = "bar", position=position_dodge2(.7, preserve = "single")) + geom_text(stat='count', aes(label=..count..), vjust=-1, position= position_dodge2(.7, preserve = 'single')) +  facet_grid(batch + section  ~ gender) + ylim(c(0,15)) + labs(fill='Student Choice') + ggtitle('Students with Different Knowledge Levels Wanting to Learning Data Analyitcs \n Knowledge Levels vs Count | Batch vs Sections vs Gender') + theme(legend.position = 'top',legend.direction = "horizontal") + scale_fill_manual(values=c("blue", "red", "green")) + xlab("Knowledge Levels"))

#see the prior test score - histogram
(g3a <- ggplot(studentsDScourse, aes(x=priorTest)) + geom_histogram(position="identity", fill="blue", color='black', alpha=0.2, bins = 10) +  facet_grid(batch ~ section) + ggtitle("Test Scores prior to Course : Score vs Count | Batch vs Section") + xlab('Test Score from 10') )

#using stat_bin and labels
(g3b <- ggplot(studentsDScourse, aes(x=priorTest)) +   stat_bin(breaks=c(0,2,4,6,8,10), fill='green', color='red') + stat_bin(breaks=c(0,2,4,6,8,10), geom='text', aes(label=..count..), pad=T) +  facet_grid(batch ~ section) + ggtitle("Test Scores prior to Course : Score vs Count | Batch vs Section") + xlab('Test Score from 10') )

(g3b <- ggplot(studentsDScourse, aes(x=priorTest)) +   stat_bin(breaks=c(0,2,4,6,8,10), fill='green', color='red', closed='left') + stat_bin(breaks=c(0,2,4,6,8,10), geom='text', aes(label=..count..), pad=T) +  facet_grid(ugcourse ~ batch) + ggtitle("Test Scores prior to Course : Score vs Count | Batch vs Section") + xlab('Test Score from 10') )

#Course in 
options(digit=2)
(g3c <- ggplot(studentsDScourse, aes(x= priorTest)) +   geom_bar(aes(y = ..prop.., ), stat="count", fill='green', colour='red', alpha=.5 ) +  geom_text(aes(label = scales::percent(..prop..,2), y= ..prop..), stat= "count", vjust = -.5) + ggtitle("Test Scores prior to Course : Score vs Count | Batch vs Section") +  facet_grid(batch ~ section) + scale_y_continuous(name="Percentage of Students", labels=scales::percent_format(accuracy=1), limits =c(0,.6)) + xlab('Test Score from 10'))
#ggsave("hist.png", p, height=4, width=6, dpi=150) #save last graph

