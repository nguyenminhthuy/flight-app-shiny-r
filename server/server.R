server <- function(input, output) {
  output$selected_output <- renderText({
    if (is.null(input$my_choices)) {
      "No options selected."
    } else {
      paste("Selected options:", paste(input$my_choices, collapse = ", "))
    }
  })
  
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
  output$fig_flights_yearly <- renderPlotly({
    plot_flights_yearly(df)
  })
  
  output$fig_flights_quarterly <- renderPlotly({
    plot_flights_quarterly(df)
  })
  
  output$fig_flights_monthly <- renderPlotly({
    plot_flights_monthly(df)
  })
  
  output$fig_flights_dow <- renderPlotly({
    plot_flights_dow(df)
  })
}









