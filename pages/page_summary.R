# ---------------------------
# Description : text only page 
# Author : Serge Zaugg
# ---------------------------

page_summary <- tabPanel(
  "Summary",
  fluidRow(
    column(width = 4,
      h2("Summary"),
      # tags$hr(style = style_divider),
      tags$p("
        This app offers an interactive exploration of the strengths and limitations of linear regression.
        Users can generate simulated datasets with different underlying structures, 
        involving one grouping variable and one continuous predictor. 
        They can fit and compare regression models of varying complexity, 
        assessing their suitability for each scenario through visualisations and summary tables.
        "
      )
    )
  )
)
  
 
         
       





