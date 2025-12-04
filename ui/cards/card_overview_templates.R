library(bsicons)

card_overview <- function(title, output_id, icon_name = "airplane") {
  card(
    card_header(
      style = "background-color: #2c3e50; color: white; text-align: center;
               font-weight: bold; padding: 5px; margin: 0;",
      bs_icon(icon_name, size = "1em", style = "color: white;"),
      title
    ),
    card_body(
      div(
        style = "color: #18bc9c; text-align: center; font-size: 30px; font-weight: bold;",
        textOutput(output_id, container = span)
      )
    )
  )
}
