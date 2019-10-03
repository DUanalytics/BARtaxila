# R Environment

ls()  #all variables in the environment
rm(list=ls())  #clean all variables
#see the env tab : right top pane

x = 1:10
ls()


#help
mean(x)
?mean
help(mean)
vignettes(mean)

#packages
#install - install from command or menu for R Studio
install.packages('MASS')
library(MASS)  #load MASS library to use the functions

#datasets
data() #available datasets in the env


