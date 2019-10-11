#Confidence Interval Plots


df=mtcars
#catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
#df[,catcols] = lapply(df[,catcols], as.factor)
numCols = c('mpg','wt','hp','disp')


library(Rmisc)
#summarySE(data = NULL, measurevar, groupvars = NULL, na.rm = FALSE, conf.interval = 0.95, .drop = TRUE)

(sum1 <- summarySE(df, measurevar="mpg", groupvars=c("gear")))
#se - standard error : it is like telling mpg is +/- some value

# Standard error of the mean
ggplot(sum1, aes(x=gear, y=mpg)) +   geom_errorbar(aes(ymin=mpg-se, ymax=mpg+se), width=.1) +  geom_line() + geom_point()

(sum2 <- summarySE(df, measurevar="mpg", groupvars=c("gear", "am")))

# Standard error of the mean
ggplot(sum2, aes(x=gear, y=mpg, colour=factor(am))) +   geom_errorbar(aes(ymin=mpg-se, ymax=mpg+se), width=.1) +  geom_line() + geom_point()


#-----
sum2
ggplot(sum2, aes(x=factor(gear), y=mpg, fill=factor(am))) + geom_bar(position=position_dodge(), stat="identity") +  geom_errorbar(aes(ymin=mpg-se, ymax=mpg+se),  width=.2,    position= position_dodge(.9))
