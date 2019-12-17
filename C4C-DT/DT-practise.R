#DT
#http://www.milbo.org/rpart-plot/prp.pdf

library(rpart)
library(rpart.plot)
data("ptitanic")
data(ptitanic)

data(trees)
volume <- rpart(Volume ~ ., data = trees)
rpart.plot(volume, type = 3, clip.right.labs = FALSE, branch = .3, under = TRUE)
rpart.rules(volume)

data(ptitanic)
survived <- rpart(survived ~ ., data = ptitanic, cp = .02)
rpart.plot(survived, type = 3, clip.right.labs = FALSE, branch = .3, under = TRUE)
rpart.rules(survived, cover = TRUE)

rpart.rules(survived) # default roundint = TRUE
rpart.rules(survived, roundint = FALSE)
rpart.rules(survived, clip.facs = TRUE)
#dropping predictor names for factors.
rpart.rules(survived, extra = 4, cover = TRUE)

#overall prob
rpart.rules(survived, extra = 9, cover = TRUE)
rpart.predict(survived, newdata=ptitanic[1:3,], rules=TRUE)
rpart.plot(survived)
rpart.plot(survived, tweak = .8)

prp(survived)
prp(survived, compress=T,  xcompact = T, ycompress=T, ycompact = T)
#
tree <- rpart(age ~ ., data = ptitanic)
tree

data(ptitanic)
tree <- rpart(survived ~ ., data = ptitanic, cp = .012)
new.tree <- prp(tree, snip = TRUE)$obj # interactively trim the tree
prp(new.tree)
prp(tree, branch.type = 5, yesno = FALSE, faclen = 0)

#heattreee
heat.tree <- function(tree, low.is.green = FALSE, ...) { # dots args passed to prp
  y <- tree$frame$yval
  if(low.is.green)
    y <- -y
  max <- max(y)
  min <- min(y)
  cols <- rainbow(99, end = .36)[
    ifelse(y > y[1], (y-y[1]) * (99-50) / (max-y[1]) + 50,
           (y-min) * (50-1) / (y[1]-min) + 1)]
  prp(tree, branch.col = cols, box.col = cols, ...)
}
heat.tree(tree, type = 4, varlen = 0, faclen = 0, fallen.leaves = TRUE)

rpart.plot(tree, type = 4, extra = 0, branch.lty = 3, box.palette = "RdYlGn")


complexities <- sort(unique(tree$frame$complexity)) # a vector of complexity values
for(complexity in complexities) {
  cols <- ifelse(tree$frame$complexity >= complexity, 1, "gray")
  dev.hold() # hold screen output to prevent flashing
  prp(tree, col = cols, branch.col = cols, split.col = cols)
  dev.flush()
  Sys.sleep(1) # pause for one second
}


tree1 <- rpart(survived ~ ., data = ptitanic)
par(mfrow = c(4,3))
for(iframe in 1:nrow(tree1$frame)) {
  cols <- ifelse(1:nrow(tree1$frame) <= iframe, "black", "gray")
  prp(tree1, col = cols, branch.col = cols, split.col = cols)
}
