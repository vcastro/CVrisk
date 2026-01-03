#' PREVENT 10-year ASCVD risk score
#'
#' Computes 10-year risk for ASCVD (atherosclerotic cardiovascular disease)
#' using the American Heart Association PREVENT equations (2023).
#'
#' @param gender patient gender (male, female)
#' @param age patient age (years), between 30 and 79
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param totchol Total cholesterol (mg/dL)
#' @param hdl HDL cholesterol (mg/dL)
#' @param statin Patient is on a statin (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param egfr Estimated glomerular filtration rate (mL/min/1.73m2)
#' @param bmi Body mass index (kg/m2)
#' @param hba1c Glycated hemoglobin (HbA1c) in percent (optional)
#' @param uacr Urine albumin-to-creatinine ratio in mg/g (optional)
#' @param zip ZIP code for Social Deprivation Index (optional)
#' @param model PREVENT model variant to use: "auto" (default, selects based on 
#'   available data), "base", "hba1c", "uacr", "sdi", or "full"
#' @param ... Additional predictors can be passed and will be ignored
#'
#' @return 10-year ASCVD risk estimate (percent)
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' # Base model (default when model = "auto" and no optional predictors provided)
#' ascvd_10y_prevent(
#'   gender = "female", age = 50,
#'   sbp = 160, bp_med = 1,
#'   totchol = 200, hdl = 45,
#'   statin = 0, diabetes = 1, smoker = 0,
#'   egfr = 90, bmi = 35
#' )
#' 
#' # Explicitly specify base model
#' ascvd_10y_prevent(
#'   gender = "female", age = 50,
#'   sbp = 160, bp_med = 1,
#'   totchol = 200, hdl = 45,
#'   statin = 0, diabetes = 1, smoker = 0,
#'   egfr = 90, bmi = 35,
#'   model = "base"
#' )
#' 
#' # Auto model with HbA1c (will use hba1c model variant)
#' ascvd_10y_prevent(
#'   gender = "male", age = 55,
#'   sbp = 140, bp_med = 0,
#'   totchol = 213, hdl = 50,
#'   statin = 0, diabetes = 0, smoker = 0,
#'   egfr = 90, bmi = 30,
#'   hba1c = 6.5
#' )
#'
#' @references
#' Khan SS, Matsushita K, Sang Y, Ballew SH, Grams ME, Surapaneni A, Blaha MJ,
#' Carson AP, Chang AR, Ciemins E, Go AS, Gutierrez OM, Hwang SJ, Jassal SK,
#' Kovesdy CP, Lloyd-Jones DM, Shlipak MG, Palaniappan LP, Sperling L,
#' Virani SS, Tuttle K, Neeland IJ, Chow SL, Rangaswami J, Pencina MJ,
#' Ndumele CE, Coresh J; Chronic Kidney Disease Prognosis Consortium and the
#' American Heart Association Cardiovascular-Kidney-Metabolic Science Advisory
#' Group. Development and Validation of the American Heart Association's
#' PREVENT Equations. Circulation. 2024 Feb 6;149(6):430-449.

