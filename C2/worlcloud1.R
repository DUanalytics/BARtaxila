#Data Visualisation - Case ST


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
(stucity = table(city))
library(wordcloud2)
wordcloud2(data=stucity, size=1)
?wordcloud2
stucity
wordcloud2(stucity,  color = ifelse(stucity < 5, 'red', (ifelse(stucity < 10, 'green','blue'))))

           