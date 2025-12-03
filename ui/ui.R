source("ui/navbar_tabs/nav_tab_overview.R")
source("ui/navbar_tabs/nav_tab_eda.R")
source("ui/navbar_tabs/nav_tab_model.R")
source("ui/navbar_tabs/nav_tab_about.R")

ui <- fillPage(
  
  navbarPage(
    "Flight Delay Dashboard",
    #theme = shinytheme("flatly"),
    theme = bs_theme(version = 5, bootswatch = "flatly"),
    
    nav_tab_overview(),
    nav_tab_eda(),
    nav_tab_model(),
    nav_tab_about()
  )
)
