nav_tab_about <- function() {
  tabPanel(
    "About Dataset",
    
    sidebarLayout(
      
      # -------- Sidebar --------
      sidebarPanel(
        width = 3,
        p("About Dataset"),
        br(), br()
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        tags$h3("Flight Delay and Cancellation Dataset (2019–2023)"),
        tags$p(
          tags$strong("Sample size: ~29m total rows; 3m SRS"), 
          textOutput("sample_size", inline = TRUE),
          " (data covers August 2019 – August 2023)."
        ),
        
        h4("About Dataset"),
        tags$p(
          "Dataset used in this app is from ",
          tags$a(href = "https://www.kaggle.com/datasets/patrickzel/flight-delay-and-cancellation-dataset-2019-2023/data", 
                 "Kaggle", target = "_blank"), 
          ", which includes flight routes, delay times, and cancellation information. The key variables are as follow:"
        ),
        
        tags$h4("Key variables"),
        tags$ul(
          tags$li(tags$code("FL_DATE"), " — Flight date (YYYY-MM-DD)"),
          tags$li(tags$code("AIRLINE"), " — Airline name"),
          tags$li(tags$code("ORIGIN"), " / ", tags$code("DEST"), " — Origin / Destination IATA airport codes"),
          tags$li(tags$code("CRS_DEP_TIME"), " / ", tags$code("DEP_TIME"), " — Scheduled / Actual departure time (hhmm)"),
          tags$li(tags$code("DEP_DELAY"), " / ", tags$code("ARR_DELAY"), " — Departure / Arrival delay (minutes)"),
          tags$li(tags$code("CANCELLED"), " — 1 = cancelled, 0 = not cancelled"),
          tags$li(tags$code("DIVERTED"), " — 1 = diverted, 0 = not diverted"),
          tags$li(tags$code("AIR_TIME"), " — Time in the air (minutes)"),
          tags$li(tags$code("DISTANCE"), " — Distance (miles)"),
          tags$li(tags$code("DELAY_DUE_WEATHER"), " / ", tags$code("DELAY_DUE_CARRIER"), " — Delay attributions (minutes)")
        ),
        
        tags$h4("Acknowledgement"),
        tags$p("Original data © U.S. DOT, Bureau of Transportation Statistics ", 
               tags$a(href = "https://www.transtats.bts.gov", "https://www.transtats.bts.gov", target = "_blank")),
        
      )
    )
  )
}
