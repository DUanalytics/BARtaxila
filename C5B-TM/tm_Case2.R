# Labels Analysis of Chats

library(zip)

fileloc = "E:/analytics/dataSets/DMBAR/AutoAndElectronics.zip"

corp1 <- Corpus(ZipSource("E:/analytics/dataSets/DMBAR/AutoAndElectronics.zip", recursive=T))
corp1
inspect(corp1)
#array of records tables
label <- c(rep(1,1000), rep(0,1000))

corp2 <- tm_map(corp1, stripWhitespace)
corp3 <- tm_map(corp2, removePunctuation)
corp4 <- tm_map(corp3, removeNumbers)

corp5 <- tm_map(corp4, removeWords, stopwords('english'))
corp6 <- tm_map(corp5, stemDocument)
tdm1 <- TermDocumentMatrix(corp5)
tfidf <- weightTfIdf(tdm1)
inspect(tfidf)

library(lsa)
lsa.tfidf <- lsa(tfidf, dim=20)
inspect(lsa.tfidf)
words.df <- ad.data.frame(as.matrix())
