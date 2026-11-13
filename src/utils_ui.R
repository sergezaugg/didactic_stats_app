# ---------------------------
# Description : ui elements are defined here and later imported to app.R
# Author : Serge Zaugg
# ---------------------------

app_custom_title <- function() {
  tags$span(
    style = "display: inline-flex; align-items: center; gap: 10px;",
    tags$img(src = "resources/z_logo_red.png", height = "30px"),
    tags$span("Applied Stats Playground")
  )
}

app_footer <- function() {
  tags$div(
    "v0.10.0 - © 2026 Serge Zaugg",
    class = "app-footer"
  )
}

make_group_controls_ns <- function(group, title, const_x = FALSE, b, ns) {
  fluidRow(
    tagList(
      column(
        width = 3,
        h6(title),
        selectInput(
          inputId = ns(paste0("n", group)),
          label = "N",
          choices = c(10, 20, 30, 50, 100),
          selected = 50
        ),
        numericInput(
          inputId = ns(paste0("sd_res", group)),
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
              inputId = ns(paste0("xmin", group)), 
              label = "xmin",
              min = -1.0, max = 0.0, value = -0.5, step = 0.1
            ),
            sliderInput(
              inputId = ns(paste0("xmax", group)), 
              label = "xmax",
              min = 0.0, max = 1.0, value = 0.5, step = 0.1
            )
          )
        },
      ),
      column(
        width = 4,
        sliderInput(
          inputId = ns(paste0("b0", group)), 
          label = "β₀", min = b[1], max = b[2], value = (b[1]+b[2])/2),
        sliderInput(
          inputId = ns(paste0("b1", group)), 
          label = "β₁", min = b[3], max = b[4], value = (b[3]+b[4])/2)
      )
    )
  )
}






