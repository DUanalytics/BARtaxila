#Git and R 

#https://cran.r-project.org/web/packages/projmgr/projmgr.pdf

install.packages('projmgr')

library(projmgr)

browse_docs('get', 'milestone')

experigit <- create_repo_ref(credentials.False)
check_rate_limit(experigit)
my_repo <- create_repo_ref("dupadhyaya", "rAnalytics")
browse_issues(my_repo)