# ---------------------------
# Description : free X - compute models and generate table and plots 
# Author : Serge Zaugg
# ---------------------------

# ---------------------------
# (1) get input from user
par_x_free_a <- reactive(list(
  n      = as.integer(input$n_x_free_a),
  xmin   = as.numeric(input$xmin_x_free_a),
  xmax   = as.numeric(input$xmax_x_free_a),
  b0     = as.numeric(input$b0_x_free_a),
  b1     = as.numeric(input$b1_x_free_a),
  sd_res = as.numeric(input$sd_res_x_free_a)
))

par_x_free_b <- reactive(list(
  n      = as.integer(input$n_x_free_b),
  xmin   = as.numeric(input$xmin_x_free_b),
  xmax   = as.numeric(input$xmax_x_free_b),
  b0     = as.numeric(input$b0_x_free_b),
  b1     = as.numeric(input$b1_x_free_b),
  sd_res = as.numeric(input$sd_res_x_free_b)
))

# ---------------------------
# (2) compute stuff
# simulate data
df_all_x_free    <- reactive({combine_dfs_lin(par_x_free_a(), par_x_free_b())})
# fit models 
lim0_x_free <- reactive(fit_regression_models(df = df_all_x_free()))
# just re-shape list 
lim1_x_free <- reactive(re_organize_list(lim0_x_free()))
# get color options from user  
show_color_x_free <- reactive(input$show_color_x_free)
# make plots 
lip_x_free <- reactive(
  re_organize_list(
    make_all_plots(
      df = df_all_x_free(), 
      models = lim0_x_free()[["models"]], 
      colo = show_color_x_free()
    )
  )
)

# ---------------------------
# (3) return output
# display plots and tables based on user choice
sel_pl_x_free = reactive(input$dist_plot_x_free)
# Selected table
output$sel_ttable_x_free <- renderTable({lim1_x_free()[[sel_pl_x_free()]][["df_tables"]]})
# Selected conv table
output$sel_tabconv_x_free <- renderTable({lim1_x_free()[[sel_pl_x_free()]][["df_tab_conv"]]})
# Selected scatter plot
output$sel_scatter_plot_x_free <- renderPlot({lip_x_free()[[sel_pl_x_free()]][["df_plots"]]})
# Selected residual plot
output$sel_residual_plot_x_free <- renderPlot({lip_x_free()[[sel_pl_x_free()]][["df_res_plots"]]})

