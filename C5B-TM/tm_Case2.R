# Labels Analysis of Chats

library(zip)

#fileloc = "E:/analytics/dataSets/DMBAR/amz.zip"
fileloc = "https://drive.google.com/file/d/1il8xDmK04bHz7ozWcT9uEagjBqlZxSLZ/view?usp=sharing"
corp1 <- Corpus(ZipSource(fileloc, recursive=T))
corp1
inspect(corp1)
#array of records tables
#label <- c(rep(1,1000), rep(0,1000))

corp2 <- tm_map(corp1, stripWhitespace)
corp3 <- tm_map(corp2, removePunctuation)
corp4 <- tm_map(corp3, removeNumbers)

corp5 <- tm_map(corp4, removeWords, stopwords('english'))
corp6 <- tm_map(corp5, stemDocument)
tdm1 <- TermDocumentMatrix(corp5)
tfidf <- weightTfIdf(tdm1)
inspect(tfidf)

#categorising documents into concepts : dim=3
#https://en.wikipedia.org/wiki/Latent_semantic_analysis
library(lsa)
lsa.tfidf <- lsa(tfidf, dim=3)
lsa.tfidf
words.df <- as.data.frame(as.matrix(lsa.tfidf$dk))
head(words.df)

