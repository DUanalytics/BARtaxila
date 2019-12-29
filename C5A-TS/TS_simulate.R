#Simulate a TS

#A time series, in which the observations fluctuate around a constant mean, have continuous variance and stochastically independent, is a random time series. Such time series doesn't exhibit any pattern:
#Observations do not tend upwards or downwards
#Variance does not increase or decrease with time
#Observations do not tend to be large in some periods than others

#Simulation of a random time series
# purely random process with mean 0 and standard deviation 1.5
eps <- rnorm(100, mean = 0, sd = 1)
mu <- 2 # the constant mean
# The process
X_t <- mu + eps

# plotting the time series
ts.plot(X_t, main = "Example of (random) stationary time series", ylab = expression(X[t]))
#The simulated process fluctuates around the constant mean μ=2.


#Random Walk
# seed X_0 = 0
X <- 0
# purely random process with mean 0 and standard deviation 1.5
Z <- rnorm(100, mean = 0.5, sd = 1.5)

# the process
for (i in 2:length(Z)){
  X[i] <- X[i-1] + Z[i]
}

# process plotting
ts.plot(X, main = "Random walk process")
