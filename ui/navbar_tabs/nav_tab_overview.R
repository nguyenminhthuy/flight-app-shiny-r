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
            br(),
            h4("General"),
            layout_columns(
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Total Flights",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_totalFlights", container = span)
                  )
                )
              ),
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of Airlines",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_airlines", container = span)
                  )
                )
              )
            ),
            br(),
            h4("Flight Status"),
            layout_columns(
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of flights delayed",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_delayFlights", container = span)
                  )
                )
              ),
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of on-time flights",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_ontimeFlights", container = span)
                  )
                )
              ),
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of flights cancelled",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_cancelFlights", container = span)
                  )
                )
              ),
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of flights diverted",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_divertFlights", container = span)
                  )
                )
              )
            ),
            br(),
            h4("Distance Category"),
            layout_columns(
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of short-haul flights",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_short", container = span)
                  )
                )
              ),
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of medium-haul flights",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_medium", container = span)
                  )
                )
              ),
              card(
                card_header(
                  style = "bg-info color: white; text-align: center; 
                            font-weight: bold; padding: 5px; margin: 0;",
                  bsicons::bs_icon("airplane", size = "1em", style = "color: white;"),
                  "Number of long-haul flights",
                ),
                card_body(
                  div(
                    style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold",
                    textOutput("lb_long", container = span)
                  )
                )
              )
            )
          ),
          
          tabPanel(
            title = tagList(icon("eye"), "View Data"),
            p(),
            DTOutput("tb_data")
          ),
          
          tabPanel(
            title = tagList(icon("chart-bar"), "Visualize"),
            p(),
            tags$div(class = "about-card",
                     tags$h3("Overall Dataset")
            ), 
            verbatimTextOutput("tabset1Selected")
          )
          
        )
      )
    )
  )
}
