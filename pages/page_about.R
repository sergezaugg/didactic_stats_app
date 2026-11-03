# ---------------------------
# Description : text only page 
# Author : Serge Zaugg
# ---------------------------

page_about <- tabPanel(
  "About",
  fluidRow(
    
    column(width = 4,
      h2("Background"),
      tags$p("
        Linear regression models are among the most versatile data analysis tools.
        They can do simple t-tests and complex multiple regression models.
        In my work, I was often asked to explain how regression works to non-statisticians,
        but of course in '3 minutes' because everyone is 'ultra busy'.
        I would then draw some ugly sketches on a sheet of paper, which was sometimes more confusing than useful.
        This app fills the gap by providing quick nicely formatted explanatory material.
        "
      )
    ),
 
    column(width = 4,
      h2("Objective"),
      tags$p("
        This app provides interactive and intuitive exploration of the mechanics of regression.
        It can be used to demonstrate the strengths and limitations of linear regression.
        Users can generate simulated datasets with different underlying structures,
        involving one grouping variable and one continuous predictor.
        They can fit and compare regression models of varying complexity,
        assessing their suitability for each scenario through visualizations and summary tables. 
        
        The app's aim is didactic and therefore it is intentionally kept simple with one
        grouping variable and one continuous predictor and a fixed range of parameters.
        "
      )
    ),
    
    column(width = 4,
      h2("Author"),
        tags$p(
        "Serge Zaugg (",
        tags$a("LinkedIn", href = "https://www.linkedin.com/in/dkifh34rtn345eb5fhrthdbgf45/",
              target = "_blank"),
        ", ",
        tags$a("GitHub", href = "https://github.com/sergezaugg",
              target = "_blank"),
        ")"
      )
    
    )
  )
)
  
 
         
       





