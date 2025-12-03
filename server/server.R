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
  
  output$lb_totalFlights <- renderText({
    format(stats$n_flights, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_airlines <- renderText({
    format(stats$n_airlines, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_delayFlights <- renderText({
    format(stats$n_flight_delay, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_ontimeFlights <- renderText({
    format(stats$n_flight_ontime, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_cancelFlights <- renderText({
    format(stats$n_flight_cancel, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_divertFlights <- renderText({
    format(stats$n_flight_divert, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_short <- renderText({
    format(stats$n_short_distance, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_medium <- renderText({
    format(stats$n_medium_distance, big.mark = ",", scientific = FALSE)
  })
  
  output$lb_long <- renderText({
    format(stats$n_long_distance, big.mark = ",", scientific = FALSE)
  })
}









