# ---------------------------
# Description : page X same
# Author : Serge Zaugg
# ---------------------------

style_pannels <- "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"
style_divider <- "margin-top: 11px; margin-bottom: 11px;"

page_x_same <- tabPanel(
  "Regression (X same)",
  fluidRow(
    # control on the left side
    column(
      width = 4,
      div(
        style = style_pannels,
        h5("Define data distribution"),
        tags$hr(style = style_divider),
        make_group_controls("x_same_a", "Group A", const_x = TRUE),
        tags$hr(style = style_divider),
        make_group_controls("x_same_b", "Group B", const_x = TRUE),
        tags$hr(style = style_divider),
        tags$p("Quick guide: Covariate (Predictor) has same distribution in both groups.
          This simulates a randomized experiment where covariate is evenly distributed across both groups.
          The covariate may have an association to response and then adjusting for it can increase power."),
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
          inputId = "dist_plot_x_same_a",
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
          outputId = "sel_scatter_plot_x_same",
          height = "300px"
        ),
        div(style = "height: 15px;"),
        plotOutput(
          outputId = "sel_residual_plot_x_same",
          height = "220px"
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
        h6("Conventional coefficients"),
        tableOutput("sel_tabconv_x_same"),
        div(style = "height: 15px;"),
        h6("Per-group coefficients"),
        tableOutput("sel_ttable_x_same")
      )
    )
  )
)
