library(leaflet)
library(dplyr)
library(rgdal)
library(shiny)

#shape file to draw service areas
areas <- readOGR("data/OGRGeoJSON.shp", layer = "OGRGeoJSON", verbose = FALSE)

#full dataset with all agencies
service_df <- read.csv('data/member_data_geo.csv', stringsAsFactors = F)

#create popup HTML text
service_df <- service_df %>%
  mutate(content = paste(sep = "<br/>",
                         paste0("<b><a href='", website,"'>" , agency, "</a></b>"),
                         street,
                         city_state_zip,
                         paste0("<b>Age Group(s):</b> ", age_group),
                         paste0("<b>Service(s):</b> ", service_type)), 
         content2 = ifelse(nchar(service_area) == 1, content, paste(sep = "</br>", content,
                                                              paste0("Additional Service Area(s):", 
                                                                     substr(service_area, 3, nchar(service_area)))))
        
  )

#if agency serves multiple areas, drop pin on first location (additional info. in popup about other locations)
service_df <- service_df %>%
  mutate(first_loc = substr(service_area, 1, 1))



