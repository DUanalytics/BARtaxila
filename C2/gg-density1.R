#ggplot - Density Plot
#Continous Variables
library(ggplot2)
library(dplyr)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

ggplot(df) + geom_density(aes(x = mpg, color = gear))


#area plot
ggplot(df) + geom_density(aes(x = mpg, fill = gear), alpha = 0.2)

ggplot(df) + geom_density(aes(x = mpg, fill = gear), alpha = 0.2) + facet_grid(am ~ vs)

# Plot
g <- ggplot(df, aes(mpg))
g + geom_density(aes(fill=cyl, alpha=0.8)) +   labs(title="Density plot",  subtitle="City Mileage Grouped by Number of cylinders",       caption="Source: mpg",       x="City Mileage", fill="# Cylinders")
                 