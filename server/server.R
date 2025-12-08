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
  o_start <- reactive({
    if (input$o_mode == "date") {
      input$o_date_range[1]
    } else if (input$o_mode == "ym") {
      input$o_ym_range[1]
    } else {
      input$o_year_range[1]
    }
  })
  
  o_end <- reactive({
    if (input$o_mode == "date") {
      input$o_date_range[2]
    } else if (input$o_mode == "ym") {
      input$o_ym_range[2]
    } else {
      input$o_year_range[2]
    }
  })
  
  output$o_result <- renderPrint({
    list(
      start = o_start(),
      end   = o_end()
    )
  })
}









