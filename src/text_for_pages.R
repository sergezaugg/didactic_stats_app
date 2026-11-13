# ---------------------------
# Description : text to be used in pages
# Author : Serge Zaugg
# ---------------------------

ptext <- list(
  x_free_ti = "Unconstrained",
  x_free_tx = "All simulation parameters are free.",
  
  x_same_ti = "Randomized Experiment", 
  x_same_tx = "This simulates an experiment where predictor (covariate) is evenly 
  distributed across both groups via randomization.
  The predictor may have an association to response and then adjusting for it is adecquate.",
  
  x_uneq_ti = "Observational Data", 
  x_uneq_tx = "This simulates observational data where predictor (covariate) 
  is diferent between both groups.
  Failing to adjust for predictor or group may lead to biased estimates.",
  
  simpso_ti = "Simpson's Paradox", 
  simpso_tx = "Default has negative slope and group B higher than A.
  This simulates Simpson's Paradox: M3 ignores groups and wrongly suggests a positive association.
  M4 & M5 include group and show negative association."
)
