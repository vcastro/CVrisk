test_that("prevent female example from preventr docs is correct", {
  # Example from preventr documentation
  # https://github.com/martingmayer/preventr
  # Expected 10-year ASCVD risk: 0.092 (9.2%)
  result <- prevent_10y_base(
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
  result <- prevent_10y_base(
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
  result <- prevent_10y_base(
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
  result <- prevent_10y_base(
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
  result2 <- prevent_10y_base(
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
  result <- prevent_10y_base(
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

test_that("prevent handles gender abbreviations", {
  # Test 'f' abbreviation
  result_f <- prevent_10y_base(
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
  result_m <- prevent_10y_base(
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
