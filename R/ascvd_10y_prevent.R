#' PREVENT 10-year ASCVD risk score (base model)
#'
#' Computes 10-year risk for ASCVD (atherosclerotic cardiovascular disease)
#' using the American Heart Association PREVENT equations (2023) base model.
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
#' @param ... Additional predictors can be passed and will be ignored
#'
#' @return 10-year ASCVD risk estimate (percent)
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' ascvd_10y_prevent(
#'   gender = "female", age = 50,
#'   sbp = 160, bp_med = 1,
#'   totchol = 200, hdl = 45,
#'   statin = 0, diabetes = 1, smoker = 0,
#'   egfr = 90, bmi = 35
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
                             diabetes, smoker, egfr, bmi, ...) {
  
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
  
  # Check if any required inputs are NA
  if (any(is.na(c(age, gender, sbp, bp_med, totchol, hdl, statin, 
                   diabetes, smoker, egfr, bmi)))) {
    return(NA)
  }
  
  # Call preventr::estimate_risk with quiet = TRUE
  result <- tryCatch({
    preventr::estimate_risk(
      age = age,
      sex = gender,
      sbp = sbp,
      bp_tx = as.logical(bp_med),
      total_c = totchol,
      hdl_c = hdl,
      statin = as.logical(statin),
      dm = as.logical(diabetes),
      smoking = as.logical(smoker),
      egfr = egfr,
      bmi = bmi,
      model = "base",
      time = "10yr",
      quiet = TRUE
    )
  }, error = function(e) {
    return(NULL)
  })
  
  # Return NA if the call failed or result is null
  if (is.null(result)) {
    return(NA)
  }
  
  # Check if ascvd column exists and extract the risk
  if (!("ascvd" %in% names(result)) || is.na(result$ascvd)) {
    return(NA)
  }
  
  # Convert from proportion to percentage to match CVrisk conventions
  ascvd_risk <- round(result$ascvd * 100, 2)
  
  return(ascvd_risk)
}
