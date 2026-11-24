

# docker rm -f didactic-stats-test

# docker build --no-cache -t didactic-stats-app .

# Creates a new container from an image and starts it
# docker run -d -p 3838:3838 --name didactic-stats-test didactic-stats-app
# http://localhost:3838/didactic_stats_app/

# The -d means detached: Docker runs it independently of your terminal.

# Starts an existing, stopped container.
# docker start didactic-stats-test
# docker stop didactic-stats-test

# docker ps
# docker ps -a



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
