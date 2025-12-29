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
    ~chd_10y_mesa, ~chd_10y_mesa_cac,
  7.01, 13.53, 16.75, NA_real_, NA_real_,
  1.22, 4.68, 4.91, NA_real_, NA_real_,
  NA_real_, NA_real_, NA_real_, NA_real_, NA_real_,
  NA_real_, NA_real_, NA_real_, NA_real_, NA_real_,
)))

test_that("compute_CVrisk returns correct data frame", {
  expect_equal(
    compute_CVrisk(
      input_df,
      scores = c("ascvd_10y_accaha", "ascvd_10y_frs", "ascvd_10y_frs_simple",
                 "chd_10y_mesa", "chd_10y_mesa_cac"),
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

test_that("compute_CVrisk works with PREVENT scores", {
  # Create test data with all required columns for PREVENT
  input_df_prevent <- as.data.frame(tribble(
    ~age, ~gender, ~race, ~BMI, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes, ~statin, ~egfr,
    50, "female", "white", 35, 160, 45, 200, 1, 0, 1, 0, 90,
    55, "male", "white", 30, 140, 50, 213, 0, 0, 0, 0, 90
  ))
  
  result <- compute_CVrisk(
    input_df_prevent,
    scores = c("prevent_10y_base"),
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
    statin = "statin",
    egfr = "egfr"
  )
  
  # Check that result is returned and contains expected columns
  expect_true("prevent_10y_base" %in% colnames(result))
  expect_equal(nrow(result), 2)
  
  # Check that PREVENT scores are numeric and in valid range
  expect_true(is.numeric(result$prevent_10y_base))
  expect_false(any(is.na(result$prevent_10y_base)))
  expect_true(all(result$prevent_10y_base >= 0 & result$prevent_10y_base <= 100))
})

test_that("compute_CVrisk uses lipid_med as statin when statin not provided", {
  # Create test data using lipid_med instead of statin
  input_df_lipid <- as.data.frame(tribble(
    ~age, ~gender, ~race, ~BMI, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes, ~lipid_med, ~egfr,
    50, "female", "white", 35, 160, 45, 200, 1, 0, 1, 0, 90
  ))
  
  result <- compute_CVrisk(
    input_df_lipid,
    scores = c("prevent_10y_base"),
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
    lipid_med = "lipid_med",
    egfr = "egfr"
  )
  
  # Check that result is returned successfully
  expect_true("prevent_10y_base" %in% colnames(result))
  expect_false(is.na(result$prevent_10y_base))
})
