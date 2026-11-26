# ---------------------------
# Description : style-related elements and functions
# Author : Serge Zaugg
# ---------------------------

# bslib custom themes
themes_li <- list(
  "custom_goth" = bs_theme(bg = "#000000", fg = "#ffffff", primary = "#ffddee", secondary = "#550044"),
  "custom_cold" = bs_theme(bg = "#000000", fg = "#ffffff", primary = "#ccddff", secondary = "#334477")
)

app_custom_theme_title <- function(text){
  tags$span(
    style = "display: inline-flex; align-items: center; gap: 10px;",
    tags$span(text)
  )
}





