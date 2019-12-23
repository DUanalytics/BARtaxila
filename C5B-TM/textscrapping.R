#Extract words

#Loading Packages
library(tm)
library(wordcloud)
library(RColorBrewer)

link1 = "https://raw.githubusercontent.com/DUanalytics/BARtaxila/master/data/pmmodispeech.txt"
speech_txt = readLines(link1)
speech_txt


link2 = "https://raw.githubusercontent.com/DUanalytics/rAnalytics/master/78-textdocs/vit.txt"
speech_txt2 = readLines(link2)
speech_txt2

link3 ="https://successfulsocieties.princeton.edu/sites/successfulsocieties/files/TT_CleanIndia_Final.txt"
speech_txt3 = readLines(link3)
speech_txt3
