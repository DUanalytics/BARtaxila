#ggplot - Line Plot
#line with growth

program = c('BBA', 'MBA',)
year = c(2017:2019)
(admission = expand.grid(program, year))
names(admission) = c('program', 'year')
admission
admission$count = trunc(runif(nrow(admission), 50, 100))
admission
admission[,c('program', 'year')] = lapply(admission[,c('program', 'year')], as.factor)

#line plot with growth
ggplot(data = admission, aes(x = year, y = count, group = program)) + geom_line(aes(color = program))

#lets add more dimensions : duration of course, domain
#and then label the values
program2 = c('BSc','BTECH','BBA', 'MBA')
(year2 = c(2016:2020))
(admission2 = expand.grid(program2, year2))
names(admission2) = c('program', 'year')
admission2
admission2$count = trunc(rnorm(nrow(admission2), 60, 10))
admission2

#add columns : domain and duration
unique(admission2$program)
admission2$duration = ifelse(admission2$program %in% c('BBA','BSc'), 3, (ifelse(admission2$program == 'MBA', 2, ifelse(admission2$program == 'BTECH', 4, NA)) ))
admission2
#domain 
admission2$stream = ifelse(admission2$program %in% c('BBA','MBA'), 'Management', (ifelse(admission2$program == 'BSc', 'Sciences', ifelse(admission2$program == 'BTECH', 'Engineering', NA)) ))
admission2
str(admission2)
admission2[, c('program','year','stream')] = lapply(admission2[,c('program','year','stream')], as.factor)
str(admission2)

#now plot
#line plot with growth
ggplot(data = admission2, aes(x = year, y = count, group = program)) + geom_line(aes(color = program))
#lets do some changes
ggplot(data = admission2, aes(x = year, y = count, group = program)) + geom_line(aes(color = program, size=duration))

gg1 <- ggplot(data = admission2, aes(x = year, y = count, group = program)) + geom_line(aes(color = program, alpha =.5, size=duration)) + geom_point(aes(shape=stream, size=2.5))
gg1
#label first year
gg2b <- geom_text(data = admission2 %>% filter(year == "2016"), aes(label = count) , hjust = "left",fontface = "bold", size = 4, nudge_x = -.5, nudge_y = .5)
gg1 + gg2b

gg2c <- geom_text(data = admission2 %>% filter(year == "2017"), aes(label = count) , hjust = "left",fontface = "bold", size = 4, nudge_x = -.5, nudge_y = .5)
gg1 + gg2b + gg2c

#ggrepel::geom_text_repel()  #jitters the labels if they overlap
library(ggrepel)
gg3b <- geom_text_repel(data = admission2 %>% filter(year == "2016"), aes(label = count) , hjust = "left",fontface = "bold", size = 4, nudge_x = -.5, nudge_y = .5, direction = "y")
gg1 + gg3b
gg3c <- geom_text_repel(data = admission2 %>% filter(year == "2017"), aes(label = count) , hjust = "left",fontface = "bold", size = 4, nudge_x = -.5, nudge_y = .5, direction = "y")
gg3d <- geom_text_repel(data = admission2 %>% filter(year == "2018"), aes(label = count) , hjust = "left",fontface = "bold", size = 4, nudge_x = -.5, nudge_y = .5, direction = "y")
gg3e <- geom_text_repel(data = admission2 %>% filter(year == "2019"), aes(label = count) , hjust = "left",fontface = "bold", size = 4, nudge_x = -.5, nudge_y = .5, direction = "y")
gg3f <- geom_text_repel(data = admission2 %>% filter(year == "2020"), aes(label = count) , hjust = "left",fontface = "bold", size = 4, nudge_x = -.5, nudge_y = .5, direction = "y")

gg1 + gg3b + gg3c + gg3d + gg3e + gg3f + ggtitle("Growth in Admission over the Years : Stream vs Year") + guides(alpha=F)




#using theme 
duTheme1 <- list(  
  # move the x axis labels up top
  scale_x_discrete(position = "top"),
  theme_bw(),
  # Format tweaks
  # Remove the legend
  theme(legend.position = "right"),
  # Remove the panel border
  theme(panel.border     = element_blank()),
  # Remove just about everything from the y axis
  theme(axis.title.y     = element_blank()),
  theme(axis.text.y      = element_blank()),
  theme(panel.grid.major.y = element_blank()),
  theme(panel.grid.minor.y = element_blank()),
  # Remove a few things from the x axis and increase font size
  theme(axis.title.x     = element_blank()),
  theme(panel.grid.major.x = element_blank()),
  theme(axis.text.x.top      = element_text(size=12)),
  # Remove x & y tick marks
  theme(axis.ticks       = element_blank()),
  # Format title & subtitle
  theme(plot.title       = element_text(size=14, face = "bold", hjust = 0.5)),
  theme(plot.subtitle    = element_text(hjust = 0.5))
)

gg1 + gg3b + gg3c + gg3d + gg3e + gg3f + ggtitle("Growth in Admission over the Years : Stream vs Year") + guides(alpha=F) + duTheme1

#labeling in different manner : shorter/ cleaner
gg1b <- ggplot(data = admission2, aes(x = year, y = count, group = program)) + geom_line(aes(color = program, alpha =.5, size=duration)) 
gg1b

glabel1 <- ggrepel::geom_label_repel(mapping = aes(label = count, fill = stream), parse = FALSE, nudge_x = .05, nudge_y = .05, label.padding = unit(0.25, "lines"), label.r = unit(0.15, "lines"), label.size = 0.25, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) 
gg1b + glabel1
gg1b + ggtitle("Growth in Admission over the Years : Stream vs Year") + guides(alpha=F) + duTheme1 +  glabel1
