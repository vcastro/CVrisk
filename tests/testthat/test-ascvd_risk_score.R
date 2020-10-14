test_that("aa male example is correct", {
  expect_equal(
    ascvd_risk_score(
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
    ascvd_risk_score(
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
    ascvd_risk_score(
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
    ascvd_risk_score(
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
