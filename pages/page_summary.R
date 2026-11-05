# ---------------------------
# Description : text only page
# Author : Serge Zaugg
# ---------------------------

page_summary <- tabPanel(
  "Regression Models",
  fluidRow(
    column(
      width = 4,
      div(  
        h5("Conventional coefficients"),
        tags$hr(style = style_divider),
        style = style_pannels,
        withMathJax(
          tags$div(
            
            h5("M1"),
            HTML("$$Y_i = \\color{orange}{\\beta_0} + \\varepsilon_i$$"),
            
            h5("M2"),
            HTML("$$Y_i = \\color{orange}{\\beta_0} + \\color{orange}{\\beta_1} G_i + \\varepsilon_i$$"),
            
            h5("M3"),
            HTML("$$Y_i = \\color{orange}{\\beta_0} + \\color{orange}{\\beta_1} X_i + \\varepsilon_i$$"),
            
            h5("M4"),
            HTML("$$Y_i = \\color{orange}{\\beta_0} + \\color{orange}{\\beta_1} X_i + \\color{orange}{\\beta_2} G_i + \\varepsilon_i$$"),
            
            h5("M5"),
            HTML("$$Y_i = \\color{orange}{\\beta_0} + \\color{orange}{\\beta_1} X_i + \\color{orange}{\\beta_2} G_i + \\color{orange}{\\beta_3} X_i G_i + \\varepsilon_i$$")
          )
        )
      )
    ),
    
    column(
      width = 4,
      div(  
        h5("Per-group coefficients"),
        tags$hr(style = style_divider),
        style = style_pannels,
        withMathJax(
          tags$div(
            h5("M1 (not applicable)"),
            HTML("$$ $$"),

            h5("M2"),
            HTML("$$Y_i = \\color{orange}{\\beta_1} G_{i,1} + \\color{orange}{\\beta_2} G_{i,2} + \\varepsilon_i$$"),
            
            h5("M3 (not applicable)"),
            HTML("$$ $$"),
            
            h5("M4"),
            HTML("$$Y_i = \\color{orange}{\\beta_1} G_{i,1} + \\color{orange}{\\beta_2} G_{i,2} + \\color{orange}{\\beta_3} X_i + \\varepsilon_i$$"),
            
            h5("M5"),
            HTML("$$Y_i = \\color{orange}{\\beta_1} G_{i,1} + \\color{orange}{\\beta_2} G_{i,2} + \\color{orange}{\\beta_3} X_i G_{i,1} + \\color{orange}{\\beta_4} X_i G_{i,2} + \\varepsilon_i$$")
          )
        )
      )
    ),
    
    column(
      width = 4,
      div(
        style = style_pannels,
        h5("Variables"),
        tags$hr(style = style_divider),
        withMathJax(
          tags$div(
            tags$p(HTML("\\(Y_i\\): response")),
            tags$p(HTML("\\(X_i\\): continuous predictor")),
            tags$p(HTML("\\(G_i\\): group indicator (0 or 1)")),
            tags$p(HTML("\\(\\varepsilon_i \\sim \\mathcal{N}(0,\\sigma^2)\\): residual error"))
          )
        )
      )
    )
  )
)
