# ACC/AHA 2013 ASCVD risk score

Computes 10-year risk for hard ASCVD event (defined as first occurrence
of non-fatal myocardial infarction (MI), congestive heart disease (CHD)
death, or fatal or nonfatal stroke).

## Usage

``` r
ascvd_10y_accaha(
  race = "white",
  gender = c("male", "female"),
  age,
  totchol,
  hdl,
  sbp,
  bp_med,
  smoker,
  diabetes,
  ...
)
```

## Arguments

- race:

  patient race (white, aa, other)

- gender:

  patient gender (male, female)

- age:

  patient age (years)

- totchol:

  Total cholesterol (mg/dL)

- hdl:

  HDL cholesterol (mg/dL)

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

Estimated 10-Y Risk for hard ASCVD (percent)

## References

Goff, David C., et al. "2013 ACC/AHA guideline on the assessment of
cardiovascular risk: a report of the American College of
Cardiology/American Heart Association Task Force on Practice
Guidelines." Journal of the American College of Cardiology 63.25 Part B
(2014): 2935-2959.

## Examples

``` r
library(CVrisk)
ascvd_10y_accaha(
  race = "aa", gender = "male", age = 55,
  totchol = 213, hdl = 50, sbp = 140,
  bp_med = 0, smoker = 0, diabetes = 0
)
#> [1] 7.95
```
