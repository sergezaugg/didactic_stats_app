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

source("pages/page_x_same.R")
source("pages/page_x_uneq.R")
source("pages/page_x_free.R")
source("pages/page_summary.R")

addResourcePath("ressources", "ressources")

style_pannels = "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"
style_divider = "margin-top: 11px; margin-bottom: 11px;"

# Define UI  
ui <- navbarPage(
  # title = "Applied Stats Playground",
  title = tags$span(
    style = "display: inline-flex; align-items: center; gap: 10px;",
    tags$img(src = "ressources/z_logo_violet.png", height = "30px"),
    tags$span("Applied Stats Playground")
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
  page_x_same,
  page_x_uneq,
  page_x_free,
  page_summary
)

# Define server  
server <- function(input, output, session) {
  # load server code from scripts
  source("server/server_x_same.R", local = TRUE)
  source("server/server_x_uneq.R", local = TRUE)
  source("server/server_x_free.R", local = TRUE)
  # de-bugging 
  # output$debug <- renderPrint(names(resfigs))
}

shinyApp(ui, server)



