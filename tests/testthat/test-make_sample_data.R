test_that("make_sample_data returns correct default size", {
  result <- make_sample_data()
  expect_equal(nrow(result), 100)
})

test_that("make_sample_data respects n parameter", {
  result <- make_sample_data(n = 50)
  expect_equal(nrow(result), 50)
  
  result <- make_sample_data(n = 10)
  expect_equal(nrow(result), 10)
  
  result <- make_sample_data(n = 200)
  expect_equal(nrow(result), 200)
})

test_that("make_sample_data returns correct column names", {
  result <- make_sample_data(n = 10)
  expected_cols <- c(
    "id", "age", "sex", "race", "sbp", "bp_med", "totchol", "hdl", 
    "lipid_med", "diabetes", "smoker", "egfr", "bmi", "hba1c", "uacr", "zip"
  )
  expect_equal(colnames(result), expected_cols)
})

test_that("make_sample_data returns correct column types", {
  result <- make_sample_data(n = 10)
  
  # Numeric columns
  expect_true(is.numeric(result$id))
  expect_true(is.numeric(result$age))
  expect_true(is.numeric(result$sbp))
  expect_true(is.numeric(result$totchol))
  expect_true(is.numeric(result$hdl))
  expect_true(is.numeric(result$egfr))
  expect_true(is.numeric(result$bmi))
  expect_true(is.numeric(result$hba1c))
  expect_true(is.numeric(result$uacr))
  
  # Logical columns
  expect_true(is.logical(result$bp_med))
  expect_true(is.logical(result$lipid_med))
  expect_true(is.logical(result$diabetes))
  expect_true(is.logical(result$smoker))
  
  # Character columns
  expect_true(is.character(result$sex))
  expect_true(is.character(result$race))
  expect_true(is.character(result$zip))
})

test_that("make_sample_data generates values in correct ranges", {
  result <- make_sample_data(n = 100)
  
  # Check id is sequential
  expect_equal(result$id, 1:100)
  
  # Check age range (30-79)
  expect_true(all(result$age >= 30 & result$age <= 79))
  
  # Check sbp range (90-200)
  expect_true(all(result$sbp >= 90 & result$sbp <= 200))
  
  # Check totchol range (130-320)
  expect_true(all(result$totchol >= 130 & result$totchol <= 320))
  
  # Check hdl range (20-100)
  expect_true(all(result$hdl >= 20 & result$hdl <= 100))
  
  # Check egfr range (15-140)
  expect_true(all(result$egfr >= 15 & result$egfr <= 140))
  
  # Check bmi range (18.5-39.9)
  expect_true(all(result$bmi >= 18.5 & result$bmi <= 39.9))
  
  # Check hba1c range (4.5-15.0 or NA)
  hba1c_non_na <- result$hba1c[!is.na(result$hba1c)]
  expect_true(all(hba1c_non_na >= 4.5 & hba1c_non_na <= 15.0))
  
  # Check uacr range (0.1-25000 or NA)
  uacr_non_na <- result$uacr[!is.na(result$uacr)]
  expect_true(all(uacr_non_na >= 0.1 & uacr_non_na <= 25000))
})

test_that("make_sample_data generates valid sex values", {
  result <- make_sample_data(n = 100)
  expect_true(all(result$sex %in% c("female", "male")))
})

test_that("make_sample_data generates valid race values", {
  result <- make_sample_data(n = 100)
  expect_true(all(result$race %in% c("white", "aa", "other")))
})

test_that("make_sample_data generates valid zip codes", {
  result <- make_sample_data(n = 100)
  
  valid_zips <- c(
    "27844","76201","24630","48821","89146","84631","23950","56552","14174", 
    "63454","53965","50561","27320","86336","00976","96744","55805","32548", 
    "12959","12138","77057","68118","07940","28579","26291","72601","48228",
    "11719","76667","02129"
  )
  
  zip_non_na <- result$zip[!is.na(result$zip)]
  expect_true(all(zip_non_na %in% valid_zips))
})

test_that("make_sample_data includes NA values in hba1c", {
  result <- make_sample_data(n = 100)
  # With equal probability, we expect some NA values
  # Testing with a larger sample to be more confident
  expect_true(any(is.na(result$hba1c)))
})

test_that("make_sample_data includes NA values in uacr", {
  result <- make_sample_data(n = 100)
  # With equal probability, we expect some NA values
  expect_true(any(is.na(result$uacr)))
})

test_that("make_sample_data includes NA values in zip", {
  result <- make_sample_data(n = 100)
  # With equal probability, we expect some NA values
  expect_true(any(is.na(result$zip)))
})

test_that("make_sample_data works with n = 1", {
  result <- make_sample_data(n = 1)
  expect_equal(nrow(result), 1)
  expect_equal(ncol(result), 16)
})

test_that("make_sample_data validates n parameter", {
  expect_error(make_sample_data(n = 0), "n must be a positive integer")
  expect_error(make_sample_data(n = -5), "n must be a positive integer")
  expect_error(make_sample_data(n = 1.5), "n must be a positive integer")
  expect_error(make_sample_data(n = "100"), "n must be a positive integer")
  expect_error(make_sample_data(n = c(10, 20)), "n must be a positive integer")
})

test_that("make_sample_data returns data.frame", {
  result <- make_sample_data(n = 10)
  expect_true(is.data.frame(result))
})

test_that("make_sample_data can be used with compute_CVrisk", {
  # This is an integration test to ensure the generated data
  # is compatible with the package's main functions
  data <- make_sample_data(n = 10)
  
  # Should not throw an error
  expect_silent(
    compute_CVrisk(
      data,
      scores = "ascvd_10y_accaha",
      age = "age",
      gender = "sex",
      race = "race",
      sbp = "sbp",
      totchol = "totchol",
      hdl = "hdl",
      bp_med = "bp_med",
      smoker = "smoker",
      diabetes = "diabetes"
    )
  )
})

test_that("make_sample_data can be used with compute_CVrisk for PREVENT score", {
  # Integration test for PREVENT score
  data <- make_sample_data(n = 10)
  
  # Should not throw an error
  expect_silent(
    compute_CVrisk(
      data,
      scores = "ascvd_10y_prevent",
      age = "age",
      gender = "sex",
      sbp = "sbp",
      totchol = "totchol",
      hdl = "hdl",
      bp_med = "bp_med",
      smoker = "smoker",
      diabetes = "diabetes",
      statin = "lipid_med",
      egfr = "egfr",
      bmi = "bmi"
    )
  )
})
