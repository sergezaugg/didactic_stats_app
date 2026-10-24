# ---------------------------
# sandbox to draft code pieces
# ---------------------------

library(ggplot2)
library(MASS)
library(tidyverse)
# source("src/utils_plots.R")
source("src/utils_sim.R")

# library(dplyr)
# library(ggplot2)



par_a <- list(n=1000, mu_x=0,   mu_y=2,    sd_x=3, sd_y=2, cov_xy =  -0.7)
par_b <- list(n=1000, mu_x=5,   mu_y=7,    sd_x=3, sd_y=2, cov_xy =  -0.4)
par_c <- list(n=1000, mu_x=16,  mu_y=16,  sd_x=3, sd_y=2, cov_xy = -0.5)

df_all <- combine_dfs(par_a, par_b)

df_reg_lines <- fit_regression_models(df_all)

names(df_reg_lines)

fig <- make_data_scatterplot(x = df_all)
fig <- add_lines_to_scatterplot(fig, df_reg_lines[["c02"]])

fig





# # check
# df_all %>%
#   group_by(group) %>%
#   summarise(
#     mean_predictor = mean(predictor, na.rm = TRUE),
#     mean_response = mean(response, na.rm = TRUE),
#     sd_predictor = sd(predictor, na.rm = TRUE),
#     sd_response = sd(response, na.rm = TRUE)
#     )
# 
# head(df_all)











