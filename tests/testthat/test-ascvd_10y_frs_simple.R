test_that("FRS-simple: 55yo male example is correct", {
  expect_equal(
    ascvd_10y_frs_simple(
      gender = "male",
      age = 55,
      bmi = 30,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    16.75
  )
})

test_that("FRS-simple: 45yo female example is correct", {
  result <- ascvd_10y_frs_simple(
    gender = "female",
    age = 45,
    bmi = 27,
    sbp = 125,
    bp_med = 1,
    smoker = 0,
    diabetes = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("FRS-simple: age below 30 returns NA", {
  expect_true(is.na(
    ascvd_10y_frs_simple(
      gender = "male",
      age = 29,
      bmi = 30,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS-simple: age above 74 returns NA", {
  expect_true(is.na(
    ascvd_10y_frs_simple(
      gender = "male",
      age = 75,
      bmi = 30,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS-simple: missing age throws error", {
  expect_error(
    ascvd_10y_frs_simple(
      gender = "male",
      bmi = 30,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    'argument "age" is missing'
  )
})

test_that("FRS-simple: invalid gender throws error", {
  expect_error(
    ascvd_10y_frs_simple(
      gender = "unknown",
      age = 55,
      bmi = 30,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    "gender must be either 'male' or 'female'"
  )
})

test_that("FRS-simple: gender abbreviation 'm' works", {
  result <- ascvd_10y_frs_simple(
    gender = "m",
    age = 55,
    bmi = 30,
    sbp = 140,
    bp_med = 0,
    smoker = 0,
    diabetes = 0
  )
  expect_equal(result, 16.75)
})

test_that("FRS-simple: gender abbreviation 'f' works", {
  result <- ascvd_10y_frs_simple(
    gender = "f",
    age = 55,
    bmi = 30,
    sbp = 140,
    bp_med = 0,
    smoker = 0,
    diabetes = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
})

test_that("FRS-simple: missing bmi returns NA", {
  expect_true(is.na(
    ascvd_10y_frs_simple(
      gender = "male",
      age = 55,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS-simple: missing sbp returns NA", {
  expect_true(is.na(
    ascvd_10y_frs_simple(
      gender = "male",
      age = 55,
      bmi = 30,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS-simple: missing bp_med returns NA", {
  expect_true(is.na(
    ascvd_10y_frs_simple(
      gender = "male",
      age = 55,
      bmi = 30,
      sbp = 140,
      smoker = 0,
      diabetes = 0
    )
  ))
})

test_that("FRS-simple: with diabetes and smoker", {
  result <- ascvd_10y_frs_simple(
    gender = "female",
    age = 60,
    bmi = 35,
    sbp = 160,
    bp_med = 1,
    smoker = 1,
    diabetes = 1
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("FRS-simple: risk capped at 30", {
  result <- ascvd_10y_frs_simple(
    gender = "male",
    age = 70,
    bmi = 40,
    sbp = 180,
    bp_med = 0,
    smoker = 1,
    diabetes = 1
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result <= 30)
})
