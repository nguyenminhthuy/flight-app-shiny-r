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
  
  output$o_result <- renderPrint({
    if (input$mode == "date") {
      return(input$date_range)
    }
    if (input$mode == "ym") {
      return(input$ym_range)
    }
    if (input$mode == "year") {
      return(input$year_range)
    }
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
  
  #==================================
  # hàm gọn
  plot_fns <- list(
    # over time
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
  
  #==================================
  # EDA Overview
  #==================================
  o_range_parsed <- eventReactive(input$o_btn_createPlot, {
    
    if (input$o_mode == "date") {
      list(
        start = input$o_date_range[1],
        end   = input$o_date_range[2]
      )
      
    } else if (input$o_mode == "year-month") {
      list(
        start = input$o_ym_range[1],
        end   = input$o_ym_range[2]
      )
      
    } else if (input$o_mode == "year") {
      list(
        start = input$o_year_range[1],
        end   = input$o_year_range[2]
      )
    }
    
  })
  
  output$o_result <- renderText({
    rng <- o_range_parsed()
    
    paste0(
      "📌 Result for Overview Filters\n",
      "----------------------------------\n",
      "Origin Airport: ", get_origin_label(input$o_origin), "\n",
      "Destination Airport: ", get_dest_label(input$o_des), "\n",
      "Date range: ", rng$start, " → ", rng$end, "\n"
    )
  })
  
  o_data_grouped <- eventReactive(input$o_btn_createPlot, {
    
    overview_flights_overtime(
      df,
      origin = input$o_origin,
      #dest = input$o_des,
      start_date = o_range_parsed()$start,
      end_date = o_range_parsed()$end,
      mode = input$o_mode
    )
    
  })
  
  output$fig_flights_overtime <- renderPlotly({
    plot_flights_bar(o_data_grouped(), 
                     mode = input$o_mode)
  })
  
  #==================================
  # Origin Airport <-> Destination Airport
  #==================================
  #---- reactive: filter by o_origin ----
  filtered_by_origin <- reactive({
    sel <- input$o_origin
    if (is.null(sel) || sel %in% c("(Select one)", "All")) return(df)
    df[df$ORIGIN == sel, ]
  })
  
  filtered_by_dest <- reactive({
    sel <- input$o_dest
    if (is.null(sel) || sel %in% c("(Select one)", "All")) return(df)
    df[df$DEST == sel, ]
  })

#==================================
#---- When o_origin changes → update o_dest ----
  observeEvent(input$o_origin, {
    d <- filtered_by_origin()
    
    df_d <- d |>
      distinct(DEST, DEST_CITY) |>
      mutate(label = paste0(DEST_CITY, " (", DEST, ")"))
    
    dest_list <- setNames(df_d$DEST, df_d$label)
    
    old_val <- isolate(input$o_dest)
    
    updateSelectInput(
      session, "o_dest",
      choices = c("(Select one)", "All", dest_list),
      selected = if (!is.null(old_val) && old_val %in% df_d$DEST)
        old_val else "(Select one)"
    )
  })

#==================================
#---- When o_dest changes → update o_origin ----
  observeEvent(input$o_dest, {
    d <- filtered_by_dest()
    
    df_o <- d |>
      distinct(ORIGIN, ORIGIN_CITY) |>
      mutate(label = paste0(ORIGIN_CITY, " (", ORIGIN, ")"))
    
    origin_list <- setNames(df_o$ORIGIN, df_o$label)
    
    old_val <- isolate(input$o_origin)
    
    updateSelectInput(
      session, "o_origin",
      choices = c("(Select one)", "All", origin_list),
      selected = if (!is.null(old_val) && old_val %in% df_o$ORIGIN)
        old_val else "(Select one)"
    )
  })
  
  #==================================
  # EDA Airline
  #==================================
  a_range_parsed <- eventReactive(input$a_btn_createPlot, {
    
    if (input$a_mode == "date") {
      list(
        start = input$a_date_range[1],
        end   = input$a_date_range[2]
      )
      
    } else if (input$a_mode == "ym") {
      list(
        start = input$a_ym_range[1],
        end   = input$a_ym_range[2]
      )
      
    } else if (input$a_mode == "year") {
      list(
        start = input$a_year_range[1],
        end   = input$a_year_range[2]
      )
    }
    
  })
  
  output$a_result <- renderPrint({
    list(
      airline = input$a_airline,
      # origin = input$a_origin,
      # des = input$a_des,
      season = input$a_season,
      mode = input$a_mode,
      range = a_range_parsed()
    )
  })
  
  output$a_result <- renderText({
    rng <- a_range_parsed()
    
    paste0(
      "📌 Result for Airline Filters\n",
      "----------------------------------\n",
      "Airline: ", input$a_airline, "\n",
      # "Origin Airport: ", get_origin_label(input$a_origin), "\n",
      # "Destination Airport: ", get_dest_label(input$a_des), "\n",
      # "Season: ", input$a_season, "\n",
      "Date range: ", rng$start, " → ", rng$end, "\n"
    )
  })
  
    # khi bấm nút create plot
  airline_grouped <- eventReactive(input$a_btn_createPlot, {
    
    d <- df
    
    # --- Filter airline ---
    if (!is.null(input$a_airline) &&
        input$a_airline != "(Select one)" &&
        input$a_airline != "All") {
      
      d <- d[d$AIRLINE == input$a_airline, ]
    }
    
    # --- Filter season ---
    if (!is.null(input$a_season) &&
        input$a_season != "(Select one)" &&
        input$a_season != "All") {
      
      d <- d[d$SEASON == input$a_season, ]
    }
    
    # --- Time filter ---
    rng <- a_range_parsed()
    
    if (input$a_mode == "date") {
      d <- d[d$FL_DATE >= rng$start & d$FL_DATE <= rng$end, ]
      
      d <- d |> 
        group_by(FL_DATE) |> 
        summarise(Total_Flights = n())
      
    } else if (input$a_mode == "ym") {
      d <- d[d$YEAR_MONTH >= rng$start & d$YEAR_MONTH <= rng$end, ]
      
      d <- d |> 
        group_by(YEAR_MONTH) |> 
        summarise(Total_Flights = n())
      
    } else if (input$a_mode == "year") {
      d <- d[d$YEAR >= rng$start & d$YEAR <= rng$end, ]
      
      d <- d |> 
        group_by(YEAR) |> 
        summarise(Total_Flights = n())
    }
    
    d
  })
  
  output$fig_airline_overtime <- renderPlotly({
    df_group <- airline_grouped()
    
    if (nrow(df_group) == 0) {
      return(plot_ly() |> layout(title = "No data available"))
    }
      
    if (input$a_mode == "date") {
      plot_airline_overtime(df_group, "FL_DATE", "Date", "Flights Over Time")
      
    } else if (input$a_mode == "ym") {
      plot_airline_overtime(df_group, "YEAR_MONTH", "Year-Month", "Monthly Flights")
      
    } else if (input$a_mode == "year") {
      plot_airline_overtime(df_group, "YEAR", "Year", "Yearly Flights")
    }
  })
  #==================================
  airline_filtered <- eventReactive(input$a_btn_createPlot, {
    d <- df
    
    # --- Filter airline ---
    if (!is.null(input$a_airline) &&
        input$a_airline != "(Select one)" &&
        input$a_airline != "All") {
      d <- d[d$AIRLINE == input$a_airline, ]
    }
    
    # --- Filter season ---
    if (!is.null(input$a_season) &&
        input$a_season != "(Select one)" &&
        input$a_season != "All") {
      d <- d[d$SEASON == input$a_season, ]
    }
    
    # --- Time filter ---
    rng <- a_range_parsed()
    
    if (input$a_mode == "date") {
      d <- d[d$FL_DATE >= rng$start & d$FL_DATE <= rng$end, ]
      
    } else if (input$a_mode == "ym") {
      d <- d[d$YEAR_MONTH >= rng$start & d$YEAR_MONTH <= rng$end, ]
      
    } else if (input$a_mode == "year") {
      d <- d[d$YEAR >= rng$start & d$YEAR <= rng$end, ]
    }
    
    d  # still contains ARR_DELAY + CANCELLED
  })
  
  output$fig_airline_rate <- renderPlotly({
    df_group <- airline_grouped()
    if (nrow(df_group) == 0) {
      return(plot_ly() |> layout(title = "No data available"))
    }
    if (input$a_mode == "date") {
      df_rate <- compute_rate(df_group, "FL_DATE")
      plot_airline_rate(df_rate, "FL_DATE", "Date")
      
    } else if (input$a_mode == "ym") {
      df_rate <- compute_rate(df_group, "YEAR_MONTH")
      plot_airline_rate(df_rate, "YEAR_MONTH", "Year-Month")
      
    } else if (input$a_mode == "year") {
      df_rate <- compute_rate(df_group, "YEAR")
      plot_airline_rate(df_rate, "YEAR", "Year")
    }
  })
  #==================================
  # EDA Airport
  #==================================
  p_range_parsed <- eventReactive(input$p_btn_createPlot, {
    
    if (input$p_mode == "date") {
      list(
        start = input$p_date_range[1],
        end   = input$p_date_range[2]
      )
      
    } else if (input$p_mode == "ym") {
      list(
        start = input$p_ym_range[1],
        end   = input$p_ym_range[2]
      )
      
    } else if (input$p_mode == "year") {
      list(
        start = input$p_year_range[1],
        end   = input$p_year_range[2]
      )
    }
    
  })
  
  output$p_result <- renderPrint({
    list(
      airline = input$p_airline,
      origin = input$p_origin,
      des = input$p_des,
      season = input$p_season,
      mode = input$p_mode,
      range = p_range_parsed()
    )
  })
  
  #==================================
  # EDA Delay
  #==================================
  d_range_parsed <- eventReactive(input$d_btn_createPlot, {
    
    if (input$d_mode == "date") {
      list(
        start = input$d_date_range[1],
        end   = input$d_date_range[2]
      )
      
    } else if (input$d_mode == "ym") {
      list(
        start = input$d_ym_range[1],
        end   = input$d_ym_range[2]
      )
      
    } else if (input$d_mode == "year") {
      list(
        start = input$d_year_range[1],
        end   = input$d_year_range[2]
      )
    }
    
  })
  
  output$d_result <- renderPrint({
    list(
      airline = input$d_airline,
      origin = input$d_origin,
      des = input$d_des,
      season = input$d_season,
      mode = input$d_mode,
      range = d_range_parsed()
    )
  })
}









