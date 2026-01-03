test_that("prevent female example from preventr docs is correct", {
  # Example from preventr documentation
  # https://github.com/martingmayer/preventr
  # Expected 10-year ASCVD risk: 0.092 (9.2%)
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  # preventr returns proportions, we convert to percentages
  # Expected: 0.092 * 100 = 9.2
  expect_equal(result, 9.2)
})

test_that("prevent male example is correct", {
  result <- ascvd_10y_prevent(
    gender = "male",
    age = 55,
    sbp = 140,
    bp_med = 0,
    totchol = 213,
    hdl = 50,
    statin = 0,
    diabetes = 0,
    smoker = 0,
    egfr = 90,
    bmi = 30
  )
  
  # Should return a numeric value
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("prevent handles missing required parameters", {
  # Missing age should return NA
  result <- ascvd_10y_prevent(
    gender = "female",
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
})

test_that("prevent handles invalid age", {
  # Age out of range (< 30)
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 25,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
  
  # Age out of range (> 79)
  result2 <- ascvd_10y_prevent(
    gender = "female",
    age = 85,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result2))
})

test_that("prevent handles invalid cholesterol values", {
  # Invalid total cholesterol
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 9999,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
})

test_that("prevent handles invalid sbp", {
  # SBP out of range (< 90)
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 80,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
  
  # SBP out of range (> 180)
  result2 <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 200,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result2))
})

test_that("prevent handles invalid hdl", {
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 150,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
})

test_that("prevent handles invalid egfr", {
  # eGFR out of range (< 15)
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 10,
    bmi = 35
  )
  
  expect_true(is.na(result))
  
  # eGFR out of range (> 140)
  result2 <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 150,
    bmi = 35
  )
  
  expect_true(is.na(result2))
})

test_that("prevent handles invalid bmi", {
  # BMI out of range (< 18.5)
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 15
  )
  
  expect_true(is.na(result))
  
  # BMI out of range (> 39.9)
  result2 <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 45
  )
  
  expect_true(is.na(result2))
})

test_that("prevent handles missing sbp", {
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
})

test_that("prevent handles missing bp_med", {
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
})

test_that("prevent handles missing statin", {
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
})

test_that("prevent handles invalid gender", {
  expect_error(
    ascvd_10y_prevent(
      gender = "unknown",
      age = 50,
      sbp = 160,
      bp_med = 1,
      totchol = 200,
      hdl = 45,
      statin = 0,
      diabetes = 1,
      smoker = 0,
      egfr = 90,
      bmi = 35
    ),
    "gender must be either 'male' or 'female'"
  )
})

test_that("prevent with statin = 1", {
  result <- ascvd_10y_prevent(
    gender = "male",
    age = 60,
    sbp = 150,
    bp_med = 1,
    totchol = 180,
    hdl = 45,
    statin = 1,
    diabetes = 0,
    smoker = 0,
    egfr = 85,
    bmi = 32
  )
  
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("prevent with smoker = 1", {
  result <- ascvd_10y_prevent(
    gender = "male",
    age = 55,
    sbp = 140,
    bp_med = 0,
    totchol = 213,
    hdl = 50,
    statin = 0,
    diabetes = 0,
    smoker = 1,
    egfr = 90,
    bmi = 30
  )
  
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("prevent handles gender abbreviations", {
  # Test 'f' abbreviation
  result_f <- ascvd_10y_prevent(
    gender = "f",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_false(is.na(result_f))
  
  # Test 'm' abbreviation
  result_m <- ascvd_10y_prevent(
    gender = "m",
    age = 55,
    sbp = 140,
    bp_med = 0,
    totchol = 213,
    hdl = 50,
    statin = 0,
    diabetes = 0,
    smoker = 0,
    egfr = 90,
    bmi = 30
  )
  
  expect_false(is.na(result_m))
})

test_that("prevent with model parameter base works", {
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35,
    model = "base"
  )
  
  # Should match the same result as the default auto with no optional params
  expect_equal(result, 9.2)
})

test_that("prevent with model parameter auto works", {
  result <- ascvd_10y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35,
    model = "auto"
  )
  
  # Should work and return valid result
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_equal(result, 9.2)
})

test_that("prevent with optional hba1c parameter works", {
  result <- ascvd_10y_prevent(
    gender = "male",
    age = 55,
    sbp = 140,
    bp_med = 0,
    totchol = 213,
    hdl = 50,
    statin = 0,
    diabetes = 0,
    smoker = 0,
    egfr = 90,
    bmi = 30,
    hba1c = 6.5
  )
  
  # Should work with hba1c
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("prevent with optional uacr parameter works", {
  result <- ascvd_10y_prevent(
    gender = "male",
    age = 55,
    sbp = 140,
    bp_med = 0,
    totchol = 213,
    hdl = 50,
    statin = 0,
    diabetes = 0,
    smoker = 0,
    egfr = 90,
    bmi = 30,
    uacr = 25
  )
  
  # Should work with uacr
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("ascvd_30y_prevent female example works", {
  result <- ascvd_30y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  # Should return a valid 30-year risk
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("ascvd_30y_prevent male example works", {
  result <- ascvd_30y_prevent(
    gender = "male",
    age = 45,
    sbp = 130,
    bp_med = 0,
    totchol = 200,
    hdl = 50,
    statin = 0,
    diabetes = 0,
    smoker = 1,
    egfr = 95,
    bmi = 28
  )
  
  # Should return a numeric value
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("ascvd_30y_prevent with model parameter base works", {
  result <- ascvd_30y_prevent(
    gender = "female",
    age = 50,
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35,
    model = "base"
  )
  
  # Should work with explicit base model
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 0 && result <= 100)
})

test_that("ascvd_30y_prevent handles missing age", {
  result <- ascvd_30y_prevent(
    gender = "female",
    sbp = 160,
    bp_med = 1,
    totchol = 200,
    hdl = 45,
    statin = 0,
    diabetes = 1,
    smoker = 0,
    egfr = 90,
    bmi = 35
  )
  
  expect_true(is.na(result))
})

test_that("ascvd_30y_prevent handles invalid gender", {
  expect_error(
    ascvd_30y_prevent(
      gender = "unknown",
      age = 50,
      sbp = 160,
      bp_med = 1,
      totchol = 200,
      hdl = 45,
      statin = 0,
      diabetes = 1,
      smoker = 0,
      egfr = 90,
      bmi = 35
    ),
    "gender must be either 'male' or 'female'"
  )
})
