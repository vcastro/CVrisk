test_that("MESA (no CAC): 70yo male example is correct", {
  expect_equal(
    chd_10y_mesa(
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
      fh_heartattack = 0
    ),
    8.61
  )
})

test_that("MESA (no CAC): white male example", {
  result <- chd_10y_mesa(
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
    fh_heartattack = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (no CAC): chinese female example", {
  result <- chd_10y_mesa(
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
    fh_heartattack = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (no CAC): aa female example", {
  result <- chd_10y_mesa(
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
    fh_heartattack = 0
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (no CAC): missing race throws error", {
  expect_error(
    chd_10y_mesa(
      gender = "male",
      age = 70,
      sbp = 130,
      hdl = 50,
      totchol = 190,
      bp_med = 1,
      lipid_med = 0,
      smoker = 0,
      diabetes = 0,
      fh_heartattack = 0
    ),
    "race must be either"
  )
})

test_that("MESA (no CAC): missing gender throws error", {
  expect_error(
    chd_10y_mesa(
      age = 70,
      race = "hispanic",
      sbp = 130,
      hdl = 50,
      totchol = 190,
      bp_med = 1,
      lipid_med = 0,
      smoker = 0,
      diabetes = 0,
      fh_heartattack = 0
    ),
    "gender must be either"
  )
})

test_that("MESA (no CAC): missing age throws error", {
  expect_error(
    chd_10y_mesa(
      gender = "male",
      race = "hispanic",
      sbp = 130,
      hdl = 50,
      totchol = 190,
      bp_med = 1,
      lipid_med = 0,
      smoker = 0,
      diabetes = 0,
      fh_heartattack = 0
    ),
    'argument "age" is missing'
  )
})

test_that("MESA (no CAC): missing totchol throws error", {
  expect_error(
    chd_10y_mesa(
      gender = "male",
      age = 70,
      race = "hispanic",
      sbp = 130,
      hdl = 50,
      bp_med = 1,
      lipid_med = 0,
      smoker = 0,
      diabetes = 0,
      fh_heartattack = 0
    ),
    "totchol must be a valid numeric value"
  )
})

test_that("MESA (no CAC): with diabetes and smoker", {
  result <- chd_10y_mesa(
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
    fh_heartattack = 1
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})

test_that("MESA (no CAC): with family history", {
  result <- chd_10y_mesa(
    gender = "female",
    age = 60,
    race = "hispanic",
    sbp = 140,
    hdl = 45,
    totchol = 230,
    bp_med = 0,
    lipid_med = 0,
    smoker = 0,
    diabetes = 0,
    fh_heartattack = 1
  )
  expect_true(is.numeric(result))
  expect_false(is.na(result))
  expect_true(result >= 1)
})
