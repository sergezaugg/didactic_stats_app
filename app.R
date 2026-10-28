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
  page_summary, 
  
)


# Define server  
server <- function(input, output, session) {

  par_a <- reactive(list(
    n      = as.integer(input$n_a),
    mu_x   = as.numeric(input$mux_a),
    mu_y   = as.numeric(input$muy_a),
    sd_x   = as.numeric(input$sdx_a),
    sd_y   = as.numeric(input$sdy_a),
    cov_xy = as.numeric(input$cor_a)
  ))
  
  par_b <- reactive(list(
    n      = as.integer(input$n_b),
    mu_x   = as.numeric(input$mux_b),
    mu_y   = as.numeric(input$muy_b),
    sd_x   = as.numeric(input$sdx_b),
    sd_y   = as.numeric(input$sdy_b),
    cov_xy = as.numeric(input$cor_b)
  ))
  
  # simulate data
  df_all    <- reactive({combine_dfs(par_a(), par_b())})
  # stats computation
  li_models <- reactive(fit_regression_models(df_all()))
  
  # display plots and tables based on user choice
  sel_pl = reactive(input$dist_plot)
  # Selected table
  output$sel_ttable <- renderTable({li_models()[[sel_pl()]][["df_tables"]]})
  # Selected scatter plot
  output$sel_scatter_plot <- renderPlot({li_models()[[sel_pl()]][["df_plots"]]})
  # Selected residual plot
  output$sel_residual_plot <- renderPlot({li_models()[[sel_pl()]][["df_res_plots"]]})
  
  # de-bugging 
  # output$debug <- renderPrint(names(resfigs))
  
}

shinyApp(ui, server)



