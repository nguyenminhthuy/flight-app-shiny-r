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
  
}









