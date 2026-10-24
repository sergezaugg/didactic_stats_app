



library(ggplot2)
library(MASS)
library(tidyverse)
source("src/utils_ui_and_plots.R")
# library(dplyr)
# library(ggplot2)


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
  
  return(
    list(
      "c00" = df_coef00,
      "c01" = df_coef01,
      "c02" = df_coef02,
      "c03" = df_coef03
    )
  )
}

# scatterplot 
make_data_scatterplot <- function(x){
  ggplot(x) + 
    geom_point(
      aes(x = predictor, y = response, color = group),
      size = 1
    ) +
    labs(title = "caraculo") +
    theme_dark() +
      theme(
        plot.background  = element_rect(fill = "#222222", color = NA),
        panel.background = element_rect(fill = "#222222", color = NA),
        text             = element_text(color = "white")
      ) +
    theme(
      panel.border = element_rect(
        colour = "white",
        fill = NA,
        linewidth = 1
      )
    )
}







# add regression lines 
add_lines_to_scatterplot <- function(fig, df_lines) { 
  fig +
    geom_abline(
      data = df_lines,
      aes(intercept = intercept, slope = slope, color = group),
      linewidth = 1
    )  
  
}






