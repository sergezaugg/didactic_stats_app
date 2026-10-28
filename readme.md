# Didactic Statistics App

### Features
- Get intuitive understanding of strengths and pitfalls with linear regression
- Simulate multiple relevant scenarios of data with groups and continuous predictors
- Explore plots and tables to show how different regression models (mis-)behave
- 5 models implemented from "single grand mean" to "separate intercept and separate slope"
- Friendly multi-page app with dark gothic theme

### Dependencies
- R 4.5.1

  - ggplot2
  - tidyverse
  - MASS

  - shiny
  - bslib
  - shinyWidgets
  - DT


### Data Source
- Simulated data, there are no external data fetched.

### Installation
1. Install R and Rstudio   
1. Clone the repository   
3. Install R packages  

### Usage
Start the dashboard locally with:
- Open repo in Rstudio as a project (e.g. double-click ```didactic_stats_app.Rproj```)

  - Easy: open app.R the use the "Run app" button
  - More control: Open Rstudio, go to terminal and do
  
```bash
Rscript --no-init-file -e "shiny::runApp(launch.browser = TRUE)"
# or 
Rscript --vanilla      -e "shiny::runApp(launch.browser = TRUE)"
# Without R-studio ... TBD
Rscript --no-init-file -e "shiny::runApp(appDir = '/your local path/didactic_stats_app', launch.browser = TRUE)"

```

### Project Structure
```text
TBD
```

### Credits
- Web-app concept, analytics and implementation by Serge Zaugg ([Pollito-ML](https://github.com/sergezaugg))

### License
[MIT License](LICENSE)





