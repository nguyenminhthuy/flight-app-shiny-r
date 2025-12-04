source("ui/cards/card_overview_dataDescription.R")
source("ui/cards/card_overview_plots.R")

nav_tab_overview <- function() {
  tabPanel(
    "Overview",
    
    sidebarLayout(
      
      # -------- Sidebar --------
      sidebarPanel(
        width = 3,
        
        h4("📘 Project Info"),
        tags$div(
          style = "background: #f8f9fa; padding: 12px; border-radius: 8px; margin-bottom: 20px;",
          p("Flight Analysis Dashboard v1.0"),
          p("Updated: Dec 2025"),
          p("Author: Thuy"),
          p("Source: ",
            tags$a(
              href = "https://www.kaggle.com/datasets/patrickzel/flight-delay-and-cancellation-dataset-2019-2023/data",
              "Kaggle",
              target = "_blank"
            ))
        ),
        
        h4("📊 Dataset Info"),
        tags$div(
          style = "background: #f8f9fa; padding: 12px; border-radius: 8px;",
          p(strong("Flights: "), "2M"),
          p(strong("Airlines: "), "18"),
          p(strong("Airports: "), "380"),
          p(strong("Period: "), "2019–2023")
        )
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("table"), "Data Summary"),
            br(),
            h4("General"),
            layout_columns(
              card_overview_nFlights(),
              card_overview_nAirlines(),
              card_overview_nAirports()
            ),
            br(),
            h4("Flight Status"),
            layout_columns(
              card_overview_ndelayFlights(),
              card_overview_ontimeFlights(),
              card_overview_cancelFlights(),
              card_overview_divertFlights()
            ),
            br(),
            h4("Distance Category"),
            layout_columns(
              card_overview_shortFlights(),
              card_overview_mediumFlights(),
              card_overview_longFlights()
            )
          ),
          
          tabPanel(
            title = tagList(icon("eye"), "View Data"),
            br(),
            DTOutput("tb_data")
          ),
          
          tabPanel(
            title = tagList(icon("chart-bar"), "Visualize"),
            br(),
            layout_columns(
              card_overview_flights_yearly(),
              card_overview_flights_quarterly()
            ),
            br(),
            layout_columns(
              card_overview_flights_monthly(),
              card_overview_flights_dow()
            )
          )
        )
      )
    )
  )
}
