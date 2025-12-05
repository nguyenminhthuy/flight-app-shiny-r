library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(data.table)
library(plotly)
library(lubridate)

source("R/eda.R")

df <- fread("data/flights_sample_2m.csv", header = TRUE)

############################################
# PREPARATION
############################################
dow_levels <- c("Monday", "Tuesday", "Wednesday", "Thursday",
                "Friday", "Saturday", "Sunday")

df <- df |>
  mutate(
    FL_DATE = ymd(FL_DATE),
    YEAR = year(FL_DATE),
    MONTH = month(FL_DATE),
    QUARTER = quarter(FL_DATE),
    
    # wday(): Sunday = 1 → Monday = 2 → ... → Saturday = 7
    DAY_NUM = wday(FL_DATE), 
    # Chuyển về Monday = 1, ... Sunday = 7
    DAY_NUM = ifelse(DAY_NUM == 1, 7, DAY_NUM - 1),
    DAY_OF_WEEK = factor(dow_levels[DAY_NUM], 
                         levels = dow_levels, 
                         ordered = TRUE),
    
    DISTANCE_CAT = cut(
      DISTANCE,
      breaks = c(-Inf, 500, 1500, Inf),
      labels = c("Short-haul", "Medium-haul", "Long-haul")
    ),
    
    DEP_HOUR = factor(floor(CRS_DEP_TIME / 100), levels = 0:23),
    
    SEASON = case_when(
      MONTH %in% c(12, 1, 2) ~ "Winter",
      MONTH %in% c(3, 4, 5) ~ "Spring",
      MONTH %in% c(6, 7, 8) ~ "Summer",
      TRUE ~ "Fall"
    ),
    
    DEST_LABEL = paste0(DEST_CITY, " (", DEST, ")")
  )

############################################
stats <- compute_basic_stats(df)

############################################
unique_airlines <- sort(unique(df$AIRLINE))
airline_choices <- c("All", unique_airlines)

unique_years <- sort(unique(df$YEAR))
years_choices <- c("All", unique_years)

unique_months <- sort(unique(df$MONTH))
month_choices <- c("All", unique_months)

unique_seasons <- sort(unique(df$SEASON))
season_choices <- c("All", unique_seasons)

unique_seasons <- dow_levels[dow_levels %in% unique(df$DAY_OF_WEEK)]
dow_choices <- c("All", unique_seasons)

#-----------------------
origin_df <- df |>
  distinct(ORIGIN, ORIGIN_CITY) |>
  mutate(ORIGIN_LABEL = paste0(ORIGIN_CITY, " (", ORIGIN, ")"))

lst_origin <- setNames(origin_df$ORIGIN, origin_df$ORIGIN_LABEL)
origin_choices <- c("All", lst_origin)

#-----------------------
dest_df <- df |>
  distinct(DEST, DEST_CITY) |>
  mutate(DEST_LABEL = paste0(DEST_CITY, " (", DEST, ")"))

lst_dest <- setNames(dest_df$DEST, dest_df$DEST_LABEL)
dest_choices <- c("All", lst_dest)







