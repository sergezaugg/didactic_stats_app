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

# Define UI for application that draws a histogram
frontend <- fixedPage(
  # add margin 
  tags$head(tags$style(HTML(".container {margin-top: 30px; margin-bottom: 30;}")) ),
  
# frontend <- fluidPage(
# # add top margin
#   tags$head(tags$style(HTML(".container-fluid {margin-top: 30px;}"))),
#     

    # theme = bs_theme(bootswatch = "darkly"),
    # theme = bs_theme(bootswatch = "cyborg"),
    theme = bs_theme(bootswatch = "slate"),
    

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "bins_00", label = "N :", min = 1, max = 500, value = 50),
            sliderInput(inputId = "bins_10", label = "Mu :", min = -50, max = 50, value = 30),
            sliderInput(inputId = "bins_20", label = "SD :", min = 0.1, max = 10.0, value = 5.0)
            ),
        # Show a plots
        mainPanel(
            fluidRow(
              column(
                width = 6,
                plotOutput("distPlot01"),
                plotOutput("distPlot02")
              ),
              column(
                width = 3,
                textOutput("out_00"),
                textOutput("out_10"),
                textOutput("out_20"),
                textOutput("sum_of_all")
              )
            )
          )
        
        
    )
)

# Define server logic 
server <- function(input, output) {
    # compute stuff 
    sim_data_x <- reactive(rnorm(n= input$bins_00, mean=input$bins_10, sd = input$bins_20))
    val_sum_of_all <- reactive(input$bins_00 + input$bins_10 + input$bins_20)
    # prepare outputs
    output$distPlot01 <- renderPlot({ make_simple_scatterplot(x = sim_data_x()) })  
    output$distPlot02 <- renderPlot({ make_ggplot_scatterplot(x = sim_data_x()) })  
    output$out_00     <- renderText(paste("Value is : ", input$bins_00))
    output$out_10     <- renderText(paste("Value is : ", input$bins_10))
    output$out_20     <- renderText(paste("Value is : ", input$bins_20))
    output$sum_of_all <- renderText(paste("Sum is : ", val_sum_of_all()))
}

# Run the application 
shinyApp(ui = frontend, server = server)

