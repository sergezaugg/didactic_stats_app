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
           numericInput(inputId = paste0("sd_res_", group),
             label = "sd resid",
             value = 0.5,
             min = 0.1,
             max = 1,
             step = 0.1
           )
      ),
      column(width = 4, 
             sliderInput(inputId = paste0("xmin_", group), label = "xmin", min = -1.0, max = 0.0, value = -0.5),
             sliderInput(inputId = paste0("b0_", group), label = "b0", min = -10, max = 10.0, value = 1.0)
      ),
      column(width = 4, 
             sliderInput(inputId = paste0("xmax_", group), label = "xmax", min = 0.0, max = 1.0, value = 0.5),
             sliderInput(inputId = paste0("b1_", group), label = "b1", min = -10, max = 10.0, value = 1.0)
      )
    )
  )
  
}


# 
# make_group_cont_nox <- function(group, title) {
#   fluidRow(
#     tagList(
#       column(width = 3, 
#              h6(title),
#              selectInput(inputId =  paste0("n_",  group),  
#                          label = "N", 
#                          choices = c(10, 50, 100, 500), 
#                          selected = 100),
#              numericInput(inputId = paste0("cor_", group),
#                           label = "Correlation",
#                           value = 0.5,
#                           min = -1,
#                           max = 1,
#                           step = 0.1
#              )
#       ),
#       column(width = 4,
#         #      
#         tags$div("X values fixed")
#       ),
#       column(width = 4, 
#              sliderInput(inputId = paste0("muy_", group), label = "Mu-Y", min = -10, max = 10, value = 0),
#              sliderInput(inputId = paste0("sdy_", group), label = "SD-Y", min = 0.1, max = 10.0, value = 1.0)
#       )
#     )
#   )
#   
# }


