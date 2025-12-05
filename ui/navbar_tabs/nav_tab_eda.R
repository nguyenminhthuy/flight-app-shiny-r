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
          id = NULL,
          open = c("A"),   # nhóm mở mặc định
          
          # ==== A. Route Filters ====
          accordion_panel(
            "A. Route Filters", value = "A",
            
            selectInput("airline", "Airline", choices = airline_choices),
            selectInput("origin", "Origin City (IATA)", choices = origin_choices),
            selectInput("dest", "Destination City (IATA)", choices = dest_choices)
          ),
          
          # ==== B. Date Filters ====
          accordion_panel(
            "B. Date Filters", value = "B",
            
            dateRangeInput("fl_date", "Date range", start = min_date, end = max_date)
            
            # sliderInput("dep_hour", "Departure hour", min = 0, max = 23, value = c(0,23)),
            # sliderInput("arr_hour", "Arrival hour", min = 0, max = 23, value = c(0,23)),
            # selectInput("dow", "Day of week", choices = dow_choices),
            # selectInput("month", "Month", choices = month_choices),
            # selectInput("year", "Year", choices = years_choices),
            # selectInput("season", "Season", choices = season_choices)
          ),
          
          # ==== C. Operational Flight Filters ====
          accordion_panel(
            "C. Operational Flight Filters", value = "C",
            
            selectInput("flight_status", "Flight status", 
                        choices = c("(Select one)", "Delayed", "Cancelled", "Diverted")),
            
            # ---- Delay filters ----
            conditionalPanel(
              condition = "input.flight_status.includes('Delayed')",
              
              h6(tags$b("Delay Filters"), style = "color:#15a589;"), 
              div(style="border-bottom: 1px solid #ccc; margin-bottom: 10px"),
              
              selectizeInput(
                "delay_type", "Delay type",
                choices = c("(Select one)","All","Carrier","Weather","NAS","Security","Late Aircraft"),
                options = list(placeholder = "Select delay reason...")
              ),
              
              sliderInput(
                "dep_delay_hr", "Departure delay (hours)",
                min = round(min_dep_delay, 2), max = round(max_dep_delay, 2),
                value = round(c(0, 15), 2), step = 0.25
              ),
              
              sliderInput(
                "arr_delay_hr", "Arrival delay (hours)",
                min = round(min_arr_delay, 2), max = round(max_arr_delay, 2),
                value = round(c(0, 15), 2), step = 0.25
              )
            ),
            
            # ---- Cancellation filters ----
            conditionalPanel(
              condition = "input.flight_status.includes('Cancelled')",
              
              h6(tags$b("Cancellation Filters"), style = "color:#15a589;"), 
              div(style="border-bottom: 1px solid #ccc; margin-bottom: 10px"),
              
              selectizeInput(
                "cancel_type", "Cancellation type",
                choices = c("(Select one)","All","A = Carrier","B = Weather","C = NAS","D = Security"),
                options = list(placeholder = "Select cancellation reason...")
              )
            ),
            
            # ---- Diverted filters ----
            conditionalPanel(
              condition = "input.flight_status.includes('Diverted')",
              h6(tags$b("Diverted Filters"), style = "color:#15a589;"), 
              p("No additional filters for diverted flights.")
            )
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
