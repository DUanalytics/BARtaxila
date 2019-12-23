#world Cloud from File
#find which words were used and their density in graphical way

# Read the text file from file
text <- readLines(file.choose())
text
text[1:5]
# Load the data as a corpus
docs = Corpus(VectorSource(text))
docs #line count

#Text transformation
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))  #create a function
docs <- tm_map(docs, toSpace, "/")
docs
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

#Cleaning Text
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
inspect(docs[1:5])
# Remove numbers
docs <- tm_map(docs, removeNumbers)
inspect(docs[1:5])
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
inspect(docs[1:5])
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
#docs <- tm_map(docs, stemDocument)
inspect(docs[1:5])
#Document Matrix
dtm <- TermDocumentMatrix(docs)
dtm
inspect(dtm)  #sample
m <- as.matrix(dtm)
head(m)
dim(m)
v <- sort(rowSums(m),decreasing=TRUE)
v
d <- data.frame(word = names(v),freq=v)
head(d, 10)

#Generate Word Cloud
par(mar=c(0,0,0,0))
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,  max.words=200, random.order=FALSE, rot.per=0.35,    colors=brewer.pal(8, "Dark2"))

findFreqTerms(dtm, lowfreq = 4)
findAssocs(dtm, terms = "india", corlimit = 0.3)
head(d, 10)

#Plot Freq
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,  col ="lightblue", main ="Most frequent words",  ylab = "Word frequencies")
