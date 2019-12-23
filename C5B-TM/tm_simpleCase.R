#Simple Case of TM

library(tm)
text <- c("This is first    sentence !", "This is the Second sentence ?", "There are 3 sentences in this vector")
text
corp1 <- Corpus(VectorSource(text))
corp1
tdm <- TermDocumentMatrix(corp1)
tdm
inspect(tdm)

#tokenisation
corp2 <- tm_map(corp1, stripWhitespace)  #space
corp2
inspect(corp2)
corp3 <- tm_map(corp2, removePunctuation)
corp3
inspect(corp3)
tdm2 <- TermDocumentMatrix(corp3)
inspect(tdm2)


#Text Reduction
stopwords("English")

library(SnowballC)
inspect(corp3)
corp4 <- tm_map(corp3, removeWords, stopwords('English'))
inspect(corp4)

#stemming
#different variants of words to one word
#sentences sentence -> sentenc
corp5 <- tm_map(corp4, stemDocument)
inspect(corp5)

tdm3 <- TermDocumentMatrix(corp5)
inspect(tdm3)

#Tf-IDF
tfidf <- weightTf(tdm3)
inspect(tfidf)
#no of times a term t appears in a document d