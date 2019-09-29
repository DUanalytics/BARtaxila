#sample

set.seed(1234)
sample(1:10)

#
LETTERS[1:26]
sample(LETTERS[1:26])

?sample
sample(x=LETTERS[1:26], size=100, replace=T)

gender = c('M','F')
gender
sample(x=gender)
sample(x=gender, size=100)  #error
sample(x=gender, size=100, replace=T)
x=sample(x=gender, size=100, replace=T)
x
table(x)
x2=sample(x=gender, size=10000, replace=T, prob=c(.4,.6))
table(x2)
