# ---------------------------
# Description : large ui elements are defined here and later imported to app.R
# Author : Serge Zaugg
# ---------------------------

# ui elements
make_group_controls <- function(group, title, const_x = FALSE, b) {
  fluidRow(
    tagList(
      column(
        width = 3,
        h6(title),
        selectInput(
          inputId = paste0("n_", group),
          label = "N",
          choices = c(10, 20, 30, 50, 100, 500),
          selected = 50
        ),
        numericInput(
          inputId = paste0("sd_res_", group),
          label = "σ (Noise)",
          value = 1.0,
          min = 0.2,
          max = 5.0,
          step = 0.2
        )
      ),
      column(
        width = 4,
        if (const_x) {
          tags$div("X values fixed")
        } else {
          tagList( # needed for shiny - tagList() groups multiple Shiny UI elements into one object
            sliderInput(
              inputId = paste0("xmin_", group), label = "xmin",
              min = -1.0, max = 0.0, value = -0.5, step = 0.1
            ),
            sliderInput(
              inputId = paste0("xmax_", group), label = "xmax",
              min = 0.0, max = 1.0, value = 0.5, step = 0.1
            )
          )
        },
      ),
      column(
        width = 4,
        sliderInput(inputId = paste0("b0_", group), label = "β₀", min = b[1], max = b[2], value = (b[1]+b[2])/2),
        sliderInput(inputId = paste0("b1_", group), label = "β₁", min = b[3], max = b[4], value = (b[3]+b[4])/2)
      )
    )
  )
}
