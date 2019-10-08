#ggplot - Heat Map
#Count : Colour Density
library(dplyr)
library(ggplot2)

df = mtcars
scale_fill_gradient(low = "white", high = "lightblue") + guides(fill=F)

hd1 <- df %>% group_by(carb, gear,am) %>% summarise(meanMPG = round(mean(mpg, na.rm=T)),2)
#this could sales in each carb(year) within products(gear)

(gh1 <- ggplot(hd1, aes(x=carb, y=gear, fill=meanMPG)) + geom_tile() + geom_text(aes(label = meanMPG), size=3) + facet_grid(. ~ am , scales='free') + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + scale_fill_gradient(low = "white", high = "lightblue") + guides(fill=F) +  ggtitle("Heat Map showing levels sales ") + scale_y_continuous(labels = function(y) stringr::str_wrap(y, width = 25)))
gh1

#count of values: which category of cars are least/highest
(dh2 <- df %>% group_by(gear, am)  %>% summarise(n=n()))
str(dh2)
#am is continuous scale : convert the columntype
ggplot(data=dh2, aes(x=gear, y=am, fill=n)) + geom_tile()
dh2[,c('gear', 'am')] <- lapply(dh2[,c('gear', 'am')],factor)
#simple heat map
ggplot(data=dh2, aes(x=gear, y=am, fill=n)) + geom_tile()
#heat map with values
ggplot(data=dh2, aes(x=gear, y=am, fill=n)) + geom_tile() + geom_text(aes(label=n), size=5)
#heatmap with selected color gradient
ggplot(data=dh2, aes(x=gear, y=am, fill=n)) + geom_tile() + geom_text(aes(label=n), size=5) + scale_fill_gradient(low = "yellow", high = "green") + guides(fill=F) 


#you can facet, themes  etc...
