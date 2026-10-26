# ---------------------------
# Description : entry point of the app
# Author : Serge Zaugg
# 
# run the application by clicking the 'Run App' button above.
# Rscript -e "shiny::runApp('app.R', port=8080, host='0.0.0.0')"
# Rscript -e "shiny::runApp('app.R', port=8080)"
# Rscript -e "shiny::runApp()"
# Rscript -e "shiny::runApp('app.R')"
# this one works : 
# Rscript --vanilla -e "shiny::runApp()"
# ---------------------------

library(shiny)
library(ggplot2)
library(bslib)
library(shinyWidgets)
library(MASS)
library(tidyverse)
source("src/utils_sim.R")
source("src/utils_ui.R")
source("src/utils_plots.R")

# Define UI 
frontend <- fluidPage(
  
  theme = bs_theme(bootswatch = "darkly"),
  
  tags$head(
    tags$style(HTML("
      .container-fluid {
        margin-top: 50px;
        margin-bottom: 30px;
        min-width: 1200px;
        max-width: 1600px;
        margin-left: auto;
        margin-right: auto;
      }
    "))
  ),
  

  sidebarLayout(
    
    # control on the side 
    sidebarPanel(width = 4,
      make_group_controls("a", "Group A"),
      tags$hr(),
      make_group_controls("b", "Group B")
    ),
    
    # Show results 
    mainPanel(width = 8,
              
        fluidRow(      
              
        column(5,      
              
          selectInput(
            inputId  = "dist_plot",
            label    = "Choose model",
            choices  = c(
              "M0 (Global mean only)" = "distPlot00",
              "M1 (Global mean & slope)" = "distPlot01",
              "M2 (Group mean & global slope)"  = "distPlot02",
              "M3 (Group mean & group slope)" = "distPlot03"
            ),
            selected = "distPlot00",
          ),
          
          plotOutput(
            outputId = "sel_scatter_plot", 
            height = "400px"
          )
          
        ),
      
        column(4,          
            tableOutput(outputId = "tab00"),
            tableOutput(outputId = "tab01"),
            tableOutput(outputId = "tab02"),
            tableOutput(outputId = "tab03")
          )
      )
    )
  )
)





# Define server logic 
server <- function(input, output) {
  
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
  

  df_all       <- reactive({combine_dfs(par_a(), par_b())})
  df_reg_lines <- reactive(fit_regression_models(df_all()))
  fig          <- reactive((make_data_scatterplot(x = df_all())))
  
  # output$debug <- renderPrint({df_all})

  fig0 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c00"]])})
  fig1 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c01"]])})
  fig2 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c02"]])})
  fig3 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c03"]])})
  
  # ------------------------
  output$tab00 <- renderTable({
    df_reg_lines()[["df_lm"]][["s00"]]
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  output$tab01 <- renderTable({
    df_reg_lines()[["df_lm"]][["s01"]]
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  output$tab02 <- renderTable({
    df_reg_lines()[["df_lm"]][["s02"]]
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  output$tab03 <- renderTable({
    df_reg_lines()[["df_lm"]][["s03"]]
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  sel_pl = reactive(input$dist_plot)
  
  output$sel_scatter_plot <- renderPlot({
    switch(
      # input$dist_plot,
      sel_pl(),
      distPlot00 = fig0(),
      distPlot01 = fig1(),
      distPlot02 = fig2(),
      distPlot03 = fig3()
    )
  })
  
}






# Run the application 
shinyApp(ui = frontend, server = server)