ascvd_10y_prevent <- function(gender = c("male", "female"),
                             age, sbp, bp_med, totchol, hdl, statin,
                             diabetes, smoker, egfr, bmi, 
                             hba1c = NULL, uacr = NULL, zip = NULL,
                             model = "auto", ...) {
  
  # Validate gender before normalization
  if (missing(gender) || !all(tolower(gender) %in% c("male", "female", "m", "f"))) {
    stop("gender must be either 'male' or 'female'")
  }
  
  # Standardize gender input
  gender <- tolower(gender)
  gender <- ifelse(gender == "m", "male", gender)
  gender <- ifelse(gender == "f", "female", gender)
  
  # Validate inputs - handle both missing and invalid values
  # For vectorized operations, we can't use || or && - use | and & instead
  if (missing(age)) {
    age <- NA
  } else {
    age <- ifelse(!is.numeric(age) | age < 30 | age > 79, NA, age)
  }
  
  if (missing(sbp)) {
    sbp <- NA
  } else {
    sbp <- ifelse(!is.numeric(sbp) | sbp < 90 | sbp > 180, NA, sbp)
  }
  
  if (missing(totchol)) {
    totchol <- NA
  } else {
    totchol <- ifelse(!is.numeric(totchol) | totchol < 130 | totchol > 320, NA, totchol)
  }
  
  if (missing(hdl)) {
    hdl <- NA
  } else {
    hdl <- ifelse(!is.numeric(hdl) | hdl < 20 | hdl > 100, NA, hdl)
  }
  
  if (missing(egfr)) {
    egfr <- NA
  } else {
    egfr <- ifelse(!is.numeric(egfr) | egfr < 15 | egfr > 140, NA, egfr)
  }
  
  if (missing(bmi)) {
    bmi <- NA
  } else {
    bmi <- ifelse(!is.numeric(bmi) | bmi < 18.5 | bmi > 39.9, NA, bmi)
  }
  
  # Handle missing values for binary variables
  if (missing(bp_med)) bp_med <- NA
  if (missing(statin)) statin <- NA
  if (missing(diabetes)) diabetes <- NA
  if (missing(smoker)) smoker <- NA
  
  # Normalize model parameter to work with preventr
  # "auto" in CVrisk maps to NULL in preventr (auto-selection)
  preventr_model <- if (model == "auto") NULL else model
  
  # Check if any required inputs are NA (vectorized check)
  any_na <- is.na(age) | is.na(gender) | is.na(sbp) | is.na(bp_med) |
            is.na(totchol) | is.na(hdl) | is.na(statin) | is.na(diabetes) |
            is.na(smoker) | is.na(egfr) | is.na(bmi)
  
  # If all inputs are invalid, return NA
  if (all(any_na)) {
    return(rep(NA_real_, length(age)))
  }
  
  # Call preventr::estimate_risk with vectorized inputs using use_dat
  # Create a data frame with all inputs
  input_df <- data.frame(
    age = age,
    sex = gender,
    sbp = sbp,
    bp_tx = bp_med,
    total_c = totchol,
    hdl_c = hdl,
    statin = statin,
    dm = diabetes,
    smoking = smoker,
    egfr = egfr,
    bmi = bmi,
    stringsAsFactors = FALSE
  )
  
  # Add optional predictors if provided
  if (!is.null(hba1c)) {
    input_df$hba1c <- hba1c
  }
  if (!is.null(uacr)) {
    input_df$uacr <- uacr
  }
  if (!is.null(zip)) {
    input_df$zip <- zip
  }
  
  # Call preventr with the data frame
  result <- tryCatch({
    preventr::estimate_risk(
      use_dat = input_df,
      model = preventr_model,
      time = "10yr",
      quiet = TRUE
    )
  }, error = function(e) {
    return(NULL)
  })
  
  # Return NA if the call failed or result is null
  if (is.null(result) || nrow(result) == 0) {
    return(rep(NA_real_, nrow(input_df)))
  }
  
  # Extract ASCVD risk and convert from proportion to percentage
  # preventr returns results ordered by preventr_id which matches input order
  ascvd_risk <- ifelse(is.na(result$ascvd), NA_real_, round(result$ascvd * 100, 2))
  
  return(ascvd_risk)
}


#' PREVENT 30-year ASCVD risk score
#'
#' Computes 30-year risk for ASCVD (atherosclerotic cardiovascular disease)
#' using the American Heart Association PREVENT equations (2023).
#'
#' @param gender patient gender (male, female)
#' @param age patient age (years), between 30 and 79
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param totchol Total cholesterol (mg/dL)
#' @param hdl HDL cholesterol (mg/dL)
#' @param statin Patient is on a statin (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param egfr Estimated glomerular filtration rate (mL/min/1.73m2)
#' @param bmi Body mass index (kg/m2)
#' @param hba1c Glycated hemoglobin (HbA1c) in percent (optional)
#' @param uacr Urine albumin-to-creatinine ratio in mg/g (optional)
#' @param zip ZIP code for Social Deprivation Index (optional)
#' @param model PREVENT model variant to use: "auto" (default, selects based on 
#'   available data), "base", "hba1c", "uacr", "sdi", or "full"
#' @param ... Additional predictors can be passed and will be ignored
#'
#' @return 30-year ASCVD risk estimate (percent)
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' # Base model (default when model = "auto" and no optional predictors provided)
#' ascvd_30y_prevent(
#'   gender = "female", age = 50,
#'   sbp = 160, bp_med = 1,
#'   totchol = 200, hdl = 45,
#'   statin = 0, diabetes = 1, smoker = 0,
#'   egfr = 90, bmi = 35
#' )
#' 
#' # Explicitly specify base model
#' ascvd_30y_prevent(
#'   gender = "male", age = 45,
#'   sbp = 130, bp_med = 0,
#'   totchol = 200, hdl = 50,
#'   statin = 0, diabetes = 0, smoker = 1,
#'   egfr = 95, bmi = 28,
#'   model = "base"
#' )
#' 
#' # Auto model with UACR (will use uacr model variant)
#' ascvd_30y_prevent(
#'   gender = "male", age = 55,
#'   sbp = 140, bp_med = 0,
#'   totchol = 213, hdl = 50,
#'   statin = 0, diabetes = 0, smoker = 0,
#'   egfr = 90, bmi = 30,
#'   uacr = 25
#' )
#'
#' @references
#' Khan SS, Matsushita K, Sang Y, Ballew SH, Grams ME, Surapaneni A, Blaha MJ,
#' Carson AP, Chang AR, Ciemins E, Go AS, Gutierrez OM, Hwang SJ, Jassal SK,
#' Kovesdy CP, Lloyd-Jones DM, Shlipak MG, Palaniappan LP, Sperling L,
#' Virani SS, Tuttle K, Neeland IJ, Chow SL, Rangaswami J, Pencina MJ,
#' Ndumele CE, Coresh J; Chronic Kidney Disease Prognosis Consortium and the
#' American Heart Association Cardiovascular-Kidney-Metabolic Science Advisory
#' Group. Development and Validation of the American Heart Association's
#' PREVENT Equations. Circulation. 2024 Feb 6;149(6):430-449.

