library(data.table)
library(plotly)
library(lubridate)
library(arrow)

source("R/eda.R")

#-------------------------------------------
# Load data (cực nhanh)
#-------------------------------------------
csv_path <- "data/flights_sample_2m.csv"
parquet_path <- "data/flights_sample_2m.parquet"

if (file.exists(parquet_path)) {
  message("Loading Parquet...")
  df <- read_parquet(parquet_path)
  # nếu muốn dùng data.table sau này
  setDT(df)
  
} else {
  message("Parquet not found. Reading CSV and converting...")
  
  # Đọc CSV nhanh bằng data.table
  dt <- fread(csv_path)
  
  # Ghi Parquet (mặc định dùng snappy compression)
  write_parquet(dt, parquet_path)
  message("Parquet created: ", parquet_path)
  
  df <- read_parquet(parquet_path)
  setDT(df)
}

#-------------------------------------------
# Convert FL_DATE 1 lần duy nhất
df[, FL_DATE := ymd(FL_DATE)]

#-------------------------------------------
# PREPARE COLUMNS (data.table: ~10x nhanh hơn)
#-------------------------------------------
df[, YEAR := year(FL_DATE)]
df[, MONTH := month(FL_DATE)]
df[, QUARTER := quarter(FL_DATE)]

# wday(): Sunday = 1
df[, DAY_NUM := wday(FL_DATE)]
df[DAY_NUM == 1, DAY_NUM := 7]
df[DAY_NUM != 1, DAY_NUM := DAY_NUM - 1]

dow_levels <- c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
df[, DAY_OF_WEEK := factor(dow_levels[DAY_NUM], levels = dow_levels, ordered = TRUE)]

df[, DISTANCE_CAT := cut(
  DISTANCE,
  breaks = c(-Inf, 500, 1500, Inf),
  labels = c("Short-haul", "Medium-haul", "Long-haul")
)]

df[, DEP_HOUR := factor(floor(CRS_DEP_TIME / 100), levels = 0:23)]

df[, SEASON := fifelse(
  MONTH %in% c(12,1,2), "Winter",
  fifelse(MONTH %in% c(3,4,5), "Spring",
          fifelse(MONTH %in% c(6,7,8), "Summer", "Fall"))
)]

df[, DEST_LABEL := paste0(DEST_CITY, " (", DEST, ")")]

df[, DEP_DELAY_HOUR := DEP_DELAY/60]
df[, ARR_DELAY_HOUR := ARR_DELAY/60]

#-------------------------------------------
# STATS
#-------------------------------------------
stats <- compute_basic_stats(df)

#-------------------------------------------
# CHOICES (không dùng dplyr để tránh chậm)
#-------------------------------------------
origin_df <- unique(df[, .(ORIGIN, ORIGIN_CITY)])
origin_df[, ORIGIN_LABEL := paste0(ORIGIN_CITY, " (", ORIGIN, ")")]
origin_choices <- c("(Select one)", "All", setNames(origin_df$ORIGIN, origin_df$ORIGIN_LABEL))

dest_df <- unique(df[, .(DEST, DEST_CITY)])
dest_df[, DEST_LABEL := paste0(DEST_CITY, " (", DEST, ")")]
dest_choices <- c("(Select one)", "All", setNames(dest_df$DEST, dest_df$DEST_LABEL))

airline_choices <- c("(Select one)", "All", sort(unique(df$AIRLINE)))

# min-max date
min_date <- min(df$FL_DATE)
max_date <- max(df$FL_DATE)

# Year-Month
ym_choices <- format(seq(min_date, max_date, by = "month"), "%Y-%m")

# Year
unique_years <- sort(unique(df$YEAR))
min_year <- min(unique_years)
max_year <- max(unique_years)

# Seasons
season <- c("(Select one)", "All", sort(unique(df$SEASON)))

