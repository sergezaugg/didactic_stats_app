# ---------------------------
# Description : ggplots are defined here 
# Author : Serge Zaugg
# ---------------------------


# scatterplot 
make_data_scatterplot <- function(x){
  ggplot(x) + 
    geom_point(
      aes(x = predictor, y = response, color = group),
      size = 1
    ) +
    labs(title = " ") +
    theme_dark() +
    theme(
      plot.background   = element_rect(fill = "#000000", color = NA),
      panel.background  = element_rect(fill = "#000000", color = NA),
      legend.background = element_rect(fill = "#000000", colour = NA),
      legend.key        = element_rect(fill = "#000000", colour = NA),
      text              = element_text(color = "white")
    ) +
    theme(
      panel.border = element_rect(
        colour = "white",
        fill = NA,
        linewidth = 1
      )
    )
}


# add regression lines 
add_lines_to_scatterplot <- function(fig, df_lines) { 
  fig +
    geom_abline(
      data = df_lines,
      aes(intercept = intercept, slope = slope, color = group),
      linewidth = 1
    )  
  
}





