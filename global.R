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
    
    DEST_LABEL = paste0(DEST_CITY, " (", DEST, ")"),
    
    DEP_DELAY_HOUR = DEP_DELAY/60,
    ARR_DELAY_HOUR = ARR_DELAY/60
    
  )

############################################
stats <- compute_basic_stats(df)

############################################
#-----------------------
origin_df <- df |>
  distinct(ORIGIN, ORIGIN_CITY) |>
  mutate(ORIGIN_LABEL = paste0(ORIGIN_CITY, " (", ORIGIN, ")"))

lst_origin <- setNames(origin_df$ORIGIN, origin_df$ORIGIN_LABEL)
origin_choices <- c("(Select one)","All", lst_origin)

#-----------------------
dest_df <- df |>
  distinct(DEST, DEST_CITY) |>
  mutate(DEST_LABEL = paste0(DEST_CITY, " (", DEST, ")"))

lst_dest <- setNames(dest_df$DEST, dest_df$DEST_LABEL)
dest_choices <- c("(Select one)","All", lst_dest)

unique_airlines <- sort(unique(df$AIRLINE))
airline_choices <- c("(Select one)","All", unique_airlines)

#-----------------------
df$FL_DATE <- as.Date(df$FL_DATE)

# min-max date
min_date <- min(df$FL_DATE, na.rm = TRUE)
max_date <- max(df$FL_DATE, na.rm = TRUE)

# Year-Month (YYYY-MM)
ym_choices <- seq(o_min_date, o_max_date, by = "month") |>
  format("%Y-%m")

# Year (numeric)
unique_years <- sort(unique(as.integer(format(df$FL_DATE, "%Y"))))
min_year <- min(unique_years, na.rm = TRUE)
max_year <- max(unique_years, na.rm = TRUE)

#-----------------------
unique_seasons <- sort(unique(df$SEASON))
season <- c("(Select one)","All", unique_seasons)

#-----------------------
min_dep_delay <- min(df$DEP_DELAY_HOUR, na.rm = TRUE)
max_dep_delay <- max(df$DEP_DELAY_HOUR, na.rm = TRUE)

min_arr_delay <- min(df$ARR_DELAY_HOUR, na.rm = TRUE)
max_arr_delay <- max(df$ARR_DELAY_HOUR, na.rm = TRUE)

