
# CVrisk

<!-- badges: start -->
[![R build status](https://github.com/vcastro/CVrisk/workflows/R-CMD-check/badge.svg)](https://github.com/vcastro/CVrisk/actions)
[![Codecov test coverage](https://codecov.io/gh/vcastro/CVrisk/branch/master/graph/badge.svg)](https://codecov.io/gh/vcastro/CVrisk?branch=master)
[![CRAN status](https://www.r-pkg.org/badges/version/CVrisk)](https://CRAN.R-project.org/package=CVrisk)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/CVrisk)](https://CRAN.R-project.org/package=CVrisk)
<!-- badges: end -->


## About the package

`CVrisk` is a  package to calculate various cardiovascular disease risk scores. 

### Currently available risk scores

- Framingham 2008 10-year ASCVD risk (model with lipid labs)
- Framingham 2008 10-year ASCVD risk (model with BMI)
- ACC/AHA 2013 10-year ASCVD risk 
- MESA 2015 10-year ASCVD risk (traditional risk factors)
- MESA 2015 10-year ASCVD risk (using coronary artery calcium)


#### Coming soon

- Reynolds 2007 10-year ASCVD risk in women
- Framingham 2009 30-year ASCVD risk

## Installation

``` r
# Install from CRAN
install.packages("CVrisk")

# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("vcastro/CVrisk")
```

## Usage

Calculate a single score:

``` r
library(CVrisk)
ascvd_10y_accaha(race = "aa", gender = "male", age = 55, 
   totchol = 213, hdl = 50, sbp = 140, 
   bp_med = FALSE, smoker=0, diabetes=0)
   
```

Calculate multiple scores for a dataframe and append scores to the
dataframe:

``` r

compute_CVrisk(sample_data,
   age = "age", race = "race", gender = "gender", bmi = "BMI", sbp = "sbp",
   hdl = "hdl", totchol = "totchol", bp_med = "bp_med", smoker = "smoker",
   diabetes = "diabetes", lipid_med = "lipid_med",
   fh_heartattack = "fh_heartattack", cac = "cac"
)

```

