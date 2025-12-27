library(tibble)

input_df <- as.data.frame(tribble(
  ~age, ~gender, ~race, ~BMI, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes, ~egfr, ~uacr,
  55, "male", "white", 30, 140, 50, 213, 0, 0, 0, 90, 10,
  45, "female", "white", 27, 125, 50, 200, 1, 0, 0, 95, 5,
  45, "female", "white", 27, 125, 50, 200, NA, 0, 0, NA, NA,
  NA, "male", "aa", 30, 130, 50, 215, 0, 0, 0, 85, 15,
))

output_df <- cbind(input_df, as.data.frame(tribble(
  ~ascvd_10y_accaha, ~ascvd_10y_frs, ~ascvd_10y_frs_simple,
    ~ascvd_10y_prevent, ~ascvd_10y_prevent_bmi,
    ~ascvd_30y_prevent, ~ascvd_30y_prevent_bmi,
    ~chd_10y_mesa, ~chd_10y_mesa_cac,
  7.01, 13.53, 16.75, 1.01, 3.59, 5.08, 17.11, NA_real_, NA_real_,
  1.22, 4.68, 4.91, 1.45, 6.01, 6.26, 24.47, NA_real_, NA_real_,
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
      diabetes = "diabetes",
      egfr = "egfr",
      uacr = "uacr"
    ),
    output_df
  )
})
