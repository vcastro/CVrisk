# Compute multiple CV risk scores

Compute multiple CV risk scores

## Usage

``` r
compute_CVrisk(
  df,
  scores = c("ascvd_10y_accaha", "ascvd_10y_frs", "ascvd_10y_frs_simple", "chd_10y_mesa",
    "chd_10y_mesa_cac"),
  age,
  gender,
  race,
  sbp = NULL,
  bmi = NULL,
  hdl = NULL,
  totchol = NULL,
  bp_med = NULL,
  smoker = NULL,
  diabetes = NULL,
  lipid_med = NULL,
  statin = NULL,
  egfr = NULL,
  fh_heartattack = NULL,
  cac = NULL
)
```

## Arguments

- df:

  input dataframe

- scores:

  scores to compute, default is all scores

- age:

  patient age in years (required for all scores)

- gender:

  patient gender (male or female)

- race:

  character string for patient race (white, aa, other) column

- sbp:

  character string of systolic blood pressure (in mm Hg) column

- bmi:

  character string of Body mass index (kg/m2) column

- hdl:

  character string of HDL column

- totchol:

  character string of total cholesterol column

- bp_med:

  character string of blood pressure medication column

- smoker:

  character string of smoking status column

- diabetes:

  character string of diabetes status column

- lipid_med:

  character string of lipid medication column (used as statin if statin
  not provided)

- statin:

  character string of statin medication column (takes precedence over
  lipid_med)

- egfr:

  character string of estimated glomerular filtration rate column

- fh_heartattack:

  character string of fh of heart attack status column

- cac:

  character string of cac column

## Value

input data frame with risk score results appended as columns

## Examples

``` r
library(CVrisk)
# Compute traditional risk scores
compute_CVrisk(sample_data,
  scores = c("ascvd_10y_accaha", "ascvd_10y_frs", "ascvd_10y_frs_simple",
             "chd_10y_mesa", "chd_10y_mesa_cac", "ascvd_10y_prevent"),
  age = "age", race = "race", gender = "gender", bmi = "BMI", sbp = "sbp",
  hdl = "hdl", totchol = "totchol", bp_med = "bp_med", smoker = "smoker",
  diabetes = "diabetes", lipid_med = "lipid_med", egfr = "egfr",
  fh_heartattack = "fh_heartattack", cac = "cac"
)
#>   age gender     race BMI sbp hdl totchol bp_med smoker diabetes lipid_med
#> 1  55   male    white  30 140  50      NA      0      0        0         0
#> 2  45 female    white  27 125  50     200      1      0        0         0
#> 3  45 female    white  27 125  50     200     NA      0        0         0
#> 4  70   male hispanic  NA 140  50     190      1      0        0         0
#> 5  70   male hispanic  NA 140  50     190      1      0        0         0
#> 6  80 female  chinese  NA 140  50     190      1      0        0         0
#> 7  60   male       aa  29 140  50     190      1      0        0         0
#>   fh_heartattack cac egfr ascvd_10y_accaha ascvd_10y_frs ascvd_10y_frs_simple
#> 1              0  NA   90               NA            NA                16.75
#> 2              0   0   90             1.22          4.68                 4.91
#> 3              0  NA   90               NA            NA                   NA
#> 4              0  NA   75            23.47         30.95                   NA
#> 5              0   0   75            23.47         30.95                   NA
#> 6              0   0   65               NA            NA                   NA
#> 7              0  50   85            15.49         20.63                28.35
#>   chd_10y_mesa chd_10y_mesa_cac ascvd_10y_prevent
#> 1           NA               NA                NA
#> 2         1.65             1.38               1.3
#> 3           NA               NA                NA
#> 4         9.34               NA                NA
#> 5         9.34             3.26                NA
#> 6         5.19             1.88                NA
#> 7         5.91             8.33               5.8
```
