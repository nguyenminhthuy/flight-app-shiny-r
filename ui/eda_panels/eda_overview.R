source("./global.R")

eda_overview_ui <- function() {
  tagList(
    tags$head(
      tags$style(HTML("
        #o_btn_createPlot {
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

        #o_btn_createPlot:hover {
          background-color: #15a589 !important;
          transform: scale(1.03) !important;
          transition: 0.15s ease-in-out !important;
        }
        
        #fig_overview_year,
        #fig_overview_year .plotly,
        #fig_overview_year .js-plotly-plot {
          opacity: 1 !important;
          background: transparent !important;
          filter: none !important;
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
          open = c("overview"),   # nhóm mở mặc định
          accordion_panel(
            "Overview Filters", value = "overview",
            #selectInput("o_airline", "Airline (Optional)", choices = airline_choices),
            selectInput("o_origin", "Origin Airport", choices = origin_choices),
            selectInput("o_des", "Destination Airport", choices = dest_choices),
            
            # Select type of date
            radioButtons(
              "o_mode", "Select type:",
              choices = c("Date" = "date", "Year-Month" = "year-month", "Year" = "year"),
              inline = TRUE
            ),
            
            # Date range
            conditionalPanel(
              "input.o_mode == 'date'",
              dateRangeInput(
                "o_date_range", "Date range:",
                start = min_date, end = max_date
              )
            ),
            
            # Year-month range
            conditionalPanel(
              "input.o_mode == 'year-month'",
              sliderTextInput(
                inputId = "o_ym_range",
                label = "Year-Month range:",
                choices = ym_choices,
                selected = c(ym_choices[1], 
                             ym_choices[length(ym_choices)]),
                grid = FALSE
              )
            ),
            
            # Year range
            conditionalPanel(
              "input.o_mode == 'year'",
              sliderInput(
                "o_year_range",
                "Year range:",
                min = min_year, max = max_year,
                value = c(min_year, max_year), 
                sep = "", step = 1
              )
            )
          )
        ),
        br(),
        actionButton(
          inputId = "o_btn_createPlot",
          label = tags$span(icon("play"), " Create plot"),
          class = "btn_createPlot"
        )
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("eye"), "Overview"),
            br(),
            fluidRow(
              column(6, card(plotlyOutput("fig_flights_yearly"), height = "300px")),
              column(6, card(plotlyOutput("fig_flights_quarterly"), height = "300px"))
            ),
            br(),
            fluidRow(
              column(6, card(plotlyOutput("fig_flights_monthly"), height = "300px")),
              column(6, card(plotlyOutput("fig_flights_dow"), height = "300px"))
            )
          ),
          
          tabPanel(
            title = tagList(icon("chart-line"), "Results"),
            br(),
            verbatimTextOutput("o_result"),
            br(),
            fluidRow(
              card(plotlyOutput("fig_overview_year"), height = "350px")
              
            ),
            br(),
            fluidRow(
              column(6, card(plotlyOutput("fig_overview_year1"), height = "300px")),
              column(6, card(plotlyOutput("fig_overview_quarterly"), height = "300px"))
            ),
          )
        )
      )
    )
  )
}