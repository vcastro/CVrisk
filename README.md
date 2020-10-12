
# CVrisk

<!-- badges: start -->
[![R build status](https://github.com/vcastro/CVrisk/workflows/R-CMD-check/badge.svg)](https://github.com/vcastro/CVrisk/actions)
<!-- badges: end -->

Calculate cardiovascular risk scores in R.

## Installation

You can install the released version of CVrisk from [CRAN](https://CRAN.R-project.org) with:

``` r
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("vcastro/CVRisk")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(CVrisk)
ascvd_risk_score(race = "aa", gender = "male", age = 55, 
   totchol = 213, hdl = 50, sbp = 140, 
   bp_med = FALSE, smoker=0, diabetes=0)
   
```

