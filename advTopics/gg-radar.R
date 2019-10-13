#ggplot - Radar Graph
#categories at particular distance from center

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

df %>% group_by(gear, cyl) %>% summarise(n=n())

(gr1 <- ggplot(data=df %>% group_by(gear, cyl) %>% summarise(n=n()),  aes(x=gear, y=n, label=n, colour=cyl)) +   geom_point(size=2)  +  geom_hline(yintercept=seq(0,15,3), lwd=.5)) + scale_y_discrete(name='Count', breaks=c(0,1,2,5,10) + geom_text(aes(label=n, y=n), hjust=-1, size=5))
gr1 +  coord_polar()


(gr2 <- ggplot(data=df %>% group_by(gear, cyl) %>% summarise(n=n()),  aes(x=gear, y=n, colour=cyl)) +   geom_point(size=3)  +  geom_text(aes(label=n), size=4, hjust=-.5, vjust=0) + geom_hline(yintercept=c(0,1,2,5,10,15,20), colour=1:7))
gr2 + coord_polar()

breaks3a=c(0,1,2,5,10,15,20)
breaks3b=c(1,5,10)
(gr3 <- ggplot(data=df %>% group_by(gear, cyl) %>% summarise(n=n()),  aes(x=gear, y=n, colour=cyl)) +   geom_point(size=3)  +  ggrepel::geom_label_repel(aes(label=paste(n, 'Cars')), size=4, hjust=-.5, vjust=1) + geom_hline(yintercept=breaks3a, colour=1:7) + scale_y_discrete(name='Count of Cars', breaks = breaks3b, labels=paste(breaks3b,'Cars') , limits=breaks3b) + scale_x_discrete(name='Gears', labels=c('Gear-3', 'Gear-4', 'Gear-5')) + geom_vline(xintercept=1:3, lwd=1:3, col=1:3) )
gr3 + coord_polar() + ggtitle("Radar Plot : No of Cars | Gear Type (Cylinder Color)")
?mtcars
#plot mileage
?seq
(breaks4a = seq.int(5,max(df$mpg),5)); length(breaks4a)
breaks4b=c(1,5,10)
(dfsum4 <- df %>% group_by(gear, cyl) %>% summarise(n=n(), meanMPG = mean(mpg, na.rm=T)) %>% mutate(carLabel = paste('Gear-',gear, ' Cyl-', cyl, '\n Count-', n, ' MPG-', meanMPG, sep='')))

(gr4 <- ggplot(data=dfsum4,  aes(x=gear, y=meanMPG, colour=cyl)) +   geom_point(aes(size=n))+  ggrepel::geom_label_repel(aes(label=carLabel), size=3, hjust=-.5, vjust=1) + geom_hline(yintercept=breaks4a, col=1:6) + scale_y_continuous(name='Mileage of Cars', breaks=breaks4a, labels=paste(breaks4a,'/MPG')) + scale_x_discrete(name='Gears', labels=c('Gear-3', 'Gear-4', 'Gear-5')) + geom_vline(xintercept=1:3, lwd=1:3, col=1:3) )
gr4 + coord_polar() + ggtitle("Radar Plot : Mileage | Gear Type (Cylinder Color)")

#What is the mileage of 6 Cylinder + 4 Gear Cars : ? 