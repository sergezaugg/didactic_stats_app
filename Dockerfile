#------------------------
# Applied Stats Playground — Dockerfile
# Author: Serge Zaugg
# Purpose: Build and run the R Shiny application
#------------------------

FROM rocker/shiny:4.5.1

WORKDIR /srv/shiny-server/didactic_stats_app

# Install Linux system dependencies
RUN apt-get update && apt-get install -y \
    libwebp-dev \
    libwebpdemux2 \
    libwebpmux3 \
    && rm -rf /var/lib/apt/lists/*

# Copy application
COPY . .

# Install renv
RUN R --vanilla -e "install.packages('renv', repos='https://cloud.r-project.org')"

# Avoid symlinks to the root user's renv cache
ENV RENV_CONFIG_CACHE_SYMLINKS=FALSE

# Restore R packages
RUN R -e "renv::restore(prompt = FALSE)"

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]
