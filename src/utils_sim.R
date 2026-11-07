# ---------------------------
# Description : Pure simulation and stats functions
# Author : Serge Zaugg
# ---------------------------

# helper function : simulate data based on b0 and b1
simulate_linear_data <- function(par){ 
  x <- runif(par$n, par$xmin, par$xmax) 
  y <- par$b0 + par$b1*x
  y <- y + rnorm(n = par$n, mean = 0, sd = par$sd_res)
  df <- tibble(predictor = x, response = y)
  return(df)
}


combine_dfs_lin <- function(...) {
  pars <- list(...)
  dfs <- lapply(seq_along(pars), function(i) {
    df <- simulate_linear_data(pars[[i]])
    df$group <- LETTERS[i]
    df
  })
  dfs <- bind_rows(dfs)
  dfs <- dfs %>% mutate(group = factor(group) )
  return(dfs)
}







# helper function : get standard t-table summary
get_t_table <- function(mod){
  as.data.frame(summary(mod)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
}



# fit multiple models on one dataset
fit_regression_models <- function(df){
  
  # conventional parametrisation
  li_formu_conv <- list(
    m01 = as.formula("response ~ 1"),
    m02 = as.formula("response ~ group"),
    m03 = as.formula("response ~ predictor"),
    m04 = as.formula("response ~ predictor + group"),
    m05 = as.formula("response ~ predictor*group")
  )
  
  # "sep-slope" parametrisation
  li_formu <- list(
    m01 = as.formula("response ~ 1"),
    m02 = as.formula("response ~ group - 1"),
    m03 = as.formula("response ~ predictor"),
    m04 = as.formula("response ~ predictor + group - 1"),
    m05 = as.formula("response ~ predictor:group + group - 1")
  )
  
  # fit conventional parametrisation (and get t-tables)
  models_conv <- lapply(li_formu_conv, lm, data = df)
  df_tab_conv <- lapply(models_conv, get_t_table)
  
  # fit "sep-slope" parametrisation (and get t-tables)
  models <- lapply(li_formu, lm, data = df)
  df_tab <- lapply(models, get_t_table)
  
  # list by item type and then models 
  li <-  list(
    "df_tables" = df_tab,
    "df_tab_conv" = df_tab_conv,
    "models"= models
  )

  return(li)
  
}



# make plots of data + lines and residual plots 
make_all_plots <- function(df, models, colo){
  
  groups = levels(df$group)
  
  coefs  <- lapply(models, coef)
  df_res <- lapply(models, residuals)
  
  # 
  df_plt <- list(
    m01  = data.frame(group = groups, intercept = coefs$m01["(Intercept)"],  slope = 0),
    m02  = data.frame(group = groups, intercept = coefs$m02[paste0("group", groups)], slope = 0),
    m03  = data.frame(group = groups, intercept = coefs$m03["(Intercept)"],  slope = coefs$m03["predictor"]),
    m04  = data.frame(group = groups, intercept = coefs$m04[paste0("group", groups)], slope = coefs$m04["predictor"]),
    m05  = data.frame(group = groups, intercept = coefs$m05[paste0("group", groups)], slope = coefs$m05[paste0("predictor:group", groups)])
  )
  
  df_plots <- list(
    m01  = make_data_scatterplot(x = df, df_lines = df_plt[["m01"]], colo),
    m02  = make_data_scatterplot(x = df, df_lines = df_plt[["m02"]], colo),
    m03  = make_data_scatterplot(x = df, df_lines = df_plt[["m03"]], colo),
    m04  = make_data_scatterplot(x = df, df_lines = df_plt[["m04"]], colo),
    m05  = make_data_scatterplot(x = df, df_lines = df_plt[["m05"]], colo)
  )
  
  df_res_plots <- list(
    m01  = make_residuals_plot(df = df, res = df_res[["m01"]], colo), 
    m02  = make_residuals_plot(df = df, res = df_res[["m02"]], colo), 
    m03  = make_residuals_plot(df = df, res = df_res[["m03"]], colo), 
    m04  = make_residuals_plot(df = df, res = df_res[["m04"]], colo), 
    m05  = make_residuals_plot(df = df, res = df_res[["m05"]], colo)
  )
  
  # list by item type and then models 
  li <- list(
    "df_plots"= df_plots,
    "df_res_plots" = df_res_plots
  )
  
  return(li)
  
}



# re-organize to list by models and then item type
re_organize_list <- function(li){
  inner_names <- unique(unlist(lapply(li, names)))
  li2 <- setNames(
    lapply(inner_names, function(inner) {
      setNames(
        lapply(li, function(outer) outer[[inner]]),
        names(li)
      )
    }),
    inner_names
  )
  return(li2)
}





