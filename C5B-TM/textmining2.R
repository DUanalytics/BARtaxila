#Text Mining - Paragraph

text <- c("Because I could not stop for Death -", "He kindly stopped for me -", "The Carriage held but just Ourselves -", "and Immortality")

text

library(dplyr)
text_df <- tibble(line = 1:4, text = text)
text_df


library(tidytext)

text_df %>%  unnest_tokens(word, text)

#The two basic arguments to unnest_tokens used here are column names. First we have the output column name that will be created as the text is unnested into it (word, in this case), and then the input column that the text comes from (text, in this case). Remember that text_df above has a column called text that contains the data of interest.

#use the text of Jane Austen’s 6 completed, published novels from the janeaustenr package (Silge 2016), and transform them into a tidy format. The janeaustenr package provides these texts in a one-row-per-line format, where a line in this context is analogous to a literal printed line in a physical book. Let’s start with that, and also use mutate() to annotate a linenumber quantity to keep track of lines in the original format and a chapter (using a regex) 


library(janeaustenr)
library(dplyr)
library(stringr)

head(austen_books())
original_books <- austen_books() %>%   group_by(book) %>%   mutate(linenumber = row_number(),  chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",  ignore_case = TRUE)))) %>%  ungroup()

original_books

#To work with this as a tidy dataset, we need to restructure it in the one-token-per-row format, which as we saw earlier is done with the unnest_tokens() function.


library(tidytext)
tidy_books <- original_books %>%   unnest_tokens(word, text)

tidy_books

data(stop_words)

tidy_books <- tidy_books %>%  anti_join(stop_words)
tidy_books
tidy_books %>% dplyr::count(word, sort=T) 


library(ggplot2)

tidy_books %>%   dplyr::count(word, sort = TRUE) %>%   filter(n > 600) %>%   mutate(word = reorder(word, n)) %>%   ggplot(aes(word, n)) +   geom_col() +   xlab(NULL) +   coord_flip()

#A common task in text mining is to look at word frequencies, just like we have done above for Jane Austen’s novels, and to compare frequencies across different texts.

library(gutenbergr)

hgwells <- gutenberg_download(c(35, 36, 5230, 159))

tidy_hgwells <- hgwells %>%  unnest_tokens(word, text) %>%  anti_join(stop_words)

tidy_hgwells %>%  dplyr::count(word, sort = TRUE)




#https://www.tidytextmining.com/tidytext.html
#tm_map(docs, content_transformer(gsub), pattern='presi', replacement='president')