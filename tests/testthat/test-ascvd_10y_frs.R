test_that("FRS: 55yo male example is correct", {
  expect_equal(
    ascvd_10y_frs(
      gender = "male",
      age = 55,
      sbp = 140,
      hdl = 50,
      totchol = 213,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    13.53
  )
})

test_that("FRS: 45yo female example is correct", {
  result <- ascvd_10y_frs(
    gender = "female",
    age = 45,
    sbp = 125,
    hdl = 50,
    totchol = 200,
    bp_med = 1,
    smoker = 0,
    diabetes = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("FRS: age below 30 returns NA", {
  expect_true(is.na(
    ascvd_10y_frs(
      gender = "male",
      age = 29,
      sbp = 140,
      hdl = 50,
      totchol = 213,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS: age above 74 returns NA", {
  expect_true(is.na(
    ascvd_10y_frs(
      gender = "male",
      age = 75,
      sbp = 140,
      hdl = 50,
      totchol = 213,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS: missing age throws error", {
  expect_error(
    ascvd_10y_frs(
      gender = "male",
      sbp = 140,
      hdl = 50,
      totchol = 213,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    'argument "age" is missing'
  )
})

test_that("FRS: invalid gender throws error", {
  expect_error(
    ascvd_10y_frs(
      gender = "unknown",
      age = 55,
      sbp = 140,
      hdl = 50,
      totchol = 213,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    "gender must be either 'male' or 'female'"
  )
})

test_that("FRS: gender abbreviation 'm' works", {
  result <- ascvd_10y_frs(
    gender = "m",
    age = 55,
    sbp = 140,
    hdl = 50,
    totchol = 213,
    bp_med = 0,
    smoker = 0,
    diabetes = 0
  )
  expect_equal(result, 13.53)
})

test_that("FRS: gender abbreviation 'f' works", {
  result <- ascvd_10y_frs(
    gender = "f",
    age = 55,
    sbp = 140,
    hdl = 50,
    totchol = 213,
    bp_med = 0,
    smoker = 0,
    diabetes = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
})

test_that("FRS: missing hdl returns NA", {
  expect_true(is.na(
    ascvd_10y_frs(
      gender = "male",
      age = 55,
      sbp = 140,
      totchol = 213,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS: missing totchol returns NA", {
  expect_true(is.na(
    ascvd_10y_frs(
      gender = "male",
      age = 55,
      sbp = 140,
      hdl = 50,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS: missing sbp returns NA", {
  expect_true(is.na(
    ascvd_10y_frs(
      gender = "male",
      age = 55,
      hdl = 50,
      totchol = 213,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS: missing bp_med returns NA", {
  expect_true(is.na(
    ascvd_10y_frs(
      gender = "male",
      age = 55,
      sbp = 140,
      hdl = 50,
      totchol = 213,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS: with diabetes and smoker", {
  result <- ascvd_10y_frs(
    gender = "female",
    age = 60,
    sbp = 160,
    hdl = 40,
    totchol = 250,
    bp_med = 1,
    smoker = 1,
    diabetes = 1
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})
