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

ui <- navbarPage(
  title = "Applied Stats Playground",
  
  # styling 
  
  theme = bs_theme(
    bg = "#000000", fg = "white", primary = "#ddccdd", secondary = "#660055"),
  
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



# Define server logic 
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
  
  # stats computation
  df_all       <- reactive({combine_dfs(par_a(), par_b())})
  df_models <- reactive(fit_regression_models(df_all()))
  
  # make all data scatter plots
  fig       <- reactive((make_data_scatterplot(x = df_all())))
  
  # output$debug <- renderPrint({df_all})

  # add regression lines to all plot
  figs <- lapply(sprintf("m%02d", 1:5), function(m) {
    reactive({
      add_lines_to_scatterplot(fig(),df_models()[["df_plt"]][[m]])
    })
  })
  names(figs) <- sprintf("fig%02d", 1:5)


  # make all residual plots
  resfigs <- lapply(sprintf("m%02d", 1:5), function(m) {
    reactive({
      make_residuals_plot(df = df_all(), res = df_models()[["df_res"]][[m]])
    })
  })
  names(resfigs) <- sprintf("res%02d", 1:5)
  
  # output$debug <- renderPrint(names(resfigs))

  # display plots and tables based on user choice
  sel_pl = reactive(input$dist_plot)
  
  # which t-table to show
  output$sel_ttable <- renderTable({
    switch(
      sel_pl(),
      m01 = df_models()[["df_lm"]][["m01"]],
      m02 = df_models()[["df_lm"]][["m02"]],
      m03 = df_models()[["df_lm"]][["m03"]],
      m04 = df_models()[["df_lm"]][["m04"]],
      m05 = df_models()[["df_lm"]][["m05"]]
    )
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  # which scatter plot to show
  output$sel_scatter_plot <- renderPlot({
    switch(
      sel_pl(),
      m01 = figs[['fig01']](),
      m02 = figs[['fig02']](), 
      m03 = figs[['fig03']](),
      m04 = figs[['fig04']](),
      m05 = figs[['fig05']]()
    )
  })
  
  # which residual plot to show 
  output$sel_residual_plot <- renderPlot({
    switch(
      sel_pl(),
      m01 = resfigs[['res01']](),
      m02 = resfigs[['res02']](),
      m03 = resfigs[['res03']](),
      m04 = resfigs[['res04']](),
      m05 = resfigs[['res05']]()
    )
  })
  
}

shinyApp(ui, server)



