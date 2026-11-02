

#-----------------------------------
# unequal X 
par_fix_a <- reactive(list(
  n      = as.integer(input$n_fix_a),
  xmin   = -0.5,
  xmax   = 0.1,
  b0     = as.numeric(input$b0_fix_a),
  b1     = as.numeric(input$b1_fix_a),
  sd_res = as.numeric(input$sd_res_fix_a)
))

par_fix_b <- reactive(list(
  n      = as.integer(input$n_fix_b),
  xmin   = -0.1,
  xmax   = 0.5,
  b0     = as.numeric(input$b0_fix_b),
  b1     = as.numeric(input$b1_fix_b),
  sd_res = as.numeric(input$sd_res_fix_b)
))

# simulate data
df_all_fix    <- reactive({combine_dfs_lin(par_fix_a(), par_fix_b())})
# stats computation
li_models_fix <- reactive(fit_regression_models(df_all_fix()))

# display plots and tables based on user choice
sel_pl_fix = reactive(input$dist_plot_fix_a)
# Selected table
output$sel_ttable_fix <- renderTable({li_models_fix()[[sel_pl_fix()]][["df_tables"]]})
# Selected scatter plot
output$sel_scatter_plot_fix <- renderPlot({li_models_fix()[[sel_pl_fix()]][["df_plots"]]})
# Selected residual plot
output$sel_residual_plot_fix <- renderPlot({li_models_fix()[[sel_pl_fix()]][["df_res_plots"]]})



