#' Framingham ASCVD Risk Score (no lab measurement)
#' 
#' Computes 10-year risk for ASCVD event (coronary death, myocardial infarction (MI),
#' coronary insufficiency, angina, ischemic stroke, hemorrhagic stroke, 
#' transient ischemic attack, peripheral artery disease, or heart failure).
#'
#' @param gender patient gender (male, female)
#' @param age patient age (years), between 30 and 74
#' @param bmi Body mass index (kg/m2)
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#' @param ... Additional predictors can be passed and will be ignored
#'
#' @return Estimated 10-Y Risk for hard ASCVD (percent)
#' 
#' @export
#'
#' @examples
#' library(CVrisk)
#' ascvd_10y_frs_simple(gender = "male", age = 55, 
#'   bmi = 30, sbp = 140, 
#'   bp_med = 0, smoker = 0, diabetes = 0)
#'   
#' #16.7
#' @references 
#' D’agostino, R.B., Vasan, R.S., Pencina, M.J., Wolf, P.A., Cobain, M., Massaro, 
#' J.M. and Kannel, W.B., 2008. General cardiovascular risk profile for use
#' in primary care. Circulation, 117(6), pp.743-753.

ascvd_10y_frs_simple <- function (gender = c("male", "female"), 
                              age, bmi, sbp, 
                              bp_med, smoker, diabetes, ...) {
  
  gender <- tolower(gender)
  gender <- ifelse(gender == "m", "male", gender)
  gender <- ifelse(gender == "f", "female", gender)
  
  if(!gender %in% c("male", "female") | missing(gender))
    stop("gender must be either 'male' or 'female'")
  
  if(!is.numeric(age) | missing(age))
    stop("age must be a valid numeric value'")

  if(age < 1 | age>120)
    return(NA)

  if(missing(bmi) | missing(sbp) | missing(bp_med) | missing(smoker) | missing(diabetes))
    return(NA)
  
  # retrieve model coefficients  
  frs_simple_coef <- NULL
  utils::data(frs_simple_coef, envir = environment())
  model_coef <- frs_simple_coef[which(frs_simple_coef$gender == gender),]
  
  sbp_treated <- ifelse(bp_med == 1, sbp, 1)
  sbp_untreated <- ifelse(bp_med == 0, sbp, 1)
  
  indv_sum <- log(age) *    model_coef$ln_age +
    log(bmi) *              model_coef$ln_bmi +
    log(sbp_treated) *      model_coef$ln_treated_sbp +
    log(sbp_untreated) *    model_coef$ln_untreated_sbp +
    smoker *                model_coef$smoker +
    diabetes *              model_coef$diabetes
  
  risk_score <- round((1-(model_coef$baseline_survival^
                            exp(indv_sum-model_coef$group_mean)))*100.000,2)
  
  ifelse(risk_score<1, 1, ifelse(risk_score>30, 30, risk_score))
}
