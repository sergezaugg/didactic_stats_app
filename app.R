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
  Failing to adjust for covariate or group may lead to biased estimates."

text_simpso = "Slope constrained to be negative and group B higher than A. 
  Simpson's Paradox: M3 ignores groups and suggests a positive association 
  between predictor and response.
  If group is included in models (M4 & M5) we find that association is negative"
  
  
page_x_free = make_page_x(id_tag = "x_free", title = "Regression (X free)", 
  const_x = FALSE, 
  betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
  text = text_x_free)

page_x_same = make_page_x(id_tag = "x_same", title = "Regression (X same)", 
  const_x = TRUE, 
  betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
  text = text_x_same)

page_x_uneq = make_page_x(id_tag = "x_uneq", title = "Regression (X unequal)", 
  const_x = TRUE, 
  betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),  
  text = text_x_uneq)

page_simpso = make_page_x(id_tag = "simpso", title = "Regression (S-Paradox)", 
  const_x = TRUE, 
  betas_a = c(-8,-2,   -8,-6), betas_b = c(2,8,    -8,-6),
  text = text_simpso)

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



