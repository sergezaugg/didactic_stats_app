# ---------------------------
# Description : page X free
# Author : Serge Zaugg
# ---------------------------

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
          h5(paste0("Simulate ", title)), 
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
          
          fluidRow(
            column(width = 8,
              selectInput(
                inputId = paste0("dist_plot_", id_tag),
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
                 inputId = paste0("show_color_", id_tag),
                 label = "Show group color",
                 value = TRUE
              )     
            )
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








make_page_mod <- function(id, title = "aa", const_x = FALSE, betas_a = "", betas_b = "", text = "") { 
  
  ns <- NS(id)
  
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
          make_group_controls_ns("_a", "Group A", const_x = const_x, b = betas_a, ns = ns),
          tags$hr(style = style_divider),
          make_group_controls_ns("_b", "Group B", const_x = const_x, b = betas_b, ns = ns),
          tags$hr(style = style_divider),
          h5(paste0("Simulate ", title)), 
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
          style = style_pannels,
          h5("Statistical estimates"),
          tags$hr(style = style_divider),
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













