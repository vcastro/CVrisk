test_that("30y ascvd prevent base female from preventr docs is correct", {
  # Example from preventr documentation
  # https://github.com/martingmayer/preventr
  # Expected 30-year ASCVD risk: 0.353 (35.4%)
  result <- ascvd_30y_prevent_base(
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
  expect_equal(result, 35.4)
})

test_that("ascvd 30y prevent base male example is correct", {
  result <- ascvd_30y_prevent_base(
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

test_that("ascvd 30y prevent base handles missing required parameters", {
  # Missing age should return NA
  result <- ascvd_30y_prevent_base(
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

test_that("ascvd 30y prevent base handles invalid age", {
  # Age out of range (< 30)
  result <- ascvd_30y_prevent_base(
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
  result2 <- ascvd_30y_prevent_base(
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

test_that("ascvd 30y prevent base handles invalid cholesterol values", {
  # Invalid total cholesterol
  result <- ascvd_30y_prevent_base(
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

test_that("ascvd 30y prevent base handles gender abbreviations", {
  # Test 'f' abbreviation
  result_f <- ascvd_30y_prevent_base(
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
  result_m <- ascvd_30y_prevent_base(
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
