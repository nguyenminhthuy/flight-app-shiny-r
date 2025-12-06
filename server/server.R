server <- function(input, output, session) {
  output$tb_data = DT::renderDT({
    datatable(
      df,
      options = list(
        scrollY = "500px",  
        scrollX = TRUE,     
        paging = TRUE      
      ),
      class = 'display nowrap'
    )
  })
  
  #-----------------------------------
  output_labels <- c(
    # --- overview ---
    lb_totalFlights = "n_flights",
    lb_airlines = "n_airlines",
    lb_airports = "n_airports",
    lb_delayFlights = "n_flight_delay",
    lb_ontimeFlights = "n_flight_ontime",
    lb_cancelFlights = "n_flight_cancel",
    lb_divertFlights = "n_flight_divert",
    lb_short = "n_short_distance",
    lb_medium = "n_medium_distance",
    lb_long = "n_long_distance"
  )
  
  lapply(names(output_labels), function(id) {
    output[[id]] <- renderText({
      val <- stats[[output_labels[[id]]]]
      format(val, big.mark = ",", scientific = FALSE)
    })
  })
  
  #-----------------------------------
  plot_fns <- list(
    fig_flights_yearly = plot_flights_yearly,
    fig_flights_quarterly = plot_flights_quarterly,
    fig_flights_monthly = plot_flights_monthly,
    fig_flights_dow = plot_flights_dow
  )
  
  lapply(names(plot_fns), function(id) {
    output[[id]] <- renderPlotly({
      plot_fns[[id]](df)
    })
  })
  #-----------------------------------
  output$ui_time_plot <- renderUI({
    req(input$time_granularity)
    
    if (input$time_granularity == "Year") {
      plotlyOutput("fig_flights_yearly")
      
    } else if (input$time_granularity == "Quarter") {
      plotlyOutput("fig_flights_quarterly")
      
    } else if (input$time_granularity == "Month") {
      plotlyOutput("fig_flights_monthly")
      
    } else if (input$time_granularity == "Day of Week") {
      plotlyOutput("fig_flights_dow")
    }
  })
  
  #-----------------------------------
  # ==== A. Route Filters ==== 
  # nav_tab_eda.R
  #-----------------------------------
  #---- reactive: filter by airline ----
  filtered_by_airline <- reactive({
    if (input$airline == "(Select one)") return(df)
    df[df$AIRLINE == input$airline]
  })
  
  #---- reactive: filter by origin ----
  filtered_by_origin <- reactive({
    if (input$origin == "(Select one)") return(filtered_by_airline())
    filtered_by_airline()[filtered_by_airline()$ORIGIN == input$origin]
  })
  
  #---- When airline changes → update origin + dest ----
  observeEvent(input$airline, {
    d <- filtered_by_airline()
    
    # Origin
    df_o <- d |> 
      distinct(ORIGIN, ORIGIN_CITY) |>
      mutate(label = paste0(ORIGIN_CITY, " (", ORIGIN, ")"))
    
    origin_list2 <- setNames(df_o$ORIGIN, df_o$label)
    
    updateSelectInput(session, "origin",
                      choices = c("(Select one)", origin_list2),
                      selected = if (input$origin %in% df_o$ORIGIN) input$origin else "(Select one)"
    )
    
    # Destination
    df_d <- d |> 
      distinct(DEST, DEST_CITY) |>
      mutate(label = paste0(DEST_CITY, " (", DEST, ")"))
    
    dest_list2 <- setNames(df_d$DEST, df_d$label)
    
    updateSelectInput(session, "dest",
                      choices = c("(Select one)", dest_list2),
                      selected = if (input$dest %in% df_d$DEST) input$dest else "(Select one)"
    )
  })
  
  #---- When origin changes → update airline + dest ----
  observeEvent(input$origin, {
    d <- filtered_by_origin()
    
    # Airline
    al2 <- sort(unique(d$AIRLINE))
    
    updateSelectInput(session, "airline",
                      choices = c("(Select one)", al2),
                      selected = if (input$airline %in% al2) input$airline else "(Select one)"
    )
    
    # Dest
    df_d <- d |> 
      distinct(DEST, DEST_CITY) |>
      mutate(label = paste0(DEST_CITY, " (", DEST, ")"))
    
    dest_list2 <- setNames(df_d$DEST, df_d$label)
    
    updateSelectInput(session, "dest",
                      choices = c("(Select one)", dest_list2),
                      selected = if (input$dest %in% df_d$DEST) input$dest else "(Select one)"
    )
  })
  
  #---- When dest changes → update airline + origin ----    
  observeEvent(input$dest, {
    if (input$dest == "(Select one)") {
      d <- filtered_by_airline()
    } else {
      d <- df[df$DEST == input$dest, ]
    }
    
    # Airline
    al2 <- sort(unique(d$AIRLINE))
    updateSelectInput(session, "airline",
                      choices = c("(Select one)", al2),
                      selected = if (input$airline %in% al2) input$airline else "(Select one)"
    )
    
    # Origin
    df_o <- d |> 
      distinct(ORIGIN, ORIGIN_CITY) |>
      mutate(label = paste0(ORIGIN_CITY, " (", ORIGIN, ")"))
    
    origin_list2 <- setNames(df_o$ORIGIN, df_o$label)
    
    updateSelectInput(session, "origin",
                      choices = c("(Select one)", origin_list2),
                      selected = if (input$origin %in% df_o$ORIGIN) input$origin else "(Select one)"
    )
  })
}









