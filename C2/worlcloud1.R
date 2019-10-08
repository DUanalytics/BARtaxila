#Data Visualisation - Case ST
library(wordcloud2)
library(dplyr)
#wordcloud

#Profile of Students
n=200
(rollno = 101:(100+n))
cities = c('Delhi', 'Mumbai','Kolkatta', 'Chennai', 'Bengaluru', 'Goa', 'Lucknow', 'Jaipur', 'Chandigarh', 'Indore','DehraDun', 'Gangtok', 'Cuttack','Cochin','Vellore', 'Moradabad', 'Bikaner', 'Noida', 'Gurgaon')
length(cities)
(p1 = sample(x=1:length(cities)))
(p2 = p1/sum(p1))
(sum(p2))
(city = sample(x=cities, size=n, replace=T, prob= p2))
(studentcity = data.frame(rollno, city))
table(studentcity$city)
(citycount <- studentcity %>% group_by(city) %>% summarise(freq = n()))
head(citycount)
#-------------

# repeating the same pattern

library(wordcloud) #requires tm package also
set.seed(1234)
wordcloud(words=citycount$city, freq=citycount$freq, min.freq = 1,max.words=50, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
citycount[order(citycount$freq, decreasing = T), ][1:10,]
#run it without set.seed to see the changes in pattern
?wordcloud
wordcloud(words=citycount$city, freq=citycount$freq, min.freq = 1,max.words=50, random.order=T, rot.per=.3, colors=brewer.pal(8, "Dark2"), scale=c(3,.5), random.color = T)
#rot.per : proportion words with 90 degree rotation (vertical text): 1 - all vertical, .3 - 30% vertical

#read this
#https://cran.r-project.org/web/packages/wordcloud/wordcloud.pdf
library(wordcloud2)
wordcloud2(data=citycount, size=1)
?wordcloud2
head(citycount)
wordcloud2(citycount,  color = ifelse(citycount$freq < 5, 'red', (ifelse(citycount$freq < 10, 'green','blue'))), backgroundColor = 'lightblue')
wordcloud2(citycount, minRotation = -pi/6, maxRotation = pi/2)
wordcloud2(citycount, shuffle=T)
wordcloud2(citycount, rotateRatio = 1) #all rotate
wordcloud2(citycount, rotateRatio = .3)
wordcloud2(citycount, shape='triangle')
wordcloud2(citycount, shape='star')

#figure path
(figPath = system.file("examples/t.png",package = "wordcloud2"))
wordcloud2(citycount, figPath = figPath, size = 1.5, color='green')
wordcloud2(demoFreq, figPath = figPath, size = 1.5,color = "skyblue")

letterCloud(demoFreq, word = "R", size = 2)

#https://rdrr.io/cran/wordcloud2/src/R/wordcloud2.R
