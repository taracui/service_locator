shinyServer(function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    #build regular expression to search for selected area(s) and specialty population(s)
    search_string <- function(x){
      for(i in 1:length(x)){
        if(i==1){
          string <- x[i]
        } else{
          string <- paste(string, x[i], sep = "|")
        }
      }
      return(string)
    }
    search_pop <- search_string(input$specialty_pop)
    
    search_area <- as.character(substr(input$service_area, 1, 1))
    
#     if(!is.null(input$specialty_pop)){
#       subset(service_df, grepl(search_pop, specialty_pop, ignore.case = T) & 
#              grepl(search_area, service_area, ignore.case = T))
#     }else{
#       subset(service_df, grepl(search_area, service_area, ignore.case = T))
#     }
    if(input$service_area == "All Areas" & is.null(input$specialty_pop)){
      service_df
    }else if(input$service_area == "All Areas" & !is.null(input$specialty_pop)){
      subset(service_df, grepl(search_pop, specialty_pop, ignore.case = T))
    }else if(!input$service_area == "All Areas" & is.null(input$specialty_pop)){
      subset(service_df, grepl(search_area, service_area, ignore.case = T))
    }else if(!input$service_area == "All Areas" & !is.null(input$specialty_pop)){
      subset(service_df, grepl(search_pop, specialty_pop, ignore.case = T) & 
               grepl(search_area, service_area, ignore.case = T))
    }
  })
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet() %>%
      addLegend("bottomleft", colors = c("red", "goldenrod", "chartreuse", "springgreen", "cyan",
                                         "blue", "purple", "deeppink"),
                labels = c("1 - Antelope Valley", "2 - San Fernando Valley", "3 - San Gabriel Valley", "4 - Central Los Angeles",
                           "5 - West Los Angeles", "6 - South Los Angeles", "7 - East Los Angeles", "8 - South Bay"),
                title = "Service Area Legend", opacity = 0.7)
    
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  
  #add Markers for selected matched agencies
  observe({
    if(nrow(filteredData()) > 0){
    leafletProxy("map") %>%
      clearMarkers() %>%
      addMarkers(data = filteredData(), ~lon, ~lat, popup = ~as.character(content2))
    }else{
      leafletProxy("map") %>%
        clearMarkers()
    }
  })
  
  #Add shape files for each service area
  observe({
    #color for each service area
    factpal <- colorFactor(rainbow(8), areas$slug)
    
    leafletProxy("map") %>%
      addPolygons(data = areas, stroke = F, color = ~factpal(slug), fillOpacity = 0.5, smoothFactor = 0.2) %>%
      addProviderTiles("Stamen.Toner", options = providerTileOptions(opacity = 0.25)) %>%
      setView(lat = 34.079279, lng = -117.887257, zoom = 10)
  }) 
})
