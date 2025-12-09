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
df[, YEAR_MONTH := format(FL_DATE, "%Y-%m")]

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

# Hàm lấy label theo code
get_origin_label <- function(code) {
  if (is.null(code) || code == "" || code == "All") return(code)
  origin_df[ORIGIN == code, ORIGIN_LABEL]
}

#-------------------------------------------
dest_df <- unique(df[, .(DEST, DEST_CITY)])
dest_df[, DEST_LABEL := paste0(DEST_CITY, " (", DEST, ")")]
dest_choices <- c("(Select one)", "All", setNames(dest_df$DEST, dest_df$DEST_LABEL))

# Hàm lấy label theo code
get_dest_label <- function(code) {
  if (is.null(code) || code == "" || code == "All") return(code)
  dest_df[DEST == code, DEST_LABEL]
}

#-------------------------------------------
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

#-------------------------------------------
routes <- unique(df[, .(ORIGIN, DEST)])




