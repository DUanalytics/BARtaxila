# Seasonal Plot
#http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#top

library(ggplot2)
library(forecast)
theme_set(theme_classic())

head(nottem)
nottem
# Subset data
nottem_small <- window(nottem, start=c(1920, 1), end=c(1925, 12))  # subset a smaller timewindow

# Plot
ggseasonplot(AirPassengers) + labs(title="Seasonal plot: International Airline Passengers")

ggseasonplot(nottem_small) + labs(title="Seasonal plot: Air temperatures at Nottingham Castle")
