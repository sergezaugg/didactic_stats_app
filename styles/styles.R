# ---------------------------
# Description : style-related elements and functions
# Author : Serge Zaugg
# ---------------------------

# bslib custom themes
themes_li <- list(
  "custom_goth" = bs_theme(bg = "#000000", fg = "#ffffff", primary = "#ffddee", secondary = "#550044"),
  "custom_cold" = bs_theme(bg = "#000000", fg = "#ffffff", primary = "#88ccff", secondary = "#003377")
)


# # server-side function to dynamically swap themes 
# change_theme <- function(input, output, session) {
#   
#   observe({
#     if (input$dark_mode == "lig") {
#       session$setCurrentTheme(themes_li$custom_cold)
#     } else {
#       session$setCurrentTheme(themes_li$custom_goth)
#     }
#   })
#   
#   output$custom_styles <- renderUI({
#     panel_color <- if (input$dark_mode == "lig") {"#001139"} else {"#330022"}
#     h5_color <- if (input$dark_mode == "lig") {"#88ccff"} else {"#ffddee"}
#     
#     if (input$dark_mode == "lig") {
#       logo <- tags$span(
#         style = "display: inline-flex; align-items: center; gap: 10px;",
#         tags$img(src = "contents/z_logo_blue.png", height = "30px"),
#         tags$span("Applied Stats Playground")
#       )
#       
#     } else {
#       logo <- tags$span(
#         style = "display: inline-flex; align-items: center; gap: 10px;",
#         tags$img(src = "contents/z_logo_red.png", height = "30px"),
#         tags$span("Applied Stats Playground")
#       )
#     }
#     
#     # return value written to output$custom_styles 
#     tagList(
#       tags$style(HTML(sprintf(".panel-custom {background-color: %s !important;}", panel_color))),
#       tags$style(HTML(sprintf("h5 {color: %s !important;}", h5_color))),
#       output$app_title <- renderUI({logo})
#     )
#     
#   })
#   
# 
# }
# 







app_custom_theme_title <- function(text){
  tags$span(
    style = "display: inline-flex; align-items: center; gap: 10px;",
    tags$span(text)
  )
}





