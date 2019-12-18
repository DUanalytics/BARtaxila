#TS Plot - Dygraphs


#https://github.com/rstudio/dygraphs
#devtools::install_github(c("ramnathv/htmlwidgets", "rstudio/dygraphs"))
library(dygraphs)
#xts-compatible time-series object creating an interactive plot of it is as simple as this:
dygraph(nhtemp, main = "New Haven Temperatures")
dygraph(AirPassengers)


#Customise
dygraph(nhtemp, main = "New Haven Temperatures") %>%   dyAxis("y", label = "Temp (F)", valueRange = c(40, 60)) %>%   dyOptions(fillGraph = TRUE, drawGrid = FALSE) %>%   dyRangeSelector()

