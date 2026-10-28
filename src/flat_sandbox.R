# ---------------------------
# Description : sandbox to draft code pieces
# Author : Serge Zaugg
# 
# ---------------------------

# library(ggplot2)
library(MASS)
library(tidyverse)
source("src/utils_sim.R")
source("src/utils_plots.R")

par_a <- list(n=1000, mu_x=0,   mu_y=5, sd_x=3, sd_y=10, cov_xy =  -0.8)
par_b <- list(n=1000, mu_x=0,   mu_y=0, sd_x=3, sd_y=1, cov_xy =  0.8)

df_all <- combine_dfs(par_a, par_b)
li_models <- fit_regression_models(df_all)

li_models %>% class()

li_models %>% names()
li_models[["m04"]] %>% names()

li_models[["m04"]][["df_tables"]]
li_models[["m04"]][["df_plots"]]
li_models[["m04"]][["df_res_plots"]]





runif(10)

# 
# simulate_linear_data <- function(par){ 
#   x <- runif(par$n, par$xmin, par$xmax) 
#   y <- par$b0 + par$b1*x
#   y <- y + rnorm(par$n, par$sd_res)
#   df <- tibble(predictor = x, response = y)
#   return(df)
# }
# 
# combine_dfs_lin <- function(...) {
#   pars <- list(...)
#   dfs <- lapply(seq_along(pars), function(i) {
#     df <- simulate_linear_data(pars[[i]])
#     df$group <- LETTERS[i]
#     df
#   })
#   dfs <- bind_rows(dfs)
#   dfs <- dfs %>% mutate(group = factor(group) )
#   return(dfs)
# }


par_b <- list(n=1000, mu_x = 0,  mu_y = 0,  sd_x=3, sd_y=1,  cov_xy =  0.8)

par_a <- list(n=1000, xmin = -1, xmax = 1,  b0=0,   b1=5,    sd_res=3)


par_b <- list(n=1000, xmin = -1, xmax = 1,  b0=0, b1=-3, sd_res=3)

simulate_linear_data(par_a)

df_all <- combine_dfs_lin(par_a, par_b)

li_models <- fit_regression_models(df_all)


li_models[["m05"]][["df_tables"]]
li_models[["m05"]][["df_plots"]]
li_models[["m05"]][["df_res_plots"]]




