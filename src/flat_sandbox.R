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






