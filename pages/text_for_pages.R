# ---------------------------
# Description : text to be used in pages
# Author : Serge Zaugg
# ---------------------------

ptext <- list(
  x_free_ti = "Unconstrained Simulation",
  x_free_tx = "All simulation parameters are free.",
  
  x_same_ti = "Sim Randomized Experiment", 
  x_same_tx = "Covariate (Predictor) constrained to same distribution in both groups.
  This simulates a randomized experiment where covariate is evenly distributed across both groups.
  The covariate may have an association to response and then adjusting for it is adecquate.",
  
  x_uneq_ti = "Sim Observational Data", 
  x_uneq_tx = "Covariate (Predictor) constrained to have different distribution.
  This simulates observational data where covariate is diferent between both groups.
  Failing to adjust for covariate or group may lead to biased estimates.",
  
  simpso_ti = "Simpson's Paradox", 
  simpso_tx = "Slope constrained to be negative and group B higher than A.
  Simpson's Paradox: M3 ignores groups and suggests a positive association
  between predictor and response.
  If group is included (M4 & M5) we find that association is negative."
)
