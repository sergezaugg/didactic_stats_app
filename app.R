# ---------------------------
# Description : entry point of the app
# Author : Serge Zaugg
# ---------------------------

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


#-----------------------------
# (1) load and generate pages   
#-----------------------------

# load non-interactive pages 
source("pages/page_about.R")
source("pages/page_summary.R")
# load function for page generations 
source("pages/page_x_functionalized.R")
# load info texts 
source("pages/text_for_pages.R")
# ptext %>% names()

# new 
source("server/server_functionalized.R")



# generate pages 
page_x_free = make_page_x(id_tag = "x_free", 
  const_x = FALSE, 
  betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
  title = ptext$x_free_ti, 
  text = ptext$x_free_tx
)

page_x_same = make_page_x(id_tag = "x_same", 
  const_x = TRUE, 
  betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
  title = ptext$x_same_ti, 
  text = ptext$x_same_tx
)

page_x_uneq = make_page_x(id_tag = "x_uneq", 
  const_x = TRUE, 
  betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8), 
  title = ptext$x_uneq_ti, 
  text = ptext$x_uneq_tx
)

page_simpso = make_page_x(id_tag = "simpso", 
  const_x = TRUE, 
  betas_a = c(-8, -2, -8, -6), betas_b = c(2, 8, -8, -6),
  title = ptext$simpso_ti, 
  text = ptext$simpso_tx
)




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
  
  page_x_same,
  make_page_mod(id = "x_same", 
                const_x = TRUE, 
                betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
                title = ptext$x_same_ti, 
                text = ptext$x_same_tx
  ),
  
  
  page_x_uneq,
  make_page_mod(id = "x_uneq",
                const_x = TRUE,
                betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
                title = ptext$x_uneq_ti,
                text = ptext$x_uneq_tx
  ),
  
  page_simpso,
  make_page_mod(id = "simpso",
                const_x = TRUE,
                betas_a = c(-8, -2, -8, -6), betas_b = c(2, 8, -8, -6),
                title = ptext$simpso_ti,
                text = ptext$simpso_tx
  ),
  
  page_x_free,
  make_page_mod(id = "x_free",
                const_x = FALSE,
                betas_a = c(-8,8,-8,8), betas_b = c(-8,8,-8,8),
                title = ptext$x_free_ti,
                text = ptext$x_free_tx
  ),
  
  
  page_summary,
  
  
  
  
  # make_page_mod(id = "test44",
  #   const_x = FALSE,
  #   betas_a = c(4,8,4,8), betas_b = c(4,8,4,8),
  #   title = "acafagasd",
  #   text = "ss ss ss ss ss "
  # )

  
  
  
  
  
  
)


#-----------------------------
# (3) Define server 
#-----------------------------

server <- function(input, output, session) {
  
  # load server code from scripts
  source("server/server_x_same.R", local = TRUE)
  source("server/server_x_uneq.R", local = TRUE)
  source("server/server_x_free.R", local = TRUE)
  source("server/server_simpso.R", local = TRUE)
  
  my_module_server("x_free")
  my_module_server("x_same", x_vals_a = c(-0.5,0.5), x_vals_b = c(-0.5, 0.5))
  my_module_server("x_uneq", x_vals_a = c(-0.5,0.2), x_vals_b = c(-0.2, 0.5))
  my_module_server("simpso", x_vals_a = c(-0.5,0.2), x_vals_b = c(-0.2, 0.5))
  
  # my_module_server("test44")

  # de-bugging 
  # output$debug <- renderPrint(names(resfigs))
  
  
}


#-----------------------------
# (4) create Shiny app object
#-----------------------------

shinyApp(ui, server)



