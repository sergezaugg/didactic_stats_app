# ---------------------------
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
source("src/utils_ui_and_plots.R")


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
              
        column(4,      
              
          selectInput(
            inputId  = "dist_plot",
            label    = "Choose model",
            choices  = c(
              "M0" = "distPlot00",
              "M1" = "distPlot01",
              "M2" = "distPlot02",
              "M3" = "distPlot03"
            ),
            selected = "distPlot00",
          ),
          
          plotOutput(
            outputId = "selected_dist_plot", 
            height = "250px"
          )
          
        ),
      
        column(4,          
            tableOutput("tab00"),
            tableOutput("tab01"),
            tableOutput("tab02"),
            tableOutput("tab03")
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
  
  # par_b <- list(n=1000, mu_x=5,   mu_y=7,    sd_x=3, sd_y=2, cov_xy =  -0.4)

  df_all <- reactive({combine_dfs(par_a(), par_b())})
  
  output$debug <- renderPrint({
    df_all
  })
  
  
  df_reg_lines <- reactive(fit_regression_models(df_all()))
  fig          <- reactive((make_data_scatterplot(x = df_all())))
  
  # output$debug <- renderPrint({
  #   df_reg_lines()[["c02"]] # i checked this is a df as exprected by add_lines_to_scatterplot()
  # })
  
  fig0 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c00"]])})
  fig1 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c01"]])})
  fig2 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c02"]])})
  fig3 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c03"]])})
  
  # output$distPlot00 <- renderPlot({fig0()})
  # output$distPlot01 <- renderPlot({fig1()})
  # output$distPlot02 <- renderPlot({fig2()})
  # output$distPlot03 <- renderPlot({fig3()})
  
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
  
  
  output$selected_dist_plot <- renderPlot({
    switch(
      input$dist_plot,
      distPlot00 = fig0(),
      distPlot01 = fig1(),
      distPlot02 = fig2(),
      distPlot03 = fig3()
    )
  })
  
  
  

  
}






# Run the application 
shinyApp(ui = frontend, server = server)

