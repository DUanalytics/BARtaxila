#Ballon Plot

library(ggplot2)
library(ggpubr)
ggballoonplot(mtcars[1:10,1:5], fill = "value") +   scale_fill_viridis_c(option = "C")

names(mtcars)
ggballoonplot(mtcars, x = "gear", y = "cyl", size = "am",fill = "hp", facet.by = "vs", ggtheme = theme_bw()) +  scale_fill_viridis_c(option = "C")
