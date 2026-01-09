# PREVENT 30-year ASCVD risk score

Computes 30-year risk for ASCVD (atherosclerotic cardiovascular disease)
using the American Heart Association PREVENT equations (2023).

## Usage

``` r
ascvd_30y_prevent(
  gender = c("male", "female"),
  age,
  sbp,
  bp_med,
  totchol,
  hdl,
  statin,
  diabetes,
  smoker,
  egfr,
  bmi,
  hba1c = NULL,
  uacr = NULL,
  zip = NULL,
  model = "auto",
  ...
)
```

## Arguments

- gender:

  patient gender (male, female)

- age:

  patient age (years), between 30 and 79

- sbp:

  Systolic blood pressure (mm Hg)

- bp_med:

  Patient is on a blood pressure medication (1=Yes, 0=No)

- totchol:

  Total cholesterol (mg/dL)

- hdl:

  HDL cholesterol (mg/dL)

- statin:

  Patient is on a statin (1=Yes, 0=No)

- diabetes:

  Diabetes (1=Yes, 0=No)

- smoker:

  Current smoker (1=Yes, 0=No)

- egfr:

  Estimated glomerular filtration rate (mL/min/1.73m2)

- bmi:

  Body mass index (kg/m2)

- hba1c:

  Glycated hemoglobin (HbA1c) in percent (optional)

- uacr:

  Urine albumin-to-creatinine ratio in mg/g (optional)

- zip:

  ZIP code for Social Deprivation Index (optional)

- model:

  PREVENT model variant to use: "auto" (default, selects based on
  available data), "base", "hba1c", "uacr", "sdi", or "full"

- ...:

  Additional predictors can be passed and will be ignored

## Value

30-year ASCVD risk estimate (percent)

## References

Khan SS, Matsushita K, Sang Y, Ballew SH, Grams ME, Surapaneni A, Blaha
MJ, Carson AP, Chang AR, Ciemins E, Go AS, Gutierrez OM, Hwang SJ,
Jassal SK, Kovesdy CP, Lloyd-Jones DM, Shlipak MG, Palaniappan LP,
Sperling L, Virani SS, Tuttle K, Neeland IJ, Chow SL, Rangaswami J,
Pencina MJ, Ndumele CE, Coresh J; Chronic Kidney Disease Prognosis
Consortium and the American Heart Association
Cardiovascular-Kidney-Metabolic Science Advisory Group. Development and
Validation of the American Heart Association's PREVENT Equations.
Circulation. 2024 Feb 6;149(6):430-449.

## Examples

``` r
library(CVrisk)
# Base model (default when model = "auto" and no optional predictors provided)
ascvd_30y_prevent(
  gender = "female", age = 50,
  sbp = 160, bp_med = 1,
  totchol = 200, hdl = 45,
  statin = 0, diabetes = 1, smoker = 0,
  egfr = 90, bmi = 35
)
#> [1] 35.4

# Explicitly specify base model
ascvd_30y_prevent(
  gender = "male", age = 45,
  sbp = 130, bp_med = 0,
  totchol = 200, hdl = 50,
  statin = 0, diabetes = 0, smoker = 1,
  egfr = 95, bmi = 28,
  model = "base"
)
#> [1] 13.8

# Auto model with UACR (will use uacr model variant)
ascvd_30y_prevent(
  gender = "male", age = 55,
  sbp = 140, bp_med = 0,
  totchol = 213, hdl = 50,
  statin = 0, diabetes = 0, smoker = 0,
  egfr = 90, bmi = 30,
  uacr = 25
)
#> [1] 19.8
```
