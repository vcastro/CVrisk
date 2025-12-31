# Framingham 2008 ASCVD risk score (with lab measurement)

Computes 10-year risk for ASCVD event (coronary death, myocardial
infarction (MI), coronary insufficiency, angina, ischemic stroke,
hemorrhagic stroke, transient ischemic attack, peripheral artery
disease, or heart failure).

## Usage

``` r
ascvd_10y_frs(
  gender = c("male", "female"),
  age,
  hdl,
  totchol,
  sbp,
  bp_med,
  smoker,
  diabetes,
  ...
)
```

## Arguments

- gender:

  patient gender (male, female)

- age:

  patient age (years), between 30 and 74

- hdl:

  HDL cholesterol (mg/dL)

- totchol:

  Total cholesterol (mg/dL)

- sbp:

  Systolic blood pressure (mm Hg)

- bp_med:

  Patient is on a blood pressure medication (1=Yes, 0=No)

- smoker:

  Current smoker (1=Yes, 0=No)

- diabetes:

  Diabetes (1=Yes, 0=No)

- ...:

  Additional predictors can be passed and will be ignored

## Value

Estimated 10-Y Risk for hard ASCVD event (percent)

## References

D’agostino, R.B., Vasan, R.S., Pencina, M.J., Wolf, P.A., Cobain, M.,
Massaro, J.M. and Kannel, W.B., 2008. General cardiovascular risk
profile for use in primary care: the Framingham Heart Study.
Circulation, 117(6), pp.743-753.

## Examples

``` r
library(CVrisk)
ascvd_10y_frs(
  gender = "male", age = 55,
  hdl = 50, totchol = 213, sbp = 140,
  bp_med = 0, smoker = 0, diabetes = 0
)
#> [1] 13.53

# 16.7
```
