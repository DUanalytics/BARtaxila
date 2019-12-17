#LM
#women Data Set


predict weight for certain height

women
head(women)
dim(women)

#Linear Model
fit = lm(weight ~ height,data = women)

summary(fit)

range(women$height)
(ndata = data.frame(height = c(60.5, 70.5, 71.5)))

#predict Wt for Ht
(predictedwt = predict(fit, newdata = ndata))
cbind(ndata, predictedwt)

resid(fit)
fitted(fit)
cbind(women, fitted(fit), resid(fit))

#assumptions

plot(fit)
