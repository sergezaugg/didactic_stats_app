# ---------------------------
# Description : sandbox to draft code pieces
# Author : Serge Zaugg
# 
# ---------------------------

library(ggplot2)
library(MASS)
library(tidyverse)
source("src/utils_sim.R")
source("src/utils_plots.R")

# get standard t-table summary
get_t_table <- function(mod){
  as.data.frame(summary(mod)$coefficients) %>% 
    rownames_to_column(var = "Term") %>% 
    mutate(across(where(is.numeric), ~ round(., 2)))
}


par_a <- list(n=1000, mu_x=0,   mu_y=5, sd_x=3, sd_y=10, cov_xy =  -0.8)
par_b <- list(n=1000, mu_x=0,   mu_y=0, sd_x=3, sd_y=1, cov_xy =  0.8)

df_all <- combine_dfs(par_a, par_b)









df <- df_all

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




df_plt %>% names()
df_tab %>% names()
df_res %>% names()










#--------------------------------------------

df = df_all



# ignore all predictors 
mod00 <- lm( response ~  group - 1, data = df)
coefs <- coef(mod00)
r00 <- residuals(mod00)
df_coef00 <- data.frame(
  group = levels(df$group),
  intercept = coefs[paste0("group", levels(df$group))],
  slope = 0.0
)



#--------------------------------------------
df = df_all
mod03 <- lm(response ~ predictor:group + group - 1, data = df)
summary(mod03)

mod03b <- lm(response ~ predictor*group , data = df)
summary(mod03b)

res <- residuals(mod03)



# scatter plot of residuals 
make_residuals_plot <- function(df, res) {
  ggplot(df) + 
    geom_point(
      aes(x = predictor, y = res, color = group),
      size = 1
    ) +
    facet_wrap(~ group, ncol = 2)
  }

make_residuals_plot(df, res)





coefs <- coef(mod03)
df_coef03 <- data.frame(
  group = levels(df$group),
  intercept = coefs[paste0("group", levels(df$group))],
  slope = coefs[paste0("predictor:group", levels(df$group))]
)

fig <-  ggplot(df_all) + 
  geom_point(
    aes(x = predictor, y = response, color = group),
    size = 1
  ) +
  geom_abline(
    data = df_coef03,
    aes(intercept = intercept, slope = slope, color = group),
    linewidth = 1
  )

fig








# run the application by clicking the 'Run App' button above.
# Rscript -e "shiny::runApp('app.R', port=8080, host='0.0.0.0')"

# # works in R sesson
# shiny::runApp(appDir = 'D:/src/src_r/didactic_stats_app', launch.browser = TRUE)

# Rscript --no-init-file -e "print(4+4)"

# (from Rstudio's terminal) halleluiaaa !!
# Rscript --no-init-file -e "shiny::runApp(appDir = 'D:/src/src_r/didactic_stats_app', launch.browser = TRUE)"
# Rscript --no-init-file -e "shiny::runApp(launch.browser = TRUE)"
# Rscript --vanilla      -e "shiny::runApp(launch.browser = TRUE)"




