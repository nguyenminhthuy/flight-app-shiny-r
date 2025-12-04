card_overview_flights_yearly <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      "Yearly",
    ),
    card_body(
      plotlyOutput("fig_flights_yearly", height = "auto")
    )
  )
}

card_overview_flights_quarterly <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      "Quarterly",
    ),
    card_body(
      plotlyOutput("fig_flights_quarterly", height = "auto")
    )
  )
}

card_overview_flights_monthly <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      "Monthly",
    ),
    card_body(
      plotlyOutput("fig_flights_monthly", height = "auto")
    )
  )
}

card_overview_flights_dow <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      "Day of Week",
    ),
    card_body(
      plotlyOutput("fig_flights_dow", height = "auto")
    )
  )
}