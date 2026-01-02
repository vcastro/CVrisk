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
    scores = c("ascvd_10y_prevent"),
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
  expect_true("ascvd_10y_prevent" %in% colnames(result))
  expect_equal(nrow(result), 2)
  
  # Check that PREVENT scores are numeric and in valid range
  expect_true(is.numeric(result$ascvd_10y_prevent))
  expect_false(any(is.na(result$ascvd_10y_prevent)))
  expect_true(all(result$ascvd_10y_prevent >= 0 & result$ascvd_10y_prevent <= 100))
})

test_that("compute_CVrisk uses lipid_med as statin when statin not provided", {
  # Create test data using lipid_med instead of statin
  input_df_lipid <- as.data.frame(tribble(
    ~age, ~gender, ~race, ~BMI, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes, ~lipid_med, ~egfr,
    50, "female", "white", 35, 160, 45, 200, 1, 0, 1, 0, 90
  ))
  
  result <- compute_CVrisk(
    input_df_lipid,
    scores = c("ascvd_10y_prevent"),
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
  expect_true("ascvd_10y_prevent" %in% colnames(result))
  expect_false(is.na(result$ascvd_10y_prevent))
})

test_that("compute_CVrisk handles single score", {
  input_df_single <- as.data.frame(tribble(
    ~age, ~gender, ~race, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes,
    55, "male", "white", 140, 50, 213, 0, 0, 0
  ))
  
  result <- compute_CVrisk(
    input_df_single,
    scores = "ascvd_10y_accaha",
    age = "age",
    race = "race",
    gender = "gender",
    sbp = "sbp",
    hdl = "hdl",
    totchol = "totchol",
    bp_med = "bp_med",
    smoker = "smoker",
    diabetes = "diabetes"
  )
  
  expect_true("ascvd_10y_accaha" %in% colnames(result))
  expect_equal(nrow(result), 1)
  expect_false(is.na(result$ascvd_10y_accaha))
})

test_that("compute_CVrisk preserves original data frame columns", {
  input_df_orig <- as.data.frame(tribble(
    ~patient_id, ~age, ~gender, ~race, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes,
    "001", 55, "male", "white", 140, 50, 213, 0, 0, 0
  ))
  
  result <- compute_CVrisk(
    input_df_orig,
    scores = "ascvd_10y_accaha",
    age = "age",
    race = "race",
    gender = "gender",
    sbp = "sbp",
    hdl = "hdl",
    totchol = "totchol",
    bp_med = "bp_med",
    smoker = "smoker",
    diabetes = "diabetes"
  )
  
  expect_true("patient_id" %in% colnames(result))
  expect_equal(result$patient_id, "001")
  expect_true("ascvd_10y_accaha" %in% colnames(result))
})

test_that("compute_CVrisk works with multiple rows", {
  input_df_multi <- as.data.frame(tribble(
    ~age, ~gender, ~race, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes,
    55, "male", "white", 140, 50, 213, 0, 0, 0,
    60, "female", "aa", 150, 45, 230, 1, 1, 1,
    50, "male", "white", 130, 55, 190, 0, 0, 0
  ))
  
  result <- compute_CVrisk(
    input_df_multi,
    scores = "ascvd_10y_accaha",
    age = "age",
    race = "race",
    gender = "gender",
    sbp = "sbp",
    hdl = "hdl",
    totchol = "totchol",
    bp_med = "bp_med",
    smoker = "smoker",
    diabetes = "diabetes"
  )
  
  expect_equal(nrow(result), 3)
  expect_true(all(!is.na(result$ascvd_10y_accaha)))
})
