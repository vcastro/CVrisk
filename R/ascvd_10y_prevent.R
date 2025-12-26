#' AHA/ACC PREVENT 2023 10-year ASCVD risk score (lipid-based)
#'
#' Computes 10-year risk for ASCVD event using the PREVENT equations
#' (2023). PREVENT is race-neutral and represents the modern replacement
#' for the 2013 Pooled Cohort Equations.
#'
#' @param gender patient gender (male, female)
#' @param age patient age (years), between 30 and 79
#' @param totchol Total cholesterol (mg/dL)
#' @param hdl HDL cholesterol (mg/dL)
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#' @param egfr Estimated glomerular filtration rate (mL/min/1.73m2), optional, defaults to 90
#' @param uacr Urine albumin-to-creatinine ratio (mg/g), optional, defaults to 0
#' @param ... Additional predictors can be passed and will be ignored
#'
#' @return Estimated 10-Y Risk for ASCVD (percent)
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' ascvd_10y_prevent(
#'   gender = "male", age = 55,
#'   totchol = 213, hdl = 50, sbp = 140,
#'   bp_med = 0, smoker = 0, diabetes = 0
#' )
#'
#' @references
#' Khan SS, Matsushita K, Sang Y, et al. Development and Validation of the
#' American Heart Association's PREVENT Equations. Circulation. 
#' 2024;149(6):430-449. doi:10.1161/CIRCULATIONAHA.123.067626

ascvd_10y_prevent <- function(gender = c("male", "female"),
                              age, totchol, hdl, sbp,
                              bp_med, smoker, diabetes,
                              egfr = 90, uacr = 0, ...) {

  gender <- tolower(gender)
  gender <- ifelse(gender == "m", "male", gender)
  gender <- ifelse(gender == "f", "female", gender)

  if (!all(gender %in% c("male", "female")) | missing(gender)) {
    stop("gender must be either 'male' or 'female'")
  }

  if (!is.numeric(age) | missing(age)) {
    stop("age must be a valid numeric value")
  }

  age <- ifelse(age < 30 | age > 79, NA, age)

  if (missing(totchol)) {
    totchol <- NA
  }

  if (missing(hdl)) {
    hdl <- NA
  }

  if (missing(sbp)) {
    sbp <- NA
  }

  if (missing(bp_med)) {
    bp_med <- NA
  }

  if (missing(smoker)) {
    smoker <- NA
  }

  if (missing(diabetes)) {
    diabetes <- NA
  }

  # Default values for optional parameters if not provided or invalid
  egfr <- ifelse(is.na(egfr) | !is.numeric(egfr), 90, egfr)
  uacr <- ifelse(is.na(uacr) | !is.numeric(uacr), 0, uacr)

  # retrieve model coefficients
  prevent_10y_coef <- NULL
  utils::data(prevent_10y_coef, envir = environment())

  # Generate data.frame of coefficients based on input `gender` vector.
  # We lose the original order after the merge operation, so will need
  # to re-sort the output based on the original order of `sex_df`.
  sex_df <- data.frame(gender)
  sex_df$id <- as.numeric(row.names(sex_df))

  model_coef <- merge(sex_df, prevent_10y_coef)
  model_coef <- model_coef[order(model_coef$id), ]

  indv_sum <- log(age) * model_coef$ln_age +
    log(totchol) * model_coef$ln_totchol +
    log(hdl) * model_coef$ln_hdl +
    log(sbp) * model_coef$ln_sbp +
    bp_med * model_coef$bp_med +
    diabetes * model_coef$diabetes +
    smoker * model_coef$smoker +
    egfr * model_coef$egfr +
    uacr * model_coef$uacr

  risk_score <- round((1 - (model_coef$baseline_survival^
    exp(indv_sum - model_coef$group_mean))) * 100.000, 2)

  ifelse(risk_score < 1, 1, risk_score)
}
