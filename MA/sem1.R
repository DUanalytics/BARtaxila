#Structure Equation Modeling (SEM)

library(sem)
data(Klein)
Klein
?Klein

library(lavaan)
library(dplyr)

model <- '
  # measurement model
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8
  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'
fit <- sem(model, data=PoliticalDemocracy)
summary(fit, standardized=TRUE)


#Boston------
#example dataset from mlbench package with home prices in Boston by census tract
library(mlbench)
data(BostonHousing2)
head(BostonHousing2)
BostonSmall <- BostonHousing2 %>% dplyr::select(
  cmedv, #median value of home in 1000s
  crim, #per capita crime by town
  nox, #nitric oxide concentration
  lstat, #proportion of lower status
  rad #proximity to radial highways
) %>% mutate(log_crim = log2(crim))

BostonSmall
lavaan_m <- 'cmedv ~ log_crim'
mlav <- sem(lavaan_m, data=BostonSmall)
summary(mlav)
summary(lm(cmedv ~ log_crim, BostonSmall))
#https://psu-psychology.github.io/r-bootcamp-2018/talks/lavaan_tutorial.html#introduction


library("lavaan")
example(cfa)

library("semPlot")
semPaths(fit, "model", "estimates")

library("semTools")
fits <- example(measurementInvariance)
semPaths(fits$value$fit.intercepts, "equality", "estimates",
         sizeLat = 5, title = FALSE, ask = FALSE,
         levels = c(1, 2, 4), edge.label.cex = 0.5)



#http://www.sachaepskamp.com/files/semPlot.pdf

#http://lavaan.ugent.be/tutorial/sem.html