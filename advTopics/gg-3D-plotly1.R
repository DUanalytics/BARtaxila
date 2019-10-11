#ggplot + plotly
#3D

library(tidyverse)
library(plotly)
#Data preparation:
  
df <- mtcars %>% rownames_to_column() %>% as_tibble() %>% mutate(am = ifelse(am == 0, "Automatic", "Manual")) %>%   mutate(am = as.factor(am))
df

# Create the plot
p <- plot_ly(   df, x = ~wt, y = ~hp, z = ~qsec,    color = ~am, colors = c('#BF382A', '#0C4B8E') ) %>%   add_markers() %>%   layout(     scene = list(xaxis = list(title = 'Weight'),  yaxis = list(title = 'Gross horsepower'),  zaxis = list(title = '1/4 mile time'))
  )
p
