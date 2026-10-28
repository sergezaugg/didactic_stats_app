


style_pannels = "background-color: #220022; padding: 15px; border-radius: 5px; height: 700px;"
style_divider = "margin-top: 11px; margin-bottom: 11px;"

page_controlled_param <- tabPanel(
  
  "Regression",
  
  fluidRow(
    
    # control on the left side 
    column(width = 4,
           div(style = style_pannels,  
               h5("Define data distribution"), 
               tags$hr(style = style_divider),
               make_group_controls("con_a", "Group A"),
               tags$hr(style = style_divider),
               make_group_controls("con_b", "Group B"),
               tags$hr(style = style_divider),
               tags$p("Quick guide: aaa bbb ccc"),
           )),
    
    
    
    # plots in the middle 
    column(width = 4, 
           div(style = style_pannels,
               h5("Scatterplot and regression lines"), 
               tags$hr(style = style_divider),
               
               selectInput(
                 inputId  = "dist_plot_con_a",
                 label    = "Choose model",
                 choices  = c(
                   "M1 (Global mean only)" = "m01",
                   "M2 (two means only)" = "m02",
                   "M3 (Global mean & slope)" = "m03",
                   "M4 (Group mean & global slope)"  = "m04",
                   "M5 (Group mean & group slope)" = "m05"
                 ),
                 selected = "m01",
               ),
               
               plotOutput(
                 outputId = "sel_scatter_plot_con", 
                 height = "300px"
               )
           )
    ),
    
    # verbatimTextOutput("debug"),
    
    # plots and table to the right 
    column(4, 
           div(style = style_pannels,
               h5("Residuals & Estimates"), 
               tags$hr(style = style_divider),
               div(style = "height: 87px;"),
               plotOutput(
                 outputId = "sel_residual_plot_con", 
                 height = "300px"
               ),
               tags$hr(style = style_divider),
               tableOutput("sel_ttable_con")
           )
    )
  )
  
)


