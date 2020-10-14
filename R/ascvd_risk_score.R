#' ACC/AHA 2013 ASCVD risk score
#' 
#' Computes 10-year risk for hard ASCVD event (defined as first occurrence of 
#' non-fatal myocardial infarction (MI), congestive heart disease (CHD) death, 
#' or fatal or nonfatal stroke).
#'
#' @param race patient race (white, aa)
#' @param gender patient gender (male, female)
#' @param age patient age (years)
#' @param totchol Total cholesterol (mg/dL)
#' @param hdl HDL cholesterol (mg/dL)
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#'
#' @return Estimated 10-Y Risk for hard ASCVD (percent)
#' 
#' @export
#'
#' @examples
#' library(CVrisk)
#' ascvd_risk_score(race = "aa", gender = "male", age = 55, 
#'   totchol = 213, hdl = 50, sbp = 140, 
#'   bp_med = 0, smoker = 0, diabetes = 0)
#'
#' @references 
#' Goff, David C., et al. "2013 ACC/AHA guideline on the assessment of 
#' cardiovascular risk: a report of the American College of 
#' Cardiology/American Heart Association Task Force on Practice 
#' Guidelines." Journal of the American College of Cardiology 63.25 
#' Part B (2014): 2935-2959.

ascvd_risk_score <- function (race, gender = c("male", "female"), 
                              age, totchol, hdl, sbp, 
                              bp_med, smoker, diabetes) {
  
  
  if(!race %in% c("aa", "white") | missing(race))
    stop("race must be either 'aa' or 'white'")

  if(!gender %in% c("male", "female") | missing(gender))
    stop("gender must be either 'male' or 'female'")
  
  if(!is.numeric(age) | age < 1 | age>120 | missing(age))
    stop("age must be a valid numeric value'")
  
  if(!is.numeric(totchol) | totchol < 1 | totchol > 999 | missing(totchol))
    stop("totchol must be a valid numeric value'")
  
  
  ascvd_pooled_coef <- NULL
  
  utils::data(ascvd_pooled_coef, envir = environment())
  
  d <- ascvd_pooled_coef 
  
  pooled_coef <- d[which(d$race == race & d$gender == gender),]
  
  sbp_treated <- ifelse(bp_med == 1, sbp, 1)
  sbp_untreated <- ifelse(bp_med == 0, sbp, 1)
  
  indv_sum <- log(age) *              pooled_coef$ln_age +
              log(age)^2 *            pooled_coef$ln_age_squared +
              log(totchol) *          pooled_coef$ln_totchol +
              log(age)*log(totchol) * pooled_coef$ln_age_totchol +
              log(hdl) *              pooled_coef$ln_hdl +
              log(age)*log(hdl) *     pooled_coef$ln_age_hdl +
              log(sbp_treated) *      pooled_coef$ln_treated_sbp +
              log(sbp_treated)*log(age) * pooled_coef$ln_age_treated_sbp +
              log(sbp_untreated) *    pooled_coef$ln_untreated_sbp +
              log(sbp_untreated)*log(age) * pooled_coef$ln_age_untreated_sbp +
              smoker *                pooled_coef$smoker +
              smoker*log(age) *       pooled_coef$ln_age_smoker +
              diabetes *              pooled_coef$diabetes

  risk_score <- round((1-(pooled_coef$baseline_survival^
                     exp(indv_sum-pooled_coef$group_mean)))*100.000,2)
  
  ifelse(risk_score<1, 1, ifelse(risk_score>30, 30, risk_score))
}

#ascvd_risk_score(race = "aa", gender = "female", age = 55, totchol = 213, hdl = 50, sbp = 140, bp_med = FALSE, smoker=0, diabetes=0)

#ascvd_risk_score(race = "aa", gender = "female", age = 20, totchol = 213, hdl = 50, sbp = 140, bp_med = FALSE, smoker=0, diabetes=0)
