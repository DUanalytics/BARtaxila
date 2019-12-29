#if else , recode

#https://mgimond.github.io/ES218/Week03a.html

x <- c(12,102, 43, 20, 90, 0, 12, 6)
x
ifelse(x < 23, 1, 0)

#The base ifelse function works as expected when the input/output values are numeric or character, but does not work as expected when applied to factors or dates. For example, if you wish to replace one factor level with another, the following example will not return the expected output.

x <- as.factor( c("apple", "banana", "banana", "pear", "apple"))
x
ifelse(x == "pear", "apple", x)

#The output is a character representation of the level number (recall that factors encode level values as numbers behind the scenes, i.e. apple =1, banana=2, etc…). Likewise, if you wish to replace an erroneous date with a missing value you will get:

library(lubridate)
y <- mdy("1/23/2016", "3/2/2016", "12/1/1901", "11/23/2016")
y
ifelse( year(y) != 2016, NA, y)

#Here, ifelse converts the date object to its internal numeric representation as number of days since 1970.
#If you want to ensure that the data type is preserved, a safer alternative is to use dplyr’s if_else function. dplyr’s if_else
library(dplyr)
#if_else function (note the underscore _), will preserve data type but does so strictly. For example, the following code will return an error:
y <- mdy("1/23/2016", "3/2/2016", "12/1/1901", "11/23/2016")
dplyr::if_else( year(y) != 2016, NA, y)

#he output data types (NA and y) are not treated the same (by seeing NA, the function assumes that the output must be logical which y is not). The solution is to force NA as a date object by wrapping it with a date function like mdy(NA):
if_else( year(y) != 2016, mdy(NA), y)

#likewise, if the input vector is of type character, you need to ensure that all output values are characters too.
y <- c("apple", "banana", "banana", "pear", "apple")
y
if_else( y == "banana", as.character(NA), y)

# has several NA reserved words for different data types (e.g. NA_character_ and NA_integer_ to name a few). So the last chunk of code could have been written as,

if_else( y == "banana", NA_character_, y)

#no reserved word for NA date types in which case you would coerce NA to date using built-in functions like as.Date(NA) or lubridate functions like mdy(NA) as demonstrated in an earlier

#----------------
#Recoding factors using recode
#When working with factors, however, if_else (as of dplyr version 0.7) will produce the following error:
if_else(x == "pear", "apple", x)
#Error: `false` must be type character, not integer

#R sees apple as a character and x as a number (i.e. the numeric representation of the factor level). A better option for recoding factors is to use dplyr’s recode function:
x  
recode(x , "pear" = "apple")

#recode more than one factor level. In fact, you can even introduce new levels in the recoding scheme:
recode(x , "pear" = "apple", "banana" = "pineapple" )

#As with if_else and case_when, recode is strict about preserving data types. So if you want to recode a level to NA make sure to use NA_character_ or as.character(NA).

#Note that recode can also be used with numeric and character data types. For example,

# Example of recoding a character vector
recode(y , "pear" = "apple", "banana" = "pineapple" )


#Note on replacing NA factor levels
#One operation you cannot perform with recode is converting an NA level to another factor level. For example, the following will generate an error message:
x[2] <- NA
x
#[1] apple  <NA>   banana pear   apple 
recode(x, NA = "other")
#Error: unexpected '=' in "recode(x, NA ="

#he simplest solution is to make use of a specialized factor package called forcats and its function, fct_explicit_na.

library(forcats)
x[2] <- NA
x
fct_explicit_na(x, na_level = "Other")


#Case-----
#Changing values based on multiple conditions: case_when
#ifelse and if_else work great when a single set of conditions is to be satisfied. But if multiple sets of conditions are to be tested, nested if/else statements become cumbersome and are prone to clerical error. The following code highlights an example of nested if/else statements.

unit <- c("F","F","C", "K")
unit
if_else( unit == "C", "Celsius", if_else(unit == "F", "Fahrenheit", "Kelvin"))
#[1] "Fahrenheit" "Fahrenheit" "Celsius"    "Kelvin"    

#A simpler solution is to use the recode function discussed in the previous section.
recode(unit, "C" = "Celsius",  "F" = "Fahrenheit", "K" = "Kelvin")

#recode is well suited for replacing values but it will not allow for more complex operations. For example, given two vectors, unit and temp, we would like to convert all temp values to Fahrenheit by applying a temperature conversion dependent on the unit value.

temp <- c(45.2, 56.3, 11.0, 285)
#This operation is best performed using the case_when function.
unit
temp
case_when(unit == "F" ~ temp,  unit == "C" ~ (temp * 9/5) + 32, TRUE ~ (temp - 273.15) * 9/5 + 32)

#The last parameter, TRUE ~, applies to all conditions not satisfied by the previous two conditions (otherwise, not doing so would return NA values). Note that the order in which these conditions are listed matters since evaluation stops at the first TRUE outcome encountered. So, had the last condition been moved to the top of the stack, all temp values would be assigned the first conversion option.

# What not to do ...
case_when(TRUE ~ (temp - 273.15) * 9/5 + 32,
          unit == "F" ~ temp,
          unit == "C" ~ (temp * 9/5) + 32)
#As with the if_else function, case_when is strict about data type in that all output must be of the same data type.

#Note that ifelse, if_else, recode and case_when can all be used inside of a mutate function. For example, to replace Canada and United States of America in variable Country with CAN and USA respectively and to create a new variable called Type which will take on the values of 1, 2 or 3 depending on the values in variable Source, type the following: