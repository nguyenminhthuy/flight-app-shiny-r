nav_tab_overview <- function() {
  tabPanel(
    "Overview",
    
    sidebarLayout(
      
      # -------- Sidebar --------
      sidebarPanel(
        width = 3,
        selectizeInput(
          inputId = "my_choices",
          label = "Select variable(s):",
          choices = c("Option A", "Option B", "Option C", "Option D"),
          multiple = TRUE,
          options = list(placeholder = "Choose variable(s)...")
        ),
        
        p("You have selected:"),
        textOutput("selected_output"),
        br(), br()
      ),
      
      # -------- Main Panel --------
      mainPanel(
        width = 9,
        
        tabsetPanel(
          type = "tabs",
          
          tabPanel(
            title = tagList(icon("table"), "Data Description"),
            p(),
            tags$div(class = "about-card",
                     tags$h3("Overall Dataset"),
                     
            ), 
            verbatimTextOutput("tabset1Selected")
          ),
          
          tabPanel(
            title = tagList(icon("eye"), "View Data"),
            p(),
            DTOutput("tb_data")
          ),
          
          tabPanel(
            title = tagList(icon("chart-bar"), "Visualize"),
            p(),
            layout_columns(
              #valueBoxOutput("n_flights_box"),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              ),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              ),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              )
            ),
            layout_columns(
              #valueBoxOutput("n_flights_box"),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              ),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              ),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              )
            ),
            layout_columns(
              #valueBoxOutput("n_flights_box"),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              ),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                          font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              ),
              card(
                card_header(
                  style = "background-color: #007BFF; color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "text-align: center; font-size: 20px; font-weight: bold;",
                    format(stats$n_flights, big.mark = ",", scientific = FALSE)
                  )
                )
              )
            )
          )
        )
      )
    )
  )
}
