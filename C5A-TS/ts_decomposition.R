#TS - Decompoistion


kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings
tskings <- ts(kings)

decompose(birthstimeseries)