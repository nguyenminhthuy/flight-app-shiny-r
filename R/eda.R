compute_basic_stats <- function(df) {
  df |>
    summarise(
      n_flights          = n(),
      n_airlines         = n_distinct(na.omit(AIRLINE)),
      n_airports         = n_distinct(na.omit(ORIGIN)),
      n_flight_delay     = sum(ARR_DELAY > 15, na.rm = TRUE),
      n_flight_ontime    = sum(ARR_DELAY <= 15, na.rm = TRUE),
      n_flight_cancel    = sum(CANCELLED == 1, na.rm = TRUE),
      n_flight_divert    = sum(DIVERTED == 1, na.rm = TRUE),
      n_short_distance   = sum(DISTANCE_CAT == "Short-haul", na.rm = TRUE),
      n_medium_distance  = sum(DISTANCE_CAT == "Medium-haul", na.rm = TRUE),
      n_long_distance    = sum(DISTANCE_CAT == "Long-haul", na.rm = TRUE)
    )
}

#---------------------------------------------
group_by_year <- function(df, value_col, new_name){
  df |>
    group_by(YEAR) |>
    summarise(
      !!new_name := n(),
      .groups = "drop"
    ) |> ungroup()
}

plot_flights_yearly <- function(df){
  df_yearly <- group_by_year(df, "FL_DATE", "Total_Flights")
    
  plot_ly(
      data = df_yearly,
      x = ~YEAR, y = ~Total_Flights,
      type = "bar", color = ~as.factor(YEAR),
      height=250
    ) |>
    layout(
      title = paste0("Monthly Flights Trend (2019–2023)"),
      xaxis = list(type = "category", title = "YEAR"),
      yaxis = list(title = "Total Flights")
    ) |> 
    config(responsive = TRUE)
}

#---------------------------------------------
group_by_quarter <- function(df, value_col, new_name){
  df |>
    group_by(YEAR, QUARTER) |>
    summarise(
      !!new_name := n(),
      .groups = "drop"
    ) |> ungroup()
}

plot_flights_quarterly <- function(df){
  df_quarter <- group_by_quarter(df, "FL_DATE", "Total_Flights")
  
  plot_ly(
    data = df_quarter,
    x = ~QUARTER, y = ~Total_Flights,
    type = "scatter", color = ~as.factor(YEAR), mode = "lines+markers",
    height=250
  ) |>
    layout(
      title = paste0("Quarterly Flights Trend (2019–2023)"),
      xaxis = list(type = "category", title = "Quarter"),
      yaxis = list(title = "Total Flights")
    ) |> 
    config(responsive = TRUE)
}

#---------------------------------------------
group_by_monthly <- function(df, value_col, new_name){
  df |>
    group_by(YEAR, MONTH) |>
    summarise(
      !!new_name := n(),
      .groups = "drop"
    ) |> ungroup()
}

plot_flights_monthly <- function(df){
  df_monthly <- group_by_monthly(df, "FL_DATE", "Total_Flights")
  
  fig <- plot_ly(
    data = df_monthly,
    x = ~MONTH, y = ~Total_Flights,
    type = "scatter", color = ~as.factor(YEAR), mode = "lines+markers",
    height=250
  ) |>
    layout(
      title = paste0("Monthly Flights Trend (2019–2023)"),
      xaxis = list(type = "category", title = "Month"),
      yaxis = list(title = "Total Flights")
    ) |> config(responsive = TRUE)
}

#---------------------------------------------
group_by_dow <- function(df, value_col, new_name){
  df |>
    group_by(YEAR, DAY_OF_WEEK) |>
    summarise(
      !!new_name := n(),
      .groups = "drop"
    ) |> ungroup()
}

plot_flights_dow <- function(df){
  airline_dow <- group_by_dow(df, "FL_DATE", "Total_Flights")
  
  fig <- plot_ly(
    data = airline_dow,
    x = ~DAY_OF_WEEK, y = ~Total_Flights,
    type = "scatter", color = ~as.factor(YEAR), mode = "lines+markers",
    height=250
  ) |>
    layout(
      title = paste0("Weekly Flights Trend (2019–2023)"),
      xaxis = list(type = "category", title = "Day of Week"),
      yaxis = list(title = "Total Flights")
    ) |> config(responsive = TRUE)
}


