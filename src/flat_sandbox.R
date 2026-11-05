# ---------------------------
# Description : sandbox to draft code pieces
# Author : Serge Zaugg
# 
# renv cheatsheet
# renv::init()
# renv::status()   # Check whether lockfile and library are synchronised
# renv::snapshot() # Update renv.lock (uses static code analysis, not the packages currently loaded)
# renv::activate()
# renv::restore()  # Restore packages from renv.lock
# ---------------------------

# install.packages("styler")
# styler::style_file("pages/page_x_same.R")
# styler::style_file("pages/page_x_free.R")
# styler::style_file("pages/page_x_uneq.R")
# styler::style_file("src/utils_plots.R")
# styler::style_file("src/utils_ui.R")
# styler::style_file("src/utils_ui.R")
# styler::style_file("pages/text_for_pages.R")
# styler::style_file("pages/page_summary.R")







source("src/utils_sim.R")
library(tidyverse)

# (1) get input from user
par_x_free_a <- list(n = 100,xmin = 1,xmax = 2,b0 = 0,b1 = -1,sd_res = 0.1)
par_x_free_b <- list(n = 100,xmin = 1,xmax = 2,b0 = 0,b1 = 1,sd_res = 0.1)

# simulate data
df_all_x_free    <- combine_dfs_lin(par_x_free_a, par_x_free_b)
                                   
# stats computation
li_models <- fit_regression_models(df_all_x_free)

li_models %>% names()

li_models[["m02"]] %>% names()

li_models[["m02"]][["df_tables"]]
li_models[["m02"]][["df_tab_conv"]]

li_models[["m05"]][["df_tables"]]
li_models[["m05"]][["df_tab_conv"]]
   