# ############################################
# Lý do app chạy chậm KHÔNG phải tại 2M rows — mà là:
# dùng tidyverse mutate trên data 2 triệu dòng
# tính toán choices bằng dplyr nhiều lần
# load tidyverse (rất nặng)
# convert FL_DATE nhiều lần
# compute quá nhiều thứ trong global
# ############################################
# library(tidyverse)
# library(tidyr)
# library(dplyr)
# library(ggplot2)
# library(readr)
# library(data.table)
# library(plotly)
# library(lubridate)
# 
# source("R/eda.R")
# 
# df <- fread("data/flights_sample_2m.csv", header = TRUE)
# 
# ############################################
# # PREPARATION
# ############################################
# dow_levels <- c("Monday", "Tuesday", "Wednesday", "Thursday",
#                 "Friday", "Saturday", "Sunday")
# 
# df <- df |>
#   mutate(
#     FL_DATE = ymd(FL_DATE),
#     YEAR = year(FL_DATE),
#     MONTH = month(FL_DATE),
#     QUARTER = quarter(FL_DATE),
# 
#     # wday(): Sunday = 1 → Monday = 2 → ... → Saturday = 7
#     DAY_NUM = wday(FL_DATE),
#     # Chuyển về Monday = 1, ... Sunday = 7
#     DAY_NUM = ifelse(DAY_NUM == 1, 7, DAY_NUM - 1),
#     DAY_OF_WEEK = factor(dow_levels[DAY_NUM],
#                          levels = dow_levels,
#                          ordered = TRUE),
# 
#     DISTANCE_CAT = cut(
#       DISTANCE,
#       breaks = c(-Inf, 500, 1500, Inf),
#       labels = c("Short-haul", "Medium-haul", "Long-haul")
#     ),
# 
#     DEP_HOUR = factor(floor(CRS_DEP_TIME / 100), levels = 0:23),
# 
#     SEASON = case_when(
#       MONTH %in% c(12, 1, 2) ~ "Winter",
#       MONTH %in% c(3, 4, 5) ~ "Spring",
#       MONTH %in% c(6, 7, 8) ~ "Summer",
#       TRUE ~ "Fall"
#     ),
# 
#     DEST_LABEL = paste0(DEST_CITY, " (", DEST, ")"),
# 
#     DEP_DELAY_HOUR = DEP_DELAY/60,
#     ARR_DELAY_HOUR = ARR_DELAY/60
# 
#   )
# 
# ############################################
# stats <- compute_basic_stats(df)
# 
# ############################################
# #-----------------------
# origin_df <- df |>
#   distinct(ORIGIN, ORIGIN_CITY) |>
#   mutate(ORIGIN_LABEL = paste0(ORIGIN_CITY, " (", ORIGIN, ")"))
# 
# lst_origin <- setNames(origin_df$ORIGIN, origin_df$ORIGIN_LABEL)
# origin_choices <- c("(Select one)","All", lst_origin)
# 
# #-----------------------
# dest_df <- df |>
#   distinct(DEST, DEST_CITY) |>
#   mutate(DEST_LABEL = paste0(DEST_CITY, " (", DEST, ")"))
# 
# lst_dest <- setNames(dest_df$DEST, dest_df$DEST_LABEL)
# dest_choices <- c("(Select one)","All", lst_dest)
# 
# unique_airlines <- sort(unique(df$AIRLINE))
# airline_choices <- c("(Select one)","All", unique_airlines)
# 
# #-----------------------
# df$FL_DATE <- as.Date(df$FL_DATE)
# 
# # min-max date
# min_date <- min(df$FL_DATE, na.rm = TRUE)
# max_date <- max(df$FL_DATE, na.rm = TRUE)
# 
# # Year-Month (YYYY-MM)
# ym_choices <- seq(o_min_date, o_max_date, by = "month") |>
#   format("%Y-%m")
# 
# # Year (numeric)
# unique_years <- sort(unique(as.integer(format(df$FL_DATE, "%Y"))))
# min_year <- min(unique_years, na.rm = TRUE)
# max_year <- max(unique_years, na.rm = TRUE)
# 
# #-----------------------
# unique_seasons <- sort(unique(df$SEASON))
# season <- c("(Select one)","All", unique_seasons)
# 
# #-----------------------
# min_dep_delay <- min(df$DEP_DELAY_HOUR, na.rm = TRUE)
# max_dep_delay <- max(df$DEP_DELAY_HOUR, na.rm = TRUE)
# 
# min_arr_delay <- min(df$ARR_DELAY_HOUR, na.rm = TRUE)
# max_arr_delay <- max(df$ARR_DELAY_HOUR, na.rm = TRUE)
# 
