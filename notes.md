
#######################
#
######################

# Example
# http://mybinder.org/v2/gh/lisatwyw/epi-gala/master?urlpath=examples/shiny/



# Ref: https://www.davidsolito.com/post/conditional-drop-down-in-shiny/

# Load library ----------------------------------------------------------
library(shiny)
library(sf)
library(shinythemes)
library(leaflet)
library(shinyBS)
library(raster)
library(stringr)
library(dplyr)
library(shinydashboard)
library(ggplot2)

variables_names = chsa_spatial_equity %>%
  distinct(index)%>% pull() %>%
  # str_subset(index, pattern = "^*_mean")
  str_subset(pattern = "^*_mean") %>%
  str_subset(pattern = "_idx_" )

variables_names_amenities = variables_names %>%
  str_subset(pattern = "acs_" ) %>% 
  as.data.frame() %>%
  mutate(index_cat = "Accessibility") %>%
  rename("choices" = '.')
# 
variables_names_proximity = variables_names %>%
  str_subset(pattern = "prxmity_" ) %>% 
  as.data.frame() %>%
  mutate(index_cat = "Proximity")%>%
  rename("choices" = '.')

choices_index = rbind(variables_names_amenities, variables_names_proximity) %>% left_join(data_labels, by = c("choices" = "recode_chsa_mean"))

# Shiny Dashboard ---------------------------------------------------------
body <- dashboardBody(
  fluidRow( # load("O:/BCCDC/Groups/Analytics/Data Science and Innovation/Geospatial Epi/p01_CANUE_data/b_script/Scripts/Spatial_Equity/data/data.RData") 
      fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/RData",
                         "text/plain",
                         ".RData")),
      # Horizontal line ----
      tags$hr()
  )
  fluidRow(
    box(
      title = "Saptial Distribution", width = 6, height = 1220, status = "primary",solidHeader = TRUE,
      column(width = 12,
              bsCollapsePanel("Input Parameters",
                      selectInput(inputId = "index_group", 
                                  label = "Select an Index Group",
                                  choices = c("Accessibility","Proximity"),
                                  selected = "Accessibility"),
                      # Fund selector
                      selectizeInput(
                        inputId = "index",
                        label = "Select an Index:",
                        # We can initialize this as NULL because
                        # we will update in the server function.
                        choices = NULL,
                        multiple = FALSE
                        ),
                      sliderInput("bin", "Select number of bins for map",
                                  min = 1, max = 15,
                                  value = 5, step = 1, width = '40%')
                      )),
      column (width = 12, height = 12,
              tags$style(type = "text/css", "#map {height: calc(100vh - 200px) !important;}"),
              # leafletOutput("map")
              leafletOutput("map")),
    ),
    box(title = " Place Score Card", solidHeader = TRUE, status = "primary", width = 6, height = 1220,
        # "Box content",
        plotOutput("plot_region", width = "100%"),
        plotOutput("plot_db_level", width = "100%"),
        plotOutput("plot_chsa_level", width = "100%")
      #   column(width = 12,
      #          box(
      #          title = "Index comparision to the region", width = NULL, solidHeader = TRUE, status = "primary", height = 1120,
      #          plotOutput("plot_region", width = "100%")
      #        )
      # )

    )
  )
)


# We'll save it in a variable `ui` so that we can preview it in the console
ui <- dashboardPage(
  dashboardHeader(title = "Spatial Equity Indicators",
                  titleWidth = 1400),
  dashboardSidebar(disable = T, width = 350),
  body
)

server <- function(input, output, session) {
  # Whatever is inside `observeEvent()` will be triggered each time the first
  # argument undergoes a change in value. In this case, that means whenever
  # the user changes the radio button value.
  observeEvent(input$index_group,
               {
                 # Use this function to update the choices for the user.
                 # First argument is session, next the input to update,
                 # and third the new choices. Here, I'm filtering the
                 # previously made data.frame to based on the series column,
                 # and returning the choices column. 
                 # `drop=TRUE` makes it explicit that I want a vector returned.
                 updateSelectizeInput(session, input = "index",
                                      choices = choices_index[choices_index$index_cat %in% input$index_group,
                                                      "short_description", drop = TRUE])
               })
  # generate data in reactive
  map_data <- reactive({
    filter_key <- choices_index %>%
      filter(short_description %in% input$index)
    
    chsa_spatial_equity %>% filter(index  %in% filter_key$choices)
    })
  
  data_m <- reactive({
    chsa_poly %>% 
      left_join(map_data(), by = c("CHSA22_TEX" = "CHSA22"))
  })
  
  # leaflet map
  output$map <- renderLeaflet({
    

    pal_sb <- colorQuantile("Purples", domain=data_m()$score, n = as.numeric(input$bin), na.color = "#bdbdbd")

    
    # leaflet(shapeData[shapeData$region == input$region, ]) %>%
    leaflet(data_m()) %>%
      setView(lng = -127.647621, lat = 53.726669, zoom = 5) %>%
      # filter(symptom %in% input$symptom)%>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(layerId = ~CHSA22_TEX, fillColor = ~pal_sb(data_m()$score),
                  color = 'grey',
                  fillOpacity = 1,
                  weight = 0.75,
                  smoothFactor = 0.4,
                  # label = ~LHA18_NAME,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    fillOpacity = 0.85,
                    bringToFront = TRUE))
    
    
  })
  
  output$plot_region<-renderPlot({
    barplot(height=data_m()$score, names=data_m()$CHSA22 , 
            col=rgb(0.8,0.1,0.1,0.6),
            xlab="CHSA", 
            ylab="Score", 
            main=input$index, 
            ylim=c(min(data_m()$score, na.rm=T),max(data_m()$score, na.rm=T))
    )+
      theme(axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.text.y=element_blank(),
            axis.ticks.y=element_blank())
  }, width = 840)
  
  
  output$plot_chsa_level <- renderPlot({
    
    ggplot(data_m(), aes(x=score)) + 
      geom_histogram(aes(y=..density..), colour="black", fill="white")+
      geom_density(alpha=.2, fill="#FF6666")+
      labs(y= "Score", x = "Distribution at CHSA level")+
      theme_classic()
    
    
    
  }, width = 840)
  
  
  
  filter_key <- reactive({
    choices_index %>%
      filter(short_description %in% input$index) %>%
      dplyr::select(recode) %>%
      pull()
  })
  

  output$plot_db_level <- renderPlot({
    
    data_plot <- spatial_equity_original %>%
      filter(index%in% filter_key())
      
    ggplot(data_plot, aes(x=score)) + 
      geom_histogram(aes(y=..density..), colour="black", fill="white")+
      geom_density(alpha=.2, fill="#FF6666")+
      labs(y= "Score", x = "Distribution at DB level")+
      theme_classic()
   
      
    
  }, width = 840)
  
}



# Preview the UI in the console
shinyApp(ui = ui, server)
