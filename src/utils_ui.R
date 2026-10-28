# ---------------------------
# Description : large ui elements are defined here and later imported to app.R
# Author : Serge Zaugg
# ---------------------------


# ui elements 
make_group_controls <- function(group, title, const_x = FALSE) {
  fluidRow(
    tagList(
      column(width = 3, 
           h6(title),
           selectInput(inputId =  paste0("n_",  group),  
             label = "N", 
             choices = c(10, 50, 100, 500), 
             selected = 100),
           numericInput(inputId = paste0("sd_res_", group),
             label = "sd resid",
             value = 0.5,
             min = 0.1,
             max = 1,
             step = 0.1
           )
      ),
      column(width = 4, 
        if (const_x){
          tags$div("X values fixed")  
        } else {
          tagList( # needed for shiny - tagList() groups multiple Shiny UI elements into one object
            sliderInput(inputId = paste0("xmin_", group), label = "xmin", min = -1.0, max = 1.0, value = -0.5, step = 0.1),
            sliderInput(inputId = paste0("xmax_", group), label = "xmax", min = -1.0, max = 1.0, value = 0.5, step = 0.1)
          )
        },
      ),
      column(width = 4, 
         sliderInput(inputId = paste0("b0_", group), label = "b0", min = -10, max = 10.0, value = 1.0),
         sliderInput(inputId = paste0("b1_", group), label = "b1", min = -10, max = 10.0, value = 1.0)
      )
    )
  )
  
}




