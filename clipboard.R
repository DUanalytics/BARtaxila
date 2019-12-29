#Clipboard


saveFrom <- clipboard()

rawx <- "34"
writeClipboard(rawx)

write.table(mtcars, "clipboard", sep="\t", row.names=FALSE)
write.table(x, "clipboard", sep="\t", row.names=FALSE, col.names=FALSE)

#large data
write.table(mtcars, "clipboard-16384", sep="\t", row.names=FALSE)


library(clipr)

## Not run:
clip_text <- read_clip()

#Save from / to clipboard

df = mtcars


write.table(x, "clipboard", sep="\t", row.names=FALSE)
write.table(x, "clipboard", sep="\t", row.names=FALSE, col.names=FALSE)


library(clipr)
#https://cran.r-project.org/web/packages/clipr/clipr.pdf
## Not run:
clip_text <- read_clip()
clip_text


read_clip_tbl(x = read_clip(), ...)