test_that("male example is correct", {
  expect_equal(
    ascvd_30y_prevent(
      gender = "male",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    5.06
  )
})

test_that("female example is correct", {
  expect_equal(
    ascvd_30y_prevent(
      gender = "female",
      age = 55,
      totchol = 213,
      hdl = 50,
      sbp = 140,
      bp_med = 0,
      smoker = 0,
      diabetes = 0
    ),
    6.12
  )
})

test_that("with egfr and uacr parameters", {
  result <- ascvd_30y_prevent(
    gender = "male",
    age = 55,
    totchol = 213,
    hdl = 50,
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
    ascvd_30y_prevent(
      gender = "male",
      age = 80,
      totchol = 190,
      hdl = 50,
      sbp = 120,
      bp_med = 0,
      smoker = 1,
      diabetes = 0
    )
  ))
})
