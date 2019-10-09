#correllogram

library(dplyr)
library(ggplot2)

df=mtcars
catcols = c('cyl', 'vs', 'am', 'gear', 'carb')
df[,catcols] = lapply(df[,catcols], as.factor)

sapply(df, class)

library(corrgram)
corrgram(df, order=TRUE, lower.panel=panel.shade,   upper.panel=panel.pie, text.panel=panel.txt, main="Car Mileage Data in PC2/PC1 Order")

corrgram(df, order=TRUE, lower.panel=panel.ellipse, upper.panel=panel.pts, text.panel=panel.txt,   diag.panel=panel.minmax, main="Car Mileage Data in PC2/PC1 Order")

corrgram(df, order=NULL, lower.panel=panel.shade, upper.panel=NULL, text.panel=panel.txt,  main="Car Mileage Data (unsorted)")



#
library(corrplot)
M<-cor(mtcars)
head(round(M,2))
corrplot(M, method="circle")

corrplot(M, method="pie")
corrplot(M, method="color")
corrplot(M, method="number")
corrplot(M, type="upper")
corrplot(M, type="lower")

# correlogram with hclust reordering
corrplot(M, type="upper", order="hclust")

# Using different color spectrum
col<- colorRampPalette(c("red", "white", "blue"))(20)
corrplot(M, type="upper", order="hclust", col=col)

# Change background color to lightblue
corrplot(M, type="upper", order="hclust", col=c("black", "white"),         bg="lightblue")


library(RColorBrewer)
corrplot(M, type="upper", order="hclust",  col=brewer.pal(n=8, name="RdBu"))


corrplot(M, type="upper", order="hclust",  col=brewer.pal(n=8, name="RdYlBu"))

corrplot(M, type="upper", order="hclust",    col=brewer.pal(n=8, name="PuOr"))

corrplot(M, type="upper", order="hclust", tl.col="black", tl.srt=45)



#http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram




#advanced----------------------

# mat : is a matrix of data
# ... : further arguments to pass to the native R cor.test function
cor.mtest <- function(mat, ...) {
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat<- matrix(NA, n, n)
  diag(p.mat) <- 0
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(mat[, i], mat[, j], ...)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
    }
  }
  colnames(p.mat) <- rownames(p.mat) <- colnames(mat)
  p.mat
}
# matrix of the p-value of the correlation
p.mat <- cor.mtest(mtcars)
head(p.mat[, 1:5])

# Specialized the insignificant value according to the significant level
corrplot(M, type="upper", order="hclust",   p.mat = p.mat, sig.level = 0.01)


#Add significance level to the correlogram
# Specialized the insignificant value according to the significant level
corrplot(M, type="upper", order="hclust",         p.mat = p.mat, sig.level = 0.01)

# Leave blank on no significant coefficient
corrplot(M, type="upper", order="hclust", p.mat = p.mat, sig.level = 0.01, insig = "blank")


#Customize the correlogram
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(M, method="color", col=col(200),  
         type="upper", order="hclust", 
         addCoef.col = "black", # Add coefficient of correlation
         tl.col="black", tl.srt=45, #Text label color and rotation
         # Combine with significance
         p.mat = p.mat, sig.level = 0.01, insig = "blank", 
         # hide correlation coefficient on the principal diagonal
         diag=FALSE 
)
