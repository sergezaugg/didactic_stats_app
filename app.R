# ---------------------------
# aaaaa
# run the application by clicking the 'Run App' button above.
# Rscript -e "shiny::runApp('app.R', port=8080, host='0.0.0.0')"
# Rscript -e "shiny::runApp('app.R', port=8080)"
# ---------------------------

library(shiny)
library(ggplot2)
library(bslib)
source("src/utils_plots.R")
library(shinyWidgets)
library(MASS)
library(tidyverse)
# source("src/utils_plots.R")
source("src/utils_sim.R")




# Define UI for application that draws a histogram
frontend <- fluidPage(
  
    # add margin 
    tags$head(tags$style(HTML(".container {margin-top: 30px; margin-bottom: 30;}")) ),
      theme = bs_theme(bootswatch = "darkly"),

    sidebarLayout(
      
      # control on the side 
      sidebarPanel(width = 4,
        fluidRow(
          column(width = 2, 
            selectInput(inputId = "n_a",label = "N", choices = c(10, 50, 100, 500, 1000), selected = 3),
            radioButtons(inputId = "cor_a",label = "Corr",choices = c(-0.9, -0.5, 0.0, 0.5, 0.9),selected = 0.0,inline = FALSE)
          ),
          column(width = 4, 
            sliderInput(inputId = "mux_a", label = "Mu-X", min = -50, max = 50, value = 30),
            sliderInput(inputId = "sdx_a", label = "SD-X", min = 0.1, max = 10.0, value = 5.0)
          ),
          column(width = 4, 
            sliderInput(inputId = "muy_a", label = "Mu-Y", min = -50, max = 50, value = 30),
            sliderInput(inputId = "sdy_a", label = "SD-Y", min = 0.1, max = 10.0, value = 5.0)
          )
        )
      ),
     
      # Show results 
      mainPanel(width = 6,
        fluidRow(
          column(
            width = 6,
            textOutput("n_a"),
            textOutput("corr_a"),
            plotOutput("distPlot01")

          ),
          column(
            width = 3,
            textOutput("out_00"),
            textOutput("out_10"),
            textOutput("out_20"),
            verbatimTextOutput("debug")
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
  
  par_b <- list(n=1000, mu_x=5,   mu_y=7,    sd_x=3, sd_y=2, cov_xy =  -0.4)

  df_all <- reactive({combine_dfs(par_a(), par_b)})
  
  df_reg_lines <- reactive(fit_regression_models(df_all()))
  fig          <- reactive((make_data_scatterplot(x = df_all())))
  
  output$debug <- renderPrint({
    df_reg_lines()[["c02"]] # i checked this is a df as exprected by add_lines_to_scatterplot()
  })
  
  fig2 <- reactive({
    add_lines_to_scatterplot(fig(), df_reg_lines()[["c02"]])
  })
  
  output$distPlot01 <- renderPlot({fig2()})
  

  
}






# Run the application 
shinyApp(ui = frontend, server = server)

