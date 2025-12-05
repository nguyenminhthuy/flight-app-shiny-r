source("./global.R")

nav_tab_eda <- function() {
  tabPanel(
    "EDA",
    sidebarLayout(
      
      # -------- Sidebar --------
      sidebarPanel(
        width = 3,
        h4("Filter Data"),
        accordion(
          id = "filter_accordion",
          open = c("A"),   # nhóm mở mặc định
          
          # ==== A. Flight Attributes ====
          accordion_panel(
            "A. Flight Attributes", value = "A",
            
            selectInput("airline", "Airline", choices = airline_choices),
            selectInput("origin", "Origin City (IATA)", choices = origin_choices),
            selectInput("dest", "Destination City (IATA)", choices = dest_choices),
            dateRangeInput("fl_date", "Date range", start = min_date, end = max_date)
          ),
          
          # ==== B. Time Filters ====
          accordion_panel(
            "B. Time Filters", value = "B",
            
            sliderInput("dep_hour", "Departure hour", min = 0, max = 23, value = c(0,23)),
            sliderInput("arr_hour", "Arrival hour", min = 0, max = 23, value = c(0,23)),
            selectInput("dow", "Day of week", choices = dow_choices),
            selectInput("month", "Month", choices = month_choices),
            selectInput("year", "Year", choices = years_choices),
            selectInput("season", "Season", choices = season_choices)
            
          ),
          
          # ==== C. Delay Filters ====
          accordion_panel(
            "C. Delay Filters", value = "C",
            
            sliderInput("dep_delay", "Departure delay", min = -60, max = 300, value = c(0, 60)),
            sliderInput("arr_delay", "Arrival delay", min = -60, max = 300, value = c(0, 60)),
            layout_columns(
              checkboxInput("cancelled", "Cancelled?", value = FALSE),
              checkboxInput("diverted", "Diverted?", value = FALSE)
            ),
            selectInput("delay_type", "Delay type", 
                        choices = c("All","N/A","Carrier","Weather","NAS","Security","Late Aircraft")),
            selectInput("cancel_type", "Cancellation type", 
                        choices = c("All","N/A","A = Carrier","B = Weather","C = NAS","D = Security"))
          )
        ),
        br(),
        actionButton(
          inputId = "btn_createPlot",
          label = tags$span(
            icon("play"), " Create plot"
          )
        )
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("table"), "Data Description"),
            br(),
            h4("General"),
            layout_columns(
              
            )
          ),
          
          tabPanel(
            title = tagList(icon("eye"), "View Data"),
            br(),
            
          )
        )
      )
    )
  )
}
