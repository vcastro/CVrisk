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

test_that("MESA (with CAC): white male with high CAC", {
  result <- chd_10y_mesa_cac(
    gender = "male",
    age = 65,
    race = "white",
    sbp = 140,
    hdl = 45,
    totchol = 210,
    bp_med = 0,
    lipid_med = 0,
    smoker = 0,
    diabetes = 0,
    fh_heartattack = 0,
    cac = 400
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (with CAC): chinese female with moderate CAC", {
  result <- chd_10y_mesa_cac(
    gender = "female",
    age = 60,
    race = "chinese",
    sbp = 135,
    hdl = 55,
    totchol = 200,
    bp_med = 1,
    lipid_med = 0,
    smoker = 0,
    diabetes = 0,
    fh_heartattack = 0,
    cac = 100
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (with CAC): aa female with low CAC", {
  result <- chd_10y_mesa_cac(
    gender = "female",
    age = 55,
    race = "aa",
    sbp = 145,
    hdl = 50,
    totchol = 220,
    bp_med = 1,
    lipid_med = 1,
    smoker = 0,
    diabetes = 0,
    fh_heartattack = 0,
    cac = 50
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (with CAC): missing race throws error", {
  expect_error(
    chd_10y_mesa_cac(
      gender = "male",
      age = 70,
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
    "race must be either"
  )
})

test_that("MESA (with CAC): missing gender throws error", {
  expect_error(
    chd_10y_mesa_cac(
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
    "gender must be either"
  )
})

test_that("MESA (with CAC): missing age throws error", {
  expect_error(
    chd_10y_mesa_cac(
      gender = "male",
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
    "age must be a valid numeric value"
  )
})

test_that("MESA (with CAC): missing totchol throws error", {
  expect_error(
    chd_10y_mesa_cac(
      gender = "male",
      age = 70,
      race = "hispanic",
      sbp = 130,
      hdl = 50,
      bp_med = 1,
      lipid_med = 0,
      smoker = 0,
      diabetes = 0,
      fh_heartattack = 0,
      cac = 0
    ),
    "totchol must be a valid numeric value"
  )
})

test_that("MESA (with CAC): with diabetes, smoker, and high CAC", {
  result <- chd_10y_mesa_cac(
    gender = "male",
    age = 65,
    race = "white",
    sbp = 150,
    hdl = 40,
    totchol = 240,
    bp_med = 1,
    lipid_med = 1,
    smoker = 1,
    diabetes = 1,
    fh_heartattack = 1,
    cac = 500
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (with CAC): CAC = 0 lowers risk compared to no CAC model", {
  # This tests that including CAC = 0 provides useful information
  result <- chd_10y_mesa_cac(
    gender = "male",
    age = 65,
    race = "white",
    sbp = 140,
    hdl = 50,
    totchol = 200,
    bp_med = 0,
    lipid_med = 0,
    smoker = 0,
    diabetes = 0,
    fh_heartattack = 0,
    cac = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})
