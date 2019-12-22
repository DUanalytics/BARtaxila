#Extract a web page in R

# load packages
library(RCurl)
library(XML)
library(htm2txt)
help(htm2txt)
library(rvest)


# assign input (could be a html file, a URL, html text, or some combination of all three is the form of a vector)
# evaluate input and convert to text

#
link1 = "https://taxila.in/director-msg"
dirmessage <- gettext(link1)  
dirmessage

library(htm2txt)
url <- 'https://en.wikipedia.org/wiki/Alan_Turing'
text <- gettxt(url)
text

library(XML)
url <- 'http://en.wikipedia.org/wiki/World_population'
allTables <- readHTMLTable(url)



# Load packages
library(rvest)
library(stringr)
library(dplyr)
library(lubridate)
library(readr)

# Read web page
webpage <- read_html("https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html")

# Extract records info
results <- webpage %>% html_nodes(".short-desc")

# Building the dataset
records <- vector("list", length = length(results))

for (i in seq_along(results)) {
  date <- str_c(results[i] %>% 
                  html_nodes("strong") %>% 
                  html_text(trim = TRUE), ', 2017')
  lie <- str_sub(xml_contents(results[i])[2] %>% html_text(trim = TRUE), 2, -2)
  explanation <- str_sub(results[i] %>% 
                           html_nodes(".short-truth") %>% 
                           html_text(trim = TRUE), 2, -2)
  url <- results[i] %>% html_nodes("a") %>% html_attr("href")
  records[[i]] <- data_frame(date = date, lie = lie, explanation = explanation, url = url)
}

df <- bind_rows(records)

# Transform to datetime format
df$date <- mdy(df$date)

# Export to csv
write_csv(df, "trump_lies.csv")

#https://towardsdatascience.com/web-scraping-tutorial-in-r-5e71fd107f32
#https://www.r-bloggers.com/htmltotext-extracting-text-from-html-via-xpath/
#https://bradleyboehmke.github.io/2015/12/scraping-html-text.html