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

# install.packages("shinylive")
# install.packages("S7")
.libPaths()

shinylive::export(appdir = ".", destdir = "docs")

httpuv::runStaticServer("docs")

