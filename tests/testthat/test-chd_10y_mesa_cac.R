test_that("MESA (with CAC): 70yo male example is correct", {
  expect_equal(
    chd_10y_mesa_cac(
      gender = "male",
      age = 70,
      race = "hispanic",
      sbp = 130,
      hdl = 50,
      totchol = 190,
      bp_med = 1,
      lipid_med = 0,
      smoker = 0,
      diabetes = 0,
      fh_heartattack = 0,
      cac = 0
    ),
    3.06
  )
})
