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
            
            selectInput("airline", "Airline", choices = c("None","Carrier","Weather","NAS","Security")),
            selectInput("origin", "Origin", choices = c("None","Carrier","Weather","NAS","Security")),
            selectInput("dest", "Destination", choices = c("None","Carrier","Weather","NAS","Security")),
            dateRangeInput("fl_date", "Date range"),
          ),
          
          # ==== B. Time Filters ====
          accordion_panel(
            "B. Time Filters", value = "B",
            
            sliderInput("dep_hour", "Departure hour", min = 0, max = 23, value = c(0,23)),
            sliderInput("arr_hour", "Arrival hour", min = 0, max = 23, value = c(0,23)),
            selectInput("dow", "Day of week", choices = 1:7),
            selectInput("month", "Month", choices = 1:12),
            selectInput("year", "Year", choices = 2019:2023)
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
            selectInput("cancel_type", "Cancellation type", choices = c("None","Carrier","Weather","NAS","Security","Aircraft"))
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
