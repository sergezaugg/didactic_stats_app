# ---------------------------
# Description : entry point of the app
# Author : Serge Zaugg
# ---------------------------

library(tidyverse)
library(shiny)
library(bslib)

source("src/utils_sim.R")
source("src/utils_ui.R")
source("src/utils_plots.R")

# make non-interactive pages 
source("pages/page_about.R")
source("pages/page_summary.R")

# parametrized page generations 
source("pages/page_x_functionalized.R")

text_x_free = "All simulation parameters are free."
text_x_same = "Covariate (Predictor) constrained to same distribution in both groups.
  This simulates a randomized experiment where covariate is evenly distributed across both groups.
  The covariate may have an association to response and then adjusting for it is adecquate."
text_x_uneq = "Covariate (Predictor) constrained to have different distribution in groups.
  This simulates observational data where covariate is diferent between both groups.
  Failing to adjust for covariate or group may lead to biased estimates.
  An extreme example is Simpson's paradox which can be simulated here"

page_x_free = make_page_x(id_tag = "x_free", title = "Regression (X free)", 
  const_x = FALSE, simpso = FALSE, text = text_x_free)

page_x_same = make_page_x(id_tag = "x_same", title = "Regression (X same)", 
  const_x = TRUE, simpso = FALSE, text = text_x_same)

page_x_uneq = make_page_x(id_tag = "x_uneq", title = "Regression (X unequal)", 
  const_x = TRUE, simpso = FALSE, text = text_x_uneq)

page_simpso = make_page_x(id_tag = "simpso", title = "Regression (S-Paradox)", 
  const_x = TRUE, simpso = TRUE, text = "")

# Tell shiny where to find ressources
addResourcePath("ressources", "ressources")

# style 
style_pannels = "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"
style_divider = "margin-top: 11px; margin-bottom: 11px;"

# Define UI  
ui <- navbarPage(
  selected = "Regression (X same)",
  title = tags$span(
    style = "display: inline-flex; align-items: center; gap: 10px;",
    tags$img(src = "ressources/z_logo_violet.png", height = "30px"),
    tags$span("Applied Stats Playground")
  ),
  # version and (c) at bottom
  tags$div(
    "v0.9.1 - © 2026 Serge Zaugg",
    style = "position: fixed;bottom: 8px; left: 20px;
      font-size: 14px; color: #888888; opacity: 1.0; z-index: 9999;
    "
  ),
  
  # styling colors
  theme = bs_theme(
    bg = "#000000", fg = "white", primary = "#ddccdd", secondary = "#660055"),
  # styling margins
  tags$head(
    tags$style(HTML("
      .container-fluid {
        margin-top: 0px;
        margin-bottom: 30px;
        min-width: 1400px;
        max-width: 1600px;
        margin-left: auto;
        margin-right: auto;
    }"))
  ),
  # pages 
  page_about,
  page_x_same,
  page_x_uneq,
  page_simpso,
  page_x_free,
  page_summary
)

# Define server  
server <- function(input, output, session) {
  # load server code from scripts
  source("server/server_x_same.R", local = TRUE)
  source("server/server_x_uneq.R", local = TRUE)
  source("server/server_x_free.R", local = TRUE)
  source("server/server_simpso.R", local = TRUE)
  # de-bugging 
  # output$debug <- renderPrint(names(resfigs))
}

shinyApp(ui, server)