ascvd_30y_prevent <- function(gender = c("male", "female"),
                             age, sbp, bp_med, totchol, hdl, statin,
                             diabetes, smoker, egfr, bmi, 
                             hba1c = NULL, uacr = NULL, zip = NULL,
                             model = "auto", ...) {
  
  # Validate gender before normalization
  if (missing(gender) || !all(tolower(gender) %in% c("male", "female", "m", "f"))) {
    stop("gender must be either 'male' or 'female'")
  }
  
  # Standardize gender input
  gender <- tolower(gender)
  gender <- ifelse(gender == "m", "male", gender)
  gender <- ifelse(gender == "f", "female", gender)
  
  # Validate inputs - handle both missing and invalid values
  # For vectorized operations, we can't use || or && - use | and & instead
  if (missing(age)) {
    age <- NA
  } else {
    age <- ifelse(!is.numeric(age) | age < 30 | age > 79, NA, age)
  }
  
  if (missing(sbp)) {
    sbp <- NA
  } else {
    sbp <- ifelse(!is.numeric(sbp) | sbp < 90 | sbp > 180, NA, sbp)
  }
  
  if (missing(totchol)) {
    totchol <- NA
  } else {
    totchol <- ifelse(!is.numeric(totchol) | totchol < 130 | totchol > 320, NA, totchol)
  }
  
  if (missing(hdl)) {
    hdl <- NA
  } else {
    hdl <- ifelse(!is.numeric(hdl) | hdl < 20 | hdl > 100, NA, hdl)
  }
  
  if (missing(egfr)) {
    egfr <- NA
  } else {
    egfr <- ifelse(!is.numeric(egfr) | egfr < 15 | egfr > 140, NA, egfr)
  }
  
  if (missing(bmi)) {
    bmi <- NA
  } else {
    bmi <- ifelse(!is.numeric(bmi) | bmi < 18.5 | bmi > 39.9, NA, bmi)
  }
  
  # Handle missing values for binary variables
  if (missing(bp_med)) bp_med <- NA
  if (missing(statin)) statin <- NA
  if (missing(diabetes)) diabetes <- NA
  if (missing(smoker)) smoker <- NA
  
  # Normalize model parameter to work with preventr
  # "auto" in CVrisk maps to NULL in preventr (auto-selection)
  preventr_model <- if (model == "auto") NULL else model
  
  # Check if any required inputs are NA (vectorized check)
  any_na <- is.na(age) | is.na(gender) | is.na(sbp) | is.na(bp_med) |
            is.na(totchol) | is.na(hdl) | is.na(statin) | is.na(diabetes) |
            is.na(smoker) | is.na(egfr) | is.na(bmi)
  
  # If all inputs are invalid, return NA
  if (all(any_na)) {
    return(rep(NA_real_, length(age)))
  }
  
  # Call preventr::estimate_risk with vectorized inputs using use_dat
  # Create a data frame with all inputs
  input_df <- data.frame(
    age = age,
    sex = gender,
    sbp = sbp,
    bp_tx = bp_med,
    total_c = totchol,
    hdl_c = hdl,
    statin = statin,
    dm = diabetes,
    smoking = smoker,
    egfr = egfr,
    bmi = bmi,
    stringsAsFactors = FALSE
  )
  
  # Add optional predictors if provided
  if (!is.null(hba1c)) {
    input_df$hba1c <- hba1c
  }
  if (!is.null(uacr)) {
    input_df$uacr <- uacr
  }
  if (!is.null(zip)) {
    input_df$zip <- zip
  }
  
  # Call preventr with the data frame, requesting 30-year risk
  result <- tryCatch({
    preventr::estimate_risk(
      use_dat = input_df,
      model = preventr_model,
      time = "30yr",
      quiet = TRUE
    )
  }, error = function(e) {
    return(NULL)
  })
  
  # Return NA if the call failed or result is null
  if (is.null(result) || nrow(result) == 0) {
    return(rep(NA_real_, nrow(input_df)))
  }
  
  # Extract ASCVD risk and convert from proportion to percentage
  # preventr returns results ordered by preventr_id which matches input order
  ascvd_risk <- ifelse(is.na(result$ascvd), NA_real_, round(result$ascvd * 100, 2))
  
  return(ascvd_risk)
}
