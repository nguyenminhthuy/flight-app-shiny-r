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
            selectInput("a_airline", "Airline (Optional)", choices = airline_choices),
            # selectInput("a_origin", "Origin Airport", choices = origin_choices),
            # selectInput("a_des", "Destination Airport", choices = dest_choices),
            
            # Select type of date
            radioButtons(
              "a_mode", "Select type:",
              choices = c("Date" = "date", "Year-Month" = "ym", "Year" = "year"),
              inline = TRUE
            ),
            
            # Date range
            conditionalPanel(
              "input.a_mode == 'date'",
              dateRangeInput(
                "a_date_range", "Date range:",
                start = min_date, end = max_date
              )
            ),
            
            # Year-month range
            conditionalPanel(
              "input.a_mode == 'ym'",
              sliderTextInput(
                inputId = "a_ym_range",
                label = "Year-Month range:",
                choices = ym_choices,
                selected = c(ym_choices[1], 
                             ym_choices[length(ym_choices)]),
                grid = FALSE
              )
            ),
            
            # Year range
            conditionalPanel(
              "input.a_mode == 'year'",
              sliderInput(
                "a_year_range",
                "Year range:",
                min = min_year, max = max_year,
                value = c(min_year, max_year), 
                sep = "", step = 1
              )
            ),
            #selectInput("a_season", "Season", choices = season),
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
            title = tagList(icon("chart-line"), "Overview"),
            br(),
            verbatimTextOutput("a_result"),
            br(),
            fluidRow(
              card(plotlyOutput("fig_airline_overtime"), height = "300px")
            ),
            h4("Growth Rate of an airline vs industry"),
            h4("Market share over time"),
            br(),
            fluidRow(
              column(6, card(height = "300px")),
              column(6, card(height = "300px"))
            ),
            h4("on-time vs delay vs cancel"),
            br(),
            fluidRow(
              column(6, card(height = "300px")),
              column(6, card(height = "300px"))
            ),
            h4("Top 5 popular routes"),
            h4("Route performance of airline"),
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