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
  df_coef00 <- data.frame(
    group = levels(df$group),
    intercept = coefs["(Intercept)"],
    slope = 0.0
  )
  
  # ignore groups 
  mod01 <- lm( response ~ predictor, data = df)
  coefs <- coef(mod01)
  df_coef01 <- data.frame(
    group = levels(df$group),
    intercept = coefs["(Intercept)"],
    slope = coefs["predictor"]
  )
  
  # sep intercept but common slope 
  mod02 <- lm( response ~ predictor + group - 1, data = df)
  coefs <- coef(mod02)
  df_coef02 <- data.frame(
    group = levels(df$group),
    intercept = coefs[paste0("group", levels(df$group))],
    slope = coefs["predictor"]
  )
  
  # sep intercept and slope models 
  mod03 <- lm(response ~ predictor:group + group - 1, data = df)
  coefs <- coef(mod03)
  df_coef03 <- data.frame(
    group = levels(df$group),
    intercept = coefs[paste0("group", levels(df$group))],
    slope = coefs[paste0("predictor:group", levels(df$group))]
  )
  
  # get standard t-table summary
  s00 <- as.data.frame(summary(mod00)$coefficients) %>% rownames_to_column(var = "Term")
  s01 <- as.data.frame(summary(mod01)$coefficients) %>% rownames_to_column(var = "Term")
  s02 <- as.data.frame(summary(mod02)$coefficients) %>% rownames_to_column(var = "Term")
  s03 <- as.data.frame(summary(mod03)$coefficients) %>% rownames_to_column(var = "Term")
  
  return(
    
    list(
    "df_plt"= list(
      "c00" = df_coef00,
      "c01" = df_coef01,
      "c02" = df_coef02,
      "c03" = df_coef03
    ),
    
    "df_lm" = list(
      "s00" = s00,
      "s01" = s01,
      "s02" = s02,
      "s03" = s03
    )
    )
    
    
  )
}














