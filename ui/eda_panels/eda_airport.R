source("./global.R")

eda_airport_ui <- function() {
  tagList(
    tags$head(
      tags$style(HTML("
        #p_btn_createPlot {
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

        #p_btn_createPlot:hover {
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
          open = c("route"),   # nhóm mở mặc định
          
          # ==== A. Route Filters ====
          accordion_panel(
            "Airport/Route Filters", value = "route",
            selectInput("p_origin", "Origin Airport", choices = c("Select one", "All", "2019")),
            selectInput("p_dest", "Destination Airport", choices = c("Select one", "All", "2019")),
            selectInput("p_year", "Year (multi-select)", choices = c("Select one", "All", "2019")),
            selectInput("p_airline", "Airline", choices = c("Select one", "All", "2019")),
            selectInput("p_topn", "TopN Selector", choices = c("Select one", "All", "2019")),
            selectInput("p_route", "Route", choices = c("Select one", "All", "2019"))
          )
        ),
        br(),
        actionButton(
          inputId = "p_btn_createPlot",
          label = tags$span(icon("play"), " Create plot")
        )
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("eye"), "Airport Overview"),
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