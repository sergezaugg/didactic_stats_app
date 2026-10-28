# ---------------------------
# Description : entry point of the app
# Author : Serge Zaugg
# renv::init()
# ---------------------------

library(shiny)
library(ggplot2)
library(bslib)
library(shinyWidgets)
library(MASS)
library(tidyverse)
library(DT)
source("src/utils_sim.R")
source("src/utils_ui.R")
source("src/utils_plots.R")
source("pages/page_summary.R")
source("pages/page_free_param.R")
source("pages/page_controled_param.R")
source("pages/page_fixed_param.R")


style_pannels = "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"
style_divider = "margin-top: 11px; margin-bottom: 11px;"

# Define UI  
ui <- navbarPage(
  title = "Applied Stats Playground",
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
  page_free_param,
  page_controlled_param,
  page_fixed_param,
  page_summary
  
)

# Define server  
server <- function(input, output, session) {
  # load server code from external scripts
  source("server/server_free.R", local = TRUE)
  source("server/server_fix_equal.R", local = TRUE)
  source("server/server_fix_unequ.R", local = TRUE)
  # de-bugging 
  # output$debug <- renderPrint(names(resfigs))
}

shinyApp(ui, server)



