library(tibble)

input_df <- as.data.frame(tribble(
  ~age, ~gender, ~race, ~BMI, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes,
  55, "male", "white", 30, 140, 50, 213, 0, 0, 0,
  45, "female", "white", 27, 125, 50, 200, 1, 0, 0,
  45, "female", "white", 27, 125, 50, 200, NA, 0, 0,
  NA, "male", "aa", 30, 130, 50, 215, 0, 0, 0,
))

output_df <- cbind(input_df, as.data.frame(tribble(
  ~ascvd_10y_accaha, ~ascvd_10y_frs, ~ascvd_10y_frs_simple,
    ~ascvd_10y_prevent, ~ascvd_10y_prevent_bmi,
    ~ascvd_30y_prevent, ~ascvd_30y_prevent_bmi,
    ~chd_10y_mesa, ~chd_10y_mesa_cac,
  7.01, 13.53, 16.75, 1.01, 3.58, 5.06, 17.06, NA_real_, NA_real_,
  1.22, 4.68, 4.91, 1.48, 6.15, 6.37, 24.90, NA_real_, NA_real_,
  NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_,
  NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_,
)))

test_that("compute_CVrisk returns correct data frame", {
  expect_equal(
    compute_CVrisk(
      input_df,
      age = "age",
      race = "race",
      gender = "gender",
      bmi = "BMI",
      sbp = "sbp",
      hdl = "hdl",
      totchol = "totchol",
      bp_med = "bp_med",
      smoker = "smoker",
      diabetes = "diabetes"
    ),
    output_df
  )
})
