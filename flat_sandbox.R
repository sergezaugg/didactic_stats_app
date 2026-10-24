# ---------------------------
# sandbox to draft code pieces
# ---------------------------

library(ggplot2)
source("src/utils_plots.R")
library(MASS)
library(tidyverse)
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







par_a <- list(n=1000, mu_x=0,   mu_y=10,    sd_x=3, sd_y=2, cov_xy =  0.9)
par_b <- list(n=1000, mu_x=5,   mu_y=7,    sd_x=3, sd_y=2, cov_xy =  0.1)
par_c <- list(n=1000, mu_x=16,   mu_y=11,    sd_x=3, sd_y=2, cov_xy =  -0.9)

df_all <- combine_dfs(par_a, par_b, par_c)
df_all <- combine_dfs(par_a, par_b)




# check
df_all %>%
  group_by(group) %>%
  summarise(
    mean_predictor = mean(predictor, na.rm = TRUE),
    mean_response = mean(response, na.rm = TRUE),
    sd_predictor = sd(predictor, na.rm = TRUE),
    sd_response = sd(response, na.rm = TRUE)
    )

head(df_all)









# igore all predictors 
mod00 <- lm( response ~ 1, data = df_all)
mod00 %>% summary()
coef(mod00)

# ignore groups 
mod01 <- lm( response ~ predictor, data = df_all)
mod01 %>% summary()
coef(mod01)

# sep intercept but common slope 
mod02 <- lm( response ~ predictor + group - 1, data = df_all)
mod02 %>% summary()
coef(mod02)

# sep intercept and slope models 
mod03 <- lm(response ~ predictor:group + group - 1, data = df_all)
mod03 %>% summary()
coef(mod03)




# get coef df for mod02
coefs <- coef(mod02)
df_coef02 <- data.frame(
  group = levels(df_all$group),
  intercept = coefs[paste0("group", levels(df_all$group))],
  slope = coefs["predictor"]
)


# get coef df for mod03
coefs <- coef(mod03)
df_coef03 <- data.frame(
  group = levels(df_all$group),
  intercept = coefs[paste0("group", levels(df_all$group))],
  slope = coefs[paste0("predictor:group", levels(df_all$group))]
)


#---------------------------------------
# plot all 

# scatterplot 
fig <- ggplot(df_all) + 
  geom_point(
    aes(x = predictor, y = response, color = group),
    size = 1
  ) +
  labs(title = "bla bla bli")

# add regression lines 
fig <- fig +
  geom_abline(
    data = df_coef02,
    aes(intercept = intercept, slope = slope, color = group),
    linewidth = 1
  )

fig

