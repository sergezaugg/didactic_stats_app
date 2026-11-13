# ---------------------------
# Description : page X free
# Author : Serge Zaugg
# ---------------------------

pages_ui_module <- function(id, title = "aa", const_x = FALSE, betas_a = "", betas_b = "", text = "") { 
  
  ns <- NS(id)
  
  page <- tabPanel(
    title = title,
    fluidRow(
      # control on the left side
      column(
        width = 4,
        div(
          class = "panel-custom",
          h5("Define data distribution"),
          tags$hr(class = "divider-custom"),
          make_group_controls_ns("_a", "Group A", const_x = const_x, b = betas_a, ns = ns),
          tags$hr(class = "divider-custom"),
          make_group_controls_ns("_b", "Group B", const_x = const_x, b = betas_b, ns = ns),
          tags$hr(class = "divider-custom"),
          h5(paste0("Simulate ", title)), 
          tags$p(text),
        )
      ),
      # plots in the middle
      column(
        width = 4,
        div(
          class = "panel-custom",
          h5("Scatterplot, regression lines, residuals"),
          tags$hr(class = "divider-custom"),
          
          fluidRow(
            column(width = 8,
                   selectInput(
                     inputId = ns("dist_plot"),
                     label = "Choose model",
                     choices = c(
                       "M1 (Null model)" = "m01",
                       "M2 (Group effect)" = "m02",
                       "M3 (Predictor effect)" = "m03",
                       "M4 (Additive model)" = "m04",
                       "M5 (Interaction model)" = "m05"
                     ),
                     selected = "m01",
                   )
            ),
            column(width = 4,
                   checkboxInput(
                     inputId = ns("show_color"),
                     label = "Show group color",
                     value = TRUE
                   )     
            )
          ),
          
          plotOutput(
            outputId = ns("sel_scatter_plot"),
            height = "300px"
          ),
          div(style = "height: 15px;"),
          plotOutput(
            outputId = ns("sel_residual_plot"),
            height = "220px"
          )
        )
      ),
      # plots and table to the right
      column(
        4,
        div(
          class = "panel-custom",
          h5("Statistical estimates"),
          tags$hr(class = "divider-custom"),
          h6("Conventional coefficients"),
          tableOutput(ns("sel_tabconv")),
          div(style = "height: 15px;"),
          h6("Per-group coefficients"),
          tableOutput(ns("sel_ttable"))
        )
      )
    )
  )
  return(page)
}













