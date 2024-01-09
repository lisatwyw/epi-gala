#######################
#
######################

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


dashboardPage(
  dashboardHeader(title = "Spatial Equity Indicators",
                  titleWidth = 1400),
  dashboardSidebar(disable = T, width = 350),
  body
)




# Preview the UI in the console
# shinyApp(ui = ui, server)
