# ---------------------------
# Description : entry point of the app
# Author : Serge Zaugg
# ---------------------------

# load packages
library(tidyverse)
library(shiny)
library(bslib)
# Tell shiny where to find resources
addResourcePath(prefix="contents", directoryPath="contents")
# load own functions
source("src/utils_sim.R")
source("src/utils_ui.R")
source("src/utils_plots.R")
# load non-interactive pages & texts 
source("src/page_about.R")
source("src/page_summary.R")
source("src/text_for_pages.R")
# load function page UI generations & server processing 
source("src/pages_ui_module.R")
source("src/pages_server_module.R")
# load styles 
source("styles/styles.R")


#-----------------------------
# Define UI  

ui <- navbarPage(
  # set starting theme 
  theme = themes_li$custom_cold,
  # apply CSS styles 
  includeCSS("styles/styles.css"),
  # default starting page 
  selected = ptext$x_same_ti,
  # add custom title and logo
  title = app_custom_title(),
  # add version and (c) at bottom
  app_footer(),
 
  #  pages 
  page_about,
  pages_ui_module(id = "x_same", 
    const_x = TRUE, betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
    title = ptext$x_same_ti, text = ptext$x_same_tx
  ),
  pages_ui_module(id = "x_uneq",
    const_x = TRUE, betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
    title = ptext$x_uneq_ti, text = ptext$x_uneq_tx
  ),
  pages_ui_module(id = "simpso",
    const_x = TRUE, betas_a = c(-8, -2, -8, -6), betas_b = c(2, 8, -8, -6),
    title = ptext$simpso_ti, text = ptext$simpso_tx
  ),
  pages_ui_module(id = "x_free",
    const_x = FALSE, betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
    title = ptext$x_free_ti, text = ptext$x_free_tx
  ),
  page_summary,
  
)

#-----------------------------
# Define server processing
server <- function(input, output, session) {
  pages_server_module("x_free")
  pages_server_module("x_same", x_vals_a = c(-0.5,0.5), x_vals_b = c(-0.5, 0.5))
  pages_server_module("x_uneq", x_vals_a = c(-0.5,0.2), x_vals_b = c(-0.2, 0.5))
  pages_server_module("simpso", x_vals_a = c(-0.5,0.2), x_vals_b = c(-0.2, 0.5))
}

#-----------------------------
# create Shiny app object
shinyApp(ui, server)



