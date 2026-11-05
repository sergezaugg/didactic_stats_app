# ---------------------------
# Description : unequal X - compute models and generate table and plots 
# Author : Serge Zaugg
# ---------------------------

# ---------------------------
# (1) get input from user
par_x_uneq_a <- reactive(list(
  n      = as.integer(input$n_x_uneq_a),
  xmin   = -0.5,
  xmax   = 0.1,
  b0     = as.numeric(input$b0_x_uneq_a),
  b1     = as.numeric(input$b1_x_uneq_a),
  sd_res = as.numeric(input$sd_res_x_uneq_a)
))

par_x_uneq_b <- reactive(list(
  n      = as.integer(input$n_x_uneq_b),
  xmin   = -0.1,
  xmax   = 0.5,
  b0     = as.numeric(input$b0_x_uneq_b),
  b1     = as.numeric(input$b1_x_uneq_b),
  sd_res = as.numeric(input$sd_res_x_uneq_b)
))

# ---------------------------
# (2) compute stuff
# simulate data
df_all_x_uneq    <- reactive({combine_dfs_lin(par_x_uneq_a(), par_x_uneq_b())})
# stats computation
li_models_x_uneq <- reactive(fit_regression_models(df_all_x_uneq()))

# ---------------------------
# (3) return output
# display plots and tables based on user choice
sel_pl_x_uneq = reactive(input$dist_plot_x_uneq)
# Selected table
output$sel_ttable_x_uneq <- renderTable({li_models_x_uneq()[[sel_pl_x_uneq()]][["df_tables"]]})
# Selected conv table
output$sel_tabconv_x_uneq <- renderTable({li_models_x_uneq()[[sel_pl_x_uneq()]][["df_tab_conv"]]})
# Selected scatter plot
output$sel_scatter_plot_x_uneq <- renderPlot({li_models_x_uneq()[[sel_pl_x_uneq()]][["df_plots"]]})
# Selected residual plot
output$sel_residual_plot_x_uneq <- renderPlot({li_models_x_uneq()[[sel_pl_x_uneq()]][["df_res_plots"]]})

