#ggplot - legend

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

p <- ggplot(df, aes(x=wt, y=mpg, color=gear)) + geom_point(aes(shape=am, size=carb, alpha=vs))
p
#position
p + theme(legend.position="top")
p + theme(legend.position="bottom")
# Remove only the legend title
p + theme(legend.title = element_blank())
# Remove the plot legend
p + theme(legend.position='none')
#position 
p + theme(legend.position = c(0.8, 0.2))

# Horizontal legend box
p +theme(legend.position="bottom", legend.box = "horizontal")
# legend box background color
p + theme(legend.background = element_rect(fill="lightblue",  size=0.5, linetype="solid"))
p + theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid", colour ="darkblue"))

#Change the order of legend items
#To change the order of items to “5”, “4”, “3” :
  
p + scale_x_discrete(limits=c("5", "4", "3"))


#Change the order for multiple guides :The function guide_legend() is used :
p+guides(color = guide_legend(order=1),  size = guide_legend(order=2),         shape = guide_legend(order=3))


p + guides(colour = guide_colourbar(order = 1),  alpha = guide_legend(order = 2), size = guide_legend(order = 3))

#remove for particular aes
p+guides(color = FALSE, size = FALSE)

# Remove legend for the point shape
p+ scale_shape(guide=FALSE)
# Remove legend for size
p + scale_size(guide=FALSE)  #no graph
# Remove legend for color
p + scale_color_manual(values=c('#999999','#E69F00','#56B4E9'), guide=FALSE)


#http://www.sthda.com/english/wiki/ggplot2-legend-easy-steps-to-change-the-position-and-the-appearance-of-a-graph-legend-in-r-software

