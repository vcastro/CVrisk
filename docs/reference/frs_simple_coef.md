# Model coefficients for ASCVD 10y FRS simple model

A data set containing the Framingham risk score coefficients (simple
model without lab features)

## Usage

``` r
frs_simple_coef
```

## Format

A data frame with 2 obs. and 10 variables:

- gender:

  Patient gender, either female or male

- ln_age:

  Natural log of patient age (years)

- ln_bmi:

  Natural log of body mass index kg/m2

- ln_untreated_sbp:

  Natural log of untreated systolic blood pressure

- ln_treated_sbp:

  Natural log of treated systolic blood pressure

- smoker:

  Smoking status

- diabetes:

  Diabetes status

- group_mean:

  Grouped mean

- baseline_survival:

  Baseline survival

## References

D’agostino, R.B., Vasan, R.S., Pencina, M.J., Wolf, P.A., Cobain, M.,
Massaro, J.M. and Kannel, W.B., 2008. General cardiovascular risk
profile for use in primary care. Circulation, 117(6), pp.743-753.
