#base - Mosaic
library(dplyr)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

# Mosaic Plot Example
library(vcd)
HairEyeColor
mosaic(HairEyeColor, shade=TRUE, legend=TRUE)

dftable <- xtabs(  ~ gear + cyl + am, data=df)

mosaic(dftable, shade=TRUE, legend=TRUE)
#For extended mosaic plots, use mosaic(x, condvar=, data=) where x is a table or formula, condvar= is an optional conditioning variable, and data= specifies a data frame or a table. Include shade=TRUE to color the figure, and legend=TRUE to display a legend for the Pearson residuals.
mosaic(x=dftable, shade=TRUE, legend=TRUE)


#----------------------
#Association Plots
#extended association plot use assoc(x, row_vars, col_vars) where x is a contingency table, row_vars is a vector of integers giving the indices of the variables to be used for the rows, and col_vars is a vector of integers giving the indices of the variables to be used for the columns of the association plot.
assoc(dftable, shade=TRUE)


#mosaic plot
mosaicplot(~ gear + cyl, data = df, shade=T, color = TRUE)

mosaicplot(~ Sex + Age + Survived, data = Titanic, shade=T, color = TRUE)
