#Case Study
#Let’s say we wanted to predict a persons income or wages. That would let us figure out what type of worker is making the most money, and whether there are any differences that might be caused by discriminaiton (against minorities for instance). We can look at that question using the data set in the package AER called PSID1982. The data is from the Panel Study of Income Dynamics and for the year 1982, so it’s a bit dated but it’s still useful to our question.

library(AER)
library(pander)

data(CASchools)
summary(lm(math~computer, data=CASchools))

data("PSID1982")

#variables we have to play with.

# experience - Years of full-time work experience.
# weeks - Weeks worked.
# occupation - factor. Is the individual a white-collar (“white”) or blue-collar (“blue”) worker?
#   industry - factor. Does the individual work in a manufacturing industry?
#   south - factor. Does the individual reside in the South?
#   smsa - factor. Does the individual reside in a SMSA (standard metropolitan statistical area)?
#   married - factor. Is the individual married?
#   gender - factor indicating gender.
# union - factor. Is the individual’s wage set by a union contract?
#   education - Years of education.
# ethnicity - factor indicating ethnicity. Is the individual African-American (“afam”) or not (“other”)?
#   wage - Wage.

# predict a persons wage.

# test the null hypothesis that whether someone works a blue collar or white collar job makes no difference in wages, and see if we can accept the alternative hypothesis that occupation does make a differnece.

summary(PSID1982)
table(PSID1982$occupation)
pander(t.test(PSID1982$wage~PSID1982$occupation))
table(PSID1982$union)
pander(t.test(PSID1982$wage~PSID1982$union))
?pander
library(reshape2)
dcast(PSID1982, union ~ occupation, value.var = "wage", fun.aggregate = mean)
summary(lm(wage~occupation+union, data=PSID1982))
summary(lm(wage~occupation+union+education+smsa+south+industry, data=PSID1982))
table(PSID1982$ethnicity)
pander(t.test(PSID1982$wage~PSID1982$ethnicity))
dcast(PSID1982, ethnicity ~ occupation, value.var = "wage", fun.aggregate = mean)
summary(lm(wage~occupation+ethnicity, data=PSID1982))
PSID1982$bluecollar <- ifelse(PSID1982$occupation=="blue", 1, 0)
summary(lm(bluecollar~ethnicity, data=PSID1982))
summary(lm(wage~occupation+ethnicity+experience+education, data=PSID1982))
summary(lm(wage~occupation+ethnicity+experience+education+union+gender+south+smsa+weeks+industry+married, data=PSID1982))

summary(lm(wage~occupation+experience+education+industry, data=PSID1982))
#For a worker in a blue collar occupation, we expect their wage to be 32 dollars lower, holding their education, experience, and industry constant, and that change is highly significant.
#For every 1 unit increase in experience, we expect them to increase their wages by 8.5 dollars, holding their occupation, education, and industry constant, and that difference is highly significant.
#For every 1 additional year of education a person earns, we expect their wages to increase by 79 dollars, holding their occupation, experience, and industry constant, and that change is highly significant.
#If a person works in manufacturing as opposed to other industries, we expect their salary to be 151 dollars higher, holding their experience, education, and occupation constant, and that change is highly significan

#https://bookdown.org/ejvanholm/Textbook/multiple-regression.html#predicting-wages