# Model coefficients for ASCVD 10y ACC/AHA model

A data set containing the 2013 ACC/AHA ASCVD 10-year risk pooled cohort
coefficients

## Usage

``` r
ascvd_pooled_coef
```

## Format

A data frame with 4 obs. and 17 variables:

- race:

  Patient race, either white or aa

- gender:

  Patient gender, either female or male

- ln_age:

  Natural log of patient age

- ln_age_squared:

  Natural log of patient age in years, squared

- ln_totchol:

  Natural log of total cholesterol level

- ln_age_totchol:

  Natural log of combined age and total cholesterol

- ln_hdl:

  Natural log of HDL level

- ln_age_hdl:

  Natural log of HDL and age

- ln_treated_sbp:

  Natural log of treated systolic blood pressure

- ln_age_treated_sbp:

  Natural log of treated systolic blood pressure and age

- ln_untreated_sbp:

  Natural log of untreated systolic blood pressure

- ln_age_untreated_sbp:

  Natural log of untreated systolic blood pressure and age

- smoker:

  Smoking status

- ln_age_smoker:

  Natural log of smoking status and age

- diabetes:

  Diabetes status

- group_mean:

  Grouped mean

- baseline_survival:

  Baseline survival

## References

Goff, David C., et al. "2013 ACC/AHA guideline on the assessment of
cardiovascular risk: a report of the American College of
Cardiology/American Heart Association Task Force on Practice
Guidelines." Journal of the American College of Cardiology 63.25 Part B
(2014): 2935-2959.
