# MESA 2015 CHD risk score

Computes 10-year risk for hard coronary heart disease (CHD) event
(defined as first occurrence of myocardial infarction (MI), resuscitated
cardiac arrest, CHD death, or revascularization with prior or concurrent
adjudicated angina).

## Usage

``` r
chd_10y_mesa(
  race = "white",
  gender = c("male", "female"),
  age,
  totchol = NA,
  hdl = NA,
  lipid_med = NA,
  sbp = NA,
  bp_med = NA,
  smoker = NA,
  diabetes = NA,
  fh_heartattack = NA,
  ...
)
```

## Arguments

- race:

  patient race/ethnicity (white, aa, chinese, or hispanic)

- gender:

  patient gender (male, female)

- age:

  patient age (years), risk computed for 45-85 year olds

- totchol:

  Total cholesterol (mg/dL)

- hdl:

  HDL cholesterol (mg/dL)

- lipid_med:

  Patient is on a hyperlipidemic medication (1=Yes, 0=No)

- sbp:

  Systolic blood pressure (mm Hg)

- bp_med:

  Patient is on a blood pressure medication (1=Yes, 0=No)

- smoker:

  Current smoker (1=Yes, 0=No)

- diabetes:

  Diabetes (1=Yes, 0=No)

- fh_heartattack:

  Family history of heart attacks (parents, siblings ,or children)
  (1=Yes, 0=No)

- ...:

  Additional predictors can be passed and will be ignored

## Value

Estimated 10-Y Risk for hard CAD event (percent)

## References

McClelland RL, Jorgensen NW, Budoff M, et al. 10-Year Coronary Heart
Disease Risk Prediction Using Coronary Artery Calcium and Traditional
Risk Factors: Derivation in the MESA (Multi-Ethnic Study of
Atherosclerosis) With Validation in the HNR (Heinz Nixdorf Recall) Study
and the DHS (Dallas Heart Study). J Am Coll Cardiol.
2015;66(15):1643-1653. doi:10.1016/j.jacc.2015.08.035

## Examples

``` r
library(CVrisk)
chd_10y_mesa(
  race = "aa", gender = "male", age = 55,
  totchol = 213, hdl = 50, sbp = 140, lipid_med = 0,
  bp_med = 1, smoker = 0, diabetes = 0, fh_heartattack = 0
)
#> [1] 5.33
```
