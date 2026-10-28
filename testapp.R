

library(shiny)

ui <- fluidPage(
  radioButtons(
    "preset",
    "Choose a preset",
    choices = c(
      "Low" = "low",
      "Medium" = "medium",
      "High" = "high"
    ),
    selected = "medium"
  ),
  
  sliderInput(
    "slider",
    "Fine-tune value",
    min = 0,
    max = 100,
    value = 50
  ),
  
  verbatimTextOutput("result")
)

server <- function(input, output, session) {
  
  observeEvent(input$preset, {
    preset_values <- c(
      low = 20,
      medium = 50,
      high = 80
    )
    
    updateSliderInput(
      session,
      "slider",
      value = preset_values[[input$preset]]
    )
  })
  
  output$result <- renderPrint({
    input$slider
  })
}

shinyApp(ui, server)