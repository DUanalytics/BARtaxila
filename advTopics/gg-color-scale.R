#ggplot - colour gradient scale


library(ggplot2)
library(dplyr)
library(scales)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)


p3 <- ggplot(data = df %>% group_by(carb) %>% summarise(meanMPG = mean(mpg, na.rm=T)), aes(x = carb, y = meanMPG)) + theme(legend.position="top",  axis.text=element_text(size = 6))
p3
(p4 <- p3 + geom_point(aes(color = meanMPG), alpha = 1,  size = 5, position = position_jitter(width = 0.25, height = 0)))

p4 +  scale_color_continuous(name="MPG Level",  breaks = c(10, 20, 30), labels = c("10", "20", "30"),  low = scales::muted("red"), high = scales::muted("green"))

p4 + scale_colour_gradient2(breaks = c(10, 15,20,25,30), low=scales::muted("red"), mid='yellow', high=scales::muted("green"), space="Lab")

p4 + scale_colour_gradient2(limits=c(10, 30))
p4 + scale_colour_gradient2(high=muted("green"))


#Links
#https://www.rdocumentation.org/packages/ggplot2/versions/1.0.0/topics/scale_colour_gradient2



#-----
sp <- ggplot(iris, aes(Sepal.Length, Sepal.Width))+   geom_point(aes(color = Sepal.Length))
sp
# Sequential color scheme. 
# Specify the colors for low and high ends of gradient
sp + scale_color_gradient(low = "blue", high = "red")

# Diverging color scheme
# Specify also the colour for mid point
mid <- mean(iris$Sepal.Length) 
sp + scale_color_gradient2(midpoint = mid, low = "blue", mid = "white", high = "red", space = "Lab" )

sp + scale_color_gradientn(colours = rainbow(5))


#https://www.datanovia.com/en/blog/ggplot-gradient-color/
