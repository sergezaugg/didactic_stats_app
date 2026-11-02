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
