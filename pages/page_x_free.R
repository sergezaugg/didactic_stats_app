# ---------------------------
# Description : page X free
# Author : Serge Zaugg
# ---------------------------

style_pannels <- "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"
style_divider <- "margin-top: 11px; margin-bottom: 11px;"

page_x_free <- tabPanel(
  title = "Regression (X free)",
  fluidRow(
    # control on the left side
    column(
      width = 4,
      div(
        style = style_pannels,
        h5("Define data distribution"),
        tags$hr(style = style_divider),
        make_group_controls("x_free_a", "Group A", const_x = FALSE),
        tags$hr(style = style_divider),
        make_group_controls("x_free_b", "Group B", const_x = FALSE),
        tags$hr(style = style_divider),
        tags$p("Quick guide: All simulation parameters are free."),
      )
    ),
    # plots in the middle
    column(
      width = 4,
      div(
        style = style_pannels,
        h5("Scatterplot and regression lines"),
        tags$hr(style = style_divider),
        selectInput(
          inputId = "dist_plot_x_free",
          label = "Choose model",
          choices = c(
            "M1 (Global mean only)" = "m01",
            "M2 (two means only)" = "m02",
            "M3 (Global mean & slope)" = "m03",
            "M4 (Group mean & global slope)" = "m04",
            "M5 (Group mean & group slope)" = "m05"
          ),
          selected = "m01",
        ),
        plotOutput(
          outputId = "sel_scatter_plot_x_free",
          height = "300px"
        )
      )
    ),
    # verbatimTextOutput("debug"),
    # plots and table to the right
    column(
      4,
      div(
        style = style_pannels,
        h5("Residuals & Estimates"),
        tags$hr(style = style_divider),
        div(style = "height: 87px;"),
        plotOutput(
          outputId = "sel_residual_plot_x_free",
          height = "300px"
        ),
        tags$hr(style = style_divider),
        tableOutput("sel_ttable_x_free")
      )
    )
  )
)
