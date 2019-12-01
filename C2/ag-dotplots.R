#Graphs - Dot Plot
#can be substitute for bar plot
# Simple Dotplot
dotchart(mtcars$mpg,labels=row.names(mtcars),cex=.7, main="Gas Milage for Car Models",   xlab="Miles Per Gallon")

#Create dotplots with the dotchart(x, labels=) function, where x is a numeric vector and labels is a vector of labels for each point. You can add a groups= option to designate a factor specifying how the elements of x are grouped. If so, the option gcolor= controls the color of the groups label. cex controls the size of the labels.

dotchart(mtcars$mpg,labels=row.names(mtcars),cex=1, groups=mtcars$gear, gcolor=1:3, pch=c(19,20,25), gpch=c(23,24,25), color='green', lcolor='violet')
?dotchart
qualityTools::dotPlot(mtcars$mpg, stacked=T)

#https://www.rdocumentation.org/packages/qualityTools/versions/1.55/topics/dotPlot
#http://www.sthda.com/english/wiki/ggplot2-dot-plot-quick-start-guide-r-software-and-data-visualization
