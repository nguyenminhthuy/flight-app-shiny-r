source("./global.R")

eda_airline_ui <- function() {
  tagList(
    tags$head(
      tags$style(HTML("
        #a_btn_createPlot {
          background-color: #18bc9c !important;
          color: white !important;
          border: none !important;
          font-size: 16px !important;
          font-weight: bold !important;
          padding: 12px 18px !important;
          width: 100% !important;
          border-radius: 8px !important;
          cursor: pointer !important;
        }

        #a_btn_createPlot:hover {
          background-color: #15a589 !important;
          transform: scale(1.03) !important;
          transition: 0.15s ease-in-out !important;
        }
      "))
    ),
    # -------- Sidebar --------
    sidebarLayout(
      sidebarPanel(
        width = 3,
        h4("Filter Data"),
        accordion(
          id = NULL,
          open = c("airline"),   # nhóm mở mặc định
          accordion_panel(
            "Airline Filters", value = "airline",
            selectInput("a_airline", "Airline (Optional)", choices = c("Select one", "All", "1")),
            selectInput("a_year", "Year (multi-select)", choices = c("Select one", "All", "2019")),
            selectInput("a_quarter", "Quarter", choices = c("Select one", "All", "1")),
            selectInput("a_month", "Month", choices = c("Select one", "All", "1")),
            selectInput("a_season", "Season", choices = c("Select one", "All", "1")),
            selectInput("a_origin", "Airport", choices = c("Select one", "All", "1")),
            selectInput("a_route", "Route / Origin–Dest pair", choices = c("Select one", "All", "1")),
          )
        ),
        br(),
        actionButton(
          inputId = "a_btn_createPlot",
          label = tags$span(icon("play"), " Create plot")
        )
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("eye"), "Airline Overview"),
            br(),
            fluidRow(
              column(6, card(height = "300px")),
              column(6, card(height = "300px"))
            ),
            br(),
            fluidRow(
              column(6, card(height = "300px")),
              column(6, card(height = "300px"))
            )
          ),
          
          tabPanel(
            title = tagList(icon("chart-line"), "Results"),
            br(),
            
          )
        )
      )
    )
  )
}