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


test_that("compute_CVrisk throws error", {
  expect_error(
    ascvd_10y_accaha(
      race = "aa",
      gender = "female",
      age = 60,
      totchol = 9999,
      hdl = 50,
      sbp = 120,
      bp_med = 0,
      smoker = 1,
      diabetes = 0))
})
