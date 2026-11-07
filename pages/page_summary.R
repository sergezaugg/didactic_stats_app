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
            
            h6("M1"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_0} + \\varepsilon_i$$"),
            
            h6("M2"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_0} + \\color{#EE82EE}{\\beta_1} G_i + \\varepsilon_i$$"),
            
            h6("M3"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_0}                                 + \\color{#EE82EE}{\\beta_2} X_i + \\varepsilon_i$$"),
            
            h6("M4"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_0} + \\color{#EE82EE}{\\beta_1} G_i + \\color{#EE82EE}{\\beta_2} X_i  + \\varepsilon_i$$"),
            
            h6("M5"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_0} + \\color{#EE82EE}{\\beta_1} G_i + \\color{#EE82EE}{\\beta_2} X_i  + \\color{#EE82EE}{\\beta_3} X_i G_i + \\varepsilon_i$$")
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
            h6("M1 (not applicable)"),
            HTML("$$ $$"),

            h6("M2"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_{1a}} G_{i,a} + \\color{#EE82EE}{\\beta_{1b}} G_{i,b} + \\varepsilon_i$$"),
            
            h6("M3 (not applicable)"),
            HTML("$$ $$"),
            
            h6("M4"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_{1a}} G_{i,a} + \\color{#EE82EE}{\\beta_{1b}} G_{i,b} + \\color{#EE82EE}{\\beta_2} X_i + \\varepsilon_i$$"),
            
            h6("M5"),
            HTML("$$Y_i = \\color{#EE82EE}{\\beta_{1a}} G_{i,a} + \\color{#EE82EE}{\\beta_{1b}} G_{i,b} + \\color{#EE82EE}{\\beta_{2a}} X_i G_{i,a} + \\color{#EE82EE}{\\beta_{2b}} X_i G_{i,b} + \\varepsilon_i$$")
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
