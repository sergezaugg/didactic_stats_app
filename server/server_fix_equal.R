
#-----------------------------------
# server x equal  
par_con_a <- reactive(list(
  n      = as.integer(input$n_con_a),
  xmin   = -0.5,
  xmax   = 0.5,
  b0     = as.numeric(input$b0_con_a),
  b1     = as.numeric(input$b1_con_a),
  sd_res = as.numeric(input$sd_res_con_a)
))

par_con_b <- reactive(list(
  n      = as.integer(input$n_con_b),
  xmin   = -0.5,
  xmax   = 0.5,
  b0     = as.numeric(input$b0_con_b),
  b1     = as.numeric(input$b1_con_b),
  sd_res = as.numeric(input$sd_res_con_b)
))

# simulate data
df_all_con    <- reactive({combine_dfs_lin(par_con_a(), par_con_b())})
# stats computation
li_models_con <- reactive(fit_regression_models(df_all_con()))

# display plots and tables based on user choice
sel_pl_con = reactive(input$dist_plot_con_a)
# Selected table
output$sel_ttable_con <- renderTable({li_models_con()[[sel_pl_con()]][["df_tables"]]})
# Selected scatter plot
output$sel_scatter_plot_con <- renderPlot({li_models_con()[[sel_pl_con()]][["df_plots"]]})
# Selected residual plot
output$sel_residual_plot_con <- renderPlot({li_models_con()[[sel_pl_con()]][["df_res_plots"]]})


