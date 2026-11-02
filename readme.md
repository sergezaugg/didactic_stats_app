# Didactic Statistics App


### Features
- Get intuitive understanding of strengths and pitfalls with linear regression
- Simulate multiple relevant scenarios of data with groups and continuous predictors
- Explore plots and tables to show how different regression models (mis-)behave
- 5 models implemented from "single grand mean" to "separate intercept and separate slope"
- Friendly multi-page app with dark gothic theme


### Dependencies
- R 4.5.1
- tidyverse
- shiny
- bslib

### Data Source
- Simulated data, no external data needed.

### Installation
* Install R and Rstudio (and git)
* In Terminal/cmd/bash: Clone this repository
* Open this repo in Rstudio as a project (e.g. double-click **didactic_stats_app.Rproj**)
* In R console:
  * Activate renv: ```renv::activate()```
  * Check needed R packages: ```renv::status()```
  * Install packages from renv.lock: ```renv::restore()```

### Usage - Start app (with R-studio )
* Open repo in Rstudio as a project (e.g. double-click ```didactic_stats_app.Rproj```)
  * Easy: open app.R the use the "Run app" button
  * More control: Open Rstudio, go to terminal and do
  * ```Rscript --no-init-file -e "shiny::runApp(launch.browser = TRUE)"```
  * or equivalently
  * ```Rscript --vanilla -e "shiny::runApp(launch.browser = TRUE)"```
  * more arguments
  * ```Rscript --vanilla -e "shiny::runApp(launch.browser = TRUE, port = 3838, host = '127.0.0.1')"```

### Usage - Start app (with PowerShell)

Navigate to dir containing Rscript.exe

```bash
cd <dir containing Rscript.exe>
```

Example ```cd "C:\Program Files\R\R-4.5.1\bin\"``` path many vary on each computer.

Install dependencies (skip if you already executed installation steps above)

```bash
.\Rscript -e "renv::restore(project = '.../didactic_stats_app')"
```

Call Rscript with repo path as argument to runApp(), below replace ... by your path to repo

```bash
.\Rscript --no-init-file -e "shiny::runApp(appDir = '.../didactic_stats_app', launch.browser = TRUE)"
```



### Project Structure

```text
didactic_stats_app/
│
├── app.R                    # Main application entry point
├── pages/                   # UI definitions for app pages
├── server/                  # Server-side logic with page-specific functionality
├── src/                     # Shared functions and components
│
├── renv/                    # Project-specific package environment
├── renv.lock                # Package versions and dependency snapshot
├── .Rprofile                # R startup config (used for renv activation)
│
├── .gitignore               # Files excluded from version control
├── didactic_stats_app.Rproj # RStudio project configuration
├── readme.md
└── LICENSE
```


### Credits
- Web-app concept, analytics and implementation by Serge Zaugg ([Pollito-ML](https://github.com/sergezaugg))

### License
[MIT License - © 2026 Serge Zaugg](LICENSE)





