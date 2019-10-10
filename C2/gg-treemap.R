#ggplot - treemap
library(ggplot2)
library(dplyr)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

library(ggplot2)
library(treemap)
library(dplyr)

data(GNI2014)
head(GNI2014)
treemap(GNI2014, index=c("continent", "iso3"),  vSize="population",    vColor="GNI",  type="value", format.legend = list(scientific = FALSE, big.mark = " "))

dftree <- df %>% group_by(gear, cyl) %>% summarise(n=n(), meanMPG = mean(mpg, na.rm=T))
dftree
dftree$gear = paste('Gear', dftree$gear)
dftree$cyl = paste('Cyl', dftree$cyl)

treemap(dftree, index=c("gear", "cyl"),  vSize="n", vColor="meanMPG",  type="value", format.legend = list(scientific = FALSE, big.mark = " "))
#Gear 5 : Ratio : Cylinder 4:6:8 = 2:1:2 ; highest MPG of Cyl4 ie 28, lowest of 15

(dftree2 <- df %>% group_by(gear) %>% summarise(n=n(), meanMPG = mean(mpg)))
treemap(dtf=dftree2,index = c("gear"),vSize="n", vColor ="meanMPG", type='value')
#gear4 cars have highest MPG - darkgreen
#gear3 are highest in no : width is largest
