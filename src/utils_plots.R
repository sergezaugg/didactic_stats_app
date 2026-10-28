# ---------------------------
# Description : function that render ggplots 
# Author : Serge Zaugg
# ---------------------------

# helpers (not used otside of this moduls )

add_scatterplot_formats <- function(fig){
  fig +
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


# main plot functions

# scatterplot 
make_data_scatterplot <- function(x, df_lines){
  fig <- ggplot(x) + 
    geom_point(
      aes(x = predictor, y = response, color = group),
      size = 1
    ) 
  
  fig <- add_lines_to_scatterplot(fig, df_lines)
  
  add_scatterplot_formats(fig)
}



# scatter plot of residuals 
make_residuals_plot <- function(df, res) {
  fig <- ggplot(df) + 
    geom_point(
      aes(x = predictor, y = res, color = group),
      size = 1
    ) +
    facet_wrap(~ group, ncol = 2)
  
  add_scatterplot_formats(fig)
}




