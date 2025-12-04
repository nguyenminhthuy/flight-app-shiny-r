nav_tab_eda <- function() {
  tabPanel(
    "EDA",
    sidebarLayout(
      
      # -------- Sidebar --------
      sidebarPanel(
        width = 3,
        h4("Filter Data"),
        
        selectizeInput(
          inputId = "sl_plotType",
          label = "Plot-type;",
          choices = c("Distribution", "Density", "Scatter", "Line", "Bar",  "Box-plot"),
          multiple = FALSE,
          options = list(placeholder = "Select one")
        ),
        
        selectizeInput(
          inputId = "sl_XVariables",
          label = "X-variable:",
          choices = c("Option A", "Option B", "Option C", "Option D"),
          multiple = FALSE,
          options = list(placeholder = "Select one")
        ),
        
        selectizeInput(
          inputId = "sl_YVariables",
          label = "Y-variable:",
          choices = c("Option A", "Option B", "Option C", "Option D"),
          multiple = FALSE,
          options = list(placeholder = "Select one")
        ),
        
        selectizeInput(
          inputId = "sl_facetRow",
          label = "Facet row:",
          choices = c("Option A", "Option B", "Option C", "Option D"),
          multiple = FALSE,
          options = list(placeholder = "Select one")
        ),
        
        selectizeInput(
          inputId = "sl_facetCol",
          label = "Facet column:",
          choices = c("Option A", "Option B", "Option C", "Option D"),
          multiple = FALSE,
          options = list(placeholder = "Select one")
        ),
        
        selectizeInput(
          inputId = "sl_fill",
          label = "Fill:",
          choices = c("Option A", "Option B", "Option C", "Option D"),
          multiple = FALSE,
          options = list(placeholder = "Select one")
        ),
        
        actionButton(
          inputId = "btn_createPlot",
          label = tags$span(
            icon("play"), " Create plot"
          )
        )
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
              
            )
          ),
          
          tabPanel(
            title = tagList(icon("eye"), "View Data"),
            br(),
            
          )
        )
      )
    )
  )
}
