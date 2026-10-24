




# ui elements 
make_group_controls <- function(group, title) {
  
  fluidRow(
    tagList(
      h4(title),
      
      column(width = 2, 
             selectInput(inputId =  paste0("n_",  group),  label = "N", choices = c(10, 50, 100, 500, 1000), selected = 500),
             radioButtons(inputId = paste0("cor_", group), label = "Corr",choices = c(-0.9, -0.8, -0.5, 0.0, 0.5, 0.8, 0.9),selected = -0.8,inline = FALSE)
      ),
      column(width = 4, 
             sliderInput(inputId = paste0("mux_", group), label = "Mu-X", min = -50, max = 50, value = 30),
             sliderInput(inputId = paste0("sdx_", group), label = "SD-X", min = 0.1, max = 10.0, value = 5.0)
      ),
      column(width = 4, 
             sliderInput(inputId = paste0("muy_", group), label = "Mu-Y", min = -50, max = 50, value = 30),
             sliderInput(inputId = paste0("sdy_", group), label = "SD-Y", min = 0.1, max = 10.0, value = 5.0)
      )
    )
  )
  
}





# 
# make_simple_scatterplot <- function(x){
#   return (plot(x, ylim = c(-50, 50), col="orange"))
#   }
# 
# 
# 
# make_ggplot_scatterplot <- function(x){
#   ggplot() + 
#     geom_point(
#       aes(x = seq(length.out = length(x)), y = x),
#       color = "steelblue",
#       size = 2
#     ) +
#     ylim(-50, 50) +
#     labs(title = "bla bla bli caca ")
# }
# 



