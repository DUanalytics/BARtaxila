#Portfolio Optimisation

#https://cran.r-project.org/web/packages/PortfolioAnalytics/vignettes/portfolio_vignette.pdf

library(PortfolioAnalytics)
data(edhec)

head(edhec)
returns <- edhec[, 1:4]

head(returns)
colnames(returns) <- c("CA", "CTAG", "DS", "EM")
print(head(returns, 5))

fund.names <- colnames(returns)

pspec <- portfolio.spec(assets=fund.names)
print.default(pspec)


#Adding Constraints to the Portfolio Object
#The weight_sum constraint specifies the constraint on the sum of the weights. Aliases for the weight_sum constraint type include weight and leverage. Here we add a constraint that the weights must sum to 1, or the full investment constraint.

pspec <- add.constraint(portfolio=pspec, type="weight_sum", min_sum=1, max_sum=1)
pspec
