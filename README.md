
# CVrisk

<!-- badges: start -->
[![R build status](https://github.com/vcastro/CVrisk/workflows/R-CMD-check/badge.svg)](https://github.com/vcastro/CVrisk/actions)
[![Codecov test coverage](https://codecov.io/gh/vcastro/CVrisk/branch/master/graph/badge.svg)](https://codecov.io/gh/vcastro/CVrisk?branch=master)
<!-- badges: end -->

Calculate cardiovascular risk scores in R.

## Installation

``` r
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("vcastro/CVRisk")
```

## Usage

``` r
library(CVrisk)
ascvd_risk_score(race = "aa", gender = "male", age = 55, 
   totchol = 213, hdl = 50, sbp = 140, 
   bp_med = FALSE, smoker=0, diabetes=0)
   
```

