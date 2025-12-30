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
  
  # Determine the length of the input (vectorized)
  n <- max(length(age), length(gender), length(sbp), length(bp_med),
           length(totchol), length(hdl), length(statin), length(diabetes),
           length(smoker), length(egfr), length(bmi))
  
  # Function to calculate risk for a single row
  calculate_single_risk <- function(i) {
    # Extract single values for this row
    age_i <- if(length(age) == 1) age else age[i]
    gender_i <- if(length(gender) == 1) gender else gender[i]
    sbp_i <- if(length(sbp) == 1) sbp else sbp[i]
    bp_med_i <- if(length(bp_med) == 1) bp_med else bp_med[i]
    totchol_i <- if(length(totchol) == 1) totchol else totchol[i]
    hdl_i <- if(length(hdl) == 1) hdl else hdl[i]
    statin_i <- if(length(statin) == 1) statin else statin[i]
    diabetes_i <- if(length(diabetes) == 1) diabetes else diabetes[i]
    smoker_i <- if(length(smoker) == 1) smoker else smoker[i]
    egfr_i <- if(length(egfr) == 1) egfr else egfr[i]
    bmi_i <- if(length(bmi) == 1) bmi else bmi[i]
    
    # Check if any required inputs are NA for this row
    if (is.na(age_i) | is.na(gender_i) | is.na(sbp_i) | is.na(bp_med_i) |
        is.na(totchol_i) | is.na(hdl_i) | is.na(statin_i) | is.na(diabetes_i) |
        is.na(smoker_i) | is.na(egfr_i) | is.na(bmi_i)) {
      return(NA)
    }
    
    # Call preventr::estimate_risk with quiet = TRUE
    result <- tryCatch({
      preventr::estimate_risk(
        age = age_i,
        sex = gender_i,
        sbp = sbp_i,
        bp_tx = as.logical(bp_med_i),
        total_c = totchol_i,
        hdl_c = hdl_i,
        statin = as.logical(statin_i),
        dm = as.logical(diabetes_i),
        smoking = as.logical(smoker_i),
        egfr = egfr_i,
        bmi = bmi_i,
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
  
  # Apply the function to each row
  results <- sapply(1:n, calculate_single_risk)
  
  return(results)
}
