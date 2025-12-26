test_that("male example is correct", {
  expect_equal(
    ascvd_30y_prevent_bmi(
      gender = "male",
      age = 55,
      bmi = 30,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    17.06
  )
})

test_that("female example is correct", {
  expect_equal(
    ascvd_30y_prevent_bmi(
      gender = "female",
      age = 55,
      bmi = 30,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    24.82
  )
})

test_that("with egfr and uacr parameters", {
  result <- ascvd_30y_prevent_bmi(
    gender = "male",
    age = 55,
    bmi = 30,
    sbp = 140,
    bp_med = 0,
    smoker = 0,
    diabetes = 0,
    egfr = 85,
    uacr = 10
  )
  expect_true(is.numeric(result))
  expect_true(result > 0)
})

test_that("out of range age returns NA", {
  expect_true(is.na(
    ascvd_30y_prevent_bmi(
      gender = "male",
      age = 80,
      bmi = 30,
      sbp = 120,
      bp_med = 0,
      smoker = 1,
      diabetes = 0
    )
  ))
})
