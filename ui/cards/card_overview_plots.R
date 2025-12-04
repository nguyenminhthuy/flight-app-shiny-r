card_overview_plot <- function(title, plot_id) {
  card(
    card_header(
      style = "background-color:#0dcaf0; color:white; text-align:center;
               font-weight:bold; padding:5px; margin:0;",
      title
    ),
    card_body(
      plotlyOutput(plot_id, height = "auto")
    )
  )
}
