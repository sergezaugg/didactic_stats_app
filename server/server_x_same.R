# ---------------------------
# Description : same X - compute models and generate table and plots 
# Author : Serge Zaugg
# ---------------------------

# ---------------------------
# (1) get input from user
par_x_same_a <- reactive(list(
  n      = as.integer(input$n_x_same_a),
  xmin   = -0.5,
  xmax   = 0.5,
  b0     = as.numeric(input$b0_x_same_a),
  b1     = as.numeric(input$b1_x_same_a),
  sd_res = as.numeric(input$sd_res_x_same_a)
))

par_x_same_b <- reactive(list(
  n      = as.integer(input$n_x_same_b),
  xmin   = -0.5,
  xmax   = 0.5,
  b0     = as.numeric(input$b0_x_same_b),
  b1     = as.numeric(input$b1_x_same_b),
  sd_res = as.numeric(input$sd_res_x_same_b)
))

# ---------------------------
# (2) compute stuff
# simulate data
df_all_x_same    <- reactive({combine_dfs_lin(par_x_same_a(), par_x_same_b())})
# stats computation
li_models_x_same <- reactive(fit_regression_models(df_all_x_same()))

# ---------------------------
# (3) return output
# display plots and tables based on user choice
sel_pl_x_same = reactive(input$dist_plot_x_same_a)
# Selected table
output$sel_ttable_x_same <- renderTable({li_models_x_same()[[sel_pl_x_same()]][["df_tables"]]})
# Selected conv table
output$sel_tabconv_x_same <- renderTable({li_models_x_same()[[sel_pl_x_same()]][["df_tab_conv"]]})
# Selected scatter plot
output$sel_scatter_plot_x_same <- renderPlot({li_models_x_same()[[sel_pl_x_same()]][["df_plots"]]})
# Selected residual plot
output$sel_residual_plot_x_same <- renderPlot({li_models_x_same()[[sel_pl_x_same()]][["df_res_plots"]]})

