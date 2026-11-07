# ---------------------------
# Description : unequal X - compute models and generate table and plots 
# Author : Serge Zaugg
# ---------------------------

# ---------------------------
# (1) get input from user
par_simpso_a <- reactive(list(
  n      = as.integer(input$n_simpso_a),
  xmin   = -0.5,
  xmax   = 0.1,
  b0     = as.numeric(input$b0_simpso_a),
  b1     = as.numeric(input$b1_simpso_a),
  sd_res = as.numeric(input$sd_res_simpso_a)
))

par_simpso_b <- reactive(list(
  n      = as.integer(input$n_simpso_b),
  xmin   = -0.1,
  xmax   = 0.5,
  b0     = as.numeric(input$b0_simpso_b),
  b1     = as.numeric(input$b1_simpso_b),
  sd_res = as.numeric(input$sd_res_simpso_b)
))

# ---------------------------
# (2) compute stuff
# simulate data
df_all_simpso <- reactive({combine_dfs_lin(par_simpso_a(), par_simpso_b())})
# fit models 
lim0_simpso <- reactive(fit_regression_models(df = df_all_simpso()))
# just re-shape list 
lim1_simpso <- reactive(re_organize_list(lim0_simpso()))
# get color options from user  
show_color_simpso <- reactive(input$show_color_simpso)
# make plots 
lip_simpso <- reactive(
  re_organize_list(
    make_all_plots(
      df = df_all_simpso(), 
      models = lim0_simpso()[["models"]], 
      colo = show_color_simpso()
    )
  )
)

# ---------------------------
# (3) return output
# display plots and tables based on user choice
sel_pl_simpso = reactive(input$dist_plot_simpso)
# Selected table
output$sel_ttable_simpso <- renderTable({lim1_simpso()[[sel_pl_simpso()]][["df_tables"]]})
# Selected conv table
output$sel_tabconv_simpso <- renderTable({lim1_simpso()[[sel_pl_simpso()]][["df_tab_conv"]]})
# Selected scatter plot
output$sel_scatter_plot_simpso <- renderPlot({lip_simpso()[[sel_pl_simpso()]][["df_plots"]]})
# Selected residual plot
output$sel_residual_plot_simpso <- renderPlot({lip_simpso()[[sel_pl_simpso()]][["df_res_plots"]]})

