# ---------------------------
# Description : large ui elements are defined here and later imported to app.R
# Author : Serge Zaugg
# ---------------------------


# ui elements 
make_group_controls <- function(group, title) {
  
  fluidRow(
    tagList(
      
      
      column(width = 3, 
           h6(title),
           selectInput(inputId =  paste0("n_",  group),  
             label = "N", 
             choices = c(10, 50, 100, 500), 
             selected = 100),
           numericInput(inputId = paste0("cor_", group),
             label = "Correlation",
             value = 0.5,
             min = -1,
             max = 1,
             step = 0.1
           )
      ),
      column(width = 4, 
             sliderInput(inputId = paste0("mux_", group), label = "Mu-X", min = -10, max = 10, value = 0),
             sliderInput(inputId = paste0("sdx_", group), label = "SD-X", min = 0.1, max = 10.0, value = 1.0)
      ),
      column(width = 4, 
             sliderInput(inputId = paste0("muy_", group), label = "Mu-Y", min = -10, max = 10, value = 0),
             sliderInput(inputId = paste0("sdy_", group), label = "SD-Y", min = 0.1, max = 10.0, value = 1.0)
      )
    )
  )
  
}





