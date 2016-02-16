library(RgoogleMaps)

setwd("/Users/Tara/Service_Locator/")

service_data <- read.csv("data/member_data2.csv", stringsAsFactors = FALSE)

service_data$city_state_zip <- paste0(service_data$city, ", ", service_data$state, " ", service_data$zip)

coords <- strsplit(service_data$coord, ",")

lat <- sapply(coords, "[", 1)

lon <- sapply(coords, "[", 2)

service_data$lat <- lat

service_data$lon <- lon

write.csv(service_data, "data/member_data_geo.csv", row.names = FALSE)


