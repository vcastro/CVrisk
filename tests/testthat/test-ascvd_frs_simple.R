test_that("FRS-simple: 55yo male example is correct", {
  expect_equal(
    ascvd_frs_simple(
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