shinyUI(bootstrapPage(
    tags$style(type = 'text/css', href='https://fonts.googleapis.com/css?family=Source+Sans+Pro', 
               rel='stylesheet', "html, body {width:100%;height:100%}",
               ".selectize-input {color: black; font-family: 'Source Sans Pro', sans-serif; font-size: 12px }",
               ".selectize-dropdown {color: black; font-family: 'Source Sans Pro', sans-serif; font-size: 12px }", 
               ".checkbox {color: black; font-family: 'Source Sans Pro', sans-serif; font-size: 12px }", 
               ".legend {color: black; font-family: 'Source Sans Pro', sans-serif; font-size: 12px }",
               "h4{color: black; font-family: 'Source Sans Pro', sans-serif; font-size: 18px; font-face: 'bold';}",
               "h5{color: black; font-family: 'Source Sans Pro', sans-serif; font-size: 14px; font-face: 'underline';}",
               "p{color: black; font-family: 'Source Sans Pro', sans-serif; font-size: 12px;}"), 
  
  leafletOutput("map", width = "100%", height = "100%"),

    absolutePanel(right = 0, top = 0, width = 450, bottom = 5,
              wellPanel(width = "100%", height = "100%", titlePanel(h4("Los Angeles County Non-Profit Service Locator")),
                        p("This service navigator was designed to assist community members
                          and non-profit agencies in locating and obtaining information about 
                          social services available in LA County.  Please click the markers for 
                          more agency information. Each marker represents the agency's main contact office."),
                selectInput(inputId = "service_area", label = h5("Select Area Served:"), 
                            choices = c("All Areas",
                                        "1 - Antelope Valley", 
                                        "2 - San Fernando Valley",
                                        "3 - San Gabriel Valley",
                                        "4 - Metro LA",
                                        "5 - West LA",
                                        "6 - South LA",
                                        "7 - East LA",
                                        "8 - South Bay",
                             value = "2 - San Fernando Valley")
                            ),
                checkboxGroupInput("specialty_pop", label = h5("Select Specialty Population(s):"),
                                   choices = c("API", "Birth to Five", "Developmental Disabilities",
                                               "Homeless", "LGBTQ", "Older Adults", "TAY" 
                                               ), 
                                   selected = NULL), 
               tags$u(h5("Service Abbreviation Key")),
                      p("API = Asian Pacific Islander", br(),
                        "COS = Community Outreach Services", br(),
                        "EYS = Emergency Youth Shelter", br(),
                        "FCCS = Field Capable Clinical Services", br(),
                        "FFA = Foster Family Agency", br(),
                        "FSP = Full Service Partnership", br(),
                        "ICM = Integrated Clinic Model", br(),
                        "IMHT = Integrated Mobile Health Team", br(),
                        "ISM = Integrated Service Management Model", br(),
                        "PEI = Prevention and Early Intervention", br(),
                        "TAY = Transition Age Youth", br(), br())
                    ))
  ))
              
  


  

