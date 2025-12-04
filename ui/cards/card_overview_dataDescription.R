library(bsicons)

card_overview_nFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Total Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_totalFlights", container = span)
      )
    )
  )
}

card_overview_nAirlines <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Airlines",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_airlines", container = span)
      )
    )
  )
}

card_overview_nAirports <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Airlines",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_airports", container = span)
      )
    )
  )
}

card_overview_ndelayFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Delayed Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_delayFlights", container = span)
      )
    )
  )
}

card_overview_ontimeFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of On-time Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_ontimeFlights", container = span)
      )
    )
  )
}

card_overview_cancelFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Canceled Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_cancelFlights", container = span)
      )
    )
  )
}

card_overview_divertFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Diverted Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_divertFlights", container = span)
      )
    )
  )
}

card_overview_shortFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Short-haul Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_short", container = span)
      )
    )
  )
}

card_overview_mediumFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Medium-haul Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_medium", container = span)
      )
    )
  )
}

card_overview_longFlights <- function(){
  card(
    card_header(
      style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
      bs_icon("airplane", size = "1em", style = "color: white;"),
      "Number of Long-haul Flights",
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
        textOutput("lb_long", container = span)
      )
    )
  )
}