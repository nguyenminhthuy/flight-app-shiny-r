library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(bslib)
library(bsicons)
library(shinythemes)
library(DT)
library(data.table)

source("R/eda.R")

df <- fread("data/flights_sample_2m.csv", header = TRUE)
stats <- compute_basic_stats(df)