#Time Series - Imputing missing values

#https://cloud.r-project.org/web/packages/imputeTS/vignettes/imputeTS-Time-Series-Missing-Value-Imputation-in-R.pdf

library(imputeTS)
#Simple Imputation Imputation Plots & Statistics Datasets
#na_locf - locf Imputation by Last Observation Carried Forward; nocb Imputation by Next Observation Carried Backward
#na_ma - simple Missing Value Imputation by Simple Moving Average; linear Missing Value Imputation by Linear Weighted Moving Average ; exponential Missing Value Imputation by Exponential Weighted Moving Average
#na_mean - mean MissingValue Imputation by Mean Value ;median Missing Value Imputation by Median Value ;mode Missing Value Imputation by Mode Value ;na_random Missing Value Imputation by Random Sample ;na_replace Replace Missing Values by a Defined Value
#na_remove Remove Missing Values

#--------------
#Dataset Description
# tsAirgap Time series of monthly airline passengers (with NAs)
# tsAirgapComplete Time series of monthly airline passengers (complete)
# tsHeating Time series of a heating systems’ supply temperature (with NAs)
# tsHeatingComplete Time series of a heating systems’ supply temperature (complete)
# tsNH4 Time series of NH4 concentration in a waste-water system (with NAs)
# tsNH4Complete Time series of NH4 concentration in a waste-water system (complete)


#
# Create a short example time series with missing values
x <- ts(c(1, 2, 3, 4, 5, 6, 7, 8, NA, NA, 11, 12))
x
mean(x)
mean(x, na.rm=T)
# Impute the missing values with na_mean
na_mean(x)
na_mean(x, option="median")



#
tsAirgap
# Impute the missing values with na_kalma
imp <- na_kalman(tsAirgap)
#Code for visualization
plotNA.imputations(tsAirgap, imp, tsAirgapComplete)
#istribution of missing values within a time series. Therefore, the time
#series is plotted and whenever a value is NA the background is colored differently. This gives a niceoverview, where in the time series most of the missing values occur

plotNA.distribution(tsAirgap)


#plotNA.distributionBar
#This function also visualizes the distribution of missing values within a time series. This is done as a barplot, which is especially useful if the time series would otherwise be too large to be plotted. Multiple observations for time intervals are grouped together and represented as bars.

# Visualize the missing values in this time series
plotNA.distributionBar(tsHeating, breaks = 20)

#tsHeating series is with over 600.000 observations a very
#large time series. While the missing values in the tsAirgap series (144 observations) can be visualized with plotNA.distribution like in Figure 2, this would for sure not work out for tsHeating. There just isn’t enough space for 600.000 single consecutive observations/points in the plotting area. The plotNA.distributionBar function solves this problem. Multiple observations are grouped together in intervals. The ’breaks’ parameter in the example defines that there should be 20 intervals used. This means every interval in Figure 3 represents approximately 30.000 observations. The first five intervals are completely green, which means there are no missing values present. This means from observation 1 up to observation 150.000 there are no missing values in the data. In the middle and at the end of the series there are several intervals each having around 40% of missing data. This means in theseintervals 12.000 out of 30.000 observation are NA. All in all, the plot is able to give a nice but rough overview about the NA distribution in very large time series

#plotNA.gapsize----
#This plotting function can be used to visualize how often different NA gaps (NAs in a row) occurin a time series. The function shows this information as a ranking. This ranking can be ordered by total NAs gap sizes account for (number occurrence gap size * gap length) or just by the number of occurrences of gap sizes. In the end the results can be read like this: In time series x, 3 NAs in a row occur most often with 20 occurrences, 6 NAs in a row occur 2nd most with 5 occurrences, 2 NAs in a row occur 3rd most with 3 occurrences
# Visualize the top gap sizes / NAs in a row
plotNA.gapsize(tsNH4)



#statsNA----
#The statsNA function prints summary stats about the distribution of missing values in univariate time series. Here is a short explanation about the information it gives:
#Length of time series
#Number of observations in the time series (including NAs)
#Number of Missing Values
#Number of missing values in the time series
#Percentage of Missing Values Percentage of missing values in the time series
#Stats for Bins
#Number/percentage of missing values for the split into bins
#Longest NA gap
#Longest series of consecutive missing values (NAs in a row) in the time series
#Most frequent gap size
#Most frequent occurring series of missing values in the time series
#Gap size accounting for most NAs
#he series of consecutive missing values that accounts for most missing values overall in the time series
#Overview NA series
#Overview about how often each series of consecutive missing values occurs. Series occurring 0 times are skipped
# Print stats about the missing data
statsNA(tsNH4)



#Missing data is a very common problem for all kinds of data. However, in case of univariate time series most standard algorithms and existing functions within R packages cannot be applied. This paper presented the imputeTS package that provides a collection of algorithms and tools especially tailored to this task. Using example time series, we illustrated the ease of use and the advantages of the provided functions. Simple algorithms as well as more complicated ones can be applied in thesame simple and user-friendly manner. The functionality provided makes the imputeTS package a good choice for preprocessing
