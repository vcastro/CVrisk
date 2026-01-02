test_that("sample_data exists and has correct structure", {
  data(sample_data, package = "CVrisk")
  expect_true(exists("sample_data"))
  expect_true(is.data.frame(sample_data))
  expect_equal(nrow(sample_data), 7)
  expect_true("age" %in% colnames(sample_data))
  expect_true("gender" %in% colnames(sample_data))
  expect_true("race" %in% colnames(sample_data))
})

test_that("frs_coef exists and has correct structure", {
  data(frs_coef, package = "CVrisk")
  expect_true(exists("frs_coef"))
  expect_true(is.data.frame(frs_coef))
  expect_equal(nrow(frs_coef), 2)
  expect_true("gender" %in% colnames(frs_coef))
  expect_true("ln_age" %in% colnames(frs_coef))
  expect_true("baseline_survival" %in% colnames(frs_coef))
})

test_that("frs_simple_coef exists and has correct structure", {
  data(frs_simple_coef, package = "CVrisk")
  expect_true(exists("frs_simple_coef"))
  expect_true(is.data.frame(frs_simple_coef))
  expect_equal(nrow(frs_simple_coef), 2)
  expect_true("gender" %in% colnames(frs_simple_coef))
  expect_true("ln_age" %in% colnames(frs_simple_coef))
  expect_true("ln_bmi" %in% colnames(frs_simple_coef))
})

test_that("ascvd_pooled_coef exists and has correct structure", {
  data(ascvd_pooled_coef, package = "CVrisk")
  expect_true(exists("ascvd_pooled_coef"))
  expect_true(is.data.frame(ascvd_pooled_coef))
  expect_equal(nrow(ascvd_pooled_coef), 4)
  expect_true("race" %in% colnames(ascvd_pooled_coef))
  expect_true("gender" %in% colnames(ascvd_pooled_coef))
  expect_true("baseline_survival" %in% colnames(ascvd_pooled_coef))
})

test_that("mesa_coef exists and has correct structure", {
  data(mesa_coef, package = "CVrisk")
  expect_true(exists("mesa_coef"))
  expect_true(is.data.frame(mesa_coef))
  expect_equal(nrow(mesa_coef), 1)
  expect_true("age" %in% colnames(mesa_coef))
  expect_true("gender_male" %in% colnames(mesa_coef))
  expect_true("baseline_survival" %in% colnames(mesa_coef))
})

test_that("mesa_cac_coef exists and has correct structure", {
  data(mesa_cac_coef, package = "CVrisk")
  expect_true(exists("mesa_cac_coef"))
  expect_true(is.data.frame(mesa_cac_coef))
  expect_equal(nrow(mesa_cac_coef), 1)
  expect_true("age" %in% colnames(mesa_cac_coef))
  expect_true("gender_male" %in% colnames(mesa_cac_coef))
  expect_true("log1p_cac" %in% colnames(mesa_cac_coef))
  expect_true("baseline_survival" %in% colnames(mesa_cac_coef))
})

test_that("frs_coef has male and female rows", {
  data(frs_coef, package = "CVrisk")
  expect_true("male" %in% frs_coef$gender)
  expect_true("female" %in% frs_coef$gender)
})

test_that("frs_simple_coef has male and female rows", {
  data(frs_simple_coef, package = "CVrisk")
  expect_true("male" %in% frs_simple_coef$gender)
  expect_true("female" %in% frs_simple_coef$gender)
})

test_that("ascvd_pooled_coef has all race/gender combinations", {
  data(ascvd_pooled_coef, package = "CVrisk")
  expect_true(any(ascvd_pooled_coef$race == "white" & ascvd_pooled_coef$gender == "male"))
  expect_true(any(ascvd_pooled_coef$race == "white" & ascvd_pooled_coef$gender == "female"))
  expect_true(any(ascvd_pooled_coef$race == "aa" & ascvd_pooled_coef$gender == "male"))
  expect_true(any(ascvd_pooled_coef$race == "aa" & ascvd_pooled_coef$gender == "female"))
})

test_that("mesa_coef has race coefficients", {
  data(mesa_coef, package = "CVrisk")
  expect_true("race_chinese" %in% colnames(mesa_coef))
  expect_true("race_aa" %in% colnames(mesa_coef))
  expect_true("race_hispanic" %in% colnames(mesa_coef))
})

test_that("coefficient data frames have numeric coefficients", {
  data(frs_coef, package = "CVrisk")
  expect_true(is.numeric(frs_coef$ln_age))
  expect_true(is.numeric(frs_coef$baseline_survival))
  
  data(ascvd_pooled_coef, package = "CVrisk")
  expect_true(is.numeric(ascvd_pooled_coef$ln_age))
  expect_true(is.numeric(ascvd_pooled_coef$baseline_survival))
  
  data(mesa_coef, package = "CVrisk")
  expect_true(is.numeric(mesa_coef$age))
  expect_true(is.numeric(mesa_coef$baseline_survival))
  
  data(mesa_cac_coef, package = "CVrisk")
  expect_true(is.numeric(mesa_cac_coef$age))
  expect_true(is.numeric(mesa_cac_coef$log1p_cac))
  expect_true(is.numeric(mesa_cac_coef$baseline_survival))
})
