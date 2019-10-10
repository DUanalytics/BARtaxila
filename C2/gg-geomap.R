#ggplot - spatial plot


# load packages
library(ggplot2)
library(ggmap)
library(ggalt)
library(tidyverse)

#needs an API
#https://console.cloud.google.com/google/maps-apis/overview?pli=1
#https://developers.google.com/maps/documentation/embed/get-api-key
#api <- readLines("google.api") # Text file with the API key
#https://stackoverflow.com/questions/32994634/this-api-project-is-not-authorized-to-use-this-api-please-ensure-that-this-api

api = 'AIzaSyBMB4igo-ShGeQmT5VKRaC3Ifq_6G0BKMg'
register_google(key = api)


# GetCoordinates --------------------------------
#jaipur <-  geocode("Jaipur")  # get longitude and latitude
locations <- c("Jaipur", "New Delhi", "Haldwani") %>%  geocode()
getOption("ggmap")


#this is paid now 
