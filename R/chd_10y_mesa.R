#' MESA 2015 CHD risk score
#'
#' Computes 10-year risk for hard coronary heart disease (CHD) event (defined
#' as first occurrence of myocardial infarction (MI), resuscitated cardiac
#' arrest, CHD death, or revascularization with prior or concurrent adjudicated
#' angina).
#'
#' @param race patient race/ethnicity (white, aa, chinese, or hispanic)
#' @param gender patient gender (male, female)
#' @param age patient age (years), risk computed for 45-85 year olds
#' @param totchol Total cholesterol (mg/dL)
#' @param hdl HDL cholesterol (mg/dL)
#' @param lipid_med Patient is on a hyperlipidemic medication (1=Yes, 0=No)
#' @param sbp Systolic blood pressure (mm Hg)
#' @param bp_med Patient is on a blood pressure medication (1=Yes, 0=No)
#' @param smoker Current smoker (1=Yes, 0=No)
#' @param diabetes Diabetes (1=Yes, 0=No)
#' @param fh_heartattack Family history of heart attacks (parents, siblings ,or
#' children) (1=Yes, 0=No)
#' @param ... Additional predictors can be passed and will be ignored
#'
#'
#' @return Estimated 10-Y Risk for hard CAD event (percent)
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' chd_10y_mesa(
#'   race = "aa", gender = "male", age = 55,
#'   totchol = 213, hdl = 50, sbp = 140, lipid_med = 0,
#'   bp_med = 1, smoker = 0, diabetes = 0, fh_heartattack = 0
#' )
#' @references
#' McClelland RL, Jorgensen NW, Budoff M, et al. 10-Year Coronary Heart Disease
#' Risk Prediction Using Coronary Artery Calcium and Traditional Risk Factors:
#' Derivation in the MESA (Multi-Ethnic Study of Atherosclerosis) With
#' Validation in the HNR (Heinz Nixdorf Recall) Study and the DHS
#' (Dallas Heart Study). J Am Coll Cardiol. 2015;66(15):1643-1653.
#' doi:10.1016/j.jacc.2015.08.035

chd_10y_mesa <- function(race = "white", gender = c("male", "female"),
                             age, totchol = NA, hdl = NA, lipid_med = NA,
                             sbp = NA, bp_med = NA, smoker = NA, diabetes = NA,
                             fh_heartattack = NA,
                         ...) {
  if (!all(race %in% c("aa", "white", "chinese", "hispanic")) | missing(race)) {
    stop("race must be either 'aa', 'chinese', or 'hispanic'")
  }

  if (!all(gender %in% c("male", "female")) | missing(gender)) {
    stop("gender must be either 'male' or 'female'")
  }

  if (!is.numeric(age) |
      any(age < 1, na.rm = TRUE) |
      any(age > 120, na.rm = TRUE) | missing(age)) {
    stop("age must be a valid numeric value")
  }

  if (!is.numeric(totchol) |
      any(totchol < 1, na.rm = TRUE) |
      any(totchol > 999, na.rm = TRUE) | missing(totchol)) {
    stop("totchol must be a valid numeric value")
  }

  mesa_coef <- NULL
  utils::data(mesa_coef, envir = environment())
  model_coef <- mesa_coef

  race_chinese <- ifelse(race == "chinese", 1, 0)
  race_aa <- ifelse(race == "aa", 1, 0)
  race_hispanic <- ifelse(race == "hispanic", 1, 0)


  gender_male <- ifelse(gender == "male", 1, 0)

  indv_sum <- age * model_coef$age +
    gender_male * model_coef$gender_male +
    race_chinese * model_coef$race_chinese +
    race_aa * model_coef$race_aa +
    race_hispanic * model_coef$race_hispanic +
    diabetes * model_coef$diabetes +
    smoker * model_coef$smoker +
    totchol * model_coef$totchol +
    hdl * model_coef$hdl +
    lipid_med * model_coef$hld_med +  ##sync name
    sbp * model_coef$sbp +
    bp_med * model_coef$bp_med +
    fh_heartattack * model_coef$fh_heartattack

  risk_score <- round((1 - (model_coef$baseline_survival^
                              exp(indv_sum))) * 100.000, 2)

  #risk_score
  ifelse(risk_score < 1, 1, ifelse(risk_score > 30, 30, risk_score))
}
