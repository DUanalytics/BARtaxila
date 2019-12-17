#Time Series - Date Time

library(hms)

hms(56, 34, 12)
#> 12:34:56
as_hms(1)
#> 00:00:01
as_hms("12:34:56")
#> 12:34:56
as_hms(Sys.time())
#> 11:18:52.496955
as.POSIXct(hms(1))
#> [1] "1970-01-01 00:00:01 UTC"

data.frame(hours = 1:3, hms = hms(hours = 1:3))

