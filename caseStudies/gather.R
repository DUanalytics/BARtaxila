#dplyr - seperate - gather
library(dplyr)

campus = paste('C',1:6,sep='')
head  = c('Operational','Capital','Salaries')
df <- expand.grid(campus, head)
colnames(df) =c('campus', 'head')
(exp = round(matrix(data= rnorm(18 * 5, mean=100, sd=10), nrow=18)))
colnames(exp) = c(2015:2019)
head(exp)
expenditure <- cbind(df, exp)
class(expenditure)

head(expenditure)  # for brevity only display first 6 rows

expenditure 
write.table(expenditure, "clipboard", sep="\t", row.names=FALSE)

library(gsheet)
link="https://docs.google.com/spreadsheets/d/1D9WaU_CZUyLiZv0TyjFX8pgdJ1WIOh99n37BWvwRAz4/edit#gid=1944891597"

df = as.data.frame(gsheet2tbl(link))
head(df)
class(df)
df %>% tidyr::gather(variable, value, -c(campus, head))



(2001 = round(rnorm(3, mean=100, sd=10)))
(2002 = round(rnorm(3, mean=120, sd=15)))
(2003 = round(rnorm(3, mean=70, sd=5)))
group = c('H1','H2','H3')

data <- data.frame(group, 2001, 2002, 2003)
data
data %>% tidyr::gather(variable, value, -group) %>%  tidyr::separate(variable, into=c("X", "Year"), sep="X") %>%   select(-X)


#https://rpubs.com/bradleyboehmke/data_wrangling

