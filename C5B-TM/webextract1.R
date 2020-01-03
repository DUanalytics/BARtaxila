#Web Extract
#https://stepupanalytics.com/web-scraping-and-analyzing-data-using-r/


library(rvest)
#(https://www.flipkart.com/search?q=Mobile&marketplace=FLIPKART&otracker=start&as-show=on&as=off)

url <- 'https://www.flipkart.com/search?q=Mobile&marketplace=FLIPKART&otracker=start&as-show=on&as=off'
#.hGSR34 , ._2rQ-NK , ._3wU53n
webpage <- read_html(url)
name_html = html_nodes(webpage,'._3wU53n')
name_html
names <- html_text(name_html)
price_html = html_nodes(webpage,'._2rQ-NK')

price <- html_text(price_html)
price <- as.numeric(gsub(x = gsub(x = price,pattern = "\u20b9",replacement = ""),pattern = ",",replacement = ""))

rating_html = html_nodes(webpage,'.hGSR34')
rating <- html_text(rating_html)[1:24]

rating <- as.numeric(sub(x = rating,pattern = " ★",replacement = ""))
data <- data.frame(Product.description = names, Price = price, Rating = rating)

data


# second element in the function html_nodes(). The second element is the “CSS” which we have to select. You may think of it as an address of the elements which you to select in the webpage. Now you can find these “CSS” by the following method –

#Install “selector gadget” extension to your Google Chrome.
#Now, go to the webpage.
#Then click on the extension.
#Now, just select the one you are interested in.
#You will get the CSS selector in a tab below.
#You can follow the visit https://selectorgadget.com/ to understand how “selector gadget” works.

#replacement for the variables “price” and “rating”. Basically, when we scrap a data from the webpage it may not be saved as we need. So, we have to modify it to serve our purpose.
