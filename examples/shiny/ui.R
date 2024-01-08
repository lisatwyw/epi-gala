library(shinydashboard)
library(leaflet)

header <- dashboardHeader(
  title = "Test"
)

body <- dashboardBody(
  fluidRow(
    column(width = 9,
      box(width = NULL, solidHeader = TRUE,
        leafletOutput("map", height = 500)
      ),
      box(width = NULL,
        uiOutput("Table")
      )
    ),
    column(width = 3,
      box(width = NULL, status = "warning",
        uiOutput("Select"),
        checkboxGroupInput("Region", "Show",
          choices = c(
            Fraser Health = 4,
            Vancouver Coastal Health = 1,
            Northern Health = 2,
            Interior Health = 3,
            Island Health = 5
          ),
          selected = c(1, 2, 3, 4)
        ),
        p(
          class = "text-muted",
          paste("")          
        ),
        actionButton("zoomButton", "Zoom to fit")
      ),
      box(width = NULL, status = "warning",
        selectInput("interval", "Refresh interval",
          choices = c(
            "30 day" = 30,
            "1 y" = 365,
            "2 y" = 730,
            "5 y" = 1825,
            "10 y" = 3650
          ),
          selected = "30"
        ),
        uiOutput("timeSinceLastUpdate"),
        actionButton("calculate", "Calculate now"),
        p(class = "text-muted",
          br(),
          "Calculate"
        )
      )
    )
  )
)

dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)
