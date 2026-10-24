

library(shiny)

ui <- fluidPage(
  textInput(inputId = "name", label = "Name:"),
  textOutput("greeting")
)

server <- function(input, output) {
  output$greeting <- renderText(paste("Hello", input$name))
}

shinyApp(ui, server)





