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


fit_regression_models <- function(df){
  
  # ignore all predictors 
  mod00 <- lm( response ~ 1, data = df)
  coefs <- coef(mod00)
  r00 <- residuals(mod00)
  df_coef00 <- data.frame(
    group = levels(df$group),
    intercept = coefs["(Intercept)"],
    slope = 0.0
  )
  
  # just compare two groups 
  mod00b <- lm( response ~  group - 1, data = df)
  coefs <- coef(mod00b)
  r00b <- residuals(mod00b)
  df_coef00b <- data.frame(
    group = levels(df$group),
    intercept = coefs[paste0("group", levels(df$group))],
    slope = 0.0
  )
  
  # ignore groups 
  mod01 <- lm( response ~ predictor, data = df)
  coefs <- coef(mod01)
  r01 <- residuals(mod01)
  df_coef01 <- data.frame(
    group = levels(df$group),
    intercept = coefs["(Intercept)"],
    slope = coefs["predictor"]
  )
  
  # sep intercept but common slope 
  mod02 <- lm( response ~ predictor + group - 1, data = df)
  coefs <- coef(mod02)
  r02 <- residuals(mod02)
  df_coef02 <- data.frame(
    group = levels(df$group),
    intercept = coefs[paste0("group", levels(df$group))],
    slope = coefs["predictor"]
  )
  
  # sep intercept and slope models 
  mod03 <- lm(response ~ predictor:group + group - 1, data = df)
  coefs <- coef(mod03)
  r03 <- residuals(mod03)
  df_coef03 <- data.frame(
    group = levels(df$group),
    intercept = coefs[paste0("group", levels(df$group))],
    slope = coefs[paste0("predictor:group", levels(df$group))]
  )
  
  # get standard t-table summary
  s00 <- as.data.frame(summary(mod00)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
  
  s00b <- as.data.frame(summary(mod00b)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
  
  s01 <- as.data.frame(summary(mod01)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
  
  s02 <- as.data.frame(summary(mod02)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
  
  s03 <- as.data.frame(summary(mod03)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
  
  return(
    
    list(
    "df_plt"= list(
      "c00" = df_coef00,
      "c00b" = df_coef00b,
      "c01" = df_coef01,
      "c02" = df_coef02,
      "c03" = df_coef03
    ),
    
    "df_lm" = list(
      "s00" = s00,
      "s00b" = s00b,
      "s01" = s01,
      "s02" = s02,
      "s03" = s03
    ),
    
    "df_res" = list(
      "r00" = r00,
      "r00b" = r00b,
      "r01" = r01,
      "r02" = r02,
      "r03" = r03
    )
    
    
    )
    
    
  )
}














