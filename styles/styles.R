# ---------------------------
# Description : style-related elements and functions
# Author : Serge Zaugg
# ---------------------------

themes_li <- list(
  
  "custom_goth" = bs_theme(
    bg = "#000000", fg = "#ffffff", 
    primary = "#ddccdd", secondary = "#550044",
    ),
  
  "custom_cold" = bs_theme(
    bg = "#000000", fg = "#ffffff", 
    primary = "#aaccee", secondary = "#003377"
    )
)




add_custom_styles <- function(theme = c("custom_cold", "custom_goth")) {
  
  theme <- match.arg(theme)
  
  panel_color <- switch(
    theme,
    custom_cold = "#001139",
    custom_goth = "#330022"
  )
  
  tags$style(HTML(sprintf("
    /* Module panels */
    .panel-custom {
      background-color: %s;
    }
  ", panel_color)))
}





