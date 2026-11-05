# ---------------------------
# Description : page X free
# Author : Serge Zaugg
# ---------------------------
 
# id_tag = "x_free"
# paste0(id_tag, "_a")
# paste0(id_tag, "_b")
# paste0("dist_plot_", id_tag)
# paste0("sel_scatter_plot_", id_tag)
# paste0("sel_residual_plot_", id_tag)
# paste0("sel_tabconv_", id_tag)
# paste0("sel_ttable_" , id_tag)

style_pannels <- "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"
style_divider <- "margin-top: 11px; margin-bottom: 11px;"

make_page_x <- function(id_tag = "default", title = "aa", const_x = FALSE, betas_a = "", betas_b = "", text = "") { 
    
  page <- tabPanel(
    title = title,
    fluidRow(
      # control on the left side
      column(
        width = 4,
        div(
          style = style_pannels,
          h5("Define data distribution"),
          tags$hr(style = style_divider),
          make_group_controls(paste0(id_tag, "_a"), "Group A", const_x = const_x, b = betas_a),
          tags$hr(style = style_divider),
          make_group_controls(paste0(id_tag, "_b"), "Group B", const_x = const_x, b = betas_b),
          tags$hr(style = style_divider),
          tags$p(text),
        )
      ),
      # plots in the middle
      column(
        width = 4,
        div(
          style = style_pannels,
          h5("Scatterplot, regression lines, residuals"),
          tags$hr(style = style_divider),
          selectInput(
            inputId = paste0("dist_plot_", id_tag),
            label = "Choose model",
            choices = c(
              "M1 (Global mean only)" = "m01",
              "M2 (Group means only)" = "m02",
              "M3 (Global mean & slope)" = "m03",
              "M4 (Group mean & global slope)" = "m04",
              "M5 (Group mean & group slope)" = "m05"
            ),
            selected = "m01",
          ),
          plotOutput(
            outputId = paste0("sel_scatter_plot_", id_tag),
            height = "300px"
          ),
          div(style = "height: 15px;"),
          plotOutput(
            outputId = paste0("sel_residual_plot_", id_tag),
            height = "220px"
          )
        )
      ),
      # plots and table to the right
      column(
        4,
        div(
          style = style_pannels,
          h5("Statistical estimates"),
          tags$hr(style = style_divider),
          h6("Conventional coefficients"),
          tableOutput(paste0("sel_tabconv_", id_tag)),
          div(style = "height: 15px;"),
          h6("Per-group coefficients"),
          tableOutput(paste0("sel_ttable_" , id_tag))
        )
      )
    )
  )
  return(page)
}
