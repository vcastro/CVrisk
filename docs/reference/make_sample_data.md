# Generate sample cardiovascular risk data

Creates a data frame with randomly generated patient data suitable for
testing cardiovascular risk calculations. The function generates
realistic ranges for all standard cardiovascular risk factors.

## Usage

``` r
make_sample_data(n = 100)
```

## Arguments

- n:

  Number of rows to generate (default: 100)

## Value

A data frame with `n` rows and the following columns:

- id:

  Sequential patient identifier (1 to n)

- age:

  Patient age in years (30-79)

- sex:

  Sex at birth ("female" or "male")

- race:

  Patient race ("white", "aa", or "other")

- sbp:

  Systolic blood pressure in mm Hg (90-200)

- bp_med:

  Blood pressure medication status (TRUE/FALSE)

- totchol:

  Total cholesterol in mg/dL (130-320)

- hdl:

  HDL cholesterol in mg/dL (20-100)

- lipid_med:

  Lipid medication status (TRUE/FALSE)

- diabetes:

  Diabetes status (TRUE/FALSE)

- smoker:

  Smoking status (TRUE/FALSE)

- egfr:

  Estimated glomerular filtration rate in mL/min/1.73m2 (15-140)

- bmi:

  Body mass index in kg/m2 (18.5-39.9)

- hba1c:

  Hemoglobin A1c percentage (4.5-15.0 or NA)

- uacr:

  Urine albumin-to-creatinine ratio in mg/g (0.1-25000 or NA)

- zip:

  ZIP code (30 valid codes or NA)

## Examples

``` r
library(CVrisk)
# Generate default 100 rows
sample_data <- make_sample_data()

# Generate 50 rows
sample_data_50 <- make_sample_data(n = 50)

# Use with compute_CVrisk
if (FALSE) { # \dontrun{
data <- make_sample_data(n = 10)
result <- compute_CVrisk(
  data,
  scores = "ascvd_10y_accaha",
  age = "age",
  gender = "sex",
  race = "race",
  sbp = "sbp",
  totchol = "totchol",
  hdl = "hdl",
  bp_med = "bp_med",
  smoker = "smoker",
  diabetes = "diabetes"
)
} # }
```
