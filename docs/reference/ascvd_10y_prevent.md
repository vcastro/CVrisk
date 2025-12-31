# PREVENT 10-year ASCVD risk score (base model)

Computes 10-year risk for ASCVD (atherosclerotic cardiovascular disease)
using the American Heart Association PREVENT equations (2023) base
model.

## Usage

``` r
ascvd_10y_prevent(
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

- ...:

  Additional predictors can be passed and will be ignored

## Value

10-year ASCVD risk estimate (percent)

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
ascvd_10y_prevent(
  gender = "female", age = 50,
  sbp = 160, bp_med = 1,
  totchol = 200, hdl = 45,
  statin = 0, diabetes = 1, smoker = 0,
  egfr = 90, bmi = 35
)
#> [1] 9.2
```
