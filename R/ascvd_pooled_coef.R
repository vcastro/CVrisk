#' ascvd_pooled_coef
#'
#' A data set containing the ASCVD pooled cohort coefficients
#' 
#'
#' @format A data frame with 4 obs. and 17 variables:
#' \describe{
#'   \item{race}{Patient race, either white or aa}
#'   \item{gender}{Patient gender, either female or male}
#'   \item{ln_age}{Natural log of patient age}
#'   \item{ln_age_squared}{Natural log of patient age in years, squared}
#'   \item{ln_totchol}{Natural log of total cholestorol level}
#'   \item{ln_age_totchol}{Natural log of combined age and total cholestorol}
#'   \item{ln_hdl}{Natural log of HDL level}
#'   \item{ln_age_hdl}{Natural log of HDL and age}
#'   \item{ln_treated_sbp}{Natural log of treated systolic blood pressure}
#'   \item{ln_age_treated_sbp}{Natural log of treated systolic blood pressure and age}
#'   \item{ln_untreated_sbp}{Natural log of untreated systolic blood pressure}
#'   \item{ln_age_untreated_sbp}{Natural log of untreated systolic blood pressure and age}
#'   \item{smoker}{Smoking status}
#'   \item{ln_age_smoker}{Natural log of smoking status and age}
#'   \item{diabetes}{Diabetes status}
#'   \item{group_mean}{Grouped mean}
#'   \item{baseline_survival}{Baseline survival}
#' }
#'
#' @references 
#' Goff, David C., et al. "2013 ACC/AHA guideline on the assessment of 
#' cardiovascular risk: a report of the American College of 
#' Cardiology/American Heart Association Task Force on Practice 
#' Guidelines." Journal of the American College of Cardiology 63.25 
#' Part B (2014): 2935-2959.
"ascvd_pooled_coef"