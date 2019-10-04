#Apply family of functions in R ----
#kanika & abhinav
#Why use Apply when for loop is faster
# Execution time of Apply() fxn is faster then  For Loop.
# Example:
# Getting the row means, of every row, of two columns in the following 10000 row dataframe:
N <- 10000
x1 <- runif(N)
x2 <- runif(N)
d <- as.data.frame(cbind(x1, x2))
head(d)

# Loop: create a vector to store the results in
rowMeanFor <- vector("double", N)

#for Loop  
for (i in seq_len(N)) {
    rowMeanFor[[i]] <- mean(c(d[i, 1], d[i, 2]))
  }
rowMeanFor  
# Apply:
rowMeanApply <- apply(d, 1, mean)
rowMeanApply  
# Checking whether the two results, one from loop & another from apply() are equal.
all.equal(rowMeanFor, rowMeanApply)
  
  
# Comparing the time to do this calculation using a for loop and using apply() # We use system.time(expr) to know how fast R processes an expression.# This function is especially useful for comparing the speed of two coding options. # It gives: "User CPU time" & "system CPU time".# "User CPU time" gives the CPU time spent by the current process (i.e., the current R session) and #"system CPU time" gives the CPU time spent by the kernel (the operating system) on behalf of the current process. # The output lists durations in seconds.
# Time to do this using the For loop:
system.time (
            for (i in seq_len(N)) {
              rowMeanFor[[i]] <- mean(c(d[i, 1], d[i, 2]))
            })

# Time to do this using the apply function:
system.time( rowMeanApply <- apply(d, 1, mean))

#Hence, using apply() fxn instead of Loops make executin faster and code simpler.

# Apply() fxn:
# Example:Sum a matrice over all the columns
m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
m1
a_m1 <- apply(m1, 2, sum)
a_m1
class(a_m1)
str(a_m1)
a_m2 <- apply(m1, 1, mean)
a_m2
class(a_m2)
str(a_m2)
  
# Note:apply() returns output in vector, list or array.
  
# lapply() fxn:
# Example: Change the string value of matrix to lower case with tolower function.
movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-lapply(movies, tolower)
str(movies_lower)
  
# sapply() fxn:
# Example: Measure the minimum speed and stopping distances of cars from the cars dataset.
  
dt <- cars
(lmn_cars <- lapply(dt, min))
(smn_cars <- sapply(dt, min))
(lmxcars <- lapply(dt, max))
(smxcars <- sapply(dt, max))

# Note: 
# sapply() returns output in vector/matrix whereas 
# lapply() retuns output in list.
