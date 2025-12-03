compute_basic_stats <- function(df) {
  
  lst_airline <- sort(unique(na.omit(df$AIRLINE)))
  list(
    n_flights = nrow(df),
    n_airlines = length(lst_airline),
    n_flight_delay = sum(df$ARR_DELAY > 15, na.rm=TRUE),
    n_flight_ontime = sum(df$ARR_DELAY <= 15, na.rm = TRUE),
    n_flight_cancel = sum(df$CANCELLED == 1, na.rm = TRUE),
    n_flight_divert = sum(df$DIVERTED == 1, na.rm = TRUE),
    n_short_distance = sum(df$DISTANCE_CAT == "Short-haul", na.rm = TRUE),
    n_medium_distance = sum(df$DISTANCE_CAT == "Medium-haul", na.rm = TRUE),
    n_long_distance = sum(df$DISTANCE_CAT == "Long-haul", na.rm = TRUE)
  )
}