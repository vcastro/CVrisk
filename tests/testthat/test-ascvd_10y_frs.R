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
