library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(bslib)
library(bsicons)
library(shinythemes)
library(DT)
library(dplyr)

source("ui/ui.R")
source("server/server.R")
source("global.R")

shinyApp(ui, server)
