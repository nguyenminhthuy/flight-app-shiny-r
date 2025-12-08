source("ui/eda_panels/eda_airline.R")
source("ui/eda_panels/eda_delay.R")
source("ui/eda_panels/eda_overview.R")
source("ui/eda_panels/eda_airport.R")

nav_tab_eda <- function() {
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  )
  navbarMenu("EDA", 
             icon = icon("magnifying-glass-chart"),
             tabPanel(
               "Flight Overview",
               icon = icon("plane"),
               value = "eda_overview",
               eda_overview_ui()
             ),
             
             tabPanel(
               "Delay Analysis",
               icon = icon("hourglass-half"),
               value = "eda_delay",
               eda_delay_ui()
             ),
             
             tabPanel(
               "Airline Analysis",
               icon = icon("plane-departure"),
               value = "eda_airline",
               eda_airline_ui()
             ),
             
             tabPanel(
               "Airport/Route Analysis",
               icon = icon("map"),
               value = "eda_airport",
               eda_airport_ui()
             )
  )
}
