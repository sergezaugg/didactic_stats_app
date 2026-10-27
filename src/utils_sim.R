# ---------------------------
# Description : Pure simulation and stats functions
# Author : Serge Zaugg
# ---------------------------

simulate_bivariate_normal <- function(par){ 
  x <- mvrnorm(
    n = par$n,
    mu = c(par$mu_x, par$mu_y),                    
    Sigma = matrix(c(1, par$cov_xy, par$cov_xy, 1), nrow = 2)  
  )
  x[,1] = ((par$sd_x)*(x[,1]-par$mu_x)) + par$mu_x
  x[,2] = ((par$sd_y)*(x[,2]-par$mu_y)) + par$mu_y
  df <- as_tibble(x) %>%
    set_names(c("predictor", "response"))
  return(df)
}


combine_dfs <- function(...) {
  pars <- list(...)
  dfs <- lapply(seq_along(pars), function(i) {
    df <- simulate_bivariate_normal(pars[[i]])
    df$group <- LETTERS[i]
    df
  })
  dfs <- bind_rows(dfs)
  dfs <- dfs %>% mutate(group = factor(group) )
  return(dfs)
}

# get standard t-table summary
get_t_table <- function(mod){
  as.data.frame(summary(mod)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
}


# 
# fit_regression_models <- function(df){
# 
#   # ignore all predictors
#   mod00 <- lm( response ~ 1, data = df)
#   s00 <- get_t_table(mod00)
#   coefs <- coef(mod00)
#   r00 <- residuals(mod00)
#   df_coef00 <- data.frame(
#     group = levels(df$group),
#     intercept = coefs["(Intercept)"],
#     slope = 0.0
#   )
# 
#   # just compare two groups
#   mod00b <- lm( response ~ group - 1, data = df)
#   s00b <- get_t_table(mod00b)
#   coefs <- coef(mod00b)
#   r00b <- residuals(mod00b)
#   df_coef00b <- data.frame(
#     group = levels(df$group),
#     intercept = coefs[paste0("group", levels(df$group))],
#     slope = 0.0
#   )
# 
#   # ignore groups
#   mod01 <- lm( response ~ predictor, data = df)
#   s01 <- get_t_table(mod01)
#   coefs <- coef(mod01)
#   r01 <- residuals(mod01)
#   df_coef01 <- data.frame(
#     group = levels(df$group),
#     intercept = coefs["(Intercept)"],
#     slope = coefs["predictor"]
#   )
# 
#   # sep intercept but common slope
#   mod02 <- lm( response ~ predictor + group - 1, data = df)
#   s02 <- get_t_table(mod02)
#   coefs <- coef(mod02)
#   r02 <- residuals(mod02)
#   df_coef02 <- data.frame(
#     group = levels(df$group),
#     intercept = coefs[paste0("group", levels(df$group))],
#     slope = coefs["predictor"]
#   )
# 
#   # sep intercept and slope models
#   mod03 <- lm(response ~ predictor:group + group - 1, data = df)
#   s03 <- get_t_table(mod03)
#   # coefs <- coef(mod03)
#   r03 <- residuals(mod03)
#   df_coef03 <- data.frame(
#     group = levels(df$group),
#     intercept = coef(mod03)[paste0("group", levels(df$group))],
#     slope = coef(mod03)[paste0("predictor:group", levels(df$group))]
#   )
# 
#   return(
# 
#     list(
#     "df_plt"= list(
#       "c00" = df_coef00,
#       "c00b" = df_coef00b,
#       "c01" = df_coef01,
#       "c02" = df_coef02,
#       "c03" = df_coef03
#     ),
# 
#     "df_lm" = list(
#       "s00" = s00,
#       "s00b" = s00b,
#       "s01" = s01,
#       "s02" = s02,
#       "s03" = s03
#     ),
# 
#     "df_res" = list(
#       "r00" = r00,
#       "r00b" = r00b,
#       "r01" = r01,
#       "r02" = r02,
#       "r03" = r03
#     )
# 
# 
#     )
# 
# 
#   )
# }



fit_regression_models <- function(df){
  
  li_formu <- list(
    m01 = as.formula("response ~ 1"),
    m02 = as.formula("response ~ group - 1"),
    m03 = as.formula("response ~ predictor"),
    m04 = as.formula("response ~ predictor + group - 1"),
    m05 = as.formula("response ~ predictor:group + group - 1")
  )
  
  groups = levels(df$group)
  
  models <- lapply(li_formu, lm, data = df)
  df_tab <- lapply(models, get_t_table)
  df_res <- lapply(models, residuals)
  coefs  <- lapply(models, coef)
  
  df_plt <- list(
    m01  = data.frame(group = groups, intercept = coefs$m01["(Intercept)"], slope = 0),
    m02  = data.frame(group = groups, intercept = coefs$m02[paste0("group", groups)], slope = 0),
    m03  = data.frame(group = groups, intercept = coefs$m03["(Intercept)"], slope = coefs$m03["predictor"]),
    m04  = data.frame(group = groups, intercept = coefs$m04[paste0("group", groups)], slope = coefs$m04["predictor"]),
    m05  = data.frame(group = groups, intercept = coefs$m05[paste0("group", groups)], slope = coefs$m05[paste0("predictor:group", groups)])
  )
  
  return(
    list(
      "df_plt"= df_plt,
      "df_lm" = df_tab,
      "df_res" = df_res
    )
  )
  
}










