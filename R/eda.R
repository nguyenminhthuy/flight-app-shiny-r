library(dplyr)

compute_basic_stats <- function(df) {
  df |>
    summarise(
      n_flights = n(),
      n_airlines = n_distinct(na.omit(AIRLINE)),
      n_airports = n_distinct(na.omit(ORIGIN)),
      n_flight_delay = sum(ARR_DELAY > 15, na.rm = TRUE),
      n_flight_ontime = sum(ARR_DELAY <= 15, na.rm = TRUE),
      n_flight_cancel = sum(CANCELLED == 1, na.rm = TRUE),
      n_flight_divert = sum(DIVERTED == 1, na.rm = TRUE),
      n_short_distance = sum(DISTANCE_CAT == "Short-haul", na.rm = TRUE),
      n_medium_distance = sum(DISTANCE_CAT == "Medium-haul", na.rm = TRUE),
      n_long_distance = sum(DISTANCE_CAT == "Long-haul", na.rm = TRUE)
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
      type = "bar", color = ~as.factor(YEAR)
    ) |>
    layout(
      title = paste0("Yearly Flights Trend (2019–2023)"),
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
    type = "scatter", color = ~as.factor(YEAR), mode = "lines+markers"
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
    type = "scatter", color = ~as.factor(YEAR), mode = "lines+markers"
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
    type = "scatter", color = ~as.factor(YEAR), mode = "lines+markers"
  ) |>
    layout(
      title = paste0("Weekly Flights Trend (2019–2023)"),
      xaxis = list(type = "category", title = "Day of Week"),
      yaxis = list(title = "Total Flights")
    ) |> config(responsive = TRUE)
}

#---------------------------------------------
overview_flights_overtime <- function(df, origin = NULL, start_date, end_date, mode = "date") {
  
  # Lọc ORIGIN nếu người dùng chọn
  if (!is.null(origin) && origin != "" && origin != "All") {
    df <- df[df$ORIGIN == origin, ]
  }
  
  # if (!is.null(dest) && dest != "" && dest != "All") {
  #   df <- df[df$DEST == dest, ]
  # }
  
  # Lọc theo FL_DATE
  
  # Gom nhóm theo mode
  if (mode == "date") {
    df_date <- df[df$FL_DATE >= as.Date(start_date) & 
               df$FL_DATE <= as.Date(end_date), ]
    
    df_group <- df_date |> 
      group_by(FL_DATE) |> 
      summarise(Total_Flights = n(), 
                .groups = "drop")
    
  } else if (mode == "year-month") {
    
    df$YEAR_MONTH <- format(df$FL_DATE, "%Y-%m")
    
    start_date <- substr(start_date, 1, 7)
    end_date   <- substr(end_date, 1, 7)
    
    df_ym <- df[df$YEAR_MONTH >= start_date &
               df$YEAR_MONTH <= end_date, ]
    
    df_group <- df_ym |> 
      group_by(YEAR_MONTH) |> 
      summarise(Total_Flights = n(), .groups = "drop")
    
  } else if (mode == "year") {
    
    df_y <- df[df$YEAR >= start_date &
               df$YEAR <= end_date, ]
    
    df_group <- df_y |> 
      group_by(YEAR) |> 
      summarise(Total_Flights = n(), .groups = "drop")
    
  } else {
    stop("mode must be 'date', 'year-month', or 'year'")
  }
  
  return(df_group)
}

plot_flights_bar <- function(df_group, mode = "date") {
  
  if (nrow(df_group) == 0) {
    return(
      plot_ly() |> 
        layout(title = "No data available")
    )
  }
  
  # DATE ----------------------------------------------------------
  if (mode == "date") {
    p <- plot_ly(
      data = df_group,
      x = ~FL_DATE,
      y = ~Total_Flights,
      type = "scatter",
      mode = "lines", 
      line = list(color = "#FF6B35", width = 2),
      #fill = "tozeroy",
      fillcolor = "rgba(255, 107, 53)"   # màu cam nhạt
    ) |> 
      layout(
        title = "Daily Flights (Area Chart)",
        xaxis = list(title = "Date"),
        yaxis = list(title = "Total Flights")
      )
    
    # YEAR-MONTH ----------------------------------------------------
  } else if (mode == "year-month") {
    p <- plot_ly(
      data = df_group,
      x = ~YEAR_MONTH,
      y = ~Total_Flights,
      type = "bar",
      color = ~YEAR_MONTH
    ) |> 
      layout(
        xaxis = list(title = "Year-Month"),
        yaxis = list(title = "Total Flights")
      )
    
    # YEAR ----------------------------------------------------------
  } else if (mode == "year") {
    p <- plot_ly(
      data = df_group,
      x = ~factor(YEAR),
      y = ~Total_Flights,
      type = "bar",
      color = ~factor(YEAR)
    ) |> 
      layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Total Flights")
      )
    
  } else {
    stop("mode must be 'date', 'year-month', hoặc 'year'")
  }
  
  return(p)
}

#---------------------------------------------




