#Time Series

## From Timeseries object (ts)
library(ggplot2)
library(ggfortify)
theme_set(theme_classic())

# Plot 
autoplot(AirPassengers) +   labs(title="AirPassengers") +  theme(plot.title = element_text(hjust=0.5))


#---from Df-----
library(ggplot2)
theme_set(theme_classic())
head(economics)

economics$returns_perc <- c(0, diff(economics$psavert)/economics$psavert[-length(economics$psavert)])

# Allow Default X Axis Labels
ggplot(economics, aes(x=date)) +   geom_line(aes(y=returns_perc)) +  labs(title="Time Series Chart", subtitle="Returns Percentage from 'Economics' Dataset",  caption="Source: Economics",    y="Returns %")



#------
library(ggplot2)
library(lubridate)
theme_set(theme_bw())
brks <- economics_y$date[seq(1, length(economics_y$date), 12)]

economics_m <- economics[1:24, ]
head(economics_m)
# labels and breaks for X axis text
lbls <- paste0(month.abb[month(economics_m$date)], " ", lubridate::year(economics_m$date))
brks <- economics_m$date

# plot
ggplot(economics_m, aes(x=date)) +   geom_line(aes(y=returns_perc)) + labs(title="Monthly Time Series",       subtitle="Returns Percentage from Economics Dataset",        caption="Source: Economics", y="Returns %") +  # title and caption
  scale_x_date(labels = lbls, breaks = brks) +  # change to monthly ticks and labels
  theme(axis.text.x = element_text(angle = 90, vjust=0.5),  # rotate x axis text
        panel.grid.minor = element_blank())  # turn off minor grid


#------
library(ggplot2)
library(lubridate)
theme_set(theme_bw())

economics$returns_perc <- c(0, diff(economics$psavert)/economics$psavert[-length(economics$psavert)])
economics_y <- economics[1:90, ]


# labels and breaks for X axis text
brks <- economics_y$date[seq(1, length(economics_y$date), 12)]
lbls <- lubridate::year(brks)

# plot
ggplot(economics_y, aes(x=date)) +   geom_line(aes(y=returns_perc)) +   labs(title="Yearly Time Series",      subtitle="Returns Percentage from Economics Dataset", caption="Source: Economics",       y="Returns %") +    scale_x_date(labels = lbls,  breaks = brks) +  theme(axis.text.x = element_text(angle = 90, vjust=0.5),  panel.grid.minor = element_blank())  # turn off minor grid

#------
library(ggplot2)
library(quantmod)
data("economics", package = "ggplot2")

# Compute % Returns
economics$returns_perc <- c(0, diff(economics$psavert)/economics$psavert[-length(economics$psavert)])

# Create break points and labels for axis ticks
brks <- economics$date[seq(1, length(economics$date), 12)]
lbls <- lubridate::year(economics$date[seq(1, length(economics$date), 12)])

# Plot
ggplot(economics[1:100, ], aes(date, returns_perc)) +   geom_area() + 
  scale_x_date(breaks=brks, labels=lbls) +  theme(axis.text.x = element_text(angle=90)) +   labs(title="Area Chart",    subtitle = "Perc Returns for Personal Savings", y="% Returns for Personal savings", caption="Source: economics")
