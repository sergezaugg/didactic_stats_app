# ---------------------------
# Description : entry point of the app
# Author : Serge Zaugg
# ---------------------------

#-----------------------------
# (1) load and prepare   
#-----------------------------

# load packages
library(tidyverse)
library(shiny)
library(bslib)
# load own functions
source("src/utils_sim.R")
source("src/utils_ui.R")
source("src/utils_plots.R")
# Tell shiny where to find resources
addResourcePath("resources", "resources")
# load non-interactive pages &  texts 
source("pages/page_about.R")
source("pages/page_summary.R")
source("pages/text_for_pages.R")
# load function page UI generations & server processing 
source("pages/pages_ui_module.R")
source("server/pages_server_module.R")

#-----------------------------
# (2) Define UI  
#-----------------------------

ui <- navbarPage(
  selected = ptext$x_same_ti,
  
  title = tags$span(
    style = "display: inline-flex; align-items: center; gap: 10px;",
    tags$img(src = "resources/z_logo_red.png", height = "30px"),
    tags$span("Applied Stats Playground")
  ),
  
  # version and (c) at bottom
  tags$div(
    "v0.9.5 - © 2026 Serge Zaugg",
    style = "position: fixed;bottom: 8px; left: 20px;
      font-size: 14px; color: #888888; opacity: 1.0; z-index: 9999;
    "
  ),
  
  # define header colors 
  tags$head(
    tags$style(HTML("
    h5 {color: #FFDDCC !important;}
  "))
  ),
  
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
  
  # formatting for MathJax equations 
  header = tags$head(
    tags$style(HTML("
      .MathJax_Display {
        text-align: left !important;
        margin-left: 0 !important;
      }
    "))
  ),
  
  # styling colors
  theme = bs_theme(
    bg = "#000000", 
    fg = "white", 
    primary = "#ddccdd", 
    secondary = "#660055"
  ),
  
  
  #  pages 
  
  page_about,
  
  pages_ui_module(
    id = "x_same", 
    const_x = TRUE, 
    betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
    title = ptext$x_same_ti, 
    text = ptext$x_same_tx
  ),
  
  pages_ui_module(
    id = "x_uneq",
    const_x = TRUE,
    betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
    title = ptext$x_uneq_ti,
    text = ptext$x_uneq_tx
  ),
  
  pages_ui_module(
    id = "simpso",
    const_x = TRUE,
    betas_a = c(-8, -2, -8, -6), betas_b = c(2, 8, -8, -6),
    title = ptext$simpso_ti,
    text = ptext$simpso_tx
  ),
  
  pages_ui_module(
    id = "x_free",
    const_x = FALSE,
    betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
    title = ptext$x_free_ti,
    text = ptext$x_free_tx
  ),
  
  page_summary,
 
)


#-----------------------------
# (3) Define server processing
#-----------------------------

server <- function(input, output, session) {
  pages_server_module("x_free")
  pages_server_module("x_same", x_vals_a = c(-0.5,0.5), x_vals_b = c(-0.5, 0.5))
  pages_server_module("x_uneq", x_vals_a = c(-0.5,0.2), x_vals_b = c(-0.2, 0.5))
  pages_server_module("simpso", x_vals_a = c(-0.5,0.2), x_vals_b = c(-0.2, 0.5))
  # output$debug <- renderPrint(names(resfigs))
}

#-----------------------------
# (4) create Shiny app object
#-----------------------------

shinyApp(ui, server)



