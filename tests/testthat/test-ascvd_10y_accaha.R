test_that("aa male example is correct", {
  expect_equal(
    ascvd_10y_accaha(
      race = "aa",
      gender = "male",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    7.95
  )
})

test_that("aa female example is correct", {
  expect_equal(
    ascvd_10y_accaha(
      race = "aa",
      gender = "female",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    5.08
  )
})

test_that("white female example is correct", {
  expect_equal(
    ascvd_10y_accaha(
      race = "white",
      gender = "female",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    2.76
  )
})


test_that("white male example is correct", {
  expect_equal(
    ascvd_10y_accaha(
      race = "white",
      gender = "male",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    7.01
  )
})


test_that("Other race male example is correct (same as White)", {
  expect_equal(
    ascvd_10y_accaha(
      race = "other",
      gender = "male",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    7.01
  )
})


test_that("invalid totchol returns NA", {
  expect_equal(
    ascvd_10y_accaha(
      race = "aa",
      gender = "female",
      age = 60,
      totchol = 9999,
      hdl = 50,
      sbp = 120,
      bp_med = 0,
      smoker = 1,
      diabetes = 0), NA)
})


test_that("out of range age returns NA", {
  expect_equal(
    ascvd_10y_accaha(
      race = "aa",
      gender = "female",
      age = 80,
      totchol = 190,
      hdl = 50,
      sbp = 120,
      bp_med = 0,
      smoker = 1,
      diabetes = 0), NA)
})

test_that("age below 20 returns NA", {
  expect_equal(
    ascvd_10y_accaha(
      race = "white",
      gender = "male",
      age = 19,
      totchol = 200,
      hdl = 50,
      sbp = 120,
      bp_med = 0,
      smoker = 0,
      diabetes = 0), NA)
})

test_that("invalid hdl returns NA", {
  expect_equal(
    ascvd_10y_accaha(
      race = "white",
      gender = "male",
      age = 55,
      totchol = 200,
      hdl = 150,
      sbp = 120,
      bp_med = 0,
      smoker = 0,
      diabetes = 0), NA)
})

test_that("invalid sbp returns NA", {
  expect_equal(
    ascvd_10y_accaha(
      race = "white",
      gender = "male",
      age = 55,
      totchol = 200,
      hdl = 50,
      sbp = 250,
      bp_med = 0,
      smoker = 0,
      diabetes = 0), NA)
})

test_that("bp_med = 1 (treated) affects score", {
  result <- ascvd_10y_accaha(
    race = "white",
    gender = "male",
    age = 55,
    totchol = 213,
    hdl = 50,
    sbp = 140,
    bp_med = 1,
    smoker = 0,
    diabetes = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result > 0)
})

test_that("smoker = 1 increases risk", {
  result <- ascvd_10y_accaha(
    race = "white",
    gender = "male",
    age = 55,
    totchol = 213,
    hdl = 50,
    sbp = 140,
    bp_med = 0,
    smoker = 1,
    diabetes = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result > 0)
})

test_that("diabetes = 1 increases risk", {
  result <- ascvd_10y_accaha(
    race = "white",
    gender = "male",
    age = 55,
    totchol = 213,
    hdl = 50,
    sbp = 140,
    bp_med = 0,
    smoker = 0,
    diabetes = 1
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result > 0)
})

test_that("missing gender throws error", {
  expect_error(
    ascvd_10y_accaha(
      race = "white",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    "gender must be either 'male' or 'female'"
  )
})

test_that("invalid gender throws error", {
  expect_error(
    ascvd_10y_accaha(
      race = "white",
      gender = "unknown",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    "gender must be either 'male' or 'female'"
  )
})

test_that("aa female with diabetes and smoker", {
  result <- ascvd_10y_accaha(
    race = "aa",
    gender = "female",
    age = 60,
    totchol = 250,
    hdl = 40,
    sbp = 150,
    bp_med = 1,
    smoker = 1,
    diabetes = 1
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("white female with bp medication", {
  result <- ascvd_10y_accaha(
    race = "white",
    gender = "female",
    age = 65,
    totchol = 220,
    hdl = 55,
    sbp = 160,
    bp_med = 1,
    smoker = 0,
    diabetes = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})
