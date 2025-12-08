source("./global.R")

eda_delay_ui <- function() {
  tagList(   
    tags$head(
      tags$style(HTML("
        #d_btn_createPlot {
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

        #d_btn_createPlot:hover {
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
          open = c("delay"),   # nhóm mở mặc định
          accordion_panel(
            "Delay Filters", value = "delay",
            selectInput("d_airline", "Airline (Optional)", choices = airline_choices),
            selectInput("d_origin", "Origin Airport", choices = origin_choices),
            selectInput("d_des", "Destination Airport", choices = dest_choices),
            
            # Select type of date
            radioButtons(
              "d_mode", "Select type:",
              choices = c("Date" = "date", "Year-Month" = "ym", "Year" = "year"),
              inline = TRUE
            ),
            
            # Date range
            conditionalPanel(
              "input.d_mode == 'date'",
              dateRangeInput(
                "d_date_range", "Date range:",
                start = min_date, end = max_date
              )
            ),
            
            # Year-month range
            conditionalPanel(
              "input.d_mode == 'ym'",
              sliderTextInput(
                inputId = "d_ym_range",
                label = "Year-Month range:",
                choices = ym_choices,
                selected = c(ym_choices[1], 
                             ym_choices[length(ym_choices)]),
                grid = FALSE
              )
            ),
            
            # Year range
            conditionalPanel(
              "input.d_mode == 'year'",
              sliderInput(
                "d_year_range",
                "Year range:",
                min = min_year, max = max_year,
                value = c(min_year, max_year), 
                sep = "", step = 1
              )
            ),
            
            verbatimTextOutput("d_result"),
            
            selectInput("d_season", "Season", choices = season),
            
          )
        ),
        br(),
        actionButton(
          inputId = "d_btn_createPlot",
          label = tags$span(icon("play"), " Create plot")
        )
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("eye"), "Delay Overview"),
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