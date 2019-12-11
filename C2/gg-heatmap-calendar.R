#Calendar Heat Map


# http://margintale.blogspot.in/2012/04/ggplot2-time-series-heatmaps.html
library(ggplot2)
library(plyr)
library(scales)
library(zoo)

df <- read.csv("https://raw.githubusercontent.com/selva86/datasets/master/yahoo.csv")
df$date <- as.Date(df$date)  # format date
df <- df[df$year >= 2012, ]  # filter reqd years

# Create Month Week
df$yearmonth <- as.yearmon(df$date)
df$yearmonthf <- factor(df$yearmonth)
df <- ddply(df,.(yearmonthf), transform, monthweek=1+week-min(week))  # compute week number of month
df <- df[, c("year", "yearmonthf", "monthf", "week", "monthweek", "weekdayf", "VIX.Close")]
head(df)
dim(df)

# Plot
ggplot(df, aes(monthweek, weekdayf, fill = VIX.Close)) +   geom_tile(colour = "white") +  facet_grid(year~monthf) +   scale_fill_gradient(low="red", high="green") + labs(x="Week of Month",y="",     title = "Time-Series Calendar Heatmap", subtitle="Yahoo Closing Price", fill="Close")
