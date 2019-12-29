#stars
#https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/stars.html

stars(mtcars[, 1:7], key.loc = c(14, 2),  main = "Motor Trend Cars : stars(*, full = F)", full = FALSE)
stars(mtcars[, 1:7], key.loc = c(14, 1.5),
      main = "Motor Trend Cars : full stars()", flip.labels = FALSE)
?stars
stars(df[, 1:2])
#not working
library(ggplot2)
#install.packages("remotes")
remotes::install_github("garrettgman/ggsubplot")
devtools::install_github("garrettgman/ggsubplot")
nasa
head(nasa)
class(nasa)
str(nasa)
df_nasa <- as.data.frame(nasa)
head(df_nasa)
ggplot(df_nasa) +  geom_subplot(aes(long, lat, group = id, subplot = geom_star(  aes(x = 0, y = 0, r = surftemp, angle = date, fill = mean(surftemp)),     r.zero = FALSE ))) +coord_quickmap()
