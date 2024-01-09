library(shinydashboard)
library(leaflet)
library(dplyr)
library(curl) 

function(input, output, session) {
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
