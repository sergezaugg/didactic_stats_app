# ---------------------------
# Description : function that render ggplots
# Author : Serge Zaugg
# ---------------------------

# ---------------------------
# helpers (not used outside of this module)

add_scatterplot_formats <- function(fig) {
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
      ),
      axis.text.x = element_text(size = 16),
      axis.text.y = element_text(size = 16),
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16),
      legend.title = element_text(size = 16),
      legend.text = element_text(size = 16)
    )
}


# # add regression lines
# add_lines_to_scatterplot <- function(fig, df_lines) {
#   fig +
#     geom_abline(
#       data = df_lines,
#       aes(intercept = intercept, slope = slope, color = group),
#       linewidth = 1
#     )
# }

# ---------------------------
# main plot functions

# scatter plot
make_data_scatterplot <- function(x, df_lines, colo = FALSE) {
  
  fig <- ggplot(x) 
    
  if (colo) {
    fig <- fig + geom_point(aes(x = predictor, y = response, color = group), size = 1)  
    fig <- fig + labs(x = "Predictor", y = "Response", group = "Group")
    fig <- fig + geom_abline(data = df_lines,
      aes(intercept = intercept, slope = slope, color = group), linewidth = 1)
    fig <- add_scatterplot_formats(fig)
    fig <- fig + theme(plot.margin = margin(t = 5, r = 5, b = 5, l = 5))
  } else {
    fig <- fig + geom_point(aes(x = predictor, y = response), color = "#ffffff") 
    fig <- fig + labs(x = "Predictor", y = "Response")
    fig <- fig + geom_abline(data = df_lines,
      aes(intercept = intercept, slope = slope), linewidth = 1, color = "#ffffff")
    fig <- add_scatterplot_formats(fig)
    fig <- fig + theme(plot.margin = margin(t = 5, r = 68, b = 5, l = 5))
  }
  
  return(fig)
  
}

# scatter plot of residuals
make_residuals_plot <- function(df, res) {
  fig <- ggplot(df) +
    geom_point(
      aes(x = predictor, y = res, color = group),
      size = 1
    ) +
    geom_hline(yintercept = 0,linetype = "dashed",color = "#ff9900") +
    labs(x = "Predictor", y = "Residuals", group = "Group")
  facet_wrap(~group, ncol = 2)
  add_scatterplot_formats(fig)
}
