#Heat Map

#install.packages("heatmaply")
library(heatmaply)
df = mtcars
df2 <- percentize(df)
df2
heatmaply(df2, k_row = 4, k_col = 2)
# I got the static image using ggheatmap instead of heatmaply


#save heatmap
#interactive version of your heatmaply into an HTML file using the following code:
dir.create("graph")
heatmaply(df2, file = "graph/heatmaply_plot.html")
browseURL("graph/heatmaply_plot.html")

#static version
heatmaply(df2, file = "graph/heatmaply_plot2.png")
browseURL("graph/heatmaply_plot.png")
