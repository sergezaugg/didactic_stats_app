# ---------------------------
# Description : sandbox to draft code pieces
# Author : Serge Zaugg
# 
# ---------------------------

library(ggplot2)
library(MASS)
library(tidyverse)
source("src/utils_sim.R")


par_a <- list(n=1000, mu_x=0,   mu_y=2,    sd_x=3, sd_y=2, cov_xy =  -0.7)
par_b <- list(n=1000, mu_x=5,   mu_y=7,    sd_x=3, sd_y=2, cov_xy =  -0.4)
par_c <- list(n=1000, mu_x=16,  mu_y=16,  sd_x=3, sd_y=2, cov_xy = -0.5)

df_all <- combine_dfs(par_a, par_b)

df_reg_lines <- fit_regression_models(df_all)

names(df_reg_lines)

xx = df_reg_lines[["df_lm"]][["s03"]]


xx = as.data.frame(xx$coefficients) %>% rownames_to_column(var = "Term")



fig <- make_data_scatterplot(x = df_all)
fig <- add_lines_to_scatterplot(fig, df_reg_lines[["c02"]])
fig














