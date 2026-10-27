


# renv::init()

library(shiny)
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



style_pannels = "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"

style_divider = "margin-top: 7px; margin-bottom: 11px;"



ui <- navbarPage(
  title = "Applied Stats Playground",
  
  
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
    }
    "))
  ),
  
  tabPanel(
    "Regression",

    fluidRow(
      
      # control on the side 
      column(width = 4,
             div(style = style_pannels,  
                 h5("Define data distribution"), 
                 tags$hr(style = style_divider),
                 make_group_controls("a", "Group A"),
                 tags$hr(style = style_divider),
                 make_group_controls("b", "Group B")
             )),
      
      
      column(width = 4, 
             div(style = style_pannels,
                 
                 h5("Scatterplot and regression lines"), 
                 tags$hr(style = style_divider),
                 
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
                   height = "350px"
                 )
             )
      ),
      
      
      column(4, 
             div(style = style_pannels,
                 h5("Estimates"), 
                 tags$hr(style = style_divider),
                 div(style = "height: 100px;"),
                 tableOutput("sel_ttable")
             )
      )
    )
    
  ),
  
  tabPanel(
    "Summary",
    h2("Summary")
    
  ),
  
  tabPanel(
    "ch3",
    h2("Analysis page")
    
  )
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
  
  
  df_all       <- reactive({combine_dfs(par_a(), par_b())})
  df_reg_lines <- reactive(fit_regression_models(df_all()))
  fig          <- reactive((make_data_scatterplot(x = df_all())))
  
  # output$debug <- renderPrint({df_all})
  
  fig0 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c00"]])})
  fig1 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c01"]])})
  fig2 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c02"]])})
  fig3 <- reactive({add_lines_to_scatterplot(fig(), df_reg_lines()[["df_plt"]][["c03"]])})
  
  
  sel_pl = reactive(input$dist_plot)
  
  output$sel_ttable <- renderTable({
    switch(
      sel_pl(),
      distPlot00 = df_reg_lines()[["df_lm"]][["s00"]],
      distPlot01 = df_reg_lines()[["df_lm"]][["s01"]],
      distPlot02 = df_reg_lines()[["df_lm"]][["s02"]],
      distPlot03 = df_reg_lines()[["df_lm"]][["s03"]]
    )
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
  
  
  output$sel_scatter_plot <- renderPlot({
    switch(
      sel_pl(),
      distPlot00 = fig0(),
      distPlot01 = fig1(),
      distPlot02 = fig2(),
      distPlot03 = fig3()
    )
  })
  
  
  
}




shinyApp(ui, server)



