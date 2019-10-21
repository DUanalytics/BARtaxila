#dygraphs 
#https://rstudio.github.io/dygraphs/
#Time Series Data

library(dygraphs)
lungDeaths <- cbind(mdeaths, fdeaths)
dygraph(lungDeaths)
#Note that this graph is fully interactive: as your mouse moves over the series individual values are displayed. You can also select regions of the graph to zoom into (double-click zooms out).

#You can customize dygraphs by piping additional commands onto the original dygraph object. Here we pipe a dyRangeSelector onto our original graph:
dygraph(lungDeaths) %>% dyRangeSelector()


#
dygraph(lungDeaths) %>% dySeries("mdeaths", label = "Male") %>%  dySeries("fdeaths", label = "Female") %>%  dyOptions(stackedGraph = TRUE) %>%  dyRangeSelector(height = 20)

#Many options for customizing series and axis display are available. It’s even possible to combine multiple lower/value/upper style series into a single display with shaded bars. Here’s an example that illustrates shaded bars, specifying a plot title, suppressing the drawing of the grid for the x axis, and the use of a custom palette for series colors:

hw <- HoltWinters(ldeaths)
predicted <- predict(hw, n.ahead = 72, prediction.interval = TRUE)

dygraph(predicted, main = "Predicted Lung Deaths (UK)") %>%  dyAxis("x", drawGrid = FALSE) %>%  dySeries(c("lwr", "fit", "upr"), label = "Deaths") %>%  dyOptions(colors = RColorBrewer::brewer.pal(3, "Set1"))


#dygraph(data, main = NULL, xlab = NULL, ylab = NULL, periodicity = NULL, group = NULL, elementId = NULL, width = NULL, height = NULL)


library(xts)
data(sample_matrix)
m <- tail(sample_matrix, n = 32)
dygraph(m) %>%   dyCandlestick()


#range selector
dygraph(nhtemp, main = "New Haven Temperatures") %>% 
  dyRangeSelector()


#strawbroom chart
library(quantmod)

tickers <- c("AAPL", "MSFT")
getSymbols(tickers)
closePrices <- do.call(merge, lapply(tickers, function(x) Cl(get(x))))
dateWindow <- c("2008-01-01", "2009-01-01")

dygraph(closePrices, main = "Value", group = "stock") %>%
  dyRebase(value = 100) %>%
  dyRangeSelector(dateWindow = dateWindow)

dygraph(closePrices, main = "Percent", group = "stock") %>%
  dyRebase(percent = TRUE) %>%
  dyRangeSelector(dateWindow = dateWindow)

dygraph(closePrices, main = "None", group = "stock") %>%
  dyRangeSelector(dateWindow = dateWindow)


dygraph(presidents, main = "Quarterly Presidential Approval Ratings") %>%  dyAxis("y", valueRange = c(0, 100)) %>% dyAnnotation("1950-7-1", text = "A", tooltip = "Korea") %>% dyAnnotation("1965-1-1", text = "B", tooltip = "Vietnam")
