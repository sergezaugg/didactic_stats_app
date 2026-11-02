

#-----------------------------------
# server free params 
par_a <- reactive(list(
  n      = as.integer(input$n_a),
  xmin   = as.numeric(input$xmin_a),
  xmax   = as.numeric(input$xmax_a),
  b0     = as.numeric(input$b0_a),
  b1     = as.numeric(input$b1_a),
  sd_res = as.numeric(input$sd_res_a)
))

par_b <- reactive(list(
  n      = as.integer(input$n_b),
  xmin   = as.numeric(input$xmin_b),
  xmax   = as.numeric(input$xmax_b),
  b0     = as.numeric(input$b0_b),
  b1     = as.numeric(input$b1_b),
  sd_res = as.numeric(input$sd_res_b)
))

# simulate data
df_all    <- reactive({combine_dfs_lin(par_a(), par_b())})
# stats computation
li_models <- reactive(fit_regression_models(df_all()))

# display plots and tables based on user choice
sel_pl = reactive(input$dist_plot)
# Selected table
output$sel_ttable <- renderTable({li_models()[[sel_pl()]][["df_tables"]]})
# Selected scatter plot
output$sel_scatter_plot <- renderPlot({li_models()[[sel_pl()]][["df_plots"]]})
# Selected residual plot
output$sel_residual_plot <- renderPlot({li_models()[[sel_pl()]][["df_res_plots"]]})